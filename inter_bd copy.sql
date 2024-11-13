-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-11-2024 a las 21:48:11
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `inter_bd`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `descargas_videos`
--

CREATE TABLE `descargas_videos` (
  `idDescarga` int(11) NOT NULL,
  `cantidades` int(11) DEFAULT 1,
  `nombre_video` varchar(255) NOT NULL,
  `video` longblob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `descargas_videos`
--

INSERT INTO `descargas_videos` (`idDescarga`, `cantidades`, `nombre_video`, `video`) VALUES
(31, 1, '20.000 Logros en STEAM!!!!',123123 );

--
-- Disparadores `descargas_videos`
--
DELIMITER $$
CREATE TRIGGER `after_descarga_insert` AFTER INSERT ON `descargas_videos` FOR EACH ROW BEGIN
    DECLARE user_id INT;

    -- Obtener el usuario_id de la tabla sesiones donde session_id es 0
    SELECT usuario_id
    INTO user_id
    FROM sesiones
    WHERE session_id = 0
    LIMIT 1;

    -- Verificar si el usuario_id ya existe en la tabla video_usuario
    IF EXISTS (SELECT 1 FROM video_usuario WHERE usuario_id = user_id) THEN
        -- Si el usuario_id existe, incrementar cant_descargas
        UPDATE video_usuario
        SET cant_descargas = cant_descargas + 1
        WHERE usuario_id = user_id;
    ELSE
        -- Si no existe, insertar un nuevo registro con cant_descargas = 1
        INSERT INTO video_usuario (usuario_id, cant_descargas)
        VALUES (user_id, 1);
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_descarga_update` AFTER UPDATE ON `descargas_videos` FOR EACH ROW BEGIN
    DECLARE user_id INT;

    -- Obtener el usuario_id de la tabla sesiones donde session_id es 0
    SELECT usuario_id
    INTO user_id
    FROM sesiones
    WHERE session_id = 0
    LIMIT 1;

    -- Verificar si el usuario_id ya existe en la tabla video_usuario
    IF EXISTS (SELECT 1 FROM video_usuario WHERE usuario_id = user_id) THEN
        -- Si el usuario_id existe, incrementar cant_descargas
        UPDATE video_usuario
        SET cant_descargas = cant_descargas + 1
        WHERE usuario_id = user_id;
    ELSE
        -- Si no existe, insertar un nuevo registro con cant_descargas = 1
        INSERT INTO video_usuario (usuario_id, cant_descargas)
        VALUES (user_id, 1);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sections`
--

CREATE TABLE `sections` (
  `id` int(11) NOT NULL,
  `section_name` varchar(255) NOT NULL,
  `content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sections`
--

INSERT INTO `sections` (`id`, `section_name`, `content`) VALUES
(1, 'section1_h3', 'Descargar Videos Youtube'),
(2, 'section1_h2', 'Instant Download - El mejor descargador de mp4 de Youtube 2024'),
(3, 'section1_p', '\"Youtube to Video\" es una herramienta que permite descargar videos de Youtube rápidamente y en diversos formatos, como MP4, sin necesidad de conversión de audio.'),
(4, 'section1_img', './static/img/loadingcat.jpg'),
(5, 'section2_h2', 'Cómo descargar mp3 de Youtube más rápido'),
(6, 'section2_div1', 'Pegue el enlace convertir YouTube a MP3 en el cuadro de búsqueda'),
(7, 'section2_div2', 'Haga clic en el botón \"Obtener video del enlace\"'),
(8, 'section2_img1', './static/img/link-solid.png'),
(9, 'section2_img2', './static/img/settings.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sesiones`
--

CREATE TABLE `sesiones` (
  `session_id` int(11) NOT NULL DEFAULT 0,
  `usuario_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `last_activity` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sesiones`
--

INSERT INTO `sesiones` (`session_id`, `usuario_id`, `username`, `last_activity`) VALUES
(0, 5, 'ma', '2024-11-13 20:35:15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `clave` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `clave`) VALUES
(1, 'franco', '$2y$10$Gp7sjfBQIhA0Pft/HhLnSOq8EaLTP/9f3hse5LCsON1BrGOxNVT.W'),
(2, 'franquito', '$2y$10$eLQEPWMNaSrtegXux4/hU.I2k/c3z77f8hLOC92CvAMcpmIBnn72m'),
(3, 'fra', '$2y$10$nsGwfwgMxnGSiTbiloH1K.vj9zEyL5/9VyGeN9ZIC9FS6b3UwnjDy'),
(4, 'agus', '$2y$10$/yWnVEDmkgrTYv7eajRH9en5U8jEtZAZufi5Fb3Mq/8cCz63TtjIe'),
(5, 'ma', '$2y$10$h/1w2GmBlSBY6E8taCOBrOVJ3bp4zto8KuxnWajRcxI5VBCsji.V2');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `video_usuario`
--

CREATE TABLE `video_usuario` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `cant_descargas` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `video_usuario`
--

INSERT INTO `video_usuario` (`id`, `usuario_id`, `cant_descargas`) VALUES
(1, 4, 4),
(3, 1, 21),
(4, 3, 1),
(5, 5, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `descargas_videos`
--
ALTER TABLE `descargas_videos`
  ADD PRIMARY KEY (`idDescarga`);

--
-- Indices de la tabla `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `sesiones`
--
ALTER TABLE `sesiones`
  ADD PRIMARY KEY (`session_id`),
  ADD KEY `fk_sesiones_usuario` (`usuario_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `video_usuario`
--
ALTER TABLE `video_usuario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `descargas_videos`
--
ALTER TABLE `descargas_videos`
  MODIFY `idDescarga` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT de la tabla `sections`
--
ALTER TABLE `sections`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `video_usuario`
--
ALTER TABLE `video_usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `sesiones`
--
ALTER TABLE `sesiones`
  ADD CONSTRAINT `fk_sesiones_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `video_usuario`
--
ALTER TABLE `video_usuario`
  ADD CONSTRAINT `video_usuario_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
