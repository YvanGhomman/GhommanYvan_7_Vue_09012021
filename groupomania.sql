-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : lun. 20 sep. 2021 à 09:06
-- Version du serveur :  5.7.31
-- Version de PHP : 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `groupomania`
--

-- --------------------------------------------------------

--
-- Structure de la table `article`
--

DROP TABLE IF EXISTS `article`;
CREATE TABLE IF NOT EXISTS `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `titre` varchar(255) NOT NULL,
  `contenu` text NOT NULL,
  `imageUrl` varchar(255) DEFAULT NULL,
  `date_creation` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `lien_article_user` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `article`
--

INSERT INTO `article` (`id`, `id_user`, `titre`, `contenu`, `imageUrl`, `date_creation`) VALUES
(1, 85, 'Bonjour à tous !', 'Bienvenue sur l\'espace de discussion interne de l\'entreprise !\nN\'hésitez pas à vous exprimer et à sympathiser.\nMais n\'oubliez pas que je veille sur ce que vous postez...\nBonne journée !', 'http://localhost:3000/images/binoculars-1209011_1920.jpg1631801409750.jpg', '2021-09-16 14:10:09'),
(2, 95, 'Encore coincé dans les bouchons', 'Les gens ne savent vraiment plus conduire ces temps-ci ...', 'http://localhost:3000/images/mario-kart8-death-stare.gif1631801736187.gif', '2021-09-16 14:15:36'),
(3, 96, 'Changement mobilier', 'Merci de ranger vos espaces de travail avant ce week-end. En effet, du nouveau mobilier devrait arriver et être mis en place pour votre retour Lundi matin. J\'ai en effet eu l\'idée d\'un bureau où chacun serait l\'égo de l\'autre et où tout le monde aurait droit à la parole. Voici un modèle que j\'ai vu chez notre fournisseur :', 'http://localhost:3000/images/1477903945_(1).jpg1631802663204.jpg', '2021-09-16 14:31:03'),
(4, 95, 'Le nouveau bureau est arrivé !', 'Je suis arrivé exprès en avance pour le voir avant tout le monde ! Il est si beau, ça transforme vraiment la pièce et en plus il y a déjà nos attributions de places. De ce que je vois, je suis à côté de notre PDG et pile en face de Wade ! Trop bien :D', NULL, '2021-09-16 14:40:44'),
(5, 98, 'Fumée au 3e étage', 'Je viens d\'arriver et je viens de voir les pompiers finir une intervention dans nos bureaux ! De ce qu\'ils m\'ont dit, la salle de réunion a été incendiée. Ils ne savent pas l\'origine du feu. Ils n\'ont rien put faire pour le nouveau mobilier ...', NULL, '2021-09-16 15:01:43'),
(6, 99, 'Suspect identifié', 'Après vérification du système de surveillance, je crois avoir trouvé le coupable de la destruction du mobilier', 'http://localhost:3000/images/photoeffets.com__final_256619074404951659_.jpg1631806080484.jpg', '2021-09-16 15:28:00'),
(8, 96, 'Programme de sortie professionnelle', 'Bon, suite à \"l\'énervement\" de certains dû à mon initiative de remplacer les bureaux de l\'open-space par une grande table ronde (je vous enverrais la facture pour les dégâts dû à l\'incendie Wade), j\'avais pour idée de faire une sortie entre nous afin de souder notre équipe. Je pensais à un voyage organisé en Brocéliande. Au programme : randonnées, visites de dolmens et châteaux et surtout on participera à la coutume locale qui est de tenter notre chance au rocher sacré. Il y a une sorte d\'épée à arracher, ça peut être marrant d\'essayer. Je ne sais pas pourquoi mais je sens que je peux y arriver...', NULL, '2021-09-16 15:41:01'),
(9, 95, 'Problème ectoplasme', 'Patron ??? Je crois que la visite des châteaux s\'est mal passée pour moi, j\'ai l\'impression qu\'on m\'épie depuis ...', 'http://localhost:3000/images/maxresdefault_(1).jpg1631811103056.jpg', '2021-09-16 16:51:43'),
(10, 96, 'Nouveau titre au bureau', 'Comme vous le savez tous, la sortie s\'est bien déroulée (sauf pour certains, toujours les mêmes...). Tellement bien passée que lors de la coutume de la région, j\'ai réussi à extirper l\'épée de leur rocher moisi. Suite à cela, ils n\'ont pas arrêté de m\'appeler \"Sire\". J\'aime bien ce titre, donc vous continuerez à m\'appelez comme cela au bureau !', 'http://localhost:3000/images/alexandre-astier-a-interprete-le-roi-arthur-pendant-6-saisons-de-kaamelott.jpg1631812105185.jpg', '2021-09-16 17:08:25'),
(11, 98, 'Mon nouvel animal de compagnie', 'Pour ma part, lors de la randonnée, j\'ai fait la connaissance d\'une créature étrange dans une des forêt qu\'on a traversé. Les habitants du coin appellent cela un elfe de Dagobah. Je ne sais pas trop ce que c\'est mais j\'ai décidé de la ramener avec moi. Est-ce que vous avez des idées de prénom ?', 'http://localhost:3000/images/the-mandalorian-14-din-grogu-690x460.jpg1631812487862.jpg', '2021-09-16 17:14:47');

-- --------------------------------------------------------

--
-- Structure de la table `commentaire`
--

DROP TABLE IF EXISTS `commentaire`;
CREATE TABLE IF NOT EXISTS `commentaire` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_article` int(11) DEFAULT NULL,
  `id_user` int(11) DEFAULT NULL,
  `commentary` text NOT NULL,
  `date_creation` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `lien_article_commentaire` (`id_article`),
  KEY `lien_user_commentaire` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `commentaire`
