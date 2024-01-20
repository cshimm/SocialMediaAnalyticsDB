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
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `address_id` int NOT NULL,
  `person_id` int DEFAULT NULL,
  `street_address` text,
  `city_id` int DEFAULT NULL,
  `state_id` int DEFAULT NULL,
  PRIMARY KEY (`address_id`),
  KEY `ad_person_id_idx` (`person_id`),
  KEY `ad_city_id_idx` (`city_id`),
  KEY `ad_state_id_idx` (`state_id`),
  CONSTRAINT `ad_city_id` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`),
  CONSTRAINT `ad_person_id` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`),
  CONSTRAINT `ad_state_id` FOREIGN KEY (`state_id`) REFERENCES `state` (`state_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` (`address_id`, `person_id`, `street_address`, `city_id`, `state_id`) VALUES (1,1,'123 Main St',1,2),(2,2,'456 Oak Ave',3,1),(3,1,'789 Pine Rd',2,3),(4,3,'321 Elm Blvd',1,2),(5,2,'567 Maple Ln',3,1);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city` (
  `city_id` int NOT NULL AUTO_INCREMENT,
  `city_name` varchar(45) NOT NULL,
  PRIMARY KEY (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` (`city_id`, `city_name`) VALUES (1,'New York'),(2,'Los Angeles'),(3,'Chicago'),(4,'San Francisco'),(5,'Miami');
/*!40000 ALTER TABLE `city` ENABLE KEYS */;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country` (
  `country_id` int NOT NULL AUTO_INCREMENT,
  `country_name` varchar(45) NOT NULL,
  `country_code` int DEFAULT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` (`country_id`, `country_name`, `country_code`) VALUES (1,'United States',0),(2,'Canada',0),(3,'United Kingdom',0),(4,'Germany',0),(5,'France',0);
/*!40000 ALTER TABLE `country` ENABLE KEYS */;

--
-- Table structure for table `device`
--

DROP TABLE IF EXISTS `device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `device` (
  `device_id` int NOT NULL,
  `ip_address` text,
  `make_id` int DEFAULT NULL,
  `model_id` int DEFAULT NULL,
  `person_id` int DEFAULT NULL,
  PRIMARY KEY (`device_id`),
  KEY `d_model_id_idx` (`model_id`),
  KEY `d_person_id_idx` (`person_id`),
  CONSTRAINT `d_model_id` FOREIGN KEY (`model_id`) REFERENCES `device_model` (`device_model_id`),
  CONSTRAINT `d_person_id` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device`
--

/*!40000 ALTER TABLE `device` DISABLE KEYS */;
INSERT INTO `device` (`device_id`, `ip_address`, `make_id`, `model_id`, `person_id`) VALUES (1,'192.168.1.100',1,101,1),(2,'192.168.2.200',2,201,2),(3,'192.168.3.300',1,102,3),(4,'192.168.4.400',3,301,1),(5,'192.168.5.500',2,202,2);
/*!40000 ALTER TABLE `device` ENABLE KEYS */;

--
-- Table structure for table `device_make`
--

DROP TABLE IF EXISTS `device_make`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `device_make` (
  `device_make_id` int NOT NULL,
  `make_name` text,
  PRIMARY KEY (`device_make_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_make`
--

/*!40000 ALTER TABLE `device_make` DISABLE KEYS */;
INSERT INTO `device_make` (`device_make_id`, `make_name`) VALUES (1,'Apple'),(2,'Samsung'),(3,'Dell'),(4,'HP'),(5,'Sony');
/*!40000 ALTER TABLE `device_make` ENABLE KEYS */;

--
-- Table structure for table `device_model`
--

DROP TABLE IF EXISTS `device_model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `device_model` (
  `device_model_id` int NOT NULL,
  `model_name` text,
  `make_id` int DEFAULT NULL,
  PRIMARY KEY (`device_model_id`),
  KEY `dev_make_id_idx` (`make_id`),
  CONSTRAINT `dev_make_id` FOREIGN KEY (`make_id`) REFERENCES `device_make` (`device_make_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_model`
--

/*!40000 ALTER TABLE `device_model` DISABLE KEYS */;
INSERT INTO `device_model` (`device_model_id`, `model_name`, `make_id`) VALUES (101,'iPhone X',1),(102,'Galaxy S20',2),(201,'Inspiron 15',3),(202,'EliteBook 840',4),(301,'PlayStation 5',5);
/*!40000 ALTER TABLE `device_model` ENABLE KEYS */;

--
-- Table structure for table `email`
--

DROP TABLE IF EXISTS `email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email` (
  `email_id` int NOT NULL AUTO_INCREMENT,
  `person_id` int DEFAULT NULL,
  `email_address` text,
  PRIMARY KEY (`email_id`),
  KEY `e_person_id_idx` (`person_id`),
  CONSTRAINT `e_person_id` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email`
--

/*!40000 ALTER TABLE `email` DISABLE KEYS */;
INSERT INTO `email` (`email_id`, `person_id`, `email_address`) VALUES (1,1,'john.doe@example.com'),(2,2,'jane.smith@example.com'),(3,3,'mike.jones@example.com'),(4,1,'susan.white@example.com'),(5,2,'david.wilson@example.com');
/*!40000 ALTER TABLE `email` ENABLE KEYS */;

--
-- Table structure for table `login_event`
--

DROP TABLE IF EXISTS `login_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login_event` (
  `login_event_id` int NOT NULL,
  `dateTime` text,
  `account_id` int DEFAULT NULL,
  `device_id` int DEFAULT NULL,
  PRIMARY KEY (`login_event_id`),
  KEY `li_account_id_idx` (`account_id`),
  KEY `li_device_id_idx` (`device_id`),
  CONSTRAINT `li_account_id` FOREIGN KEY (`account_id`) REFERENCES `social_account` (`social_account_id`),
  CONSTRAINT `li_device_id` FOREIGN KEY (`device_id`) REFERENCES `device` (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_event`
--

/*!40000 ALTER TABLE `login_event` DISABLE KEYS */;
INSERT INTO `login_event` (`login_event_id`, `dateTime`, `account_id`, `device_id`) VALUES (1,'2024-01-16 8:30:00',101,1),(2,'2024-01-16 12:45:00',202,2),(3,'2024-01-16 15:20:00',303,3),(4,'2024-01-16 18:10:00',101,4),(5,'2024-01-16 21:00:00',202,5);
/*!40000 ALTER TABLE `login_event` ENABLE KEYS */;

--
-- Table structure for table `logout_event`
--

DROP TABLE IF EXISTS `logout_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logout_event` (
  `logout_event_id` int NOT NULL,
  `dateTime` text,
  `account_id` int DEFAULT NULL,
  `device_id` int DEFAULT NULL,
  PRIMARY KEY (`logout_event_id`),
  KEY `lo_account_id_idx` (`account_id`),
  KEY `lo_device_id_idx` (`device_id`),
  CONSTRAINT `lo_account_id` FOREIGN KEY (`account_id`) REFERENCES `social_account` (`social_account_id`),
  CONSTRAINT `lo_device_id` FOREIGN KEY (`device_id`) REFERENCES `device` (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logout_event`
--

/*!40000 ALTER TABLE `logout_event` DISABLE KEYS */;
INSERT INTO `logout_event` (`logout_event_id`, `dateTime`, `account_id`, `device_id`) VALUES (1,'2024-01-16 9:15:00',101,1),(2,'2024-01-16 13:30:00',202,2),(3,'2024-01-16 16:45:00',303,3),(4,'2024-01-16 19:30:00',101,4),(5,'2024-01-16 22:15:00',202,5);
/*!40000 ALTER TABLE `logout_event` ENABLE KEYS */;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person` (
  `person_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` (`person_id`, `first_name`, `last_name`, `date_of_birth`, `gender`) VALUES (1,'John','Doe','1990-05-15','Male'),(2,'Jane','Smith','1985-08-22','Female'),(3,'Mike','Jones','1993-02-10','Male'),(4,'Susan','White','1988-11-30','Female'),(5,'David','Wilson','1995-07-07','Male');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;

--
-- Table structure for table `phone`
--

DROP TABLE IF EXISTS `phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phone` (
  `phone_id` int NOT NULL,
  `person_id` int DEFAULT NULL,
  `country_code` text,
  `phone_num` text,
  PRIMARY KEY (`phone_id`),
  KEY `p_person_id_idx` (`person_id`),
  CONSTRAINT `p_person_id` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phone`
--

/*!40000 ALTER TABLE `phone` DISABLE KEYS */;
INSERT INTO `phone` (`phone_id`, `person_id`, `country_code`, `phone_num`) VALUES (1,1,'+1','555-1234'),(2,2,'+1','555-5678'),(3,3,'+44','20-1234-5678'),(4,1,'+1','555-8765'),(5,2,'+1','555-4321');
/*!40000 ALTER TABLE `phone` ENABLE KEYS */;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `price` varchar(45) NOT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` (`product_id`, `name`, `price`) VALUES (1,'Laptop','1200'),(2,'Smartphone','800'),(3,'Headphones','100'),(4,'Desk Chair','150'),(5,'Tablet','500');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;

--
-- Table structure for table `purchase`
--

DROP TABLE IF EXISTS `purchase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase` (
  `purchase_id` int NOT NULL,
  `date` text,
  `seller_acc_id` int DEFAULT NULL,
  `buyer_acc_id` int DEFAULT NULL,
  PRIMARY KEY (`purchase_id`),
  KEY `pur_seller_id_idx` (`seller_acc_id`),
  KEY `pur_buyer_id_idx` (`buyer_acc_id`),
  CONSTRAINT `pur_buyer_id` FOREIGN KEY (`buyer_acc_id`) REFERENCES `social_account` (`social_account_id`),
  CONSTRAINT `pur_seller_id` FOREIGN KEY (`seller_acc_id`) REFERENCES `social_account` (`social_account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase`
--

/*!40000 ALTER TABLE `purchase` DISABLE KEYS */;
INSERT INTO `purchase` (`purchase_id`, `date`, `seller_acc_id`, `buyer_acc_id`) VALUES (1,'2024-01-16',101,202),(2,'2024-01-17',202,101),(3,'2024-01-18',303,404),(4,'2024-01-19',101,303),(5,'2024-01-20',202,505);
/*!40000 ALTER TABLE `purchase` ENABLE KEYS */;

--
-- Table structure for table `purchase_products`
--

DROP TABLE IF EXISTS `purchase_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_products` (
  `purchase_product_id` int NOT NULL,
  `qty` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `purchase_id` int DEFAULT NULL,
  PRIMARY KEY (`purchase_product_id`),
  KEY `pp_product_id_idx` (`product_id`),
  KEY `pp_purchase_id_idx` (`purchase_id`),
  CONSTRAINT `pp_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `pp_purchase_id` FOREIGN KEY (`purchase_id`) REFERENCES `purchase` (`purchase_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_products`
--

/*!40000 ALTER TABLE `purchase_products` DISABLE KEYS */;
INSERT INTO `purchase_products` (`purchase_product_id`, `qty`, `product_id`, `purchase_id`) VALUES (1,2,1,1),(2,1,3,1),(3,3,2,2),(4,1,5,2),(5,2,4,3);
/*!40000 ALTER TABLE `purchase_products` ENABLE KEYS */;

--
-- Table structure for table `social_account`
--

DROP TABLE IF EXISTS `social_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `social_account` (
  `social_account_id` int NOT NULL,
  `username` text,
  `person_id` int DEFAULT NULL,
  `platform_id` int DEFAULT NULL,
  PRIMARY KEY (`social_account_id`),
  KEY `sa_person_id_idx` (`person_id`),
  KEY `sa_platform_id_idx` (`platform_id`),
  CONSTRAINT `sa_person_id` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`),
  CONSTRAINT `sa_platform_id` FOREIGN KEY (`platform_id`) REFERENCES `social_platform` (`social_platform_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_account`
--

/*!40000 ALTER TABLE `social_account` DISABLE KEYS */;
INSERT INTO `social_account` (`social_account_id`, `username`, `person_id`, `platform_id`) VALUES (101,'john_doe_123',1,1),(202,'jane_smith_456',2,2),(303,'mike_jones_789',3,3),(404,'susan_white_101',1,4),(505,'david_wilson_202',2,1);
/*!40000 ALTER TABLE `social_account` ENABLE KEYS */;

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

/*!40000 ALTER TABLE `social_comment` DISABLE KEYS */;
INSERT INTO `social_comment` (`social_comment_id`, `content`, `dateTime`, `post_id`, `account_id`) VALUES (1,'Great post!','2024-01-16 10:30:00',101,101),(2,'I love this!','2024-01-16 12:45:00',202,202),(3,'Interesting discussion!','2024-01-16 15:20:00',303,303),(4,'Thanks for sharing!','2024-01-16 18:10:00',101,404),(5,'Amazing content!','2024-01-16 21:00:00',202,505);
/*!40000 ALTER TABLE `social_comment` ENABLE KEYS */;

--
-- Table structure for table `social_like`
--

DROP TABLE IF EXISTS `social_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `social_like` (
  `social_like_id` int NOT NULL,
  `date` text,
  `post_id` int DEFAULT NULL,
  `account_id` int DEFAULT NULL,
  PRIMARY KEY (`social_like_id`),
  KEY `sl_post_id_idx` (`post_id`),
  KEY `sl_account_id_idx` (`account_id`),
  CONSTRAINT `sl_account_id` FOREIGN KEY (`account_id`) REFERENCES `social_account` (`social_account_id`),
  CONSTRAINT `sl_post_id` FOREIGN KEY (`post_id`) REFERENCES `social_post` (`social_post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_like`
--

/*!40000 ALTER TABLE `social_like` DISABLE KEYS */;
INSERT INTO `social_like` (`social_like_id`, `date`, `post_id`, `account_id`) VALUES (1,'2024-01-16 11:15:00',101,101),(2,'2024-01-16 13:30:00',202,202),(3,'2024-01-16 16:45:00',303,303),(4,'2024-01-16 19:30:00',101,404),(5,'2024-01-16 22:15:00',202,505);
/*!40000 ALTER TABLE `social_like` ENABLE KEYS */;

--
-- Table structure for table `social_platform`
--

DROP TABLE IF EXISTS `social_platform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `social_platform` (
  `social_platform_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`social_platform_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_platform`
--

/*!40000 ALTER TABLE `social_platform` DISABLE KEYS */;
INSERT INTO `social_platform` (`social_platform_id`, `name`) VALUES (1,'Instagram'),(2,'Facebook'),(3,'Twitter'),(4,'LinkedIn'),(5,'TikTok');
/*!40000 ALTER TABLE `social_platform` ENABLE KEYS */;

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

/*!40000 ALTER TABLE `social_post` DISABLE KEYS */;
INSERT INTO `social_post` (`social_post_id`, `title`, `content`, `dateTime`, `account_id`) VALUES (101,'My Adventure','Just had an amazing adventure!','2024-01-16 10:00:00',101),(202,'Delicious Recipe','Check out this delicious recipe I tried!','2024-01-16 12:30:00',202),(303,'Tech Talk','Discussing the latest tech trends.','2024-01-16 15:00:00',303),(404,'Beautiful Sunset','Captured a beautiful sunset today.','2024-01-16 18:45:00',404),(505,'Travel Diaries','Sharing memories from my recent travels.','2024-01-16 21:15:00',505);
/*!40000 ALTER TABLE `social_post` ENABLE KEYS */;

--
-- Table structure for table `state`
--

DROP TABLE IF EXISTS `state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `state` (
  `state_id` int NOT NULL AUTO_INCREMENT,
  `state_name` varchar(45) NOT NULL,
  PRIMARY KEY (`state_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `state`
--

/*!40000 ALTER TABLE `state` DISABLE KEYS */;
INSERT INTO `state` (`state_id`, `state_name`) VALUES (1,'New York'),(2,'California'),(3,'Texas'),(4,'Florida'),(5,'Illinois');
/*!40000 ALTER TABLE `state` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-20 11:20:23
