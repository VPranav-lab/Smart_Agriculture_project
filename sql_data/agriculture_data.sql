-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: smart_agriculture
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `farms`
--

DROP TABLE IF EXISTS `farms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `farms` (
  `farm_id` varchar(50) NOT NULL,
  `farm_name` varchar(100) NOT NULL,
  `owner_name` varchar(100) DEFAULT NULL,
  `contact_email` varchar(100) DEFAULT NULL,
  `contact_phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`farm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `farms`
--

LOCK TABLES `farms` WRITE;
/*!40000 ALTER TABLE `farms` DISABLE KEYS */;
INSERT INTO `farms` VALUES ('FARM_01','Green Valley','Martina Rinaldi','martina@gmail.com','3516582459'),('FARM_02','Sunny Acres','Davide Moretti','davide@gmail.com','3684596257'),('FARM_03','Harvest Moon','Andrea Lombardi','andrea@gmail.com','3542689875'),('FARM_04','Prairie Fields','Gabriele Lombardi','gabriele@gmail.com','6546852168'),('FARM_05','Orchard Grove','Sofia Conti','sofia@gmail.com','3514689572');
/*!40000 ALTER TABLE `farms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `readings`
--

DROP TABLE IF EXISTS `readings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `readings` (
  `reading_id` int NOT NULL AUTO_INCREMENT,
  `sensor_id` varchar(50) DEFAULT NULL,
  `value` float DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`reading_id`),
  KEY `sensor_id` (`sensor_id`),
  CONSTRAINT `readings_ibfk_1` FOREIGN KEY (`sensor_id`) REFERENCES `sensors` (`sensor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1148 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Table structure for table `sensors`
--

DROP TABLE IF EXISTS `sensors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sensors` (
  `sensor_id` varchar(50) NOT NULL,
  `sensor_type` varchar(50) DEFAULT NULL,
  `zone_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`sensor_id`),
  KEY `zone_id` (`zone_id`),
  CONSTRAINT `sensors_ibfk_1` FOREIGN KEY (`zone_id`) REFERENCES `zones` (`zone_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sensors`
--

LOCK TABLES `sensors` WRITE;
/*!40000 ALTER TABLE `sensors` DISABLE KEYS */;
INSERT INTO `sensors` VALUES ('SENSOR_001','Temperature','ZONE_01'),('SENSOR_002','Moisture','ZONE_01'),('SENSOR_003','Soil_pH','ZONE_01'),('SENSOR_004','Temperature','ZONE_02'),('SENSOR_005','Moisture','ZONE_02'),('SENSOR_006','Soil_pH','ZONE_02'),('SENSOR_007','Temperature','ZONE_03'),('SENSOR_008','Moisture','ZONE_03'),('SENSOR_009','Soil_pH','ZONE_03'),('SENSOR_010','Temperature','ZONE_04'),('SENSOR_011','Moisture','ZONE_04'),('SENSOR_012','Soil_pH','ZONE_04'),('SENSOR_013','Temperature','ZONE_05'),('SENSOR_014','Moisture','ZONE_05'),('SENSOR_015','Soil_pH','ZONE_05'),('SENSOR_016','Temperature','ZONE_06'),('SENSOR_017','Moisture','ZONE_06'),('SENSOR_018','Soil_pH','ZONE_06'),('SENSOR_019','Temperature','ZONE_07'),('SENSOR_020','Moisture','ZONE_07'),('SENSOR_021','Soil_pH','ZONE_07'),('SENSOR_022','Temperature','ZONE_08'),('SENSOR_023','Moisture','ZONE_08'),('SENSOR_024','Soil_pH','ZONE_08'),('SENSOR_025','Temperature','ZONE_09'),('SENSOR_026','Moisture','ZONE_09'),('SENSOR_027','Soil_pH','ZONE_09'),('SENSOR_028','Temperature','ZONE_10'),('SENSOR_029','Moisture','ZONE_10'),('SENSOR_030','Soil_pH','ZONE_10'),('SENSOR_031','Temperature','ZONE_11'),('SENSOR_032','Moisture','ZONE_11'),('SENSOR_033','Soil_pH','ZONE_11'),('SENSOR_034','Temperature','ZONE_12'),('SENSOR_035','Moisture','ZONE_12'),('SENSOR_036','Soil_pH','ZONE_12'),('SENSOR_037','Temperature','ZONE_13'),('SENSOR_038','Moisture','ZONE_13'),('SENSOR_039','Soil_pH','ZONE_13'),('SENSOR_040','Temperature','ZONE_14'),('SENSOR_041','Moisture','ZONE_14'),('SENSOR_042','Soil_pH','ZONE_14'),('SENSOR_043','Temperature','ZONE_15'),('SENSOR_044','Moisture','ZONE_15'),('SENSOR_045','Soil_pH','ZONE_15'),('SENSOR_046','Temperature','ZONE_16'),('SENSOR_047','Moisture','ZONE_16'),('SENSOR_048','Soil_pH','ZONE_16'),('SENSOR_049','Temperature','ZONE_17'),('SENSOR_050','Moisture','ZONE_17'),('SENSOR_051','Soil_pH','ZONE_17'),('SENSOR_052','Temperature','ZONE_18'),('SENSOR_053','Moisture','ZONE_18'),('SENSOR_054','Soil_pH','ZONE_18'),('SENSOR_055','Temperature','ZONE_19'),('SENSOR_056','Moisture','ZONE_19'),('SENSOR_057','Soil_pH','ZONE_19'),('SENSOR_058','Temperature','ZONE_20'),('SENSOR_059','Moisture','ZONE_20'),('SENSOR_060','Soil_pH','ZONE_20');
/*!40000 ALTER TABLE `sensors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zones`
--

DROP TABLE IF EXISTS `zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zones` (
  `zone_id` varchar(50) NOT NULL,
  `crop_name` varchar(100) DEFAULT NULL,
  `farm_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`zone_id`),
  KEY `farm_id` (`farm_id`),
  CONSTRAINT `zones_ibfk_1` FOREIGN KEY (`farm_id`) REFERENCES `farms` (`farm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zones`
--

LOCK TABLES `zones` WRITE;
/*!40000 ALTER TABLE `zones` DISABLE KEYS */;
INSERT INTO `zones` VALUES ('ZONE_01','Wheat','FARM_01'),('ZONE_02','Corn','FARM_01'),('ZONE_03','Soybeans','FARM_01'),('ZONE_04','Barley','FARM_01'),('ZONE_05','Corn','FARM_02'),('ZONE_06','Tomatoes','FARM_02'),('ZONE_07','Lettuce','FARM_02'),('ZONE_08','Cucumbers','FARM_02'),('ZONE_09','Rice','FARM_03'),('ZONE_10','Potatoes','FARM_03'),('ZONE_11','Carrots','FARM_03'),('ZONE_12','Onions','FARM_03'),('ZONE_13','Apples','FARM_04'),('ZONE_14','Peaches','FARM_04'),('ZONE_15','Pears','FARM_04'),('ZONE_16','Plums','FARM_04'),('ZONE_17','Grapes','FARM_05'),('ZONE_18','Blueberries','FARM_05'),('ZONE_19','Strawberries','FARM_05'),('ZONE_20','Blackberries','FARM_05');
/*!40000 ALTER TABLE `zones` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-28 17:39:22
