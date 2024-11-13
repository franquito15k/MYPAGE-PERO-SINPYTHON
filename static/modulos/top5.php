<aside class="top10-songs" style="width: 85%;">
    <?php
    // Configuración de la base de datos
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "inter_bd";

    // Crear conexión
    $conn = new mysqli($servername, $username, $password, $dbname);

    // Verificar conexión
    $sql = "SELECT nombre_video, cantidades FROM descargas_videos ORDER BY cantidades DESC LIMIT 5";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        echo "<h1>Top 5 Videos Más Descargados</h1>";
        echo "<ul>";
        // Salida de datos de cada fila
        while ($row = $result->fetch_assoc()) {
            echo "<li>" . $row["nombre_video"] . " - " . $row["cantidades"] . " descargas</li>";
        }
        echo "</ul>";
    } else {
        echo "0 resultados";
    }

    // Cerrar conexión
    $conn->close();
    ?>
</aside>