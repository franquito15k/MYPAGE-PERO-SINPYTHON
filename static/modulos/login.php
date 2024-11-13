<?php
//cerrar sesion
//cerrar sesion
if (isset($_GET['salir'])) {
    // Delete all session data from sesiones table
    $delete_all_sessions_sql = "DELETE FROM sesiones";
    mysqli_query($con, $delete_all_sessions_sql);

    session_destroy();
    echo "<script>window.location='index.php';</script>";
}

//iniciar sesion
if (isset($_POST['nombre']) && isset($_POST['clave'])) {
    $sql = "SELECT * FROM usuarios WHERE nombre='" . $_POST['nombre'] . "'";
    $sql = mysqli_query($con, $sql);
    if (mysqli_num_rows($sql) != 0) {
        $r = mysqli_fetch_array($sql);
        if (password_verify(addslashes($_POST['clave']), $r['clave'])) {
            //crear las vbles. de sesion
            $_SESSION['id'] = $r['id'];
            $_SESSION['nombre_usuario'] = $r['nombre'];
            echo "<script>alert('Bienvenido: " . $_SESSION['nombre_usuario'] . "');</script>";

            // Insert session data into sesiones table
            $usuario_id = $r['id'];
            $username = $r['nombre'];
            $insert_session_sql = "INSERT INTO sesiones (usuario_id, username) VALUES ('$usuario_id', '$username')";
            mysqli_query($con, $insert_session_sql);
        } else {
            echo "<script>alert('Clave incorrecta.');</script>";
        }
    } else {
        echo "<script>alert('Verifique los datos.');</script>";
    }
    echo "<script>window.location='index.php';</script>";
}
?>
<section id="login" class="section" style="height: auto; width: auto;">
    <h2>Iniciar Sesión</h2>
    <form action="index.php?modulo=login" method="POST">
        <label for="login-username">Nombre de Usuario:</label>
        <input type="text" id="nombre" name="nombre" required>
        <label for="login-password">Clave:</label>
        <input type="password" id="clave" name="clave" required>
        <button type="submit">Iniciar Sesión</button>
    </form>
</section>