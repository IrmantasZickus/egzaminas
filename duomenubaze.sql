-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: project
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

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
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_like` (`user_id`,`post_id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (85,8,23,'2024-12-12 08:39:18'),(86,8,27,'2024-12-12 08:39:20'),(87,8,31,'2024-12-12 08:39:24'),(88,8,28,'2024-12-12 08:39:27'),(89,4,23,'2024-12-12 09:04:24'),(90,4,24,'2024-12-12 09:04:27'),(91,4,22,'2024-12-12 09:04:29'),(92,4,28,'2024-12-12 09:04:31'),(93,6,22,'2024-12-12 09:04:50'),(94,6,23,'2024-12-12 09:04:57'),(95,9,23,'2024-12-12 09:09:19'),(96,10,33,'2024-12-12 09:22:58');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `category` varchar(100) NOT NULL,
  `likes` int(11) DEFAULT 0,
  `user_id` int(11) NOT NULL,
  `event_time` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `images` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (22,'Spektaklis šeimai „Kalėdų giesmė“.','Vilnius, Meno erdvės VILEIŠIO18.\nSpektaklis sukurtas pagal garsaus anglų rašytojo Charleso Dickenso to paties pavadinimo apysaką, kurioje pasakojama apie šykštuolį Ebenzerį Skrudžą, kuris nemato prasmės džiaugtis Kalėdomis, kol Kūčių vakarą jo neaplanko trys Dvasios. Šiandien ši apysaka pati yra tapusi Kalėdų tradicija, ji jaudina seną ir jauną, vargšą ir turtingą tiek pat, kiek ir 1843 m., kai pasirodė pirmą kartą. Tai viena iš geriausių visų laikų kalėdinių istorijų ir… pati pirmoji.','Spektakliai',2,4,'2024-12-12 12:00:00','2024-12-12 08:05:09','[\"/uploads/1733990709635_spektaklis-seimai-kaledu-giesme_jpg.png\"]'),(23,'Muzikinė komedija AMERIKA PIRTYJE - rež. Valentinas Masalskis','„Amerika pirtyje“ – tai pirmasis Lietuvoje viešai lietuvių kalba suvaidintas vienos dalies spektaklis pagal to paties pavadinimo Keturakio pjesę, kuris po beveik 125 metų pavirto šiuolaikine muzikine komedija ir yra pristatomas šių laikų žiūrovui!Komedijoje šmaikščiai pateikiamas lietuvių identiteto raida bei gili patriotiškumo dvasia, kurios ištakos neretai slepiasi pačioje tikriausiose provincijoje. Scenografijos autorė Renata Valčik spektaklyje meistriškai kuria tokios provincijos atmosferą – panaudotos automobilio padangos čia atstoja baldus, o išradingai išraitytos ir ryškiomis spalvomis nudažytos gulbės – tikrų tikriausias provincijos meninės beskonybės liudijimas.','Spektakliai',4,4,'2024-12-28 18:30:00','2024-12-12 08:06:17','[\"/uploads/1733990777598_muzikine-komedija-amerika-pirtyje-rez-valentinas-masalskis_jpg.png\"]'),(24,'Kalėdinė meno mugė 2024','Klaipėda, Galerija Lyceum. Kalėdiniame šurmulyje galerija LYCEUM kviečia atsikvėpti jaukioje meno oazėje šalia Danės upės, susipažinti su įvairių krypčių Lietuvos kūrėjais bei įsigyti autorinių menininkų darbų - nuo mažo formato paveikslų, skulptūrų, keramikos dirbinių iki valgomų skanėstų bei kalėdinių atvirlaiškių.','Parodos',1,5,'2024-12-13 16:00:00','2024-12-12 08:13:57','[\"/uploads/1733991237928_kaledine-meno-muge-2024_jpg.png\"]'),(25,'Nauja ekspozicija „Rūmų istorijos“','Kaunas, Istorinė Lietuvos Respublikos Prezidentūra. 2021 m. gruodžio 15 d. Istorinėje Prezidentūroje Kaune atidaryta nauja ekspozicija „Rūmų istorijos“, kuri kviečia pamatyti, išgirsti, paliesti ir net užuosti paskutinių dviejų šimtmečių istoriją. Ekspozicijoje lankytojų laukia daug naujų siužetų ir garsių istorinių asmenybių. Muziejaus lankytojams įprastą pasakojimą apie Pirmąją Lietuvos Respubliką (1918–1940 m.), Prezidento instituciją ir tarpukario prezidentus papildo istorijos apie imperatorius, gubernatorius, karo vadus, civilinių ir karinių administracijų viršininkus, partinius veikėjus, pionierius, mokytojus, verslius žmones ir net įžymią dailininkę.','Parodos',0,5,'2024-12-29 13:00:00','2024-12-12 08:15:27','[\"/uploads/1733991327119_nauja-ekspozicija-rumu-istorijos_jpg.png\"]'),(26,'Premjera! Naujas meškinų muziejus \'\'PLUSHY B 55\'\' Raganiukės teatre','Vilnius, Kalėdų senelio muziejus.  Pasinerkite į stebuklingą nuotykį – Raganiukės teatro Meškinų muziejus ”PLUSHY B 55” kviečia jus į nepaprastą kelionę! \n\nTai vienintelis toks meškiukų muziejus Lietuvoje, kur švelnūs ir žavingi meškiukai tampa jūsų nuotykių gidu. Kiekviena muziejaus erdvė pulsuoja magija, o čia laukia ne tik nuostabios ekspozicijos, bet ir nepamirštami įspūdžiai, kurie pavergs ir mažuosius, ir suaugusius lankytojus. Tai ne tik ekspozicija, tai gyvas stebuklų pasaulis, kur kiekvienas kampelis pasakoja unikalią istoriją. ','Vaikams',0,6,'2024-12-22 10:00:00','2024-12-12 08:17:02','[\"/uploads/1733991422531_premjera-naujas-meskinu-muziejus-plushy-b-55-raganiukes-teatre_jpg.png\"]'),(27,'Šventinis spektaklis vaikams \"Šunyčiai gelbėja Kalėdas\"','Klaipėdos koncertų salė. Niekam ne paslaptis, kad Kalėdos– pati laukiamausia metų šventė ne tik vaikučiams, bet ir šunyčiams.Su didžiausiu nekantrumu jie ruošiasi šventei, kai staiga supranta, kad Kalėdos gali neįvykti, nes Kalėdų Senelis... įniko į kompiuterinius žaidimus! Jis pamiršo visas savo pareigas, vaikučius ir pačią gražiausią šventę – Kalėdas, todėl vieną dieną jį pagrobia kompiuterinių žaidimų vampyrai... ','Vaikams',1,6,'2024-12-18 12:00:00','2024-12-12 08:20:06','[\"/uploads/1733991606364_sventinis-spektaklis-vaikams-sunyciai-gelbeja-kaledas_jpg.png\"]'),(28,'Naujųjų 2025 metų sutikimas su Igoriu Jarmolenka','Kaunas, Gulbės Galerija. Iškilmingas Naujųjų 2025 metų sutikimas. Jūsų laukia šventinė vakarienė,  gyva muzika, nuotaikinga ir užburianti programa.','Vakarėliai',2,6,'2024-12-31 21:00:00','2024-12-12 08:22:00','[\"/uploads/1733991720583_naujuju-2025-metu-sutikimas-su-igoriu-jarmolenka_jpg.png\"]'),(29,'Christmas party: pasiŠOKT?! PASLAPČIŲ KAMBARYS – naktinis klubas LA45!','Kaunas, Night Club LA45. Christmas party: pasiŠOKT?! PASLAPČIŲ KAMBARYS – naktinis klubas LA45!','Vakarėliai',0,6,'2024-12-13 20:00:00','2024-12-12 08:23:29','[\"/uploads/1733991809072_weekend-party-pasisokt-2-as-aukstas-naktinis-kokteiliu-klubas-la45_jpg.png\"]'),(30,'Kalėdiniai žaisliukai iš gipso','Kaunas, Ąžuolyno biblioteka, Radastų g. 2. Prisijunkite prie 2,5-3 valandos trunkančio kūrybinio užsiėmimo, kuriame sužinosite, kaip namų sąlygomis pasigaminti įvairiausius unikalius kalėdinius žaisliukus iš gipso.','Mokymai',0,6,'2024-12-12 13:30:00','2024-12-12 08:26:10','[\"/uploads/1733991970842_kalediniai-zaisliukai-is-gipso_jpg.png\"]'),(31,'KEEP SINGING 2024 – Jono Meko įkvėptas festivalis','Vilnius, Signatarų namai. 4-ąjį kartą sostinę virpins legendinio lietuvių kūrėjo Jono Meko įkvėptas festivalis „Keep Singing“. Per dvi dienas jūsų laukia Pagrindinė ir Naktinė programos, kuriose – net 11 intriguojančių muzikinių pasirodymų; taip pat Jono Meko trumpųjų filmų programa, audiovizualinė instaliacija „Monteverdi Comes Alive“, o vakarus užbaigsime su jam session!','Festivaliai',1,7,'2024-12-20 19:30:00','2024-12-12 08:28:41','[\"/uploads/1733992121349_keep-singing-2024-jono-meko-ikveptas-festivalis_jpg.png\"]'),(32,'Žiemos festivalis „Besmegenių vestuvės“','Pakruojis, Pakruojo dvaras. Pirmosios galaktikoje Besmegenių vestuvės Kalėdiniame dvare. Įstabi ir niekur kitur nematyta vestuvinė pasaka šviesos žibintų apsupty. Šis linksmybių kupinas spektaklis sujungs ne tik dvi sniego širdis, bet ir daugybę žmonių, norinčių švęsti ŽIEMOS GROŽĮ ir KALĖDŲ STEBUKLĄ. Tai spektaklis, kuris sužadins šypsenas visiems! Jūs būsite įtraukti į nuotaikingą vestuvinės puotos šurmulį ir tapsite šios šventės liudininkais.','Festivaliai',0,7,'2024-12-21 17:00:00','2024-12-12 08:30:20','[\"/uploads/1733992220063_ziemos-festivalis-besmegeniu-vestuves_jpg.png\"]'),(33,'Gintauto Vėliaus paskaita „Viduramžių Kernavė: mirusiųjų pasauliai“ | Istorijos miestui ir pasauliui','Vilnius, Senasis arsenalas. Jau penktą dešimtmetį vykdomų Kernavės archeologinių tyrimų rezultatai leidžia susidaryti gana patikimą legendinės Lietuvos sostinės vaizdinį. Čia susikūrė vienas pirmųjų valstybės galios centrų, čia rezidavo kariaunos saugomi kunigaikščiai, čia gimė viena ankstyviausių miestietiškų bendruomenių etninėje Lietuvoje. Ilgus metus kasinėtas viduramžių miestas ir piliakalnių gynybinė sistema neleidžia abejoti šiais teiginiais. Tačiau ką apie XIII–XIV a. Kernavę ir jos gyventojus byloja to meto kapai? Kokiai socialinei kategorijai atstovavo palaidotieji, kokia kalba jie kalbėjo ir kokiems dievams meldėsi? Kur ilsisi Kernavės kunigaikščiai ir juos gynę kariai? Ar šiandien galime tikėtis vienareikšmiškų atsakymų į šiuos klausimus? Visa tai pabandysime išsiaiškinti, pasitelkdami pastaraisiais metais tyrinėtų Kernavės kapinynų duomenis.','Seminarai',1,8,'2024-12-19 14:00:00','2024-12-12 08:32:35','[\"/uploads/1733992355060_gintauto-veliaus-paskaita-viduramziu-kernave-mirusiuju-pasauliai-istorijos-miestui-ir-pasauliui_jpg.png\"]'),(35,'KALĖDINĖ EKSKURSIJA PO KAUNO SENAMIESTĮ ','Kaunas, Prie Kauno pilies tiltelio. MB \"Kauno gidas\" maloniai kviečia į šventinį pasivaikščiojimą po Kauno senamiestį – pilną gerų emocijų, bei  netikėtų atradimų. Ekskursijos metu keliausime po kalėdine nuotaika alsuojančias gražiausias ir įdomiausias  Kauno senamiesčio gatveles. Aplankysime vietas, susijusias su  miesto ištakomis, kur išgirsite istoriją apie viduramžių Kauną, sužinosite, kada atsirado prakartėlės Lietuvoje, kur Kaune buvo papuošta pirmoji eglutė, kaip gimė kalėdinių dovanėlių tradicijos ir kaip Kalėdas švęsdavo senojo Kauno gyventojai. ','Ekskursijos',0,8,'2024-12-20 17:15:00','2024-12-12 08:35:52','[\"/uploads/1733992552009_kaledine-ekskursija-po-kauno-senamiesti_jpg.png\"]'),(36,'EKSKURSIJA PAŽAISLYJE. VIENUOLYNAS IR BAŽNYČIA ','Kaunas, Pažaislio kamaldulių vienuolynas. MB ,,Kauno gidas” maloniai kviečia apsilankyti buvusiame kamaldulių vienuolyne Pažaislyje, kuris laikomas vienu gražiausių baroko ansamblių Baltijos šalyse!  Pažinkime Kauną kartu!  Pažaislio kamaldulių vienuolyno ir Švč. Mergelės Marijos Apsilankymo bažnyčios mįslinga trauka nuo seno žadino žmonių vaizduotę. Vienuolyną XVII amžiaus antroje pusėje įkūrė Lietuvos Didžiosios Kunigaikštystės kancleris Kristupas Zigmantas Pacas. Vienuolyno statyba prasidėjo 1667 metais. Kalnas, ant kurio buvo numatytas pastatas, buvo pavadintas MontePacis (Taikos kalnas).','Ekskursijos',0,8,'2024-12-26 17:15:00','2024-12-12 08:36:30','[\"/uploads/1733992590363_ekskursija-pazaislyje-vienuolynas-ir-baznycia_jpg.png\"]'),(37,'Banginukas kviečia į NEMOKAMĄ pramogų šventę!','Panevežys, LAZERIŲ ARENA. Nauja pramogų erdvė „Banginukas“ kviečia Jus į nepamirštamą pramogų ir linksmybių kupiną dieną! Visus mažylius ir jų tėvelius kviečiame kartu praleisti magišką ir džiaugsmingą popietę mūsų naujoje erdvėje.','Vaikams',0,8,'2024-12-12 15:00:00','2024-12-12 08:38:09','[\"/uploads/1733992689022_banginukas-kviecia-i-nemokama-pramogu-svente-nuotrauka-8_jpg.png\"]');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','user') DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Test User','test@example.com','password','user','2024-12-11 17:48:30'),(2,'antras','antras@gmail.com','antras','admin','2024-12-11 18:57:46'),(3,'treciassss','trecias@gmail.com','trecias','admin','2024-12-11 18:59:55'),(4,'ketvirtas','ketvirtas@gmail.com','ketvirtas','user','2024-12-11 19:48:45'),(5,'sestas','sestas@gmail.com','sestas','user','2024-12-12 08:12:44'),(6,'astuntas','astuntas@gmail.com','astuntas','user','2024-12-12 08:16:12'),(7,'devintas','devintas@gmail.com','devintas','user','2024-12-12 08:27:57'),(8,'desimtas','desimtas@gmail.com','desimtas','user','2024-12-12 08:31:32'),(9,'vienuoliktas','vienuoliktas@gmail.com','$2b$10$mktEX6lVcM8Z/YZe661ySuhpSeqKnTuIWbrO/6BKT5PoEo0hW1mt6','user','2024-12-12 09:08:36'),(10,'dvyliktas','dvyliktas@gmail.com','$2b$10$wHQZD69opYfzL4Lj4O1XIuAtUnOc53Gh0hPq66sKWfX6m3po0RoVi','user','2024-12-12 09:10:39'),(11,'trylika','trylika@gmail.com','$2b$10$TA4aZBU9jDQAsBkNWY8fveR9OStBT4kWQn1W78wjffd3MWFp5CTiO','user','2024-12-12 09:19:27'),(12,'keturiolika','keturiolika@gmail.com','$2b$10$/ok3dXAU71SOrXz6czmWyuwL6NPkcm1ZBNwSDZzZRt4OCW7Eiluje','user','2024-12-12 09:21:03'),(13,'asdasd','asdasd@gmail.com','$2b$10$u5vcQ01VRko7dk/nvM7NKuo29hvWM8rd6X.YXU5.yBx729.mvoW6S','user','2024-12-12 09:21:22'),(14,'egrgetr','geregregrt@gmail.com','$2b$10$Ryyw2VxFf.YTt6DJbCK9euNEovFm4KF60FXXGAHEIA.MQZ5Oj2A5S','user','2024-12-12 09:21:37');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-12 12:02:22
