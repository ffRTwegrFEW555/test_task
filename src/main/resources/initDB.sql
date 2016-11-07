CREATE DATABASE  IF NOT EXISTS `test` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `test`;
-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: test
-- ------------------------------------------------------
-- Server version	5.7.16-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS User;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
  id int(8) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  age int NOT NULL,
  isAdmin bit NOT NULL,
  createdDate timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY id_UNIQUE (id)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

INSERT INTO User VALUES (1,'Евстратов Иван Валерьевич',25,'','2016-05-26 18:19:33');
INSERT INTO User VALUES (2,'Ковалева Галина Федоровна',33,'\0','2016-05-27 18:19:33');
INSERT INTO User VALUES (3,'Волкова Анна Юрьевна',34,'\0','2016-05-28 18:19:33');
INSERT INTO User VALUES (4,'Лепешева Ирина Алексеевна',32,'\0','2016-06-05 18:19:33');
INSERT INTO User VALUES (5,'Санукова Алина Сергеевна',43,'\0','2016-06-08 18:19:33');
INSERT INTO User VALUES (6,'Хуобонен Марина Энсиовна',45,'\0','2016-06-10 18:19:33');
INSERT INTO User VALUES (7,'Малинов Геннадий Иванович',32,'\0','2016-06-17 18:19:33');
INSERT INTO User VALUES (8,'Пешкова Ирина Валерьевна',48,'\0','2016-06-25 18:19:33');
INSERT INTO User VALUES (9,'Волгина Нина Викторовна',50,'\0','2016-06-27 18:19:33');
INSERT INTO User VALUES (10,'Евсина Ольга Валерьевна',31,'\0','2016-06-29 18:19:33');
INSERT INTO User VALUES (11,'Кириллова Галина Петровна',32,'\0','2016-06-30 18:19:33');
INSERT INTO User VALUES (12,'Ковалева Рита Евгеньевна',31,'\0','2016-07-02 18:19:33');
INSERT INTO User VALUES (13,'Кравцов Андрей Сергеевич',33,'\0','2016-07-04 18:19:33');
INSERT INTO User VALUES (14,'Круглова Галина Егоровна',43,'\0','2016-07-06 18:19:33');
INSERT INTO User VALUES (15,'Медведева Вера Николаевна',44,'\0','2016-07-07 18:19:33');
INSERT INTO User VALUES (16,'Мезгин Роман Викторович',43,'\0','2016-07-11 18:19:33');
INSERT INTO User VALUES (17,'Науменков Юрий Юрьевич',32,'','2016-07-12 18:19:33');
INSERT INTO User VALUES (18,'Пилипак Наталья Ивановна',34,'\0','2016-07-14 18:19:33');
INSERT INTO User VALUES (19,'Цунский Юрий Анатольевич',41,'\0','2016-07-21 18:19:33');
INSERT INTO User VALUES (20,'Шмарова Елена Николаевна',43,'\0','2016-07-23 18:19:33');
INSERT INTO User VALUES (21,'Эстрин Юрий Зальманович',32,'\0','2016-07-26 18:19:33');
INSERT INTO User VALUES (22,'Чиненова Ирина Евгеньевна',34,'\0','2016-07-28 18:19:33');
INSERT INTO User VALUES (23,'Антонова Регина Фоминична',26,'\0','2016-08-08 18:19:33');
INSERT INTO User VALUES (24,'Вага Татьяна Владимировна',28,'\0','2016-08-10 18:19:33');
INSERT INTO User VALUES (25,'Потахин Сергей Борисович',29,'\0','2016-08-11 18:19:33');
INSERT INTO User VALUES (26,'Куимова Ирина Сергеевна',32,'\0','2016-08-19 18:19:33');
INSERT INTO User VALUES (27,'Ильин Андрей Михайлович',33,'\0','2016-08-20 18:19:33');
INSERT INTO User VALUES (28,'Каменева Елена Евгеньевна',43,'\0','2016-08-21 18:19:33');
INSERT INTO User VALUES (29,'Нельсон Виктор Энокович',43,'\0','2016-08-22 18:19:33');
INSERT INTO User VALUES (30,'Сазонов Владимир Павлович',44,'\0','2016-08-23 18:19:33');
INSERT INTO User VALUES (31,'Коржук Андрей Анатольевич',37,'\0','2016-08-28 18:19:33');
INSERT INTO User VALUES (32,'Леташкова Нина Викторовна',38,'','2016-08-29 18:19:33');
INSERT INTO User VALUES (33,'Гадов Михаил Васильевич',39,'\0','2016-08-30 18:19:33');
INSERT INTO User VALUES (34,'Голубева Тамара Федоровна',43,'\0','2016-09-03 18:19:33');
INSERT INTO User VALUES (35,'Давудова Юлия Петровна',22,'\0','2016-09-06 18:19:33');
INSERT INTO User VALUES (36,'Добров Сергей Михайлович',29,'\0','2016-09-13 18:19:33');
INSERT INTO User VALUES (37,'Кураков Олег Валентинович',32,'\0','2016-09-16 18:19:33');
INSERT INTO User VALUES (38,'Николаева Нина Николаевна',36,'\0','2016-09-20 18:19:33');
INSERT INTO User VALUES (39,'Павков Леонид Борисович',42,'\0','2016-09-26 18:19:33');
INSERT INTO User VALUES (40,'Ригаев Леонид Николаевич',44,'\0','2016-09-28 18:19:33');
INSERT INTO User VALUES (41,'Титов Сергей Анатольевич',32,'\0','2016-07-26 18:19:33');
INSERT INTO User VALUES (42,'Цупко Игорь Владимирович',34,'\0','2016-07-28 18:19:33');
INSERT INTO User VALUES (43,'Шаталов Андрей Юрьевич',26,'\0','2016-08-08 18:19:33');
INSERT INTO User VALUES (44,'Лось Николай Антонович',28,'\0','2016-08-10 18:19:33');
INSERT INTO User VALUES (45,'Обухов Олег Эдуардович',29,'\0','2016-08-11 18:19:33');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed
