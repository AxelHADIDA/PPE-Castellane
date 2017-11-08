SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

DROP TABLE IF EXISTS `appartenir`;
CREATE TABLE IF NOT EXISTS `appartenir` (
  `N_Client` int(11) NOT NULL,
  `degre` int(11) NOT NULL,
  PRIMARY KEY (`N_Client`,`degre`),
  KEY `FK_appartenir_degre` (`degre`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `client`;
CREATE TABLE IF NOT EXISTS `client` (
  `N_Client` int(11) NOT NULL,
  `nom_client` varchar(25) DEFAULT NULL,
  `Prenom_client` varchar(25) DEFAULT NULL,
  `Adresse_client` varchar(25) DEFAULT NULL,
  `Date_de_naissance` date DEFAULT NULL,
  `Telephone` int(11) DEFAULT NULL,
  `Date_inscription` date DEFAULT NULL,
  `mode_facturation` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`N_Client`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `etablissement`;
CREATE TABLE IF NOT EXISTS `etablissement` (
  `degre` int(11) NOT NULL,
  `nom` varchar(25) DEFAULT NULL,
  `adresse` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`degre`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `etudiant`;
CREATE TABLE IF NOT EXISTS `etudiant` (
  `niveau_etude` varchar(25) DEFAULT NULL,
  `reduction` int(11) DEFAULT NULL,
  `N_Client` int(11) NOT NULL,
  PRIMARY KEY (`N_Client`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `events`;
CREATE TABLE IF NOT EXISTS `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `color` varchar(7) DEFAULT NULL,
  `start` datetime NOT NULL,
  `end` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

INSERT INTO `events` (`id`, `title`, `color`, `start`, `end`) VALUES
(1, 'Heure Conduite', '', '2017-11-08 00:00:00', '2017-11-09 00:00:00'),
(3, 'Heure Conduite', '#008000', '2017-11-09 00:00:00', '2017-11-10 00:00:00');

DROP TABLE IF EXISTS `exam`;
CREATE TABLE IF NOT EXISTS `exam` (
  `id_exam` varchar(25) NOT NULL,
  `code_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_exam`),
  KEY `FK_Exam_code_type` (`code_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `exam_code`;
CREATE TABLE IF NOT EXISTS `exam_code` (
  `date_c` date DEFAULT NULL,
  `heure_c` time DEFAULT NULL,
  `resultat_c` int(11) DEFAULT NULL,
  `id_exam` varchar(25) NOT NULL,
  `N_Client` int(11) NOT NULL,
  PRIMARY KEY (`id_exam`,`N_Client`),
  KEY `FK_Exam_code_N_Client` (`N_Client`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `exam_permis`;
CREATE TABLE IF NOT EXISTS `exam_permis` (
  `date_p` date DEFAULT NULL,
  `heure_p` time DEFAULT NULL,
  `resultat_p` int(11) DEFAULT NULL,
  `id_exam` varchar(25) NOT NULL,
  `N_Client` int(11) NOT NULL,
  PRIMARY KEY (`id_exam`,`N_Client`),
  KEY `FK_Exam_permis_N_Client` (`N_Client`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `lecon`;
CREATE TABLE IF NOT EXISTS `lecon` (
  `N_lecon` int(11) NOT NULL,
  `Date_lecon` date DEFAULT NULL,
  `Heure_lecon` int(11) DEFAULT NULL,
  `tarif_heure` int(11) DEFAULT NULL,
  PRIMARY KEY (`N_lecon`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `modele`;
CREATE TABLE IF NOT EXISTS `modele` (
  `Code_modele` int(11) NOT NULL,
  `nom_modele` varchar(25) DEFAULT NULL,
  `annee_modele` year(4) DEFAULT NULL,
  PRIMARY KEY (`Code_modele`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `mois`;
CREATE TABLE IF NOT EXISTS `mois` (
  `N_Mois` int(11) NOT NULL,
  `Annee` year(4) DEFAULT NULL,
  PRIMARY KEY (`N_Mois`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `moniteur`;
CREATE TABLE IF NOT EXISTS `moniteur` (
  `N_Moniteur` int(11) NOT NULL,
  `nom_monteur` varchar(25) DEFAULT NULL,
  `date_d_embauche` date DEFAULT NULL,
  PRIMARY KEY (`N_Moniteur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `moniteur` (`N_Moniteur`, `nom_monteur`, `date_d_embauche`) VALUES
(1, 'David', '2011-11-04'),
(2, 'Luc', '2012-05-20'),
(3, 'Alfonse', '2010-06-01'),
(4, 'Mohamed', '2015-12-30');

DROP TABLE IF EXISTS `moto`;
CREATE TABLE IF NOT EXISTS `moto` (
  `cylindre` varchar(25) DEFAULT NULL,
  `puissance` int(11) DEFAULT NULL,
  `Code_modele` int(11) NOT NULL,
  PRIMARY KEY (`Code_modele`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `planning`;
CREATE TABLE IF NOT EXISTS `planning` (
  `Date_heure_debut` date DEFAULT NULL,
  `Date_heure_fin` date DEFAULT NULL,
  `N_Moniteur` int(11) NOT NULL,
  `N_Client` int(11) NOT NULL,
  `N_lecon` int(11) NOT NULL,
  `N_vehicule` int(11) NOT NULL,
  PRIMARY KEY (`N_Moniteur`,`N_Client`,`N_lecon`,`N_vehicule`),
  KEY `FK_Planning_N_Client` (`N_Client`),
  KEY `FK_Planning_N_lecon` (`N_lecon`),
  KEY `FK_Planning_N_vehicule` (`N_vehicule`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `rouler`;
CREATE TABLE IF NOT EXISTS `rouler` (
  `N_km_parcourus_dans_le_mois` int(11) DEFAULT NULL,
  `N_Mois` int(11) NOT NULL,
  `N_vehicule` int(11) NOT NULL,
  PRIMARY KEY (`N_Mois`,`N_vehicule`),
  KEY `FK_Rouler_N_vehicule` (`N_vehicule`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `salarie`;
CREATE TABLE IF NOT EXISTS `salarie` (
  `nom_entreprise` varchar(25) DEFAULT NULL,
  `N_Client` int(11) NOT NULL,
  PRIMARY KEY (`N_Client`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `type_exam`;
CREATE TABLE IF NOT EXISTS `type_exam` (
  `code_type` int(11) NOT NULL,
  `libelle_type` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`code_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(30) NOT NULL,
  `userEmail` varchar(60) NOT NULL,
  `userPass` varchar(255) NOT NULL,
  PRIMARY KEY (`userId`),
  UNIQUE KEY `userEmail` (`userEmail`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

INSERT INTO `users` (`userId`, `userName`, `userEmail`, `userPass`) VALUES
(1, 'Axel Hadida', 'axel.hadida@outlook.fr', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92'),
(2, 'PlanÃ§on Mederick', 'mede58@live.fr', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92'),
(3, 'Akram Oumar', 'oumar.akram@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92');

DROP TABLE IF EXISTS `utiliser`;
CREATE TABLE IF NOT EXISTS `utiliser` (
  `N_lecon` int(11) NOT NULL,
  `N_vehicule` int(11) NOT NULL,
  PRIMARY KEY (`N_lecon`,`N_vehicule`),
  KEY `FK_utiliser_N_vehicule` (`N_vehicule`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `vehicule`;
CREATE TABLE IF NOT EXISTS `vehicule` (
  `N_vehicule` int(11) NOT NULL,
  `N_immatriculation` int(11) DEFAULT NULL,
  `date_achat` date DEFAULT NULL,
  `nb_km_initial` int(11) DEFAULT NULL,
  `Code_modele` int(11) DEFAULT NULL,
  PRIMARY KEY (`N_vehicule`),
  KEY `FK_Vehicule_Code_modele` (`Code_modele`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `voiture`;
CREATE TABLE IF NOT EXISTS `voiture` (
  `type_conso` int(11) DEFAULT NULL,
  `Code_modele` int(11) NOT NULL,
  PRIMARY KEY (`Code_modele`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE `appartenir`
  ADD CONSTRAINT `FK_appartenir_N_Client` FOREIGN KEY (`N_Client`) REFERENCES `client` (`N_Client`),
  ADD CONSTRAINT `FK_appartenir_degre` FOREIGN KEY (`degre`) REFERENCES `etablissement` (`degre`);

ALTER TABLE `etudiant`
  ADD CONSTRAINT `FK_Etudiant_N_Client` FOREIGN KEY (`N_Client`) REFERENCES `client` (`N_Client`);

ALTER TABLE `exam`
  ADD CONSTRAINT `FK_Exam_code_type` FOREIGN KEY (`code_type`) REFERENCES `type_exam` (`code_type`);

ALTER TABLE `exam_code`
  ADD CONSTRAINT `FK_Exam_code_N_Client` FOREIGN KEY (`N_Client`) REFERENCES `client` (`N_Client`),
  ADD CONSTRAINT `FK_Exam_code_id_exam` FOREIGN KEY (`id_exam`) REFERENCES `exam` (`id_exam`);

ALTER TABLE `exam_permis`
  ADD CONSTRAINT `FK_Exam_permis_N_Client` FOREIGN KEY (`N_Client`) REFERENCES `client` (`N_Client`),
  ADD CONSTRAINT `FK_Exam_permis_id_exam` FOREIGN KEY (`id_exam`) REFERENCES `exam` (`id_exam`);

ALTER TABLE `moto`
  ADD CONSTRAINT `FK_Moto_Code_modele` FOREIGN KEY (`Code_modele`) REFERENCES `modele` (`Code_modele`);

ALTER TABLE `planning`
  ADD CONSTRAINT `FK_Planning_N_Client` FOREIGN KEY (`N_Client`) REFERENCES `client` (`N_Client`),
  ADD CONSTRAINT `FK_Planning_N_Moniteur` FOREIGN KEY (`N_Moniteur`) REFERENCES `moniteur` (`N_Moniteur`),
  ADD CONSTRAINT `FK_Planning_N_lecon` FOREIGN KEY (`N_lecon`) REFERENCES `lecon` (`N_lecon`),
  ADD CONSTRAINT `FK_Planning_N_vehicule` FOREIGN KEY (`N_vehicule`) REFERENCES `vehicule` (`N_vehicule`);

ALTER TABLE `rouler`
  ADD CONSTRAINT `FK_Rouler_N_Mois` FOREIGN KEY (`N_Mois`) REFERENCES `mois` (`N_Mois`),
  ADD CONSTRAINT `FK_Rouler_N_vehicule` FOREIGN KEY (`N_vehicule`) REFERENCES `vehicule` (`N_vehicule`);

ALTER TABLE `salarie`
  ADD CONSTRAINT `FK_salarie_N_Client` FOREIGN KEY (`N_Client`) REFERENCES `client` (`N_Client`);

ALTER TABLE `utiliser`
  ADD CONSTRAINT `FK_utiliser_N_lecon` FOREIGN KEY (`N_lecon`) REFERENCES `lecon` (`N_lecon`),
  ADD CONSTRAINT `FK_utiliser_N_vehicule` FOREIGN KEY (`N_vehicule`) REFERENCES `vehicule` (`N_vehicule`);

ALTER TABLE `vehicule`
  ADD CONSTRAINT `FK_Vehicule_Code_modele` FOREIGN KEY (`Code_modele`) REFERENCES `modele` (`Code_modele`);

ALTER TABLE `voiture`
  ADD CONSTRAINT `FK_voiture_Code_modele` FOREIGN KEY (`Code_modele`) REFERENCES `modele` (`Code_modele`);
COMMIT;