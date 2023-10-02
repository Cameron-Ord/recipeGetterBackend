-- MariaDB dump 10.19  Distrib 10.5.21-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: RecipeGenerator
-- ------------------------------------------------------
-- Server version	10.5.21-MariaDB

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
-- Table structure for table `Admin`
--

DROP TABLE IF EXISTS `Admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Admin_UN` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Admin`
--

LOCK TABLES `Admin` WRITE;
/*!40000 ALTER TABLE `Admin` DISABLE KEYS */;
INSERT INTO `Admin` VALUES (1,'Cameron','$2b$12$V/FBpWGlcAGRRrHXnbjI/eOMIq7elGCogT/gzQ57IicUz9f3VL/3S','2023-10-02 15:55:14');
/*!40000 ALTER TABLE `Admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AdminKeys`
--

DROP TABLE IF EXISTS `AdminKeys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AdminKeys` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` int(10) unsigned DEFAULT NULL,
  `apiKey` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `AdminKeys_FK` (`admin_id`),
  CONSTRAINT `AdminKeys_FK` FOREIGN KEY (`admin_id`) REFERENCES `Admin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AdminKeys`
--

LOCK TABLES `AdminKeys` WRITE;
/*!40000 ALTER TABLE `AdminKeys` DISABLE KEYS */;
/*!40000 ALTER TABLE `AdminKeys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AdminSession`
--

DROP TABLE IF EXISTS `AdminSession`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AdminSession` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` int(10) unsigned DEFAULT NULL,
  `session_token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AdminSession`
--

LOCK TABLES `AdminSession` WRITE;
/*!40000 ALTER TABLE `AdminSession` DISABLE KEYS */;
INSERT INTO `AdminSession` VALUES (4,1,'8bda1a609fe84f50b2eb3b036f4bf199');
/*!40000 ALTER TABLE `AdminSession` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Client`
--

DROP TABLE IF EXISTS `Client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Client` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Client_UN` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Client`
--

LOCK TABLES `Client` WRITE;
/*!40000 ALTER TABLE `Client` DISABLE KEYS */;
INSERT INTO `Client` VALUES (2,'cameron','2023-10-02','$2b$12$537QYCyclxB5LcsxI1PpUum2jbpf6lGJ9/1Y62bZU9I37edwZJlIK','email');
/*!40000 ALTER TABLE `Client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ClientSession`
--

DROP TABLE IF EXISTS `ClientSession`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ClientSession` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(10) unsigned DEFAULT NULL,
  `session_token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ClientSession_FK` (`client_id`),
  CONSTRAINT `ClientSession_FK` FOREIGN KEY (`client_id`) REFERENCES `Client` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ClientSession`
--

LOCK TABLES `ClientSession` WRITE;
/*!40000 ALTER TABLE `ClientSession` DISABLE KEYS */;
INSERT INTO `ClientSession` VALUES (2,2,'683051cc6a814671afd2648f7e91714d');
/*!40000 ALTER TABLE `ClientSession` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NutritionalProfiles`
--

DROP TABLE IF EXISTS `NutritionalProfiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NutritionalProfiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `recipe_id` int(10) unsigned DEFAULT NULL,
  `protein` float DEFAULT NULL,
  `fat` float DEFAULT NULL,
  `carbohydrates` float DEFAULT NULL,
  `calories` float DEFAULT NULL,
  `saturatedfats` float DEFAULT NULL,
  `sugars` float DEFAULT NULL,
  `salt` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `NutritionalProfiles_FK` (`recipe_id`),
  CONSTRAINT `NutritionalProfiles_FK` FOREIGN KEY (`recipe_id`) REFERENCES `Recipes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NutritionalProfiles`
--

LOCK TABLES `NutritionalProfiles` WRITE;
/*!40000 ALTER TABLE `NutritionalProfiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `NutritionalProfiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RecipeInstructions`
--

DROP TABLE IF EXISTS `RecipeInstructions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RecipeInstructions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `recipe_id` int(10) unsigned DEFAULT NULL,
  `prepInstructions` varchar(500) DEFAULT NULL,
  `cookingInstructions` varchar(500) DEFAULT NULL,
  `cookingMethods` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `RecipeInstructions_UN` (`recipe_id`),
  CONSTRAINT `RecipeInstructions_FK` FOREIGN KEY (`recipe_id`) REFERENCES `Recipes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RecipeInstructions`
--

LOCK TABLES `RecipeInstructions` WRITE;
/*!40000 ALTER TABLE `RecipeInstructions` DISABLE KEYS */;
/*!40000 ALTER TABLE `RecipeInstructions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Recipes`
--

DROP TABLE IF EXISTS `Recipes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Recipes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `desc` varchar(255) DEFAULT NULL,
  `image_url` varchar(500) DEFAULT NULL,
  `ingredients` varchar(500) DEFAULT NULL,
  `isHealthy` tinyint(1) DEFAULT NULL,
  `cuisine` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Recipes_UN` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Recipes`
--

LOCK TABLES `Recipes` WRITE;
/*!40000 ALTER TABLE `Recipes` DISABLE KEYS */;
INSERT INTO `Recipes` VALUES (16,'kung pao chicken','desc','http://127.0.0.1:5000/images/58665116331d4d05b37a135f5fdcb125.jpg','ingredients',0,'chinese');
/*!40000 ALTER TABLE `Recipes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserKeys`
--

DROP TABLE IF EXISTS `UserKeys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserKeys` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `apiKey` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Keys_FK` (`user_id`),
  CONSTRAINT `Keys_FK` FOREIGN KEY (`user_id`) REFERENCES `Client` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserKeys`
--

LOCK TABLES `UserKeys` WRITE;
/*!40000 ALTER TABLE `UserKeys` DISABLE KEYS */;
INSERT INTO `UserKeys` VALUES (2,2,'b747b57a13694dfab142787a71ff6543');
/*!40000 ALTER TABLE `UserKeys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'RecipeGenerator'
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `adminLogin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`Cameron`@`localhost` PROCEDURE `adminLogin`(usernameInput varchar(100), passwordInput varchar(100), tokenInput varchar(255))
    MODIFIES SQL DATA
BEGIN
    declare adminId int unsigned;
    set adminId = (select id from Admin where username=usernameInput);
    if adminId is not null and passwordInput is not null then
      delete from AdminSession where admin_id = adminId;
	  insert into AdminSession (admin_id,session_token) values (adminId,tokenInput);
	  select admin_id, convert(session_token using "utf8") as session_token from AdminSession where admin_id = adminId and session_token = tokenInput;
	commit;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `clientLogin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`Cameron`@`localhost` PROCEDURE `clientLogin`(usernameInput varchar(100), passwordInput varchar(100), tokenInput varchar(255))
    MODIFIES SQL DATA
BEGIN
    declare clientId int unsigned;
    set clientId = (select id from Client where username=usernameInput);
    if clientId is not null and passwordInput is not null then
      delete from ClientSession where client_id = clientId;
	  insert into ClientSession (client_id,session_token) values (clientId,tokenInput);
	  select client_id, convert(session_token using "utf8") as session_token from ClientSession where client_id = clientId and session_token = tokenInput;
	commit;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `clientSignup` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`Cameron`@`localhost` PROCEDURE `clientSignup`(usernameInput varchar(100), passwordInput varchar(100), emailInput varchar(255))
    MODIFIES SQL DATA
BEGIN
	if usernameInput is not null and passwordInput is not null and emailInput is not null then
	 insert into Client(username, created_at, password, email) values (usernameInput, now() ,passwordInput, emailInput);
	 select LAST_INSERT_ID();  
	end if;
   commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createAdmin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`Cameron`@`localhost` PROCEDURE `createAdmin`(usernameInput varchar(100), passwordInput varchar(100))
    MODIFIES SQL DATA
BEGIN
	if usernameInput is not null and passwordInput is not null then
	 insert into Admin(username, password, created_at) values (usernameInput,passwordInput,now());
	 select LAST_INSERT_ID();  
	end if;
   commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createInstructions` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`Cameron`@`localhost` PROCEDURE `createInstructions`(idInput int unsigned, prepInput varchar(500), cookInput varchar(500), methodsInput varchar(500))
    MODIFIES SQL DATA
BEGIN
	insert into RecipeInstructions(recipe_id, prepInstructions, cookingInstructions, cookingMethods)
	values(idInput, prepInput, cookInput, methodsInput);
    select LAST_INSERT_ID(); 
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createNutritionalProfile` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`Cameron`@`localhost` PROCEDURE `createNutritionalProfile`(recipeIdInput int unsigned, proteinInput float, fatInput float, carbInput float, calInput float, satfatInput float, sugarInput float, saltInput int)
    MODIFIES SQL DATA
BEGIN
	insert into NutrionalProfiles
	(recipe_id, protein, fat, carbohydrates, calories, saturatedfats, sugars, salt)
	values 
	(recipeIdInput, proteinInput,fatInput,carbInput,calInput,satfatInput,sugarInput,saltInput);
SELECT LAST_INSERT_ID(); 
commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createRecipe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`Cameron`@`localhost` PROCEDURE `createRecipe`(titleInput varchar(255), descInput varchar(255), imageInput varchar(250), ingredientInput varchar(500), isHealthyInput BOOL, cuisineInput varchar(255), tokenInput varchar(500), idInput int unsigned)
    MODIFIES SQL DATA
BEGIN
	if tokenInput = (select session_token from AdminSession where admin_id = idInput) then
    INSERT INTO Recipes (title, `desc`, image_url, ingredients, isHealthy, cuisine) 
    VALUES (titleInput, descInput, imageInput, ingredientInput, isHealthyInput, cuisineInput);
    SELECT LAST_INSERT_ID();  
    COMMIT;
   end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `generateKey` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`Cameron`@`localhost` PROCEDURE `generateKey`(clientIdInput int unsigned, generatedToken varchar(250), sessionTokenInput varchar(500))
    MODIFIES SQL DATA
BEGIN
	declare id int unsigned;
    declare token varchar(255);
    declare confirmedId int unsigned;
    set id = clientIdInput;
    set token = generatedToken;
   if id is not null then
    set confirmedId = (select id from Client where id = clientIdInput);
   else
    set confirmedId = null;
   end if;
   if confirmedId is not null and token is not null THEN 
     if (select session_token from ClientSession where client_id = confirmedId) = sessionTokenInput THEN
      delete from UserKeys where user_id = confirmedId;
      insert into UserKeys (user_id, apiKey) 
      values (confirmedId, token);
      select convert(apiKey using "utf8") as apiKey from UserKeys where user_id = confirmedId and apiKey = token;
     end if;
     commit;
   end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getAdminHashedPW` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`Cameron`@`localhost` PROCEDURE `getAdminHashedPW`(usernameInput varchar(100))
BEGIN
	select convert(password using "utf8") as password from Admin where username=usernameInput;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getHashedPW` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`Cameron`@`localhost` PROCEDURE `getHashedPW`(usernameInput varchar(255))
BEGIN
	select convert(password using "utf8") as password from Client where username=usernameInput;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getInstructions` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`Cameron`@`localhost` PROCEDURE `getInstructions`(idInput int unsigned)
BEGIN
	select 
	convert(prepInstructions using "utf8") as prepInstructions,
	convert(cookingInstructions using "utf8") as cookingInstructions,
	convert(cookingMethods using "utf8") as cookingMethods
	from RecipeInstructions 
	where recipe_id = idInput;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getNutrition` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`Cameron`@`localhost` PROCEDURE `getNutrition`(recipeIdInput int unsigned)
BEGIN
	select protein, fat, carbohydrates, calories, saturatedfats, sugars, salt
	from NutritionalProfiles where recipe_id = recipeIdInput;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getRecipeId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`Cameron`@`localhost` PROCEDURE `getRecipeId`(titleInput varchar(255))
BEGIN
	select id from Recipes where title=titleInput;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `searchByCuisine` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`Cameron`@`localhost` PROCEDURE `searchByCuisine`(searchInput varchar(255), keyInput varchar(500))
BEGIN
	declare confirmedKey BOOL;
	declare keyValue varchar(500);
    set keyValue = (select apiKey from UserKeys where apiKey = keyInput);
    
    if keyValue is not null then
    set confirmedKey = 1;
        if confirmedKey = 1 THEN
           	select id,
	        convert(title using "utf8") as title,
         	convert(`desc` using "utf8") as `desc`,
	        convert(image_url using "utf8") as image_url,
        	isHealthy,
	        convert(cuisine using "utf8") as cuisine 
	        from Recipes where cuisine = searchInput;
	    end if;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `searchRecipe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`Cameron`@`localhost` PROCEDURE `searchRecipe`(searchInput varchar(255))
BEGIN
	select id,
	convert(title using "utf8") as title,
	convert(`desc` using "utf8") as `desc`,
	convert(image_url using "utf8") as image_url,
	isHealthy,
	convert(cuisine using "utf8") as cuisine 
	from Recipes where title = searchInput;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-02 16:59:53
