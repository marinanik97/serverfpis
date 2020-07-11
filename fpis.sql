/*
SQLyog Community v13.1.5  (64 bit)
MySQL - 10.4.8-MariaDB : Database - fpis
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`fpis` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `fpis`;

/*Table structure for table `doktor` */

DROP TABLE IF EXISTS `doktor`;

CREATE TABLE `doktor` (
  `doktorid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ime` varchar(255) DEFAULT NULL,
  `prezime` varchar(255) DEFAULT NULL,
  `JMBG` varchar(255) DEFAULT NULL,
  `specijalnost` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`doktorid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

/*Data for the table `doktor` */

insert  into `doktor`(`doktorid`,`ime`,`prezime`,`JMBG`,`specijalnost`) values 
(1,'Jovana','Radojevic','0208976715189','plasticni hirurg'),
(2,'Marija','Milosevic','1510985673192','neuropsihijatar'),
(3,'Milica','Zivanovic','1701969532238','kardiolog'),
(4,'Milos','Mirkovic','12049956897341','opsta praksa');

/*Table structure for table `izvestaj` */

DROP TABLE IF EXISTS `izvestaj`;

CREATE TABLE `izvestaj` (
  `kartonid` int(10) unsigned NOT NULL,
  `izvestajid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `datumstampanja` varchar(255) DEFAULT NULL,
  `napomena` varchar(255) DEFAULT NULL,
  `doktorid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`kartonid`,`izvestajid`),
  KEY `izvestajid` (`izvestajid`),
  KEY `fk_doktor` (`doktorid`),
  CONSTRAINT `fk_doktor` FOREIGN KEY (`doktorid`) REFERENCES `doktor` (`doktorid`) ON DELETE CASCADE,
  CONSTRAINT `fk_karton` FOREIGN KEY (`kartonid`) REFERENCES `karton` (`kartonid`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;

/*Data for the table `izvestaj` */

insert  into `izvestaj`(`kartonid`,`izvestajid`,`datumstampanja`,`napomena`,`doktorid`) values 
(3,20,'4/6/2020','Dobri su rezultati',4);

/*Table structure for table `karton` */

DROP TABLE IF EXISTS `karton`;

CREATE TABLE `karton` (
  `kartonid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ime` varchar(255) DEFAULT NULL,
  `prezime` varchar(255) DEFAULT NULL,
  `JMBG` varchar(255) DEFAULT NULL,
  `pol` varchar(255) DEFAULT NULL,
  `datumRodjenja` date DEFAULT NULL,
  `telefon` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`kartonid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `karton` */

insert  into `karton`(`kartonid`,`ime`,`prezime`,`JMBG`,`pol`,`datumRodjenja`,`telefon`,`email`) values 
(1,'Ivona','Nikolic','0607978321456','zenski','1978-07-06','066321451','ivona@gmail.com'),
(2,'Igor','Igic','2108982341651','muski','1982-09-21','061781329','igor@gmail.com'),
(3,'Maja','Zigic','2202995612345','zenski','1995-02-22','064379141','maja@gmail.com');

/*Table structure for table `kolicina` */

DROP TABLE IF EXISTS `kolicina`;

CREATE TABLE `kolicina` (
  `kolicinaid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `broj` double DEFAULT NULL,
  `jedinicamere` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`kolicinaid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `kolicina` */

/*Table structure for table `korisnik` */

DROP TABLE IF EXISTS `korisnik`;

CREATE TABLE `korisnik` (
  `korisnikid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`korisnikid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `korisnik` */

insert  into `korisnik`(`korisnikid`,`email`,`password`) values 
(1,'marina@gmail.com','marince123'),
(2,'nikola@gmail.com','nikolce123'),
(3,'miki@gmail.com','miki123');

/*Table structure for table `parametar` */

DROP TABLE IF EXISTS `parametar`;

CREATE TABLE `parametar` (
  `parametarid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `naziv` varchar(255) DEFAULT NULL,
  `referentnevrednosti` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`parametarid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

/*Data for the table `parametar` */

insert  into `parametar`(`parametarid`,`naziv`,`referentnevrednosti`) values 
(1,'leukociti','3.9 – 10 x 109/l'),
(3,'eritrociti zene','3.80 – 5.00 x 1012/l za žene'),
(4,'eritrociti muskarci','4.30 – 5.70 x 1012/l za muškarce'),
(5,'trombociti','140 – 450 x 109/l'),
(6,'hemoglobin','110 – 180 g/l');

/*Table structure for table `rezultat` */

DROP TABLE IF EXISTS `rezultat`;

CREATE TABLE `rezultat` (
  `rezultatid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `posiljalac` varchar(255) DEFAULT NULL,
  `datumupisa` varchar(255) DEFAULT NULL,
  `uzorakid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`rezultatid`),
  KEY `fk_uzorak` (`uzorakid`),
  CONSTRAINT `fk_uzorak` FOREIGN KEY (`uzorakid`) REFERENCES `uzorak` (`uzorakid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

/*Data for the table `rezultat` */

insert  into `rezultat`(`rezultatid`,`posiljalac`,`datumupisa`,`uzorakid`) values 
(7,'BelMedic','6/6/2020',2),
(9,'AquaLab Banovo','29/6/2020',1);

/*Table structure for table `stavkaizvestaja` */

DROP TABLE IF EXISTS `stavkaizvestaja`;

CREATE TABLE `stavkaizvestaja` (
  `kartonid` int(10) unsigned NOT NULL,
  `izvestajid` int(10) unsigned NOT NULL,
  `rb` int(10) unsigned NOT NULL,
  `indikator` varchar(255) DEFAULT NULL,
  `rezultatparametra` double DEFAULT NULL,
  `parametarid` int(10) unsigned NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`kartonid`,`izvestajid`,`rb`),
  KEY `rb` (`rb`),
  KEY `fk_parametar` (`parametarid`),
  CONSTRAINT `fk_novo` FOREIGN KEY (`kartonid`, `izvestajid`) REFERENCES `izvestaj` (`kartonid`, `izvestajid`) ON DELETE CASCADE,
  CONSTRAINT `fk_parametar` FOREIGN KEY (`parametarid`) REFERENCES `parametar` (`parametarid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `stavkaizvestaja` */

insert  into `stavkaizvestaja`(`kartonid`,`izvestajid`,`rb`,`indikator`,`rezultatparametra`,`parametarid`,`status`) values 
(3,20,1,'H',210,3,'dodavanje'),
(3,20,2,'H',110,3,'dodavanje');

/*Table structure for table `tipuzorka` */

DROP TABLE IF EXISTS `tipuzorka`;

CREATE TABLE `tipuzorka` (
  `tipuzorkaid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `naziv` varchar(255) DEFAULT NULL,
  `opis` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`tipuzorkaid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

/*Data for the table `tipuzorka` */

insert  into `tipuzorka`(`tipuzorkaid`,`naziv`,`opis`) values 
(1,'urin','urinokultura'),
(2,'krv','za izradu krvne slike');

/*Table structure for table `uzorak` */

DROP TABLE IF EXISTS `uzorak`;

CREATE TABLE `uzorak` (
  `uzorakid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `potrebnirezultati` varchar(255) DEFAULT NULL,
  `kartonid` int(10) unsigned NOT NULL,
  `tipuzorkaid` int(10) unsigned NOT NULL,
  `doktorid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`uzorakid`),
  KEY `fk_karton1` (`kartonid`),
  KEY `fk_tipuzorka1` (`tipuzorkaid`),
  KEY `fk_doktor1` (`doktorid`),
  CONSTRAINT `fk_doktor1` FOREIGN KEY (`doktorid`) REFERENCES `doktor` (`doktorid`),
  CONSTRAINT `fk_karton1` FOREIGN KEY (`kartonid`) REFERENCES `karton` (`kartonid`),
  CONSTRAINT `fk_tipuzorka1` FOREIGN KEY (`tipuzorkaid`) REFERENCES `tipuzorka` (`tipuzorkaid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

/*Data for the table `uzorak` */

insert  into `uzorak`(`uzorakid`,`potrebnirezultati`,`kartonid`,`tipuzorkaid`,`doktorid`) values 
(1,'Krvna slika',2,2,3),
(2,'Urin',3,1,2);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
