CREATE DATABASE  IF NOT EXISTS `paytrack` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `paytrack`;
-- MySQL dump 10.13  Distrib 5.1.40, for Win32 (ia32)
--
-- Host: 127.0.0.1    Database: paytrack
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
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients` (
  `id` int(11) NOT NULL auto_increment,
  `first_name` varchar(100) character set latin1 default NULL,
  `last_name` varchar(100) character set latin1 default NULL,
  `email_id` varchar(50) character set latin1 NOT NULL,
  `mobile_number` varchar(20) character set latin1 default NULL,
  `address` varchar(300) character set latin1 default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,'Rama','Palaniappan','rama.palaniappan@gmail.com','+919845531505','Bangalore - 560037');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `providers`
--

DROP TABLE IF EXISTS `providers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `providers` (
  `id` int(11) NOT NULL auto_increment,
  `first_name` varchar(100) character set latin1 default NULL,
  `last_name` varchar(100) character set latin1 default NULL,
  `email_id` varchar(50) character set latin1 NOT NULL,
  `mobile_number` varchar(20) character set latin1 default NULL,
  `address` varchar(300) character set latin1 default NULL,
  `service_name` varchar(200) character set latin1 default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `providers`
--

LOCK TABLES `providers` WRITE;
/*!40000 ALTER TABLE `providers` DISABLE KEYS */;
INSERT INTO `providers` VALUES (1,'Vijayan','Srinivasan','vijayan.srinivasan@gmail.com','+919986508767','2/87 Pavadi Street, Kalangani PO, Namakkal - 637014','Maths Tution'),(2,'Venkata','Gopinath','gopinathbodagala@gmail.com','+919538092053','Kadappa - 516001','English Tution'),(3,'Sushma','Chakkirala','sushma.chakkirala@gmail.com','+919945115107','Bangalore - 560037','Dance Class'),(4,'Rama','Palaniappan','rama.palaniappan@gmail.com','+919845531505','Bangalore - 560037','Cricket Coach');
/*!40000 ALTER TABLE `providers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider_clients`
--

DROP TABLE IF EXISTS `provider_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provider_clients` (
  `id` int(11) NOT NULL auto_increment,
  `provider_id` int(11) default NULL,
  `client_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `provider_foreign_key` (`provider_id`),
  KEY `client_foreign_key` (`client_id`),
  CONSTRAINT `client_foreign_key` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `provider_foreign_key` FOREIGN KEY (`provider_id`) REFERENCES `providers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider_clients`
--

LOCK TABLES `provider_clients` WRITE;
/*!40000 ALTER TABLE `provider_clients` DISABLE KEYS */;
INSERT INTO `provider_clients` VALUES (1,1,1);
/*!40000 ALTER TABLE `provider_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reciepts`
--

DROP TABLE IF EXISTS `reciepts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reciepts` (
  `id` int(11) NOT NULL auto_increment,
  `provider_clients_id` int(11) default NULL,
  `from` timestamp NULL default NULL,
  `to` timestamp NULL default NULL,
  `amount` decimal(10,0) default NULL,
  `payment_date` timestamp NULL default NULL,
  PRIMARY KEY  (`id`),
  KEY `provider_clients_id` (`provider_clients_id`),
  CONSTRAINT `provider_clients_id` FOREIGN KEY (`provider_clients_id`) REFERENCES `provider_clients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reciepts`
--

LOCK TABLES `reciepts` WRITE;
/*!40000 ALTER TABLE `reciepts` DISABLE KEYS */;
INSERT INTO `reciepts` VALUES (1,1,'2012-11-30 18:30:00','2012-12-30 18:30:00','1000','2012-12-04 18:30:00'),(2,1,'2012-11-30 18:30:00','2012-12-30 18:30:00','1000','2012-12-05 18:30:00'),(3,1,'2012-11-30 18:30:00','2012-12-30 18:30:00','1000','2012-11-30 18:30:00');
/*!40000 ALTER TABLE `reciepts` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-12-05 15:54:14