--

INSERT INTO `commentaire` (`id`, `id_article`, `id_user`, `commentary`, `date_creation`) VALUES
(1, 1, 95, 'Oh ... Merci de l\'information, je ferais attention ...', '2021-09-16 14:14:51'),
(2, 2, 96, 'Tachez de pas arriver en retard comme la dernière fois !', '2021-09-16 14:18:16'),
(3, 3, 95, 'Bonne idée patron, ça changera de ces espaces cloisonnés. On pourra enfin tous se voir !', '2021-09-16 14:35:46'),
(4, 3, 97, 'Tant que je ne suis pas en face de toi, ça me va ^^', '2021-09-16 14:44:39'),
(5, 4, 96, 'N\'en faites pas trop non plus', '2021-09-16 14:45:23'),
(7, 4, 97, 'QUOI ?! Je suis en face de toi ?! Je vais devoir employer les grands moyens !', '2021-09-16 14:47:52'),
(8, 1, 98, 'On fera de notre mieux, hâte de discuter avec tout le monde !', '2021-09-16 14:52:01'),
(10, 2, 98, 'Ah au fait, il faudra qu\'on discute de tes dégâts causés aux véhicules de fonction : sur le constat tu as écrit \"impact de carapace rouge\". Tu peux m\'expliquer ?', '2021-09-16 14:56:04'),
(11, 5, 96, 'MAIS QU\'EST-CE QUE VOUS AVEZ FOUTU ? QU\'EST-CE QU\'IL S\'EST PASSÉ ?', '2021-09-16 15:03:14'),
(12, 5, 97, 'Ahlala si seulement on pouvait connaitre le coupable. C\'est dommage d\'avoir perdu cette si belle table :/', '2021-09-16 15:04:56'),
(13, 1, 99, 'Je veillerais moi aussi, je serais l\'ombre', '2021-09-16 15:20:33'),
(14, 5, 99, 'Je vais enquêter sur cette affaire !', '2021-09-16 15:21:53'),
(15, 6, 96, 'WAAAAADE ? Des explications ?', '2021-09-16 15:28:36'),
(16, 6, 97, 'Et mince ! J\'ai oublié cette fichue caméra !', '2021-09-16 15:29:43'),
(17, 8, 95, 'Je sais pas trop si je veux venir, il paraît que par là-bas, les châteaux sont hantés, ça me fait un peu peur :(', '2021-09-16 16:37:21'),
(18, 8, 96, 'N\'importe quoi ! Vous viendrez, c\'est non négociable !', '2021-09-16 16:40:14'),
(19, 8, 97, 'Ne t\'inquiète pas Luigi, j\'assurerais ta protection :p', '2021-09-16 16:45:24'),
(20, 9, 96, 'Mais non, c\'est votre imagination ...', '2021-09-16 16:52:22'),
(21, 10, 95, 'Très bien Patron !', '2021-09-16 17:10:11'),
(22, 10, 95, 'Heu Sire, pardon ...', '2021-09-16 17:10:24'),
(23, 11, 96, 'Pourquoi pas Bohort ?', '2021-09-16 17:15:58'),
(24, 11, 95, 'Je pensais à \"Yoshi\", c\'est mignon', '2021-09-16 17:16:48'),
(25, 11, 97, 'Ah mais ça venait de là l\'odeur dans le bus du retour ! Pourquoi pas le \"Green Goblin\" ? Haha ;)', '2021-09-16 17:18:51'),
(26, 11, 99, 'Le Green Lantern ? Le Sphinx ? L\'Épouvantail ? ou encore ... Le Joker ?', '2021-09-16 17:24:25'),
(27, 11, 85, 'Et pourquoi pas tout simplement \"Grogu\" ?', '2021-09-16 17:25:08');

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `job` varchar(255) NOT NULL,
  `admin` tinyint(1) NOT NULL,
  `profilPic` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `name` (`name`),
  KEY `firstname` (`firstname`),
  KEY `profilPic` (`profilPic`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `email`, `password`, `name`, `firstname`, `job`, `admin`, `profilPic`) VALUES
