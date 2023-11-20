-- MariaDB dump 10.19-11.1.2-MariaDB, for osx10.19 (arm64)
--
-- Host: 127.0.0.1    Database: Book_Loan_DB
-- ------------------------------------------------------
-- Server version	10.11.5-MariaDB-1:10.11.5+maria~ubu2204

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Book`
--

DROP TABLE IF EXISTS `Book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Book` (
  `Book_id` varchar(2) NOT NULL,
  `Title` varchar(255) NOT NULL,
  `Publisher_name` varchar(255) NOT NULL,
  PRIMARY KEY (`Book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Book`
--

LOCK TABLES `Book` WRITE;
/*!40000 ALTER TABLE `Book` DISABLE KEYS */;
INSERT INTO `Book` VALUES
('B1','The Lost Tribe','Picador'),
('B2','It','Simon & Schuster'),
('B3','Event Horizon','Tom Doherty Assoc Llc'),
('B4','The Age of AI','Back Bay Books'),
('B5','A World Restored','Simon & Schuster');
/*!40000 ALTER TABLE `Book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Book_Authors`
--

DROP TABLE IF EXISTS `Book_Authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Book_Authors` (
  `Book_id` varchar(2) NOT NULL,
  `Author_name` varchar(255) NOT NULL,
  PRIMARY KEY (`Book_id`,`Author_name`),
  CONSTRAINT `Book_Authors_ibfk_1` FOREIGN KEY (`Book_id`) REFERENCES `Book` (`Book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Book_Authors`
--

LOCK TABLES `Book_Authors` WRITE;
/*!40000 ALTER TABLE `Book_Authors` DISABLE KEYS */;
INSERT INTO `Book_Authors` VALUES
('B1','Mark Lee'),
('B2','Stephen King'),
('B3','Steven McDonald'),
('B4','Daniel Huttenlocher'),
('B4','Eric Schmidt '),
('B4','Henry A Kissinger'),
('B5','Henry A Kissinger');
/*!40000 ALTER TABLE `Book_Authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Book_Copies`
--

DROP TABLE IF EXISTS `Book_Copies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Book_Copies` (
  `Book_id` varchar(2) NOT NULL,
  `Branch_id` varchar(3) NOT NULL,
  `No_of_copies` int(11) NOT NULL,
  PRIMARY KEY (`Book_id`,`Branch_id`),
  CONSTRAINT `Book_Copies_ibfk_1` FOREIGN KEY (`Book_id`) REFERENCES `Book` (`Book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Book_Copies`
--

LOCK TABLES `Book_Copies` WRITE;
/*!40000 ALTER TABLE `Book_Copies` DISABLE KEYS */;
INSERT INTO `Book_Copies` VALUES
('B1','BR1',15),
('B1','BR2',25),
('B2','BR2',10),
('B3','BR3',2),
('B3','BR5',5),
('B4','BR3',7),
('B4','BR5',10),
('B5','BR4',5);
/*!40000 ALTER TABLE `Book_Copies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Book_Loans`
--

DROP TABLE IF EXISTS `Book_Loans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Book_Loans` (
  `Book_id` varchar(2) NOT NULL,
  `Branch_id` varchar(3) NOT NULL,
  `Card_no` varchar(2) NOT NULL,
  `Date_out` date NOT NULL,
  `Due_date` date NOT NULL,
  PRIMARY KEY (`Book_id`,`Branch_id`,`Card_no`),
  KEY `Branch_id` (`Branch_id`),
  KEY `Card_no` (`Card_no`),
  CONSTRAINT `Book_Loans_ibfk_1` FOREIGN KEY (`Book_id`) REFERENCES `Book` (`Book_id`),
  CONSTRAINT `Book_Loans_ibfk_2` FOREIGN KEY (`Branch_id`) REFERENCES `Library_Branch` (`Branch_id`),
  CONSTRAINT `Book_Loans_ibfk_3` FOREIGN KEY (`Card_no`) REFERENCES `Borrower` (`Card_no`),
  CONSTRAINT `chk_due_date` CHECK (`Due_date` >= `Date_out`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Book_Loans`
--

LOCK TABLES `Book_Loans` WRITE;
/*!40000 ALTER TABLE `Book_Loans` DISABLE KEYS */;
INSERT INTO `Book_Loans` VALUES
('B1','BR1','C1','2023-01-02','2023-02-02'),
('B2','BR1','C2','2022-12-06','2023-01-06'),
('B3','BR3','C2','2023-01-29','2023-02-28'),
('B3','BR3','C3','2023-01-20','2023-02-20'),
('B3','BR5','C4','2022-12-20','2023-01-20'),
('B4','BR5','C2','2022-12-20','2023-01-20'),
('B4','BR5','C4','2022-12-20','2023-01-20'),
('B5','BR4','C4','2022-12-20','2023-01-20');
/*!40000 ALTER TABLE `Book_Loans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Borrower`
--

DROP TABLE IF EXISTS `Borrower`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Borrower` (
  `Card_no` varchar(2) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Address` varchar(255) NOT NULL,
  `Phone` varchar(14) NOT NULL,
  PRIMARY KEY (`Card_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Borrower`
--

LOCK TABLES `Borrower` WRITE;
/*!40000 ALTER TABLE `Borrower` DISABLE KEYS */;
INSERT INTO `Borrower` VALUES
('C1','John Smith','731 Fondren, Houoston, TX','(206) 342-8631'),
('C2','Franklin Wong','638 Voss, Houston, TX','(717) 550-1675'),
('C3','Alicia Zelaya','3321 Castle, Spring, TX','(248) 762-0356'),
('C4','Ramesh Narayan','975 Fire Oak, Humble, TX','(832) 529-5371'),
('C5','James Borg','450 Stone, Houston, Tx','(281) 601-9395');
/*!40000 ALTER TABLE `Borrower` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Library_Branch`
--

DROP TABLE IF EXISTS `Library_Branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Library_Branch` (
  `Branch_id` varchar(3) NOT NULL,
  `Branch_name` varchar(255) NOT NULL,
  `Address` varchar(255) NOT NULL,
  PRIMARY KEY (`Branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Library_Branch`
--

LOCK TABLES `Library_Branch` WRITE;
/*!40000 ALTER TABLE `Library_Branch` DISABLE KEYS */;
INSERT INTO `Library_Branch` VALUES
('BR1','Sharpstown','9 Bow Ridge Street Sharpstown'),
('BR2','Beloit','3 West Rd. Beloit'),
('BR3','Drive Lake Charles','824 Rock Maple Drive Lake Charles'),
('BR4','Mansfield Center','120 Storrs Road'),
('BR5','Storrs','123 West Road');
/*!40000 ALTER TABLE `Library_Branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Publisher`
--

DROP TABLE IF EXISTS `Publisher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Publisher` (
  `Name` varchar(255) NOT NULL,
  `Address` varchar(255) NOT NULL,
  `Phone` varchar(14) NOT NULL,
  `City` varchar(255) NOT NULL,
  PRIMARY KEY (`Name`,`Address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Publisher`
--

LOCK TABLES `Publisher` WRITE;
/*!40000 ALTER TABLE `Publisher` DISABLE KEYS */;
INSERT INTO `Publisher` VALUES
('Back Bay Books','25 Main Street','','Boston'),
('Picador','300-76 Stafford St. ','(416) 934-9900','Toronto'),
('Simon & Schuster','4096 Emerson Road','(212) 540-1675','New York City'),
('Tom Doherty Assoc Llc','4321 Walnut Hill Drive','(212) 388-0100','New York City');
/*!40000 ALTER TABLE `Publisher` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-19 21:30:32
