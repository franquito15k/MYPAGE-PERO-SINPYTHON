<?php
session_start();
include './static/modulos/conexion.php';
conectar();

?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Instant Download</title>
    <link rel="stylesheet" href="./static/css/styles.css">
    <script src="./static/js/jquery.tabledit.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
        href="https://fonts.googleapis.com/css2?family=Nunito:wght@200..1000&display=swap"
        rel="stylesheet" />
    <script src="https://markcell.github.io/jquery-tabledit/assets/js/jquery.tabledit.min.js"></script>
</head>

<body>
    <header>
        <nav class="flex row">
            <div class="flex row" id="nav" style="visibility: visible;">
                <a class="buttom-style" href="index.php" id="home">Instant Download</a>
                <ul class="flex row" id="button-nav" style="list-style-type: none;">
                    <li><a href="index.php?modulo=login" class="buttom-style">Login</a></li>
                    <li><a href="index.php?modulo=register" class="buttom-style">Registro</a></li>
                </ul>
            </div>
            <nav id="menu" style="visibility: hidden;">
                <ul>
                    <li><a href="index.php">Instant Download</a></li>
                    <li><a href="index.php?modulo=login" class="buttom-style">Login</a></li>
                    <li><a href="index.php?modulo=register" class="buttom-style">Registro</a></li>
                </ul>
            </nav>
            <div class="flex row align-items-center ">
                <?php
                if (!empty($_SESSION['nombre_usuario'])) {
                ?>
                    <p style="color: #ce796b; background-color: #461220; padding: 10px; margin-right: 10px; border-radius: 5px; box-shadow: #ce796b;">Hola <strong><?php echo $_SESSION['nombre_usuario']; ?></strong></p>
                    <a href="index.php?modulo=login&salir=ok" class="buttom-style">SALIR</a>
                <?php
                }
                ?>
            </div>
        </nav>
    </header>

    <div class="content-wrapper">
        <main>
            <?php
            if (isset($_GET['modulo'])) {
                $modulo = $_GET['modulo'];
                if ($modulo == 'login') {
                    include './static/modulos/login.php';
                } elseif ($modulo == 'register') {
                    include './static/modulos/register.php';
                } elseif ($modulo == 'link-send') {
                    include './static/modulos/link-send.php';
                }
            } else {
                include './static/modulos/link-send.php';
            }
            ?>
        </main>
        <aside>
            <?php
            include './static/modulos/top5.php';
            ?>
        </aside>
    </div>

    <footer>

    </footer>
</body>

</html>