(85, 'admin@groupomania.com', '$2b$10$iLy4g4SwFY4bcZCawqtWh.jMNWghI9BGGU2VDLZ9nxTn1nw.x84BK', 'Admin', 'Monsieur', 'Admin', 1, 'http://localhost:3000/profilPic/icon.png1631801192963.png'),
(95, 'luigi@groupomania.com', '$2b$10$mbip05llcSbM6mHJ2yA7DuwGhQFAip06bmze8XJHE3AI6I4qL2zTC', 'Bros', 'Luigi', 'Entretien', 0, 'http://localhost:3000/profilPic/Luigi_Infobox.png1631801636994.png'),
(96, 'arthur@groupomania.com', '$2b$10$vt5K/34nfyiiMGtRpdjx7OP.Qr2rxWuiZBCx7bfg.yTPCmdrDIwHa', 'Pendragon', 'Arthur', 'PDG', 0, 'http://localhost:3000/profilPic/Kaamelott-le-film-Le-tournage-a-commence.jpg1631801867057.jpg'),
(97, 'deadpool@groupomania.com', '$2b$10$d0Q9hcCx7qvhDZBUARbKd.nDjp8UK6YTlW5rAfHvIC0zEgJIY6VQu', 'Wilson', 'Wade', 'Securite', 0, 'http://localhost:3000/profilPic/heart-i-love-you.gif1631802810059.gif'),
(98, 'mando@groupomania.com', '$2b$10$QUsC8NM6ThDMAtd.cr9PYO0vb/zFo7MwohhKq1q81gway2kKiSXh6', 'Djarin', 'Mando', 'Logistique', 0, 'http://localhost:3000/profilPic/media.jpg1631803882324.jpg'),
(99, 'batman@groupomania.com', '$2b$10$hfjMGe1GAVuCOmL1yiOesOAikhMNhi7MK6MM6sckC0qIEeo6hjp9S', 'Wayne', 'Bruce', 'Surveillance', 0, 'http://localhost:3000/profilPic/christian-bale-dark-knight-rises-wallpaper-preview.jpg1631805601896.jpg');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `article`
--
ALTER TABLE `article`
  ADD CONSTRAINT `lien_article_user` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `commentaire`
--
ALTER TABLE `commentaire`
  ADD CONSTRAINT `lien_article_commentaire` FOREIGN KEY (`id_article`) REFERENCES `article` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `lien_user_commentaire` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
