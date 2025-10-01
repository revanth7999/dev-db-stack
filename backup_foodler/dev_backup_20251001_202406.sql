-- MySQL dump 10.13  Distrib 8.0.43, for Linux (x86_64)
--
-- Host: localhost    Database: dev
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `DATABASECHANGELOG`
--

DROP TABLE IF EXISTS `DATABASECHANGELOG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DATABASECHANGELOG` (
  `ID` varchar(255) NOT NULL,
  `AUTHOR` varchar(255) NOT NULL,
  `FILENAME` varchar(255) NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int NOT NULL,
  `EXECTYPE` varchar(10) NOT NULL,
  `MD5SUM` varchar(35) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `COMMENTS` varchar(255) DEFAULT NULL,
  `TAG` varchar(255) DEFAULT NULL,
  `LIQUIBASE` varchar(20) DEFAULT NULL,
  `CONTEXTS` varchar(255) DEFAULT NULL,
  `LABELS` varchar(255) DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DATABASECHANGELOG`
--

LOCK TABLES `DATABASECHANGELOG` WRITE;
/*!40000 ALTER TABLE `DATABASECHANGELOG` DISABLE KEYS */;
INSERT INTO `DATABASECHANGELOG` VALUES ('1','Revanth N','db/changelog/changelog-1.0.xml','2025-05-04 07:32:34',1,'EXECUTED','9:c5075b337c9af3827f92f45f8662fb4c','insert tableName=captain','',NULL,'4.29.2',NULL,NULL,'6324154817'),('1','admin','db/changelog/changelog-2.0.xml','2025-05-04 09:15:11',2,'EXECUTED','9:665ac7f22d6982765a98f335d6ea1f65','insert tableName=restaurants','',NULL,'4.29.2',NULL,NULL,'6330311450'),('2','Revanth N','db/changelog/changelog-2.0.xml','2025-05-04 09:15:11',3,'EXECUTED','9:4271b8700aef1a70ee54328da713a0fa','insert tableName=restaurants','',NULL,'4.29.2',NULL,NULL,'6330311450'),('3','Revanth N','db/changelog/changelog-2.0.xml','2025-05-04 09:15:11',4,'EXECUTED','9:b80afe47aee65d454ea03d6ef30df31c','insert tableName=restaurants','',NULL,'4.29.2',NULL,NULL,'6330311450'),('4','Revanth N','db/changelog/changelog-2.0.xml','2025-05-04 15:37:15',5,'EXECUTED','9:8deb3616cc259a162de5dce0766674a5','addColumn tableName=restaurants','',NULL,'4.29.2',NULL,NULL,'6353235374'),('5','Revanth N','db/changelog/changelog-2.0.xml','2025-05-04 15:37:15',6,'EXECUTED','9:ca8fd92978186fe1b121cdc74e217c6b','update tableName=restaurants; update tableName=restaurants; update tableName=restaurants','',NULL,'4.29.2',NULL,NULL,'6353235374'),('update-address-existing-data','Revanth N','db/changelog/changelog-3.0.xml','2025-05-06 07:01:06',7,'EXECUTED','9:82daa7b6058a1b98615982d71edd71a0','update tableName=restaurants; update tableName=restaurants; update tableName=restaurants','',NULL,'4.29.2',NULL,NULL,'6495066294'),('add-dish-data','Revanth N','db/changelog/changelog-4.0.xml','2025-05-07 06:46:44',8,'EXECUTED','9:d6cd2d0e803e0e4dcdecfa58ba7987c2','update tableName=restaurants; update tableName=restaurants; update tableName=restaurants','',NULL,'4.29.2',NULL,NULL,'6580602980'),('add-dish-datas','Revanth N','db/changelog/changelog-4.0.xml','2025-05-07 07:09:45',9,'EXECUTED','9:d6cd2d0e803e0e4dcdecfa58ba7987c2','update tableName=restaurants; update tableName=restaurants; update tableName=restaurants','',NULL,'4.29.2',NULL,NULL,'6581985938'),('insert-dishes-001','Revanth N','db/changelog/changelog-5.0.xml','2025-05-07 07:10:44',10,'EXECUTED','9:4f94f8609bc1af56b6a8f21f8dea2594','insert tableName=restaurant_dishes; insert tableName=restaurant_dishes; insert tableName=restaurant_dishes','',NULL,'4.29.2',NULL,NULL,'6582044251'),('insert-roles','Revanth N','db/changelog/changelog-6.0.xml','2025-05-09 17:31:10',11,'EXECUTED','9:806b45225096512c5d3b6c40c5ec1b02','insert tableName=roles; insert tableName=roles; insert tableName=roles','',NULL,'4.29.2',NULL,NULL,'6792070409');
/*!40000 ALTER TABLE `DATABASECHANGELOG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DATABASECHANGELOGLOCK`
--

DROP TABLE IF EXISTS `DATABASECHANGELOGLOCK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DATABASECHANGELOGLOCK` (
  `ID` int NOT NULL,
  `LOCKED` tinyint NOT NULL,
  `LOCKGRANTED` datetime DEFAULT NULL,
  `LOCKEDBY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DATABASECHANGELOGLOCK`
--

LOCK TABLES `DATABASECHANGELOGLOCK` WRITE;
/*!40000 ALTER TABLE `DATABASECHANGELOGLOCK` DISABLE KEYS */;
INSERT INTO `DATABASECHANGELOGLOCK` VALUES (1,0,NULL,NULL);
/*!40000 ALTER TABLE `DATABASECHANGELOGLOCK` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `captain`
--

DROP TABLE IF EXISTS `captain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `captain` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(255) DEFAULT NULL,
  `created_time_stamp` datetime(6) DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `captain`
--

LOCK TABLES `captain` WRITE;
/*!40000 ALTER TABLE `captain` DISABLE KEYS */;
INSERT INTO `captain` VALUES (1,NULL,'2025-04-28 12:00:00.000000',NULL,'admin','captain_01'),(2,'$2a$10$gyyT0n73omNLUTNm1YPbr.VZT456QPS7jZGM5s/LpS9csMtIAemDm','2025-05-04 07:45:38.713000',NULL,'CUSTOMER','yashu'),(3,'$2a$10$vIiR0ad7Jph0/9Fn/zZ0teumsvXrc3w8d8oDTwekiIBbBVz6dBCdK','2025-05-04 14:46:08.195000',NULL,'CUSTOMER','rev'),(4,'$2a$10$dBxsVR7lY9irjueCVpa41ufxpf395rHVWivf0SvYRViQg301bRvBi','2025-05-04 14:51:12.306000',NULL,'CUSTOMER','rr'),(5,'$2a$10$tiJUg8q.jAwTQ2rAoFLdtO1pjamdlqiqzr5JJc90pVwfKkfMkXdha','2025-05-04 15:18:35.260000',NULL,'CUSTOMER','io'),(6,'$2a$10$sJmjEtR/t1vIe5DvJRFtku3h.4B4iGgiy5YyAYP5P8bkofQFovnxi','2025-05-04 15:19:21.936000',NULL,'CUSTOMER','tt'),(7,'$2a$10$qaFwwCpYT4KgFPT7680IJejRd48zsUZKZcUPIJw0VHG8ENCU5Rj1i','2025-05-04 15:38:05.869000',NULL,'CUSTOMER','e'),(8,'$2a$10$XPPodq.rkPen1nRSnwdJaeKQGtY12UnbIT241IflsVSKx91cfwxTS','2025-05-06 07:03:17.809000',NULL,'CUSTOMER','oo'),(9,'$2a$10$mSQVuuiKiVtUFDMNa6E73e4o/xlDQN6IzIT9u33CO/anYRDb4b7Yy','2025-05-06 07:44:00.729000',NULL,'CUSTOMER','check'),(10,'$2a$10$vHJ50/eV37SmN0NGyDSwz./bmbnSBoylvkE6WnLxJ50yhgMPiek.G','2025-05-06 08:03:52.188000',NULL,NULL,'revthtrdfgd'),(11,'$2a$10$Hztux5WfEMRyDhZTiExZxe5xrjceD7yyYAd76QQuw7bpkWBqtMb/i','2025-05-06 08:04:03.375000',NULL,'Cleaner','revthtrdfgd'),(12,'$2a$10$NZrloqOSBPIOZ/F/t6zrJeV2wZ0BFYHqIsDZmT/gPU7osj.d2PX/a','2025-05-06 15:44:58.063000',NULL,'ADMIN','admin'),(13,'$2a$10$Cb7TXI17VcGzi77Lnw8gBuhFF/yc0qDrp1iUl0B9yU2vZyLnYGPTO','2025-05-06 16:18:44.153000',NULL,'Admin','admin1'),(14,'$2a$10$1WMBfbZUOOfMeJ5Eh9ohwe1ljrsMsRZll77tkvDcwIlOz/gThE8ri','2025-05-06 16:24:04.223000',_binary '','CUSTOMER','hbhj'),(15,'$2a$10$sUy0E5CiiXjJUagzhKQXtOEMimB/LSrewNRHJWjDjl8x7cV.Uw64m','2025-05-09 18:34:21.820000',_binary '','CUSTOMER','deedevsh'),(16,'$2a$10$hcu5LRZIAfUeNWsAkHTeVervjQAMKEW2web.ewNZzexNMZ9aIhHC2','2025-05-09 18:38:36.625000',NULL,'CUSTOMER','jathin'),(17,'$2a$10$dS1XkyIcQyq6KjZcH9n95.QTJ78IaboBi.ayStblkRgXwpAWKsZNu','2025-05-09 18:39:28.145000',NULL,'CUSTOMER','major'),(18,'$2a$10$KI.GvGS/VbQEQAxrE72fxuAHmevdBtlyBipc5asC7zY/1u.SMLgkW','2025-05-09 18:40:25.877000',NULL,'CUSTOMER','mega'),(19,'$2a$10$v.PjpFRiOblj3sj80DS7qOuKam56kg/9QB0BZOJpTXaTfz06LUOsi','2025-05-09 18:41:07.535000',_binary '','CUSTOMER','varis'),(20,'$2a$10$itDiP7oLrrQzBrHgMRuiZOSznCcZ4nQeoHVIMbeZqoCVhmWBFRm7.','2025-05-10 06:32:46.447000',_binary '','CUSTOMER','hero'),(21,'$2a$10$bIEPazJqBgGIGJsX54viIux/GSTvhZQYizB3vQNWdehW01ip2E.Me','2025-05-10 06:35:40.803000',_binary '','CUSTOMER','hiva'),(22,'$2a$10$WMqBZg1r8Jy0h/o8k.H4leo.3KE4vCxOnbXXI9L6R/F79YrCdSLr.','2025-05-10 06:36:06.743000',_binary '','CUSTOMER','hiva'),(23,'$2a$10$A.k1vSILgr4HB/kMk8hbqeI0I2ft/0IVuthMXZwtX.cjGzTlKraSa','2025-05-10 08:12:30.995000',_binary '','CUSTOMER','wcds');
/*!40000 ALTER TABLE `captain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cart_id` bigint DEFAULT NULL,
  `item_id` bigint DEFAULT NULL,
  `item_name` varchar(255) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `restaurant_id` bigint DEFAULT NULL,
  `total_price` double DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1,1,NULL,NULL,NULL,NULL,202,NULL,101),(2,1,NULL,NULL,NULL,NULL,202,NULL,101),(3,2,NULL,NULL,NULL,NULL,210,NULL,201),(4,23,NULL,NULL,NULL,NULL,232,NULL,34);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant_dishes`
--

DROP TABLE IF EXISTS `restaurant_dishes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant_dishes` (
  `restaurant_id` bigint NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `dish_name` varchar(255) DEFAULT NULL,
  `price` int DEFAULT NULL,
  KEY `FKklfiyixo5xysep8t6itnlr9py` (`restaurant_id`),
  CONSTRAINT `FKklfiyixo5xysep8t6itnlr9py` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant_dishes`
--

LOCK TABLES `restaurant_dishes` WRITE;
/*!40000 ALTER TABLE `restaurant_dishes` DISABLE KEYS */;
INSERT INTO `restaurant_dishes` VALUES (1,'Creamy Alfredo pasta with herbs','Pasta',250),(2,'Cheese burst pizza with toppings','Pizza',300),(3,'Veg burger with fries','Burger',150);
/*!40000 ALTER TABLE `restaurant_dishes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurants`
--

DROP TABLE IF EXISTS `restaurants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurants` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cuisine` varchar(255) DEFAULT NULL,
  `is_open` bit(1) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `rating` decimal(38,2) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `zipcode` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `dish_name` varchar(255) DEFAULT NULL,
  `price` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurants`
--

LOCK TABLES `restaurants` WRITE;
/*!40000 ALTER TABLE `restaurants` DISABLE KEYS */;
INSERT INTO `restaurants` VALUES (1,'Italian',_binary '','The Great Restaurant','123-456-7890',4.50,'Springfield','IL','123 Main St','62701','Creamy Alfredo pasta with herbs','Pasta',250),(2,'Indian',_binary '\0','Spicy Bistro','987-654-3210',4.20,'Metropolis','NY','456 Oak Ave','10001','Cheese burst pizza with toppings','Pizza',300),(3,'Japanese',_binary '','Sushi World','555-123-4567',4.80,'Gotham','NJ','789 Elm Rd','07001','Veg burger with fries','Burger',150);
/*!40000 ALTER TABLE `restaurants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `roles` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'ADMIN'),(2,'CUSTOMER'),(3,'GUEST');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-01 14:54:06
