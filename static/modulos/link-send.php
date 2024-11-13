<?php
// Conexión a la base de datos
$conn = new mysqli("localhost", "root", "", "inter_bd");
if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
}

// Función para obtener el contenido
function obtenerContenido($conn, $ubicacion)
{
    $stmt = $conn->prepare("SELECT contenido FROM contenido_estatico WHERE ubicacion = ?");
    $stmt->bind_param("s", $ubicacion);
    $stmt->execute();
    $contenido = null;
    $stmt->bind_result($contenido);
    $stmt->fetch();
    $stmt->close();
    return $contenido;
}

// Función para obtener el contenido de las imágenes
function obtenerImagen($conn, $ubicacion)
{
    $stmt = $conn->prepare("SELECT contenido, alt_text FROM contenido_estatico WHERE ubicacion = ?");
    $stmt->bind_param("s", $ubicacion);
    $stmt->execute();
    $src = $alt = null;
    $stmt->bind_result($src, $alt);
    $stmt->fetch();
    $stmt->close();
    return ["src" => $src, "alt" => $alt];
}
?>

<main style="width: 90%; overflow-y: hidden;">
    <div class="recuadros">
        <section class="flex column align-items-center">
            <h3><?= obtenerContenido($conn, 'titulo_descargar_video') ?></h3>
            <form class="flex row justify-row" id="download-form" method="POST">
                <div>
                    <label for="video-url">Pegar alado la URL: </label>
                </div>
                <div>
                    <input type="text" name="video-url" id="video-url" placeholder="Pegar el enlace aquí..." required>
                </div>
                <div>
                    <button type="submit">Obtener el video del enlace</button>
                </div>
            </form>
        </section>

        <?php $loadingGif = obtenerImagen($conn, 'loading_gif'); ?>
        <img src="<?= $loadingGif['src'] ?>" alt="<?= $loadingGif['alt'] ?>" id="loadingGif" style="display: none;">

        <section class="flex column align-items-center justify-content-center">
            <h2><?= obtenerContenido($conn, 'titulo_instant_download') ?></h2>
            <p><?= obtenerContenido($conn, 'descripcion_herramienta') ?></p>
        </section>

        <section class="flex column align-items-center justify-content-center">
            <h2><?= obtenerContenido($conn, 'titulo_descargar_mp3') ?></h2>
            <div class="flex row justify-content-center" id="tablet-query">
                <div class="flex row" id="text-img">
                    <?php $linkImage = obtenerImagen($conn, 'link_image'); ?>
                    <img src="<?= $linkImage['src'] ?>" alt="<?= $linkImage['alt'] ?>" width="32" height="32">
                    <div><?= obtenerContenido($conn, 'instruccion_link') ?></div>
                </div>
                <div class="flex row" id="text-img">
                    <?php $configImage = obtenerImagen($conn, 'configurator_image'); ?>
                    <img src="<?= $configImage['src'] ?>" alt="<?= $configImage['alt'] ?>" width="32" height="32">
                    <div><?= obtenerContenido($conn, 'instruccion_boton') ?></div>
                </div>
            </div>
        </section>
    </div>
</main>

<?php $conn->close(); ?>

<script>
    document.getElementById('download-form').addEventListener('submit', async function(event) {
        event.preventDefault();

        const url = document.getElementById('video-url').value;
        const loadingGif = document.getElementById('loadingGif');
        loadingGif.style.display = 'block';

        try {
            const response = await fetch('http://localhost:5000/download', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams({
                    url: url
                })
            });

            if (response.ok) {
                const data = await response.json();
                if (data.idDescarga) {
                    window.location.href = `http://127.0.0.1:5000/video/${data.idDescarga}`;
                } else {
                    alert('Error al obtener el ID del video.');
                }
            } else {
                alert('Error al descargar el video.');
            }
        } catch (error) {
            alert('Error al conectar con el servicio de descarga.');
        } finally {
            loadingGif.style.display = 'none';
        }
    });
</script>