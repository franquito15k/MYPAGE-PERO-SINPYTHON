<?php
include './conexion.php';
conectar();

if (isset($_GET['id'])) {
    $idDescarga = intval($_GET['id']);
    
    // Consulta para obtener el video desde la base de datos
    $stmt = $conn->prepare("SELECT video, nombre_video FROM descargas_videos WHERE idDescarga = ?");
    $stmt->bind_param("i", $idDescarga);
    $stmt->execute();
    $stmt->bind_result($videoBlob, $videoTitle);
    $stmt->fetch();
    $stmt->close();
    
    if ($videoBlob) {
        header('Content-Type: application/octet-stream');
        header("Content-Disposition: attachment; filename=\"$videoTitle.mp4\"");
        echo $videoBlob;
    } else {
        echo "<p>Error: Video no encontrado.</p>";
    }
}
?>
