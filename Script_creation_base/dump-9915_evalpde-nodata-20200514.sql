-- MySQL dump 10.13  Distrib 5.5.60, for Linux (x86_64)
--
-- Host: localhost    Database: 9915_evalpde
-- ------------------------------------------------------
-- Server version	5.5.60-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary table structure for view `action_view`
--

DROP TABLE IF EXISTS `action_view`;
/*!50001 DROP VIEW IF EXISTS `action_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `action_view` (
  `evaluation_id` tinyint NOT NULL,
  `mat_attribut_id` tinyint NOT NULL,
  `mat_attribut_nom` tinyint NOT NULL,
  `selectionne` tinyint NOT NULL,
  `avancement` tinyint NOT NULL,
  `selectionne_eval_precedent` tinyint NOT NULL,
  `avancement_eval_precedent` tinyint NOT NULL,
  `position_bloc` tinyint NOT NULL,
  `position_groupe` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `auth_filtre`
--

DROP TABLE IF EXISTS `auth_filtre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_filtre` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(45) NOT NULL,
  `nom` varchar(64) DEFAULT NULL,
  `strategy` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE_idx` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_filtre_permission`
--

DROP TABLE IF EXISTS `auth_filtre_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_filtre_permission` (
  `filtre_id` int(11) NOT NULL DEFAULT '0',
  `permission_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`filtre_id`,`permission_id`),
  KEY `fk_auth_filtre_permission_permission1_idx` (`permission_id`),
  KEY `fk_auth_filtre_permission_filtre1_idx` (`filtre_id`),
  CONSTRAINT `auth_filtre_permission_filtre_id_auth_filtre_id` FOREIGN KEY (`filtre_id`) REFERENCES `auth_filtre` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `auth_filtre_permission_permission_id_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(45) NOT NULL,
  `nom` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE_idx` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_profil`
--

DROP TABLE IF EXISTS `auth_profil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_profil` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(45) NOT NULL,
  `nom` varchar(45) NOT NULL,
  `dispo_inscription` tinyint(1) NOT NULL DEFAULT '0',
  `priorite` int(11) NOT NULL DEFAULT '1',
  `description` text,
  `libelle` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE_idx` (`code`),
  UNIQUE KEY `priorite_UNIQUE_idx` (`priorite`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_profil_administrable`
--

DROP TABLE IF EXISTS `auth_profil_administrable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_profil_administrable` (
  `auth_profil_id` int(11) NOT NULL DEFAULT '0',
  `auth_profil_administrable_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`auth_profil_id`,`auth_profil_administrable_id`),
  KEY `fk_auth_profil_has_auth_profil_auth_profil2_idx` (`auth_profil_administrable_id`),
  KEY `fk_auth_profil_has_auth_profil_auth_profil1_idx` (`auth_profil_id`),
  CONSTRAINT `aaai` FOREIGN KEY (`auth_profil_administrable_id`) REFERENCES `auth_profil` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `auth_profil_administrable_auth_profil_id_auth_profil_id` FOREIGN KEY (`auth_profil_id`) REFERENCES `auth_profil` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_profil_filtre`
--

DROP TABLE IF EXISTS `auth_profil_filtre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_profil_filtre` (
  `profil_id` int(11) NOT NULL DEFAULT '0',
  `filtre_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`profil_id`,`filtre_id`),
  KEY `fk_auth_profil_filtre_filtre1_idx` (`filtre_id`),
  KEY `fk_auth_profil_filtre_profil1_idx` (`profil_id`),
  CONSTRAINT `auth_profil_filtre_filtre_id_auth_filtre_id` FOREIGN KEY (`filtre_id`) REFERENCES `auth_filtre` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `auth_profil_filtre_profil_id_auth_profil_id` FOREIGN KEY (`profil_id`) REFERENCES `auth_profil` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_profil_permission`
--

DROP TABLE IF EXISTS `auth_profil_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_profil_permission` (
  `profil_id` int(11) NOT NULL DEFAULT '0',
  `permission_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`profil_id`,`permission_id`),
  KEY `fk_auth_profil_permission_permission1_idx` (`permission_id`),
  KEY `fk_auth_profil_permission_role1_idx` (`profil_id`),
  CONSTRAINT `auth_profil_permission_permission_id_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `auth_profil_permission_profil_id_auth_profil_id` FOREIGN KEY (`profil_id`) REFERENCES `auth_profil` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `classe_effectif`
--

DROP TABLE IF EXISTS `classe_effectif`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classe_effectif` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(80) NOT NULL,
  `min` smallint(6) NOT NULL DEFAULT '0',
  `max` smallint(6) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `demenagement`
--

DROP TABLE IF EXISTS `demenagement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `demenagement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(64) NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etablissement`
--

DROP TABLE IF EXISTS `etablissement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etablissement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `raison_sociale` varchar(64) NOT NULL,
  `adresse_no` varchar(10) DEFAULT NULL,
  `adresse_voie` text,
  `code_postal` varchar(5) DEFAULT NULL,
  `geo_ville_id` int(11) NOT NULL,
  `siret` char(14) DEFAULT NULL,
  `effectif` int(10) unsigned NOT NULL,
  `date_entree` date DEFAULT NULL,
  `nom_demarche` varchar(80) DEFAULT NULL,
  `naf_sous_classe_id` int(11) NOT NULL,
  `structure_juridique_id` int(11) NOT NULL,
  `referent_id` int(11) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `en_attente` tinyint(1) NOT NULL DEFAULT '1',
  `date_validation` datetime DEFAULT NULL,
  `latitude` double(18,10) DEFAULT NULL,
  `longitude` double(18,10) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `perim_pdu` tinyint(1) DEFAULT NULL,
  `volont_pdu` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_etablissement_naf_sous_classe1_idx` (`naf_sous_classe_id`),
  KEY `fk_etablissement_structure_juridique1_idx` (`structure_juridique_id`),
  KEY `fk_etablissement_user1_idx` (`referent_id`),
  KEY `fk_etablissement_geo_ville1_idx` (`geo_ville_id`),
  CONSTRAINT `etablissement_geo_ville_id_geo_ville_id` FOREIGN KEY (`geo_ville_id`) REFERENCES `geo_ville` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `etablissement_naf_sous_classe_id_naf_sous_classe_id` FOREIGN KEY (`naf_sous_classe_id`) REFERENCES `naf_sous_classe` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `etablissement_referent_id_user_id` FOREIGN KEY (`referent_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `etablissement_structure_juridique_id_structure_juridique_id` FOREIGN KEY (`structure_juridique_id`) REFERENCES `structure_juridique` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=240 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etablissement_structure`
--

DROP TABLE IF EXISTS `etablissement_structure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etablissement_structure` (
  `etablissement_id` int(11) NOT NULL DEFAULT '0',
  `structure_id` int(11) NOT NULL DEFAULT '0',
  `statut_demande_id` int(11) NOT NULL DEFAULT '3',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`etablissement_id`,`structure_id`),
  KEY `fk_eta_structure_structure1_idx` (`structure_id`),
  KEY `fk_eta_structure_etablissement1_idx` (`etablissement_id`),
  KEY `fk_etat_structure_statut_demande1_idx` (`statut_demande_id`),
  CONSTRAINT `etablissement_structure_etablissement_id_etablissement_id` FOREIGN KEY (`etablissement_id`) REFERENCES `etablissement` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `etablissement_structure_statut_demande_id_statut_demande_id` FOREIGN KEY (`statut_demande_id`) REFERENCES `statut_demande` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `etablissement_structure_structure_id_structure_id` FOREIGN KEY (`structure_id`) REFERENCES `structure` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eval_attribut`
--

DROP TABLE IF EXISTS `eval_attribut`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eval_attribut` (
  `evaluation_id` int(11) NOT NULL DEFAULT '0',
  `mat_attribut_id` int(11) NOT NULL DEFAULT '0',
  `value` mediumblob,
  PRIMARY KEY (`evaluation_id`,`mat_attribut_id`),
  KEY `fk_evaluation_mat_attribut_mat_attribut1_idx` (`mat_attribut_id`),
  KEY `fk_evaluation_mat_attribut_evaluation1_idx` (`evaluation_id`),
  CONSTRAINT `eval_attribut_evaluation_id_evaluation_id` FOREIGN KEY (`evaluation_id`) REFERENCES `evaluation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `eval_attribut_mat_attribut_id_mat_attribut_id` FOREIGN KEY (`mat_attribut_id`) REFERENCES `mat_attribut` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eval_famille`
--

DROP TABLE IF EXISTS `eval_famille`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eval_famille` (
  `evaluation_id` int(11) NOT NULL DEFAULT '0',
  `mat_famille_id` int(11) NOT NULL DEFAULT '0',
  `champs_requis_remplis` tinyint(1) NOT NULL DEFAULT '0',
  `est_validee` tinyint(1) NOT NULL DEFAULT '0',
  `date_validee` datetime DEFAULT NULL,
  `est_debutee` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`evaluation_id`,`mat_famille_id`),
  KEY `fk_evaluation_mat_famille_mat_famille2_idx` (`mat_famille_id`),
  KEY `fk_evaluation_mat_famille_evaluation2_idx` (`evaluation_id`),
  CONSTRAINT `eval_famille_evaluation_id_evaluation_id` FOREIGN KEY (`evaluation_id`) REFERENCES `evaluation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `eval_famille_mat_famille_id_mat_famille_id` FOREIGN KEY (`mat_famille_id`) REFERENCES `mat_famille` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `eval_famille_modifiee_view`
--

DROP TABLE IF EXISTS `eval_famille_modifiee_view`;
/*!50001 DROP VIEW IF EXISTS `eval_famille_modifiee_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `eval_famille_modifiee_view` (
  `evaluation_id` tinyint NOT NULL,
  `mat_famille_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `eval_option`
--

DROP TABLE IF EXISTS `eval_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eval_option` (
  `evaluation_id` int(11) NOT NULL DEFAULT '0',
  `mat_attribut_id` int(11) NOT NULL DEFAULT '0',
  `mat_option_id` int(11) NOT NULL DEFAULT '0',
  `value` int(11) NOT NULL,
  PRIMARY KEY (`evaluation_id`,`mat_attribut_id`,`mat_option_id`),
  KEY `fk_eval_option_mat_option1_idx` (`mat_option_id`),
  KEY `fk_eval_option_evaluation1_idx` (`evaluation_id`),
  KEY `fk_eval_option_mat_attribut1_idx` (`mat_attribut_id`),
  CONSTRAINT `eval_option_evaluation_id_evaluation_id` FOREIGN KEY (`evaluation_id`) REFERENCES `evaluation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `eval_option_mat_attribut_id_mat_attribut_id` FOREIGN KEY (`mat_attribut_id`) REFERENCES `mat_attribut` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `eval_option_mat_option_id_mat_option_id` FOREIGN KEY (`mat_option_id`) REFERENCES `mat_option` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `eval_precedente`
--

DROP TABLE IF EXISTS `eval_precedente`;
/*!50001 DROP VIEW IF EXISTS `eval_precedente`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `eval_precedente` (
  `etablissement_id` tinyint NOT NULL,
  `evaluation_id` tinyint NOT NULL,
  `evaluation_precedente_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `eval_prop_attribut_histo`
--

DROP TABLE IF EXISTS `eval_prop_attribut_histo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eval_prop_attribut_histo` (
  `evaluation_id` int(11) NOT NULL DEFAULT '0',
  `prop_attribut_id` int(11) NOT NULL DEFAULT '0',
  `version` bigint(20) NOT NULL,
  `statut` tinyint(4) NOT NULL DEFAULT '0',
  `date_statut` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`evaluation_id`,`prop_attribut_id`),
  KEY `fk_eval_prop_attribut_evaluation1_idx` (`evaluation_id`),
  KEY `fk_eval_prop_attribut_histo_prop_attribut1_idx` (`prop_attribut_id`),
  CONSTRAINT `eval_prop_attribut_histo_evaluation_id_evaluation_id` FOREIGN KEY (`evaluation_id`) REFERENCES `evaluation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `eval_prop_attribut_histo_prop_attribut_id_prop_attribut_id` FOREIGN KEY (`prop_attribut_id`) REFERENCES `prop_attribut` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eval_prop_option_histo`
--

DROP TABLE IF EXISTS `eval_prop_option_histo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eval_prop_option_histo` (
  `evaluation_id` int(11) NOT NULL DEFAULT '0',
  `prop_option_id` int(11) NOT NULL DEFAULT '0',
  `version` bigint(20) NOT NULL,
  `statut` tinyint(4) NOT NULL DEFAULT '0',
  `date_statut` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`evaluation_id`,`prop_option_id`),
  KEY `fk_eval_prop_attribut_evaluation1_idx` (`evaluation_id`),
  KEY `fk_eval_prop_option_histo_prop_option1_idx` (`prop_option_id`),
  CONSTRAINT `eval_prop_option_histo_evaluation_id_evaluation_id` FOREIGN KEY (`evaluation_id`) REFERENCES `evaluation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `eval_prop_option_histo_prop_option_id_prop_option_id` FOREIGN KEY (`prop_option_id`) REFERENCES `prop_option` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eval_sous_famille`
--

DROP TABLE IF EXISTS `eval_sous_famille`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eval_sous_famille` (
  `evaluation_id` int(11) NOT NULL DEFAULT '0',
  `mat_sous_famille_id` int(11) NOT NULL DEFAULT '0',
  `commentaire` mediumtext,
  PRIMARY KEY (`evaluation_id`,`mat_sous_famille_id`),
  KEY `fk_eval_sous_famille_evaluation1_idx` (`evaluation_id`),
  KEY `fk_eval_sous_famille_mat_sous_famille1_idx` (`mat_sous_famille_id`),
  CONSTRAINT `eval_sous_famille_evaluation_id_evaluation_id` FOREIGN KEY (`evaluation_id`) REFERENCES `evaluation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `eval_sous_famille_mat_sous_famille_id_mat_sous_famille_id` FOREIGN KEY (`mat_sous_famille_id`) REFERENCES `mat_sous_famille` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `evaluation`
--

DROP TABLE IF EXISTS `evaluation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `evaluation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `etablissement_id` int(11) DEFAULT NULL,
  `nom` varchar(32) DEFAULT NULL,
  `est_initial` tinyint(1) NOT NULL DEFAULT '0',
  `est_en_cours` tinyint(1) NOT NULL DEFAULT '1',
  `est_validee` tinyint(1) NOT NULL DEFAULT '0',
  `est_archivee` tinyint(1) NOT NULL DEFAULT '0',
  `date_saisie` date DEFAULT NULL,
  `date_validee` datetime DEFAULT NULL,
  `date_publiee` datetime DEFAULT NULL,
  `validateur_id` int(11) DEFAULT NULL,
  `matrice_version_id` bigint(20) NOT NULL,
  `reference_version_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_evaluation_etablissement1_idx` (`etablissement_id`),
  KEY `fk_evaluation_matrice_version1_idx` (`matrice_version_id`),
  KEY `fk_evaluation_user1_idx` (`validateur_id`),
  KEY `reference_version_id_idx` (`reference_version_id`),
  CONSTRAINT `evaluation_etablissement_id_etablissement_id` FOREIGN KEY (`etablissement_id`) REFERENCES `etablissement` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `evaluation_matrice_version_id_matrice_version_id` FOREIGN KEY (`matrice_version_id`) REFERENCES `matrice_version` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `evaluation_reference_version_id_reference_version_id` FOREIGN KEY (`reference_version_id`) REFERENCES `reference_version` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `evaluation_validateur_id_user_id` FOREIGN KEY (`validateur_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=296 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `faq_famille`
--

DROP TABLE IF EXISTS `faq_famille`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faq_famille` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(80) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `faq_piece_jointe`
--

DROP TABLE IF EXISTS `faq_piece_jointe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faq_piece_jointe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `lien` text,
  `intitule` varchar(32) DEFAULT NULL,
  `faq_question_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_faq_piece_jointe_faq_question1_idx_idx` (`faq_question_id`),
  CONSTRAINT `faq_piece_jointe_faq_question_id_faq_question_id` FOREIGN KEY (`faq_question_id`) REFERENCES `faq_question` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `faq_question`
--

DROP TABLE IF EXISTS `faq_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faq_question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(180) NOT NULL,
  `reponse` mediumtext,
  `enabled` tinyint(1) DEFAULT NULL,
  `faq_famille_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `position` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_faq_question_faq_famille1_idx_idx` (`faq_famille_id`),
  CONSTRAINT `faq_question_faq_famille_id_faq_famille_id` FOREIGN KEY (`faq_famille_id`) REFERENCES `faq_famille` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `geo_departement`
--

DROP TABLE IF EXISTS `geo_departement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `geo_departement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(64) NOT NULL,
  `code` varchar(3) NOT NULL,
  `geo_region_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `geo_departement_code_idx` (`code`),
  KEY `fk_geo_departement_geo_region1_idx` (`geo_region_id`),
  CONSTRAINT `geo_departement_geo_region_id_geo_region_id` FOREIGN KEY (`geo_region_id`) REFERENCES `geo_region` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `geo_region`
--

DROP TABLE IF EXISTS `geo_region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `geo_region` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `geo_ville`
--

DROP TABLE IF EXISTS `geo_ville`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `geo_ville` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` char(5) NOT NULL,
  `code_postal` char(5) NOT NULL,
  `nom` varchar(64) NOT NULL,
  `geo_departement_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `geo_ville_cp_idx` (`code_postal`),
  KEY `fk_geo_ville_geo_departement1_idx` (`geo_departement_id`),
  CONSTRAINT `geo_ville_geo_departement_id_geo_departement_id` FOREIGN KEY (`geo_departement_id`) REFERENCES `geo_departement` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=60872 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `graphique`
--

DROP TABLE IF EXISTS `graphique`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graphique` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NOT NULL,
  `graphique_type_id` int(11) NOT NULL,
  `graphique_categorie_id` int(11) DEFAULT NULL,
  `reference` varchar(10) NOT NULL,
  `nom` text NOT NULL,
  `libelle_court` varchar(100) NOT NULL,
  `libelle_axe` varchar(40) DEFAULT NULL,
  `position` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reference_UNIQUE_idx` (`reference`),
  KEY `graphique_graphique_type_id_idx` (`graphique_type_id`),
  KEY `graphique_categorie_id_idx` (`graphique_categorie_id`),
  CONSTRAINT `graphique_graphique_categorie_id_graphique_categorie_id` FOREIGN KEY (`graphique_categorie_id`) REFERENCES `graphique_categorie` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `graphique_categorie`
--

DROP TABLE IF EXISTS `graphique_categorie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graphique_categorie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `categorie_parent_id` int(11) DEFAULT NULL,
  `position` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_graphique_categorie_graphique_categorie1_idx` (`categorie_parent_id`),
  CONSTRAINT `graphique_categorie_categorie_parent_id_graphique_categorie_id` FOREIGN KEY (`categorie_parent_id`) REFERENCES `graphique_categorie` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `graphique_indicateur`
--

DROP TABLE IF EXISTS `graphique_indicateur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graphique_indicateur` (
  `graphique_id` int(11) NOT NULL DEFAULT '0',
  `indicateur_id` int(11) NOT NULL DEFAULT '0',
  `position` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`graphique_id`,`indicateur_id`),
  KEY `fk_graphique_indicateur_indicateur1_idx` (`indicateur_id`),
  KEY `fk_graphique_indicateur_graphique1_idx` (`graphique_id`),
  CONSTRAINT `graphique_indicateur_graphique_id_graphique_id` FOREIGN KEY (`graphique_id`) REFERENCES `graphique` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `graphique_indicateur_indicateur_id_indicateur_id` FOREIGN KEY (`indicateur_id`) REFERENCES `indicateur` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `indicateur`
--

DROP TABLE IF EXISTS `indicateur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indicateur` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NOT NULL,
  `indicateur_categorie_id` int(11) DEFAULT NULL,
  `custom` tinyint(1) DEFAULT '0',
  `reference` varchar(10) NOT NULL,
  `nom` text NOT NULL,
  `libelle_court` varchar(100) NOT NULL,
  `unite` varchar(40) DEFAULT NULL,
  `precision_affichage` int(11) DEFAULT NULL,
  `abreviation_unite` varchar(10) DEFAULT NULL,
  `formule` mediumtext NOT NULL,
  `formule_md5` varchar(32) DEFAULT NULL,
  `serialized_instructions` mediumblob,
  `est_pourcentage` tinyint(1) DEFAULT '0',
  `compteur_appel` int(11) DEFAULT '0',
  `position` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reference_UNIQUE_idx` (`reference`),
  KEY `indicateur_type_id_idx` (`type_id`),
  KEY `indicateur_categorie_id_idx` (`indicateur_categorie_id`),
  CONSTRAINT `indicateur_indicateur_categorie_id_indicateur_categorie_id` FOREIGN KEY (`indicateur_categorie_id`) REFERENCES `indicateur_categorie` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=196 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `indicateur_categorie`
--

DROP TABLE IF EXISTS `indicateur_categorie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indicateur_categorie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `categorie_parent_id` int(11) DEFAULT NULL,
  `position` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_indicateur_categorie_indicateur_categorie1_idx` (`categorie_parent_id`),
  CONSTRAINT `indicateur_categorie_categorie_parent_id_indicateur_categorie_id` FOREIGN KEY (`categorie_parent_id`) REFERENCES `indicateur_categorie` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `indicateur_dependance_attr`
--

DROP TABLE IF EXISTS `indicateur_dependance_attr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indicateur_dependance_attr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `indicateur_id` int(11) NOT NULL,
  `mat_attribut_id` int(11) NOT NULL,
  `niveau` int(11) DEFAULT NULL,
  `mandatory` tinyint(1) NOT NULL,
  `is_history` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_indicateur_dependance_indicateur1_idx` (`indicateur_id`),
  KEY `fk_indicateur_dependance_mat_attribut1_idx` (`mat_attribut_id`),
  CONSTRAINT `indicateur_dependance_attr_indicateur_id_indicateur_id` FOREIGN KEY (`indicateur_id`) REFERENCES `indicateur` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `indicateur_dependance_attr_mat_attribut_id_mat_attribut_id` FOREIGN KEY (`mat_attribut_id`) REFERENCES `mat_attribut` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2400 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `indicateur_dependance_ind`
--

DROP TABLE IF EXISTS `indicateur_dependance_ind`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indicateur_dependance_ind` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `indicateur_id` int(11) NOT NULL,
  `indicateur_dependant_id` int(11) NOT NULL,
  `niveau` int(11) DEFAULT NULL,
  `is_history` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_indicateur_dependance_ind_indicateur1_idx` (`indicateur_id`),
  KEY `fk_indicateur_dependance_ind_indicateur2_idx` (`indicateur_dependant_id`),
  CONSTRAINT `indicateur_dependance_ind_indicateur_dependant_id_indicateur_id` FOREIGN KEY (`indicateur_dependant_id`) REFERENCES `indicateur` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `indicateur_dependance_ind_indicateur_id_indicateur_id` FOREIGN KEY (`indicateur_id`) REFERENCES `indicateur` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=197 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `indicateur_dependance_key`
--

DROP TABLE IF EXISTS `indicateur_dependance_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indicateur_dependance_key` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `indicateur_id` int(11) NOT NULL,
  `mandatory` tinyint(1) NOT NULL,
  `key_type` tinyint(4) NOT NULL,
  `key_name` varchar(45) NOT NULL,
  `key_min` int(11) DEFAULT NULL,
  `key_max` int(11) DEFAULT NULL,
  `is_history` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_indicateur_dependance_indicateur1_idx` (`indicateur_id`),
  CONSTRAINT `indicateur_dependance_key_indicateur_id_indicateur_id` FOREIGN KEY (`indicateur_id`) REFERENCES `indicateur` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=441 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `indicateur_dependance_valeur_reference`
--

DROP TABLE IF EXISTS `indicateur_dependance_valeur_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indicateur_dependance_valeur_reference` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `indicateur_id` int(11) NOT NULL,
  `valeur_reference_id` int(11) NOT NULL,
  `niveau` int(11) DEFAULT NULL,
  `is_history` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_indicateur_dependance_valeur_reference_indicateur1_idx` (`indicateur_id`),
  KEY `fk_indicateur_dependance_valeur_reference_valeur_reference1_idx` (`valeur_reference_id`),
  CONSTRAINT `iiii_1` FOREIGN KEY (`indicateur_id`) REFERENCES `indicateur` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ivvi` FOREIGN KEY (`valeur_reference_id`) REFERENCES `valeur_reference` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=617 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `indicateur_evaluation_cache`
--

DROP TABLE IF EXISTS `indicateur_evaluation_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indicateur_evaluation_cache` (
  `indicateur_id` int(11) NOT NULL DEFAULT '0',
  `evaluation_id` int(11) NOT NULL DEFAULT '0',
  `value` mediumblob,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`indicateur_id`,`evaluation_id`),
  KEY `fk_indicateur_cache_indicateur1_idx` (`indicateur_id`),
  KEY `fk_indicateur_cache_evaluation1_idx` (`evaluation_id`),
  CONSTRAINT `indicateur_evaluation_cache_evaluation_id_evaluation_id` FOREIGN KEY (`evaluation_id`) REFERENCES `evaluation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `indicateur_evaluation_cache_indicateur_id_indicateur_id` FOREIGN KEY (`indicateur_id`) REFERENCES `indicateur` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invite_etablissement`
--

DROP TABLE IF EXISTS `invite_etablissement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invite_etablissement` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `etablissement_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`etablissement_id`),
  KEY `fk_user_etablissement_etablissement1_idx` (`etablissement_id`),
  KEY `fk_user_etablissement_user1_idx` (`user_id`),
  CONSTRAINT `invite_etablissement_etablissement_id_etablissement_id` FOREIGN KEY (`etablissement_id`) REFERENCES `etablissement` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `invite_etablissement_user_id_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invite_structure`
--

DROP TABLE IF EXISTS `invite_structure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invite_structure` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `structure_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`structure_id`),
  KEY `fk_user_structure_structure1_idx` (`structure_id`),
  KEY `fk_user_structure_user1_idx` (`user_id`),
  CONSTRAINT `invite_structure_structure_id_structure_id` FOREIGN KEY (`structure_id`) REFERENCES `structure` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `invite_structure_user_id_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mat_attribut`
--

DROP TABLE IF EXISTS `mat_attribut`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mat_attribut` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `matrice_version_id` bigint(20) DEFAULT NULL,
  `mat_groupe_id` int(11) NOT NULL,
  `mat_attribut_type_id` int(11) NOT NULL,
  `mat_option_set_id` int(11) DEFAULT NULL,
  `nom` varchar(200) NOT NULL,
  `unite` varchar(25) DEFAULT NULL,
  `decimales` int(11) DEFAULT NULL,
  `identifiant` varchar(100) NOT NULL,
  `code` varchar(25) NOT NULL,
  `ref_maxeva` varchar(10) DEFAULT NULL,
  `min` int(11) DEFAULT NULL,
  `min_strictly` tinyint(1) DEFAULT NULL,
  `max` int(11) DEFAULT NULL,
  `max_strictly` tinyint(1) DEFAULT NULL,
  `obligatoire` tinyint(1) NOT NULL DEFAULT '0',
  `dupliquer` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `position` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `identifiant_UNIQUE_idx` (`identifiant`),
  KEY `fk_mat_attribut_mat_groupe1_idx` (`mat_groupe_id`),
  KEY `fk_mat_attribut_matrice_version1_idx` (`matrice_version_id`),
  KEY `fk_mat_attribut_mat_type1_idx` (`mat_attribut_type_id`),
  KEY `fk_mat_attribut_mat_option_set1_idx` (`mat_option_set_id`),
  CONSTRAINT `mat_attribut_matrice_version_id_matrice_version_id` FOREIGN KEY (`matrice_version_id`) REFERENCES `matrice_version` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mat_attribut_mat_attribut_type_id_mat_attribut_type_id` FOREIGN KEY (`mat_attribut_type_id`) REFERENCES `mat_attribut_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mat_attribut_mat_groupe_id_mat_groupe_id` FOREIGN KEY (`mat_groupe_id`) REFERENCES `mat_groupe` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mat_attribut_mat_option_set_id_mat_option_set_id` FOREIGN KEY (`mat_option_set_id`) REFERENCES `mat_option_set` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=624 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mat_attribut_type`
--

DROP TABLE IF EXISTS `mat_attribut_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mat_attribut_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(80) NOT NULL,
  `description` text,
  `element` varchar(100) NOT NULL DEFAULT 'Ademe_Form_Element_Standard',
  `default_min` int(11) DEFAULT NULL,
  `default_min_strictly` tinyint(1) NOT NULL DEFAULT '1',
  `default_max` int(11) DEFAULT NULL,
  `default_max_strictly` tinyint(1) NOT NULL DEFAULT '1',
  `is_multi` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mat_attribut_version`
--

DROP TABLE IF EXISTS `mat_attribut_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mat_attribut_version` (
  `id` int(11) NOT NULL DEFAULT '0',
  `matrice_version_id` bigint(20) NOT NULL DEFAULT '0',
  `mat_groupe_id` int(11) NOT NULL,
  `mat_attribut_type_id` int(11) NOT NULL,
  `mat_option_set_id` int(11) DEFAULT NULL,
  `nom` varchar(200) NOT NULL,
  `unite` varchar(25) DEFAULT NULL,
  `decimales` int(11) DEFAULT NULL,
  `identifiant` varchar(100) NOT NULL,
  `code` varchar(25) NOT NULL,
  `ref_maxeva` varchar(10) DEFAULT NULL,
  `min` int(11) DEFAULT NULL,
  `min_strictly` tinyint(1) DEFAULT NULL,
  `max` int(11) DEFAULT NULL,
  `max_strictly` tinyint(1) DEFAULT NULL,
  `obligatoire` tinyint(1) NOT NULL DEFAULT '0',
  `dupliquer` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `position` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`matrice_version_id`),
  CONSTRAINT `mat_attribut_version_id_mat_attribut_id` FOREIGN KEY (`id`) REFERENCES `mat_attribut` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mat_bloc`
--

DROP TABLE IF EXISTS `mat_bloc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mat_bloc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `matrice_version_id` bigint(20) DEFAULT NULL,
  `mat_sous_famille_id` int(11) NOT NULL,
  `mat_bloc_type_id` int(11) NOT NULL,
  `identifiant` varchar(100) NOT NULL,
  `nom` varchar(80) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `position` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `identifiant_UNIQUE_idx` (`identifiant`),
  KEY `fk_mat_bloc_matrice_version1_idx` (`matrice_version_id`),
  KEY `fk_mat_bloc_mat_bloc_type1_idx` (`mat_bloc_type_id`),
  KEY `fk_mat_bloc_mat_sous_famille1_idx` (`mat_sous_famille_id`),
  KEY `mat_bloc_mat_bloc_type_id_idx` (`mat_bloc_type_id`),
  CONSTRAINT `mat_bloc_matrice_version_id_matrice_version_id` FOREIGN KEY (`matrice_version_id`) REFERENCES `matrice_version` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mat_bloc_mat_bloc_type_id_mat_bloc_type_id` FOREIGN KEY (`mat_bloc_type_id`) REFERENCES `mat_bloc_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mat_bloc_mat_sous_famille_id_mat_sous_famille_id` FOREIGN KEY (`mat_sous_famille_id`) REFERENCES `mat_sous_famille` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mat_bloc_type`
--

DROP TABLE IF EXISTS `mat_bloc_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mat_bloc_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(80) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mat_bloc_version`
--

DROP TABLE IF EXISTS `mat_bloc_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mat_bloc_version` (
  `id` int(11) NOT NULL DEFAULT '0',
  `matrice_version_id` bigint(20) NOT NULL DEFAULT '0',
  `mat_sous_famille_id` int(11) NOT NULL,
  `mat_bloc_type_id` int(11) NOT NULL,
  `identifiant` varchar(100) NOT NULL,
  `nom` varchar(80) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `position` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`matrice_version_id`),
  CONSTRAINT `mat_bloc_version_id_mat_bloc_id` FOREIGN KEY (`id`) REFERENCES `mat_bloc` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mat_famille`
--

DROP TABLE IF EXISTS `mat_famille`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mat_famille` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `texte_id` int(11) DEFAULT NULL,
  `aide_id` int(11) DEFAULT NULL,
  `matrice_version_id` bigint(20) DEFAULT NULL,
  `nom` varchar(80) NOT NULL,
  `nom_court` varchar(24) NOT NULL,
  `est_actif_pour_init` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `position` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_mat_famille_matrice_version1_idx` (`matrice_version_id`),
  KEY `fk_mat_famille_texte1_idx` (`texte_id`),
  KEY `aide_id_idx` (`aide_id`),
  CONSTRAINT `mat_famille_aide_id_texte_id` FOREIGN KEY (`aide_id`) REFERENCES `texte` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mat_famille_matrice_version_id_matrice_version_id` FOREIGN KEY (`matrice_version_id`) REFERENCES `matrice_version` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mat_famille_texte_id_texte_id` FOREIGN KEY (`texte_id`) REFERENCES `texte` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mat_famille_version`
--

DROP TABLE IF EXISTS `mat_famille_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mat_famille_version` (
  `id` int(11) NOT NULL DEFAULT '0',
  `texte_id` int(11) DEFAULT NULL,
  `aide_id` int(11) DEFAULT NULL,
  `matrice_version_id` bigint(20) NOT NULL DEFAULT '0',
  `nom` varchar(80) NOT NULL,
  `nom_court` varchar(24) NOT NULL,
  `est_actif_pour_init` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `position` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`matrice_version_id`),
  CONSTRAINT `mat_famille_version_id_mat_famille_id` FOREIGN KEY (`id`) REFERENCES `mat_famille` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mat_groupe`
--

DROP TABLE IF EXISTS `mat_groupe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mat_groupe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `matrice_version_id` bigint(20) DEFAULT NULL,
  `mat_bloc_id` int(11) NOT NULL,
  `mat_groupe_type_id` int(11) NOT NULL,
  `identifiant` varchar(100) NOT NULL,
  `nom` varchar(80) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `position` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `identifiant_UNIQUE_idx` (`identifiant`),
  KEY `fk_mat_groupe_mat_bloc1_idx` (`mat_bloc_id`),
  KEY `fk_mat_groupe_matrice_version1_idx` (`matrice_version_id`),
  KEY `fk_mat_groupe_mat_groupe_type1_idx` (`mat_groupe_type_id`),
  KEY `mat_groupe_mat_groupe_type_id_idx` (`mat_groupe_type_id`),
  CONSTRAINT `mat_groupe_matrice_version_id_matrice_version_id` FOREIGN KEY (`matrice_version_id`) REFERENCES `matrice_version` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mat_groupe_mat_bloc_id_mat_bloc_id` FOREIGN KEY (`mat_bloc_id`) REFERENCES `mat_bloc` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mat_groupe_mat_groupe_type_id_mat_groupe_type_id` FOREIGN KEY (`mat_groupe_type_id`) REFERENCES `mat_groupe_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mat_groupe_type`
--

DROP TABLE IF EXISTS `mat_groupe_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mat_groupe_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(80) NOT NULL,
  `form` varchar(100) NOT NULL DEFAULT 'Ademe_Form_Modules_Evaluation_Subform_Groupe_Standard',
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mat_groupe_version`
--

DROP TABLE IF EXISTS `mat_groupe_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mat_groupe_version` (
  `id` int(11) NOT NULL DEFAULT '0',
  `matrice_version_id` bigint(20) NOT NULL DEFAULT '0',
  `mat_bloc_id` int(11) NOT NULL,
  `mat_groupe_type_id` int(11) NOT NULL,
  `identifiant` varchar(100) NOT NULL,
  `nom` varchar(80) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `position` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`matrice_version_id`),
  CONSTRAINT `mat_groupe_version_id_mat_groupe_id` FOREIGN KEY (`id`) REFERENCES `mat_groupe` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mat_option`
--

DROP TABLE IF EXISTS `mat_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mat_option` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `matrice_version_id` bigint(20) DEFAULT NULL,
  `mat_option_set_id` int(11) NOT NULL,
  `nom` varchar(150) DEFAULT NULL,
  `nom_court` varchar(20) DEFAULT NULL,
  `code` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `position` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_mat_option_matrice_version1_idx` (`matrice_version_id`),
  KEY `fk_mat_option_mat_option_set1_idx` (`mat_option_set_id`),
  CONSTRAINT `mat_option_matrice_version_id_matrice_version_id` FOREIGN KEY (`matrice_version_id`) REFERENCES `matrice_version` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mat_option_mat_option_set_id_mat_option_set_id` FOREIGN KEY (`mat_option_set_id`) REFERENCES `mat_option_set` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mat_option_set`
--

DROP TABLE IF EXISTS `mat_option_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mat_option_set` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mat_option_version`
--

DROP TABLE IF EXISTS `mat_option_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mat_option_version` (
  `id` int(11) NOT NULL DEFAULT '0',
  `matrice_version_id` bigint(20) NOT NULL DEFAULT '0',
  `mat_option_set_id` int(11) NOT NULL,
  `nom` varchar(150) DEFAULT NULL,
  `nom_court` varchar(20) DEFAULT NULL,
  `code` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `position` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`matrice_version_id`),
  CONSTRAINT `mat_option_version_id_mat_option_id` FOREIGN KEY (`id`) REFERENCES `mat_option` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mat_sous_famille`
--

DROP TABLE IF EXISTS `mat_sous_famille`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mat_sous_famille` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `matrice_version_id` bigint(20) DEFAULT NULL,
  `mat_famille_id` int(11) NOT NULL,
  `nom` varchar(80) NOT NULL,
  `nom_court` varchar(24) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `position` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_mat_sous_famille_matrice_version1_idx` (`matrice_version_id`),
  KEY `fk_mat_sous_famille_mat_famille1_idx` (`mat_famille_id`),
  CONSTRAINT `mat_sous_famille_matrice_version_id_matrice_version_id` FOREIGN KEY (`matrice_version_id`) REFERENCES `matrice_version` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mat_sous_famille_mat_famille_id_mat_famille_id` FOREIGN KEY (`mat_famille_id`) REFERENCES `mat_famille` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mat_sous_famille_version`
--

DROP TABLE IF EXISTS `mat_sous_famille_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mat_sous_famille_version` (
  `id` int(11) NOT NULL DEFAULT '0',
  `matrice_version_id` bigint(20) NOT NULL DEFAULT '0',
  `mat_famille_id` int(11) NOT NULL,
  `nom` varchar(80) NOT NULL,
  `nom_court` varchar(24) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `position` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`matrice_version_id`),
  CONSTRAINT `mat_sous_famille_version_id_mat_sous_famille_id` FOREIGN KEY (`id`) REFERENCES `mat_sous_famille` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrice_version`
--

DROP TABLE IF EXISTS `matrice_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrice_version` (
  `id` bigint(20) NOT NULL DEFAULT '0',
  `publiee` tinyint(1) NOT NULL DEFAULT '0',
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `naf_classe`
--

DROP TABLE IF EXISTS `naf_classe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `naf_classe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `naf_groupe_id` int(11) NOT NULL,
  `code` tinyint(4) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_naf_classe_naf_groupe1_idx` (`naf_groupe_id`),
  CONSTRAINT `naf_classe_naf_groupe_id_naf_groupe_id` FOREIGN KEY (`naf_groupe_id`) REFERENCES `naf_groupe` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=616 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `naf_division`
--

DROP TABLE IF EXISTS `naf_division`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `naf_division` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `naf_section_id` int(11) NOT NULL,
  `code` tinyint(4) NOT NULL,
  `nom` varchar(150) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_naf_division_naf_section1_idx` (`naf_section_id`),
  CONSTRAINT `naf_division_naf_section_id_naf_section_id` FOREIGN KEY (`naf_section_id`) REFERENCES `naf_section` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `naf_groupe`
--

DROP TABLE IF EXISTS `naf_groupe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `naf_groupe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `naf_division_id` int(11) NOT NULL,
  `code` tinyint(4) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_naf_groupe_naf_division1_idx` (`naf_division_id`),
  CONSTRAINT `naf_groupe_naf_division_id_naf_division_id` FOREIGN KEY (`naf_division_id`) REFERENCES `naf_division` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=273 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `naf_section`
--

DROP TABLE IF EXISTS `naf_section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `naf_section` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` char(1) NOT NULL,
  `nom` varchar(250) NOT NULL,
  `enabled` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE_idx` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `naf_sous_classe`
--

DROP TABLE IF EXISTS `naf_sous_classe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `naf_sous_classe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `naf_classe_id` int(11) NOT NULL,
  `code` char(1) NOT NULL,
  `code_recherche` char(5) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_naf_sous_classe_naf_classe1_idx` (`naf_classe_id`),
  CONSTRAINT `naf_sous_classe_naf_classe_id_naf_classe_id` FOREIGN KEY (`naf_classe_id`) REFERENCES `naf_classe` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=733 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `objectif_view`
--

DROP TABLE IF EXISTS `objectif_view`;
/*!50001 DROP VIEW IF EXISTS `objectif_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `objectif_view` (
  `evaluation_id` tinyint NOT NULL,
  `mat_attribut_id` tinyint NOT NULL,
  `mat_attribut_nom` tinyint NOT NULL,
  `selectionne` tinyint NOT NULL,
  `realise` tinyint NOT NULL,
  `selectionne_eval_precedent` tinyint NOT NULL,
  `realise_eval_precedent` tinyint NOT NULL,
  `position_bloc` tinyint NOT NULL,
  `position_groupe` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `prop_attribut`
--

DROP TABLE IF EXISTS `prop_attribut`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prop_attribut` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structure_id` int(11) NOT NULL,
  `mat_attribut_id` int(11) NOT NULL,
  `version` bigint(20) DEFAULT NULL,
  `value` mediumblob,
  `imposee` tinyint(1) NOT NULL DEFAULT '1',
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_propatt_attstru_idx` (`structure_id`,`mat_attribut_id`),
  KEY `fk_prop_attribut_mat_attribut1_idx` (`mat_attribut_id`),
  KEY `fk_prop_attribut_structure1_idx` (`structure_id`),
  CONSTRAINT `prop_attribut_mat_attribut_id_mat_attribut_id` FOREIGN KEY (`mat_attribut_id`) REFERENCES `mat_attribut` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `prop_attribut_structure_id_structure_id` FOREIGN KEY (`structure_id`) REFERENCES `structure` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=695 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `prop_attribut_view`
--

DROP TABLE IF EXISTS `prop_attribut_view`;
/*!50001 DROP VIEW IF EXISTS `prop_attribut_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `prop_attribut_view` (
  `id` tinyint NOT NULL,
  `structure_id` tinyint NOT NULL,
  `mat_attribut_id` tinyint NOT NULL,
  `version` tinyint NOT NULL,
  `value` tinyint NOT NULL,
  `imposee` tinyint NOT NULL,
  `enabled` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `order_type_structure` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `prop_option`
--

DROP TABLE IF EXISTS `prop_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prop_option` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structure_id` int(11) NOT NULL,
  `mat_attribut_id` int(11) NOT NULL,
  `mat_option_id` int(11) NOT NULL,
  `version` bigint(20) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `imposee` tinyint(1) NOT NULL DEFAULT '1',
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_propopt_struattopt_idx` (`structure_id`,`mat_attribut_id`,`mat_option_id`),
  KEY `fk_prop_attribut_mat_option_mat_option1_idx` (`mat_option_id`),
  KEY `fk_prop_option_mat_attribut1_idx` (`mat_attribut_id`),
  KEY `fk_prop_option_structure1_idx` (`structure_id`),
  CONSTRAINT `prop_option_mat_attribut_id_mat_attribut_id` FOREIGN KEY (`mat_attribut_id`) REFERENCES `mat_attribut` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `prop_option_mat_option_id_mat_option_id` FOREIGN KEY (`mat_option_id`) REFERENCES `mat_option` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `prop_option_structure_id_structure_id` FOREIGN KEY (`structure_id`) REFERENCES `structure` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `prop_option_view`
--

DROP TABLE IF EXISTS `prop_option_view`;
/*!50001 DROP VIEW IF EXISTS `prop_option_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `prop_option_view` (
  `id` tinyint NOT NULL,
  `structure_id` tinyint NOT NULL,
  `mat_attribut_id` tinyint NOT NULL,
  `mat_option_id` tinyint NOT NULL,
  `version` tinyint NOT NULL,
  `value` tinyint NOT NULL,
  `imposee` tinyint NOT NULL,
  `enabled` tinyint NOT NULL,
  `created_at` tinyint NOT NULL,
  `updated_at` tinyint NOT NULL,
  `order_type_structure` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `proposer_imposer_count`
--

DROP TABLE IF EXISTS `proposer_imposer_count`;
/*!50001 DROP VIEW IF EXISTS `proposer_imposer_count`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `proposer_imposer_count` (
  `mat_famille_id` tinyint NOT NULL,
  `prop_attribut_structure_id` tinyint NOT NULL,
  `prop_option_structure_id` tinyint NOT NULL,
  `prop_attribut_evaluation_id` tinyint NOT NULL,
  `prop_option_evaluation_id` tinyint NOT NULL,
  `prop_attribut_statut` tinyint NOT NULL,
  `prop_option_statut` tinyint NOT NULL,
  `count_prop_attribut` tinyint NOT NULL,
  `count_prop_option` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `reference_version`
--

DROP TABLE IF EXISTS `reference_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reference_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `statut_demande`
--

DROP TABLE IF EXISTS `statut_demande`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statut_demande` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(64) NOT NULL,
  `libelle_court` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structure`
--

DROP TABLE IF EXISTS `structure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structure` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_structure_id` int(11) NOT NULL,
  `nom` varchar(64) DEFAULT NULL,
  `raison_sociale` varchar(64) NOT NULL,
  `adresse_no` varchar(10) DEFAULT NULL,
  `adresse_voie` text,
  `code_postal` varchar(5) DEFAULT NULL,
  `geo_ville_id` int(11) NOT NULL,
  `referent_id` int(11) DEFAULT NULL,
  `type_demarche_id` int(11) NOT NULL DEFAULT '1',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `en_attente` tinyint(1) NOT NULL DEFAULT '1',
  `siren` char(9) DEFAULT NULL,
  `effectif` int(10) unsigned DEFAULT NULL,
  `naf_sous_classe_id` int(11) DEFAULT NULL,
  `structure_juridique_id` int(11) DEFAULT NULL,
  `date_entree` date DEFAULT NULL,
  `nom_demarche` varchar(80) DEFAULT NULL,
  `latitude` double(18,2) DEFAULT NULL,
  `longitude` double(18,2) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_structure_type_demarche1_idx` (`type_demarche_id`),
  KEY `fk_structure_type_structure1_idx` (`type_structure_id`),
  KEY `fk_structure_user1_idx` (`referent_id`),
  KEY `fk_structure_geo_ville1_idx` (`geo_ville_id`),
  KEY `fk_etablissement_naf_sous_classe1_idx` (`naf_sous_classe_id`),
  KEY `fk_etablissement_structure_juridique1_idx` (`structure_juridique_id`),
  CONSTRAINT `structure_geo_ville_id_geo_ville_id` FOREIGN KEY (`geo_ville_id`) REFERENCES `geo_ville` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `structure_naf_sous_classe_id_naf_sous_classe_id` FOREIGN KEY (`naf_sous_classe_id`) REFERENCES `naf_sous_classe` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `structure_referent_id_user_id` FOREIGN KEY (`referent_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `structure_structure_juridique_id_structure_juridique_id` FOREIGN KEY (`structure_juridique_id`) REFERENCES `structure_juridique` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `structure_type_demarche_id_type_demarche_id` FOREIGN KEY (`type_demarche_id`) REFERENCES `type_demarche` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `structure_type_structure_id_type_structure_id` FOREIGN KEY (`type_structure_id`) REFERENCES `type_structure` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=363 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structure_juridique`
--

DROP TABLE IF EXISTS `structure_juridique`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structure_juridique` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(80) NOT NULL,
  `enabled` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `territoire`
--

DROP TABLE IF EXISTS `territoire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `territoire` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `zone_intervention_id` int(11) NOT NULL,
  `geo_region_id` int(11) NOT NULL,
  `geo_departement_id` int(11) DEFAULT NULL,
  `code_ville` char(5) DEFAULT NULL,
  `statut_demande_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_territoire_idx` (`zone_intervention_id`,`geo_region_id`,`geo_departement_id`,`code_ville`),
  KEY `fk_territoire_zone_intervention1_idx` (`zone_intervention_id`),
  KEY `fk_territoire_geo_region1_idx` (`geo_region_id`),
  KEY `fk_territoire_geo_departement1_idx` (`geo_departement_id`),
  KEY `fk_territoire_statut_demande1_idx` (`statut_demande_id`),
  CONSTRAINT `territoire_geo_departement_id_geo_departement_id` FOREIGN KEY (`geo_departement_id`) REFERENCES `geo_departement` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `territoire_geo_region_id_geo_region_id` FOREIGN KEY (`geo_region_id`) REFERENCES `geo_region` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `territoire_statut_demande_id_statut_demande_id` FOREIGN KEY (`statut_demande_id`) REFERENCES `statut_demande` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `territoire_zone_intervention_id_zone_intervention_id` FOREIGN KEY (`zone_intervention_id`) REFERENCES `zone_intervention` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1192 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `texte`
--

DROP TABLE IF EXISTS `texte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `texte` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_texte_id` int(11) NOT NULL,
  `nom` varchar(45) NOT NULL,
  `titre` varchar(200) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `texte` mediumtext NOT NULL,
  `selector` varchar(100) DEFAULT NULL,
  `position` int(11) DEFAULT '0',
  `administrable` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nom_UNIQUE_idx` (`nom`),
  KEY `fk_perimetre_typetexte1_idx` (`type_texte_id`),
  CONSTRAINT `texte_type_texte_id_type_texte_id` FOREIGN KEY (`type_texte_id`) REFERENCES `type_texte` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=221 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `type_demarche`
--

DROP TABLE IF EXISTS `type_demarche`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `type_demarche` (
  `id` int(11) NOT NULL DEFAULT '0',
  `code` varchar(5) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE_idx` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `type_structure`
--

DROP TABLE IF EXISTS `type_structure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `type_structure` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `type_texte`
--

DROP TABLE IF EXISTS `type_texte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `type_texte` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  `texte_riche` tinyint(4) DEFAULT NULL,
  `libelle_liste` varchar(100) DEFAULT NULL,
  `libelle_detail` varchar(100) DEFAULT NULL,
  `position` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` char(40) DEFAULT NULL,
  `nom` varchar(64) DEFAULT NULL,
  `prenom` varchar(64) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `fonction` varchar(64) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `en_attente` tinyint(1) NOT NULL DEFAULT '1',
  `last_connection` datetime DEFAULT NULL,
  `last_connection_tmp` datetime DEFAULT NULL,
  `preferences` mediumtext,
  `consentement` tinyint(1) NOT NULL,
  `date_rgpd` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE_idx` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=354 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_auth_profil`
--

DROP TABLE IF EXISTS `user_auth_profil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_auth_profil` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `auth_profil_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`auth_profil_id`),
  KEY `fk_user_auth_profil_auth_profil1_idx` (`auth_profil_id`),
  KEY `fk_user_auth_profil_user1_idx` (`user_id`),
  CONSTRAINT `user_auth_profil_auth_profil_id_auth_profil_id` FOREIGN KEY (`auth_profil_id`) REFERENCES `auth_profil` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_auth_profil_user_id_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_profil_edit`
--

DROP TABLE IF EXISTS `user_profil_edit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_profil_edit` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `auth_profil_id` int(11) NOT NULL DEFAULT '0',
  `date_modification` date NOT NULL,
  `commentaire` mediumtext NOT NULL,
  `new_email` varchar(100) DEFAULT NULL,
  `etablissement_id` int(11) DEFAULT NULL,
  `structure_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`auth_profil_id`),
  KEY `fk_user_profil_edit_user1_idx` (`user_id`),
  KEY `fk_user_profil_edit_auth_profil1_idx` (`auth_profil_id`),
  KEY `fk_user_profil_edit_etablissement1_idx` (`etablissement_id`),
  KEY `fk_user_profil_edit_structure1_idx` (`structure_id`),
  CONSTRAINT `user_profil_edit_auth_profil_id_auth_profil_id` FOREIGN KEY (`auth_profil_id`) REFERENCES `auth_profil` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_profil_edit_etablissement_id_etablissement_id` FOREIGN KEY (`etablissement_id`) REFERENCES `etablissement` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_profil_edit_structure_id_structure_id` FOREIGN KEY (`structure_id`) REFERENCES `structure` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_profil_edit_user_id_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_texte`
--

DROP TABLE IF EXISTS `user_texte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_texte` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `texte_id` int(11) NOT NULL DEFAULT '0',
  `est_lu` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`user_id`,`texte_id`),
  KEY `fk_user_texte_user1_idx` (`user_id`),
  KEY `fk_user_texte_texte1_idx` (`texte_id`),
  CONSTRAINT `user_texte_texte_id_texte_id` FOREIGN KEY (`texte_id`) REFERENCES `texte` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_texte_user_id_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_token`
--

DROP TABLE IF EXISTS `user_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) DEFAULT NULL,
  `expire_at` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `url` varchar(100) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_token_user1_idx` (`user_id`),
  CONSTRAINT `user_token_user_id_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1659 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `valeur_reference`
--

DROP TABLE IF EXISTS `valeur_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `valeur_reference` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reference` varchar(10) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `libelle_court` varchar(60) NOT NULL,
  `unite` varchar(40) DEFAULT NULL,
  `position` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `valeur_reference_valeur`
--

DROP TABLE IF EXISTS `valeur_reference_valeur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `valeur_reference_valeur` (
  `valeur_reference_id` int(11) NOT NULL DEFAULT '0',
  `reference_version_id` int(11) NOT NULL DEFAULT '0',
  `valeur` double(18,10) NOT NULL,
  `source` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`valeur_reference_id`,`reference_version_id`),
  KEY `fk_table1_valeur_reference1_idx` (`valeur_reference_id`),
  KEY `fk_table1_reference_version1_idx` (`reference_version_id`),
  CONSTRAINT `valeur_reference_valeur_valeur_reference_id_valeur_reference_id` FOREIGN KEY (`valeur_reference_id`) REFERENCES `valeur_reference` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `vrri` FOREIGN KEY (`reference_version_id`) REFERENCES `reference_version` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `zone_intervention`
--

DROP TABLE IF EXISTS `zone_intervention`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zone_intervention` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(64) NOT NULL,
  `structure_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_zone_intervention_structure1_idx` (`structure_id`),
  CONSTRAINT `zone_intervention_structure_id_structure_id` FOREIGN KEY (`structure_id`) REFERENCES `structure` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=244 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database '9915_evalpde'
--
/*!50003 DROP PROCEDURE IF EXISTS `copy_indicator_dependancies` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `copy_indicator_dependancies`(IN indicator_name VARCHAR(45), IN level INT, IN root_indicator INT, IN is_history BOOLEAN)
copy_indicator_dependancies_root: BEGIN

    
    
    
    copy_indicator_dependancies_etape0: BEGIN
        
        INSERT INTO indicateur_dependance_ind
        
            SELECT 
                NULL AS id,
                root_indicator AS indicateur_id, 
                i.id AS indicateur_dependant_id,
                level AS niveau,
                is_history AS is_history

            FROM indicateur i
            WHERE i.reference=indicator_name;

    END copy_indicator_dependancies_etape0;
    
    
    
    
    copy_indicator_dependancies_etape1: BEGIN
        INSERT INTO indicateur_dependance_attr
        
            SELECT 
                NULL AS id,
                root_indicator AS indicateur_id, 
                ida.mat_attribut_id,
                level + 1 AS niveau,
                ida.mandatory AS mandatory,
                is_history AS is_history

            FROM indicateur_dependance_attr ida
            LEFT JOIN indicateur i ON i.id=ida.indicateur_id
            WHERE i.reference=indicator_name;
    
    END copy_indicator_dependancies_etape1;
    
    
    
    
    copy_indicator_dependancies_etape2: BEGIN
    
        INSERT INTO indicateur_dependance_valeur_reference
        
            SELECT 
                NULL AS id,
                root_indicator AS indicateur_id, 
                idvr.valeur_reference_id,
                level + 1 AS niveau,
                is_history AS is_history
            
            FROM indicateur_dependance_valeur_reference idvr
            LEFT JOIN indicateur i ON i.id=idvr.indicateur_id
            WHERE i.reference=indicator_name;
    
    END copy_indicator_dependancies_etape2;
  
    
    
    
    
    copy_indicator_dependancies_etape3: BEGIN
        
        
        
        DECLARE indicateur_id INT;
        DECLARE key_name VARCHAR(45);
        
        
        DECLARE done INT DEFAULT 0;
        
        
        DECLARE indicator_cursor CURSOR FOR 
            SELECT idk.key_name
            FROM indicateur i
            LEFT JOIN indicateur_dependance_key idk ON idk.indicateur_id=i.id
            WHERE i.reference=indicator_name
            AND idk.key_type=4;
            
        
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

        OPEN indicator_cursor;
        
        cursor_loop: LOOP
        
            FETCH indicator_cursor INTO key_name;
            
            IF done THEN 
                LEAVE cursor_loop; 
            END IF;
            
            CALL copy_indicator_dependancies(key_name, level + 1, root_indicator, is_history);
                    
        END LOOP;
        
        CLOSE indicator_cursor;
        
    END copy_indicator_dependancies_etape3;
    
END copy_indicator_dependancies_root ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rebuild_indicator_dependencies` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `rebuild_indicator_dependencies`()
rebuild_indicator_dependencies_root: BEGIN

    
    
    
    
    rebuild_indicator_dependencies_etape1: BEGIN
        TRUNCATE TABLE indicateur_dependance_attr;
        TRUNCATE TABLE indicateur_dependance_ind;
        TRUNCATE TABLE indicateur_dependance_valeur_reference;
    END rebuild_indicator_dependencies_etape1;

    
    
    

    rebuild_indicator_dependencies_etape2: BEGIN
    
        INSERT INTO indicateur_dependance_attr
            SELECT 
                NULL AS id,
                idk.indicateur_id AS indicateur_id, 
                ma.id AS mat_attribut_id, 
                0 AS niveau,
                idk.mandatory AS mandatory,
                idk.is_history AS is_history
            FROM indicateur_dependance_key idk
            LEFT JOIN mat_attribut ma ON ma.identifiant=idk.key_name
            WHERE idk.key_type=1  
            AND ma.id IS NOT NULL;
        
    END rebuild_indicator_dependencies_etape2;
    
    
    
    
    
    rebuild_indicator_dependencies_etape3: BEGIN
    
        
        DECLARE indicateur_id INT;
        DECLARE key_name VARCHAR(45);
        DECLARE key_min INT;
        DECLARE key_max INT;
        DECLARE mandatory BOOLEAN;
        DECLARE is_history BOOLEAN;
        
        
        DECLARE done INT DEFAULT 0;
        
        
        DECLARE pattern_cursor CURSOR FOR 
            SELECT 
                idk.indicateur_id AS indicateur_id, 
                idk.key_name AS key_name,
                idk.key_min AS key_min,
                idk.key_max AS key_max,
                idk.mandatory AS mandatory,
                idk.is_history AS is_history
            FROM indicateur_dependance_key idk
            WHERE idk.key_type=2; 
            
        
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
            
        OPEN pattern_cursor;
        
        cursor_loop: LOOP
        
            FETCH pattern_cursor INTO indicateur_id, key_name, key_min, key_max, mandatory, is_history;
            
            IF done THEN 
                LEAVE cursor_loop; 
            END IF;
            
            IF key_min IS NULL THEN
                SET key_min = 0;
            END IF;
            
            IF key_max IS NULL OR key_max=0 THEN
                SET key_max = 999999999; 
            END IF;
        
            
            
            INSERT INTO indicateur_dependance_attr
                SELECT
                    NULL AS id,
                    indicateur_id,
                    ma.id AS mat_attribut_id, 
                    0 AS niveau,
                    mandatory,
                    is_history
                FROM mat_attribut ma
                WHERE CAST(SUBSTRING(identifiant FROM LOCATE('?', key_name)) AS UNSIGNED) BETWEEN key_min AND key_max
                AND identifiant LIKE REPLACE(key_name, '?', '%');
                    
        END LOOP;
        
        CLOSE pattern_cursor;
    
    END rebuild_indicator_dependencies_etape3;
    
    
    
    
    
    rebuild_indicator_dependencies_etape4: BEGIN
    
        INSERT INTO indicateur_dependance_valeur_reference
            SELECT 
                NULL AS id,
                idk.indicateur_id AS indicateur_id, 
                vr.id AS valeur_reference_id, 
                0 AS niveau,
                idk.is_history AS is_history
            FROM indicateur_dependance_key idk
            LEFT JOIN valeur_reference vr ON vr.reference=idk.key_name
            WHERE idk.key_type=3  
            AND vr.id IS NOT NULL;
        
    END rebuild_indicator_dependencies_etape4;
    
    
    
    
    
    rebuild_indicator_dependencies_etape5: BEGIN
    
        
        DECLARE indicateur_id INT;
        DECLARE indicateur_dependant_id INT;
        DECLARE key_name VARCHAR(45);
        DECLARE is_history BOOLEAN;
        
        
        DECLARE done INT DEFAULT 0;
        
        
        DECLARE indicator_cursor CURSOR FOR 
            SELECT 
                idk.indicateur_id AS indicateur_id, 
                idk.key_name AS key_name,
                i.id AS indicateur_dependant_id,
                idk.is_history AS is_history
            FROM indicateur_dependance_key idk
            LEFT JOIN indicateur i ON i.reference=idk.key_name
            WHERE idk.key_type=4 
            AND i.id IS NOT NULL;
            
        
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

        OPEN indicator_cursor;
        
        cursor_loop: LOOP
        
            FETCH indicator_cursor INTO indicateur_id, key_name, indicateur_dependant_id, is_history;
            
            IF done THEN 
                LEAVE cursor_loop; 
            END IF;
                        
            SET max_sp_recursion_depth=10; 
            CALL copy_indicator_dependancies(key_name, 0, indicateur_id, is_history);
                    
        END LOOP;
        
        CLOSE indicator_cursor;
    
    END rebuild_indicator_dependencies_etape5;
    
END rebuild_indicator_dependencies_root ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `action_view`
--

/*!50001 DROP TABLE IF EXISTS `action_view`*/;
/*!50001 DROP VIEW IF EXISTS `action_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `action_view` AS select `e`.`id` AS `evaluation_id`,`ma`.`id` AS `mat_attribut_id`,`ma`.`nom` AS `mat_attribut_nom`,cast(`ea`.`value` as unsigned) AS `selectionne`,cast(`ea_avct`.`value` as decimal(5,2)) AS `avancement`,cast(`ea_precedent`.`value` as unsigned) AS `selectionne_eval_precedent`,cast(`ea_avancement_precedent`.`value` as decimal(5,2)) AS `avancement_eval_precedent`,`mb`.`position` AS `position_bloc`,`mg`.`position` AS `position_groupe` from (((((((((`eval_attribut` `ea` left join `mat_attribut` `ma` on((`ea`.`mat_attribut_id` = `ma`.`id`))) left join `mat_groupe` `mg` on((`ma`.`mat_groupe_id` = `mg`.`id`))) left join `mat_bloc` `mb` on((`mg`.`mat_bloc_id` = `mb`.`id`))) left join `evaluation` `e` on((`ea`.`evaluation_id` = `e`.`id`))) left join `mat_attribut` `ma_avct` on(((`ma_avct`.`mat_groupe_id` = `ma`.`mat_groupe_id`) and (`ma_avct`.`code` = 'ACT_AVCT')))) left join `eval_attribut` `ea_avct` on(((`ea_avct`.`evaluation_id` = `e`.`id`) and (`ea_avct`.`mat_attribut_id` = `ma_avct`.`id`)))) left join `eval_precedente` on((`eval_precedente`.`evaluation_id` = `e`.`id`))) left join `eval_attribut` `ea_precedent` on(((`ea_precedent`.`evaluation_id` = `eval_precedente`.`evaluation_precedente_id`) and (`ea_precedent`.`mat_attribut_id` = `ma_avct`.`id`)))) left join `eval_attribut` `ea_avancement_precedent` on(((`ea_avancement_precedent`.`evaluation_id` = `eval_precedente`.`evaluation_precedente_id`) and (`ea_avancement_precedent`.`mat_attribut_id` = `ma_avct`.`id`)))) where (`ma`.`code` = 'ACT_SEL') order by `e`.`id`,`ma`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `eval_famille_modifiee_view`
--

/*!50001 DROP TABLE IF EXISTS `eval_famille_modifiee_view`*/;
/*!50001 DROP VIEW IF EXISTS `eval_famille_modifiee_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `eval_famille_modifiee_view` AS select `ef`.`evaluation_id` AS `evaluation_id`,`ef`.`mat_famille_id` AS `mat_famille_id` from ((((((((((`eval_famille` `ef` left join `mat_sous_famille` `msf` on((`ef`.`mat_famille_id` = `msf`.`mat_famille_id`))) left join `mat_bloc` `mb` on((`msf`.`id` = `mb`.`mat_sous_famille_id`))) left join `mat_groupe` `mg` on((`mb`.`id` = `mg`.`mat_bloc_id`))) left join `mat_attribut` `ma` on((`mg`.`id` = `ma`.`mat_groupe_id`))) left join `eval_attribut` `ea` on(((`ea`.`evaluation_id` = `ef`.`evaluation_id`) and (`ma`.`id` = `ea`.`mat_attribut_id`)))) left join `eval_option` `eo` on(((`eo`.`evaluation_id` = `ef`.`evaluation_id`) and (`ma`.`id` = `eo`.`mat_attribut_id`)))) left join `eval_precedente` on((`ef`.`evaluation_id` = `eval_precedente`.`evaluation_id`))) left join `eval_attribut` `ea_precedent` on(((`ea_precedent`.`evaluation_id` = `eval_precedente`.`evaluation_precedente_id`) and (`ma`.`id` = `ea_precedent`.`mat_attribut_id`)))) left join `eval_option` `eo_precedent` on(((`eo_precedent`.`evaluation_id` = `eval_precedente`.`evaluation_precedente_id`) and (`ma`.`id` = `eo_precedent`.`mat_attribut_id`) and (`eo_precedent`.`mat_option_id` = `eo`.`mat_option_id`)))) left join `eval_famille` `ef_precedente` on(((`ef_precedente`.`evaluation_id` = `eval_precedente`.`evaluation_precedente_id`) and (`ef`.`mat_famille_id` = `ef_precedente`.`mat_famille_id`)))) where ((((`ea_precedent`.`value` <=> `ea`.`value`) = 0) or ((`eo_precedent`.`value` <=> `eo`.`value`) = 0)) and ((`ea`.`evaluation_id` is not null) or (`eo`.`evaluation_id` is not null)) and (`ef_precedente`.`evaluation_id` is not null)) group by `ef`.`evaluation_id`,`ef`.`mat_famille_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `eval_precedente`
--

/*!50001 DROP TABLE IF EXISTS `eval_precedente`*/;
/*!50001 DROP VIEW IF EXISTS `eval_precedente`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `eval_precedente` AS select `e`.`etablissement_id` AS `etablissement_id`,`e`.`id` AS `evaluation_id`,(select `evaluation`.`id` from `evaluation` where ((`evaluation`.`est_validee` = 1) and ((`evaluation`.`date_validee` < `e`.`date_validee`) or `e`.`est_en_cours`) and (`evaluation`.`etablissement_id` = `e`.`etablissement_id`)) order by `evaluation`.`date_validee` desc limit 1) AS `evaluation_precedente_id` from `evaluation` `e` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `objectif_view`
--

/*!50001 DROP TABLE IF EXISTS `objectif_view`*/;
/*!50001 DROP VIEW IF EXISTS `objectif_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `objectif_view` AS select `e`.`id` AS `evaluation_id`,`ma`.`id` AS `mat_attribut_id`,`ma`.`nom` AS `mat_attribut_nom`,cast(`ea`.`value` as unsigned) AS `selectionne`,cast(`ea_rea`.`value` as unsigned) AS `realise`,cast(`ea_precedent`.`value` as unsigned) AS `selectionne_eval_precedent`,cast(`ea_rea_precedent`.`value` as unsigned) AS `realise_eval_precedent`,`mb`.`position` AS `position_bloc`,`mg`.`position` AS `position_groupe` from (((((((((`eval_attribut` `ea` left join `mat_attribut` `ma` on((`ea`.`mat_attribut_id` = `ma`.`id`))) left join `mat_groupe` `mg` on((`ma`.`mat_groupe_id` = `mg`.`id`))) left join `mat_bloc` `mb` on((`mg`.`mat_bloc_id` = `mb`.`id`))) left join `evaluation` `e` on((`ea`.`evaluation_id` = `e`.`id`))) left join `mat_attribut` `ma_rea` on(((`ma_rea`.`mat_groupe_id` = `ma`.`mat_groupe_id`) and (`ma_rea`.`code` = 'OBJ_REALISE')))) left join `eval_attribut` `ea_rea` on(((`ea_rea`.`evaluation_id` = `e`.`id`) and (`ea_rea`.`mat_attribut_id` = `ma_rea`.`id`)))) left join `eval_precedente` on((`eval_precedente`.`evaluation_id` = `e`.`id`))) left join `eval_attribut` `ea_precedent` on(((`ea_precedent`.`evaluation_id` = `eval_precedente`.`evaluation_precedente_id`) and (`ea_precedent`.`mat_attribut_id` = `ma`.`id`)))) left join `eval_attribut` `ea_rea_precedent` on(((`ea_rea_precedent`.`evaluation_id` = `eval_precedente`.`evaluation_precedente_id`) and (`ea_rea_precedent`.`mat_attribut_id` = `ma_rea`.`id`)))) where ((`ma`.`code` = 'OBJ_SEL') or (`ma`.`code` = 'OBJ_SEL_AUTRE')) order by `e`.`id`,`ma`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `prop_attribut_view`
--

/*!50001 DROP TABLE IF EXISTS `prop_attribut_view`*/;
/*!50001 DROP VIEW IF EXISTS `prop_attribut_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `prop_attribut_view` AS select `pa`.`id` AS `id`,`pa`.`structure_id` AS `structure_id`,`pa`.`mat_attribut_id` AS `mat_attribut_id`,`pa`.`version` AS `version`,`pa`.`value` AS `value`,`pa`.`imposee` AS `imposee`,`pa`.`enabled` AS `enabled`,`pa`.`created_at` AS `created_at`,`pa`.`updated_at` AS `updated_at`,(case when isnull(`t`.`id`) then NULL when ((`t`.`id` = 1) and `pa`.`imposee`) then 0 else 1 end) AS `order_type_structure` from ((`prop_attribut` `pa` left join `structure` `s` on((`s`.`id` = `pa`.`structure_id`))) left join `type_structure` `t` on((`t`.`id` = `s`.`type_structure_id`))) where (`s`.`enabled` = 1) order by (case when isnull(`t`.`id`) then NULL when ((`t`.`id` = 1) and `pa`.`imposee`) then 0 else 1 end),`pa`.`imposee` desc,`pa`.`updated_at` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `prop_option_view`
--

/*!50001 DROP TABLE IF EXISTS `prop_option_view`*/;
/*!50001 DROP VIEW IF EXISTS `prop_option_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `prop_option_view` AS select `po`.`id` AS `id`,`po`.`structure_id` AS `structure_id`,`po`.`mat_attribut_id` AS `mat_attribut_id`,`po`.`mat_option_id` AS `mat_option_id`,`po`.`version` AS `version`,`po`.`value` AS `value`,`po`.`imposee` AS `imposee`,`po`.`enabled` AS `enabled`,`po`.`created_at` AS `created_at`,`po`.`updated_at` AS `updated_at`,(case when isnull(`t`.`id`) then NULL when ((`t`.`id` = 1) and `po`.`imposee`) then 0 else 1 end) AS `order_type_structure` from ((`prop_option` `po` left join `structure` `s` on((`s`.`id` = `po`.`structure_id`))) left join `type_structure` `t` on((`t`.`id` = `s`.`type_structure_id`))) where (`s`.`enabled` = 1) order by (case when isnull(`t`.`id`) then NULL when ((`t`.`id` = 1) and `po`.`imposee`) then 0 else 1 end),`po`.`imposee` desc,`po`.`updated_at` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `proposer_imposer_count`
--

/*!50001 DROP TABLE IF EXISTS `proposer_imposer_count`*/;
/*!50001 DROP VIEW IF EXISTS `proposer_imposer_count`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `proposer_imposer_count` AS select `mf`.`id` AS `mat_famille_id`,`pa`.`structure_id` AS `prop_attribut_structure_id`,`po`.`structure_id` AS `prop_option_structure_id`,`epah`.`evaluation_id` AS `prop_attribut_evaluation_id`,`epoh`.`evaluation_id` AS `prop_option_evaluation_id`,`epah`.`statut` AS `prop_attribut_statut`,`epoh`.`statut` AS `prop_option_statut`,count(`pa`.`id`) AS `count_prop_attribut`,count(`po`.`id`) AS `count_prop_option` from ((((((((((`mat_famille` `mf` left join `mat_sous_famille` `msf` on((`msf`.`mat_famille_id` = `mf`.`id`))) left join `mat_bloc` `mb` on((`mb`.`mat_sous_famille_id` = `msf`.`id`))) left join `mat_groupe` `mg` on((`mg`.`mat_bloc_id` = `mb`.`id`))) left join `mat_attribut` `ma` on((`ma`.`mat_groupe_id` = `mg`.`id`))) left join `prop_attribut` `pa` on((`pa`.`mat_attribut_id` = `ma`.`id`))) left join `mat_option_set` `mos` on((`mos`.`id` = `ma`.`mat_option_set_id`))) left join `mat_option` `mo` on((`mo`.`mat_option_set_id` = `mos`.`id`))) left join `prop_option` `po` on(((`po`.`mat_attribut_id` = `ma`.`id`) and (`po`.`mat_option_id` = `mo`.`id`) and (`po`.`enabled` = 1)))) left join `eval_prop_attribut_histo` `epah` on((`epah`.`prop_attribut_id` = `pa`.`id`))) left join `eval_prop_option_histo` `epoh` on((`epoh`.`prop_option_id` = `po`.`id`))) where ((`pa`.`structure_id` is not null) or (`po`.`structure_id` is not null)) group by `mf`.`id`,`pa`.`structure_id`,`po`.`structure_id`,`epah`.`evaluation_id`,`epoh`.`evaluation_id`,`epah`.`statut`,`epoh`.`statut` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-14 17:07:48
