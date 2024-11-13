SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


CREATE TABLE `descargas_videos` (
  `idDescarga` int(11) NOT NULL,
  `cantidades` int(11) DEFAULT 1,
  `nombre_video` varchar(255) NOT NULL,
  `video` longblob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `descargas_videos` (`idDescarga`, `cantidades`, `nombre_video`, `video`) VALUES
(9, 3, 'TARJETA GRÁFICA DE $25 vs $2500.mp4', ''),
(12, 7, 'como CONECTAR una base de datos MYSQL con PHP en xampp 🚀.mp4', '');
INSERT INTO `descargas_videos` (`idDescarga`, `cantidades`, `nombre_video`, `video`) VALUES
(19, 3, '1 Minute Timer Bomb [MISSION IMPOSSIBLE] 💣', );
INSERT INTO `descargas_videos` (`idDescarga`, `cantidades`, `nombre_video`, `video`) VALUES
(20, 15, '20.000 Logros en STEAM!!!!', );

CREATE TABLE `sesiones` (
  `session_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `last_activity` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `sesiones` (`session_id`, `usuario_id`, `username`, `last_activity`) VALUES
(0, 4, 'agus', '2024-11-13 10:59:33');

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `clave` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `usuarios` (`id`, `nombre`, `clave`) VALUES
(1, 'franco', '$2y$10$Gp7sjfBQIhA0Pft/HhLnSOq8EaLTP/9f3hse5LCsON1BrGOxNVT.W'),
(2, 'franquito', '$2y$10$eLQEPWMNaSrtegXux4/hU.I2k/c3z77f8hLOC92CvAMcpmIBnn72m'),
(3, 'fra', '$2y$10$nsGwfwgMxnGSiTbiloH1K.vj9zEyL5/9VyGeN9ZIC9FS6b3UwnjDy'),
(4, 'agus', '$2y$10$/yWnVEDmkgrTYv7eajRH9en5U8jEtZAZufi5Fb3Mq/8cCz63TtjIe');

CREATE TABLE `video_usuario` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `cant_descargas` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


ALTER TABLE `descargas_videos`
  ADD PRIMARY KEY (`idDescarga`);

ALTER TABLE `sesiones`
  ADD PRIMARY KEY (`session_id`),
  ADD KEY `fk_sesiones_usuario` (`usuario_id`);

ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `video_usuario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);


ALTER TABLE `descargas_videos`
  MODIFY `idDescarga` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

ALTER TABLE `video_usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;


ALTER TABLE `sesiones`
  ADD CONSTRAINT `fk_sesiones_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `video_usuario`
  ADD CONSTRAINT `video_usuario_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
