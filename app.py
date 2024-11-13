from flask import Flask, render_template, request, send_file, jsonify, redirect, url_for
from yt_dlp import YoutubeDL
import os
import json
import mysql.connector
from mysql.connector import Error

app = Flask(__name__)

# Configuración de la base de datos
db_config = {
    'user': 'root',
    'password': '',
    'host': 'localhost',
    'database': 'inter_bd'
}

def get_db_connection():
    try:
        conn = mysql.connector.connect(**db_config)
        if conn.is_connected():
            print("Conexión a la base de datos establecida correctamente.✅")
            return conn
    except Error as e:
        print(f"Error al conectar con la base de datos: {e}❌")
        return None

# Cambio de la carpeta de descargas
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DOWNLOAD_FOLDER = os.path.join(BASE_DIR, 'downloads')

# Creo la carpeta de descargas si no existe
if not os.path.exists(DOWNLOAD_FOLDER):
    os.makedirs(DOWNLOAD_FOLDER)
    
def download_video(url):
    ydl_opts = {
        'outtmpl': os.path.join(DOWNLOAD_FOLDER, '%(title)s.%(ext)s')
    }
    with YoutubeDL(ydl_opts) as ydl:
        info_dict = ydl.extract_info(url, download=True)
        video_path = ydl.prepare_filename(info_dict)
        video_title = info_dict.get('title', 'Unknown Title')
        return video_path, video_title
    
    
def insertar_descarga(nombre_video):
    conn = get_db_connection()
    if conn:
        try:
            cursor = conn.cursor()
            print(f"Intentando insertar descarga para el video: {nombre_video}")
            cursor.execute("INSERT INTO descargas_videos (nombre_video) VALUES (%s)", (nombre_video,))
            conn.commit()
            print(f"Descarga insertada correctamente para el video: {nombre_video}✅")
        except Error as e:
            print(f"Error al insertar descarga: {e}❌")
        finally:
            cursor.close()
            conn.close()
    else:
        print("No se pudo establecer la conexión a la base de datos.❌")

def incrementar_descarga(nombre_video):
    conn = get_db_connection()
    if conn:
        try:
            cursor = conn.cursor()
            print(f"Intentando incrementar descarga para el video: {nombre_video}")
            cursor.execute("UPDATE descargas_videos SET cantidades = cantidades + 1 WHERE nombre_video = %s", (nombre_video,))
            conn.commit()
            print(f"Descarga incrementada correctamente para el video: {nombre_video} ✅")
        except Error as e:
            print(f"Error al incrementar descarga: {e} ❌")
        finally:
            cursor.close()
            conn.close()
    else:
        print("No se pudo establecer la conexión a la base de datos.❌")

def insert_video_to_db(video_path, video_title):
    conn = get_db_connection()
    if conn is None:
        return "Error al conectar con la base de datos❌"
    
    try:
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM descargas_videos WHERE nombre_video = %s", (video_title,))
        result = cursor.fetchone()
        if result:
            incrementar_descarga(video_title)
        else:
            with open(video_path, 'rb') as file:
                binary_data = file.read()
            query = "INSERT INTO descargas_videos (video, nombre_video) VALUES (%s, %s)"
            cursor.execute(query, (binary_data, video_title))
            conn.commit()
            print("Video insertado en la base de datos correctamente.✅")
    except Error as e:
        print(f"Error al insertar el video en la base de datos: {e}❌")
    finally:
        cursor.close()
        conn.close()

@app.route('/download', methods=['POST'])
def download():
    url = request.form['url']
    video_path, video_title = download_video(url)
    insert_video_to_db(video_path, video_title)
    
    # Obtener el ID del video descargado de la base de datos
    conn = get_db_connection()
    video_id = None
    if conn:
        try:
            cursor = conn.cursor()
            cursor.execute("SELECT idDescarga FROM descargas_videos WHERE nombre_video = %s", (video_title,))
            result = cursor.fetchone()
            if result:
                video_id = result[0]
        except Error as e:
            print(f"Error al obtener el ID del video: {e}❌")
        finally:
            cursor.close()
            conn.close()
    
    # Responder con el ID del video descargado
    return jsonify({
        "message": "Video descargado e insertado en la base de datos correctamente.✅",
        "idDescarga": video_id
    })


if __name__ == '__main__':
    app.run(debug=True)