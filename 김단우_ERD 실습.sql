-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: db0309
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `견적서`
--

DROP TABLE IF EXISTS `견적서`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `견적서` (
  `견적번호` varchar(45) NOT NULL,
  `견적일` date DEFAULT NULL,
  `접수자` varchar(10) DEFAULT NULL,
  `담당` varchar(10) DEFAULT NULL,
  `공급가액` int DEFAULT NULL,
  `비고` varchar(45) DEFAULT NULL,
  `공급자` varchar(15) NOT NULL,
  PRIMARY KEY (`견적번호`),
  KEY `공급자` (`공급자`),
  CONSTRAINT `견적서_ibfk_1` FOREIGN KEY (`공급자`) REFERENCES `공급자` (`등록번호`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `견적서`
--

LOCK TABLES `견적서` WRITE;
/*!40000 ALTER TABLE `견적서` DISABLE KEYS */;
INSERT INTO `견적서` VALUES ('3','2023-03-13','김접수','김담당',5000,'','123-456-789');
/*!40000 ALTER TABLE `견적서` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `견적세부내용`
--

DROP TABLE IF EXISTS `견적세부내용`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `견적세부내용` (
  `일련번호` int NOT NULL AUTO_INCREMENT,
  `수량` int DEFAULT NULL,
  `합계` int DEFAULT NULL,
  `제품` varchar(45) DEFAULT NULL,
  `견적번호` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`일련번호`),
  KEY `제품` (`제품`),
  KEY `견적번호` (`견적번호`),
  CONSTRAINT `견적세부내용_ibfk_1` FOREIGN KEY (`제품`) REFERENCES `제품` (`제품번호`),
  CONSTRAINT `견적세부내용_ibfk_2` FOREIGN KEY (`견적번호`) REFERENCES `견적서` (`견적번호`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `견적세부내용`
--

LOCK TABLES `견적세부내용` WRITE;
/*!40000 ALTER TABLE `견적세부내용` DISABLE KEYS */;
INSERT INTO `견적세부내용` VALUES (2,5,20000,'1','3');
/*!40000 ALTER TABLE `견적세부내용` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `공급자`
--

DROP TABLE IF EXISTS `공급자`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `공급자` (
  `등록번호` varchar(15) NOT NULL,
  `상호` varchar(45) NOT NULL,
  `대표성명` varchar(45) DEFAULT NULL,
  `사업장주소` varchar(45) DEFAULT NULL,
  `업태` varchar(45) DEFAULT NULL,
  `종목` varchar(45) DEFAULT NULL,
  `전화번호` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`등록번호`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `공급자`
--

LOCK TABLES `공급자` WRITE;
/*!40000 ALTER TABLE `공급자` DISABLE KEYS */;
INSERT INTO `공급자` VALUES ('123-456-789','부산가구','김가구','부산시 금정구','제조업','가구제조','051-111-1111');
/*!40000 ALTER TABLE `공급자` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `제품`
--

DROP TABLE IF EXISTS `제품`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `제품` (
  `제품번호` varchar(45) NOT NULL,
  `품명` varchar(45) NOT NULL,
  `규격` varchar(45) DEFAULT NULL,
  `단가` int DEFAULT NULL,
  PRIMARY KEY (`제품번호`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `제품`
--

LOCK TABLES `제품` WRITE;
/*!40000 ALTER TABLE `제품` DISABLE KEYS */;
INSERT INTO `제품` VALUES ('1','스툴','1a2a3a',4000);
/*!40000 ALTER TABLE `제품` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'db0309'
--

--
-- Dumping routines for database 'db0309'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-13 12:20:54
