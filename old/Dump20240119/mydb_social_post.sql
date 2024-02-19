-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `social_post`
--

DROP TABLE IF EXISTS `social_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `social_post` (
  `social_post_id` int NOT NULL,
  `title` text,
  `content` text,
  `dateTime` text,
  `account_id` int DEFAULT NULL,
  PRIMARY KEY (`social_post_id`),
  KEY `sp_account_id_idx` (`account_id`),
  CONSTRAINT `sp_account_id` FOREIGN KEY (`account_id`) REFERENCES `social_account` (`social_account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_post`
--

LOCK TABLES `social_post` WRITE;
/*!40000 ALTER TABLE `social_post` DISABLE KEYS */;
INSERT INTO `social_post` VALUES (101,'My Adventure','Just had an amazing adventure!','2024-01-16 10:00:00',101),(202,'Delicious Recipe','Check out this delicious recipe I tried!','2024-01-16 12:30:00',202),(303,'Tech Talk','Discussing the latest tech trends.','2024-01-16 15:00:00',303),(404,'Beautiful Sunset','Captured a beautiful sunset today.','2024-01-16 18:45:00',404),(505,'Travel Diaries','Sharing memories from my recent travels.','2024-01-16 21:15:00',505);
/*!40000 ALTER TABLE `social_post` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-19 12:53:50
