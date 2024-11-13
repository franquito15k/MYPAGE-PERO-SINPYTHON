<?php
function conectar()
{
    global $con;
    $host = "localhost";
    $username = "root";
    $password = "";
    $db = "inter_bd";

    $con = mysqli_connect($host, $username, $password, $db);
    if (mysqli_connect_errno()) {
        printf("Falló la conexión: %s\n", mysqli_connect_error());
        exit();
    } else {
        $con->set_charset("utf8");
        $ret = true;
    }

    return $ret;
}
function desconectar()
{
    global $con;
    mysqli_close($con);
}
