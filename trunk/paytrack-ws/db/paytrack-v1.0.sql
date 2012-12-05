CREATE DATABASE  IF NOT EXISTS `vsrinivasan` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `vsrinivasan`;
-- MySQL dump 10.13  Distrib 5.1.40, for Win32 (ia32)
--
-- Host: 127.0.0.1    Database: vsrinivasan
-- ------------------------------------------------------
-- Server version	5.0.18-nt

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
-- Not dumping tablespaces as no INFORMATION_SCHEMA.FILES table on this server
--

--
-- Table structure for table `gcm_devices`
--

DROP TABLE IF EXISTS `gcm_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gcm_devices` (
  `id` int(11) NOT NULL auto_increment,
  `project_number` bigint(20) NOT NULL,
  `registration_id` varchar(255) NOT NULL,
  `created_timestamp` timestamp NOT NULL default '0000-00-00 00:00:00',
  `last_updated_timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `uk_gcm_devices_1` (`project_number`,`registration_id`),
  KEY `fk_gcm_devices_1` (`project_number`),
  CONSTRAINT `fk_gcm_devices_1` FOREIGN KEY (`project_number`) REFERENCES `gcm_projects` (`project_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gcm_devices`
--

LOCK TABLES `gcm_devices` WRITE;
/*!40000 ALTER TABLE `gcm_devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `gcm_devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gcm_team_members`
--

DROP TABLE IF EXISTS `gcm_team_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gcm_team_members` (
  `id` int(11) NOT NULL auto_increment,
  `project_number` bigint(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `role` enum('Can view','Can edit','Is owner') NOT NULL,
  `created_timestamp` timestamp NOT NULL default '0000-00-00 00:00:00',
  `last_updated_timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `uk_gcm_team_members_1` (`project_number`,`email`,`role`),
  KEY `fk_gcm_team_members_1` (`project_number`),
  CONSTRAINT `fk_gcm_team_members_1` FOREIGN KEY (`project_number`) REFERENCES `gcm_projects` (`project_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gcm_team_members`
--

LOCK TABLES `gcm_team_members` WRITE;
/*!40000 ALTER TABLE `gcm_team_members` DISABLE KEYS */;
/*!40000 ALTER TABLE `gcm_team_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gcm_users`
--

DROP TABLE IF EXISTS `gcm_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gcm_users` (
  `id` int(11) NOT NULL auto_increment,
  `project_number` bigint(20) NOT NULL,
  `user_key` varchar(100) NOT NULL,
  `created_timestamp` timestamp NOT NULL default '0000-00-00 00:00:00',
  `last_updated_timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `uk_gcm_users_1` (`project_number`,`user_key`),
  KEY `fk_gcm_users_1` (`project_number`),
  CONSTRAINT `fk_gcm_users_1` FOREIGN KEY (`project_number`) REFERENCES `gcm_projects` (`project_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gcm_users`
--

LOCK TABLES `gcm_users` WRITE;
/*!40000 ALTER TABLE `gcm_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `gcm_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `apns_projects`
--

DROP TABLE IF EXISTS `apns_projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `apns_projects` (
  `bundle_identifier` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  `bundle_seed_id` varchar(100) NOT NULL,
  `user_key_type` enum('Intuit Id','Mobile Number','Email Address','other') NOT NULL default 'Email Address',
  `created_timestamp` timestamp NOT NULL default '0000-00-00 00:00:00',
  `last_updated_timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`bundle_identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apns_projects`
--

LOCK TABLES `apns_projects` WRITE;
/*!40000 ALTER TABLE `apns_projects` DISABLE KEYS */;
/*!40000 ALTER TABLE `apns_projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `apns_user_groups`
--

DROP TABLE IF EXISTS `apns_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `apns_user_groups` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `group_name` varchar(45) NOT NULL,
  `created_timestamp` timestamp NOT NULL default '0000-00-00 00:00:00',
  `last_updated_timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `uk_apns_user_groups_1` (`user_id`,`group_name`),
  KEY `fk_apns_user_groups_1` (`user_id`),
  CONSTRAINT `fk_apns_user_groups_1` FOREIGN KEY (`user_id`) REFERENCES `apns_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apns_user_groups`
--

LOCK TABLES `apns_user_groups` WRITE;
/*!40000 ALTER TABLE `apns_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `apns_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `apns_users`
--

DROP TABLE IF EXISTS `apns_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `apns_users` (
  `id` int(11) NOT NULL auto_increment,
  `bundle_identifier` varchar(100) NOT NULL,
  `user_key` varchar(100) NOT NULL,
  `created_timestamp` timestamp NOT NULL default '0000-00-00 00:00:00',
  `last_updated_timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `uk_apns_users_1` (`bundle_identifier`,`user_key`),
  KEY `fk_apns_users_1` (`bundle_identifier`),
  CONSTRAINT `fk_apns_users_1` FOREIGN KEY (`bundle_identifier`) REFERENCES `apns_projects` (`bundle_identifier`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apns_users`
--

LOCK TABLES `apns_users` WRITE;
/*!40000 ALTER TABLE `apns_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `apns_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `apns_device_users`
--

DROP TABLE IF EXISTS `apns_device_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `apns_device_users` (
  `id` int(11) NOT NULL auto_increment,
  `device_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_timestamp` timestamp NOT NULL default '0000-00-00 00:00:00',
  `last_updated_timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `fk_apns_device_users_1` (`device_id`),
  KEY `fk_apns_device_users_2` (`user_id`),
  CONSTRAINT `fk_apns_device_users_1` FOREIGN KEY (`device_id`) REFERENCES `apns_devices` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_apns_device_users_2` FOREIGN KEY (`user_id`) REFERENCES `apns_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apns_device_users`
--

LOCK TABLES `apns_device_users` WRITE;
/*!40000 ALTER TABLE `apns_device_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `apns_device_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gcm_device_users`
--

DROP TABLE IF EXISTS `gcm_device_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gcm_device_users` (
  `id` int(11) NOT NULL auto_increment,
  `device_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_timestamp` timestamp NOT NULL default '0000-00-00 00:00:00',
  `last_updated_timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `fk_gcm_device_users_1` (`user_id`),
  KEY `fk_gcm_device_users_2` (`device_id`),
  CONSTRAINT `fk_gcm_device_users_2` FOREIGN KEY (`device_id`) REFERENCES `gcm_devices` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_gcm_device_users_1` FOREIGN KEY (`user_id`) REFERENCES `gcm_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gcm_device_users`
--

LOCK TABLES `gcm_device_users` WRITE;
/*!40000 ALTER TABLE `gcm_device_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `gcm_device_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `apns_devices`
--

DROP TABLE IF EXISTS `apns_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `apns_devices` (
  `id` int(11) NOT NULL auto_increment,
  `bundle_identifier` varchar(100) NOT NULL,
  `device_token` varchar(255) NOT NULL,
  `badge_count` int(11) NOT NULL default '0',
  `created_timestamp` timestamp NOT NULL default '0000-00-00 00:00:00',
  `last_updated_timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `uk_apns_devices_1` (`bundle_identifier`,`device_token`),
  KEY `fk_apns_devices_1` (`bundle_identifier`),
  CONSTRAINT `fk_apns_devices_1` FOREIGN KEY (`bundle_identifier`) REFERENCES `apns_projects` (`bundle_identifier`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apns_devices`
--

LOCK TABLES `apns_devices` WRITE;
/*!40000 ALTER TABLE `apns_devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `apns_devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `apns_certificates`
--

DROP TABLE IF EXISTS `apns_certificates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `apns_certificates` (
  `id` int(11) NOT NULL auto_increment,
  `bundle_identifier` varchar(100) NOT NULL,
  `environment_type` enum('Development','Production') NOT NULL,
  `path` varchar(255) NOT NULL,
  `password` varchar(50) NOT NULL,
  `created_timestamp` timestamp NOT NULL default '0000-00-00 00:00:00',
  `last_updated_timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `uk_apns_certificates_1` (`bundle_identifier`,`environment_type`),
  KEY `fk_apns_certificates_1` (`bundle_identifier`),
  CONSTRAINT `fk_apns_certificates_1` FOREIGN KEY (`bundle_identifier`) REFERENCES `apns_projects` (`bundle_identifier`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apns_certificates`
--

LOCK TABLES `apns_certificates` WRITE;
/*!40000 ALTER TABLE `apns_certificates` DISABLE KEYS */;
/*!40000 ALTER TABLE `apns_certificates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gcm_projects`
--

DROP TABLE IF EXISTS `gcm_projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gcm_projects` (
  `project_number` bigint(20) NOT NULL,
  `project_name` varchar(100) NOT NULL,
  `api_key` varchar(100) NOT NULL,
  `user_key_type` enum('Intuit Id','Mobile Number','Email Address','other') NOT NULL default 'Email Address',
  `created_timestamp` timestamp NOT NULL default '0000-00-00 00:00:00',
  `last_updated_timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`project_number`),
  UNIQUE KEY `uk_gcm_projects_1` (`project_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gcm_projects`
--

LOCK TABLES `gcm_projects` WRITE;
/*!40000 ALTER TABLE `gcm_projects` DISABLE KEYS */;
/*!40000 ALTER TABLE `gcm_projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gcm_user_groups`
--

DROP TABLE IF EXISTS `gcm_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gcm_user_groups` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `group_name` varchar(45) NOT NULL,
  `created_timestamp` timestamp NOT NULL default '0000-00-00 00:00:00',
  `last_updated_timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `uk_gcm_user_groups_1` (`user_id`,`group_name`),
  KEY `fk_gcm_user_groups_1` (`user_id`),
  CONSTRAINT `fk_gcm_user_groups_1` FOREIGN KEY (`user_id`) REFERENCES `gcm_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gcm_user_groups`
--

LOCK TABLES `gcm_user_groups` WRITE;
/*!40000 ALTER TABLE `gcm_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `gcm_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `apns_team_members`
--

DROP TABLE IF EXISTS `apns_team_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `apns_team_members` (
  `id` int(11) NOT NULL auto_increment,
  `bundle_identifier` varchar(100) NOT NULL,
  `email` varchar(50) NOT NULL,
  `role` enum('Admin','Developer') NOT NULL,
  `created_timestamp` timestamp NOT NULL default '0000-00-00 00:00:00',
  `last_updated_timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `uk_apns_team_members_1` (`bundle_identifier`,`email`,`role`),
  KEY `fk_apns_team_members_1` (`bundle_identifier`),
  CONSTRAINT `fk_apns_team_members_1` FOREIGN KEY (`bundle_identifier`) REFERENCES `apns_projects` (`bundle_identifier`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apns_team_members`
--

LOCK TABLES `apns_team_members` WRITE;
/*!40000 ALTER TABLE `apns_team_members` DISABLE KEYS */;
/*!40000 ALTER TABLE `apns_team_members` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-11-23 15:42:41
