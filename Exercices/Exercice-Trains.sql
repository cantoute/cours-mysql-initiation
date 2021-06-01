SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

CREATE TABLE `gare` (
  `id` int(11) NOT NULL,
  `nom` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `gare` (`id`, `nom`) VALUES
(1, 'Paris'),
(2, 'Lyon'),
(3, 'Marseille'),
(4, 'Toulouse'),
(5, 'Lille');

CREATE TABLE `modele` (
  `id` int(11) NOT NULL,
  `nom` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `modele` (`id`, `nom`) VALUES
(1, 'TGV'),
(2, 'TER'),
(3, 'Fret');

CREATE TABLE `train` (
  `id` int(11) NOT NULL,
  `modele_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `train` (`id`, `modele_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 2),
(6, 2),
(7, 2),
(8, 2),
(9, 3),
(10, 3),
(11, 3),
(12, 3);

CREATE TABLE `trajet` (
  `id` int(11) NOT NULL,
  `dep_gare_id` int(11) NOT NULL,
  `arr_gare_id` int(11) NOT NULL,
  `train_id` int(11) NOT NULL,
  `heure_dep` time NOT NULL,
  `heure_arr` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `trajet` (`id`, `dep_gare_id`, `arr_gare_id`, `train_id`, `heure_dep`, `heure_arr`) VALUES
(2, 1, 5, 8, '02:00:00', '08:00:00'),
(3, 1, 2, 7, '09:00:00', '19:00:00'),
(4, 1, 3, 6, '03:00:00', '14:00:00'),
(5, 2, 3, 5, '15:00:00', '23:00:00'),
(6, 3, 4, 1, '13:00:00', '18:00:00'),
(7, 3, 5, 2, '16:00:00', '21:00:00'),
(8, 4, 5, 3, '10:00:00', '22:00:00'),
(9, 4, 1, 4, '05:00:00', '19:00:00'),
(10, 5, 3, 9, '04:00:00', '00:00:00'),
(11, 5, 2, 10, '01:00:00', '17:00:00'),
(12, 2, 1, 11, '06:00:00', '12:00:00'),
(13, 2, 5, 12, '07:00:00', '20:00:00');


ALTER TABLE `gare`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `modele`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `train`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `trajet`
  ADD PRIMARY KEY (`id`);


ALTER TABLE `gare`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

ALTER TABLE `modele`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE `train`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

ALTER TABLE `trajet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;


ALTER TABLE `train`
  ADD CONSTRAINT `fk_train_modele_id` FOREIGN KEY (`modele_id`) REFERENCES `modele` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `trajet`
  ADD CONSTRAINT `fk_trajet_dep_gare_id` FOREIGN KEY (`dep_gare_id`) REFERENCES `gare` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_trajet_arr_gare_id` FOREIGN KEY (`arr_gare_id`) REFERENCES `gare` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_trajet_train_id` FOREIGN KEY (`train_id`) REFERENCES `train` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
