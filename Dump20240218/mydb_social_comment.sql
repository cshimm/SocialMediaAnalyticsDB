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
-- Table structure for table `social_comment`
--

DROP TABLE IF EXISTS `social_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `social_comment` (
  `social_comment_id` int NOT NULL,
  `content` text,
  `dateTime` text,
  `post_id` int DEFAULT NULL,
  `account_id` int DEFAULT NULL,
  PRIMARY KEY (`social_comment_id`),
  KEY `sc_post_id_idx` (`post_id`),
  KEY `sc_account_id_idx` (`account_id`),
  CONSTRAINT `sc_account_id` FOREIGN KEY (`account_id`) REFERENCES `social_account` (`social_account_id`),
  CONSTRAINT `sc_post_id` FOREIGN KEY (`post_id`) REFERENCES `social_post` (`social_post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_comment`
--

LOCK TABLES `social_comment` WRITE;
/*!40000 ALTER TABLE `social_comment` DISABLE KEYS */;
INSERT INTO `social_comment` (`social_comment_id`, `content`, `dateTime`, `post_id`, `account_id`) VALUES (1,'Great post!','2024-01-16 10:30:00',101,101),(2,'I love this!','2024-01-16 12:45:00',202,202),(3,'Interesting discussion!','2024-01-16 15:20:00',303,303),(4,'Thanks for sharing!','2024-01-16 18:10:00',101,404),(5,'Amazing content!','2024-01-16 21:00:00',202,505);
/*!40000 ALTER TABLE `social_comment` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-18 16:19:46
