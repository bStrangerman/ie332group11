-- phpMyAdmin SQL Dump
-- version 4.0.9
-- http://www.phpmyadmin.net
--
-- Host: mydb.ics.purdue.edu
-- Generation Time: Oct 22, 2018 at 04:06 PM
-- Server version: 5.5.61-log
-- PHP Version: 5.4.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `bhaberma`
--

-- --------------------------------------------------------

--
-- Table structure for table `phprbac_permissions`
--

CREATE TABLE IF NOT EXISTS `phprbac_permissions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` char(64) COLLATE utf8_bin NOT NULL,
  `Description` text COLLATE utf8_bin NOT NULL,
  `Lft` int(11) NOT NULL,
  `Rght` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `Title` (`Title`),
  KEY `Lft` (`Lft`),
  KEY `Rght` (`Rght`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=13 ;

--
-- Dumping data for table `phprbac_permissions`
--

INSERT INTO `phprbac_permissions` (`ID`, `Title`, `Description`, `Lft`, `Rght`) VALUES
(1, 'root', 'root', 0, 1),
(2, 'add_warehouses', '', 0, 0),
(3, 'add_spaces', '', 0, 0),
(4, 'add_employees', '', 0, 0),
(5, 'accept_contract', '', 0, 0),
(6, 'deny_contract', '', 0, 0),
(7, 'remove_warehouse', '', 0, 0),
(8, 'remove_space', '', 0, 0),
(9, 'hide_warehouse', '', 0, 0),
(10, 'hide_space', '', 0, 0),
(11, 'remove_employee', '', 0, 0),
(12, 'can_lease', '', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `phprbac_rolepermissions`
--

CREATE TABLE IF NOT EXISTS `phprbac_rolepermissions` (
  `RoleID` int(11) NOT NULL,
  `PermissionID` int(11) NOT NULL,
  `AssignmentDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`RoleID`,`PermissionID`),
  KEY `PermissionID` (`PermissionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `phprbac_rolepermissions`
--

INSERT INTO `phprbac_rolepermissions` (`RoleID`, `PermissionID`, `AssignmentDate`) VALUES
(3, 2, '2018-10-22 20:01:37'),
(3, 3, '2018-10-22 20:02:41'),
(3, 4, '2018-10-22 20:02:41'),
(3, 5, '2018-10-22 20:03:12'),
(3, 6, '2018-10-22 20:03:12'),
(3, 7, '2018-10-22 20:03:22'),
(3, 8, '2018-10-22 20:03:22'),
(3, 9, '2018-10-22 20:03:33'),
(3, 10, '2018-10-22 20:03:33');

-- --------------------------------------------------------

--
-- Table structure for table `phprbac_roles`
--

CREATE TABLE IF NOT EXISTS `phprbac_roles` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(128) COLLATE utf8_bin NOT NULL,
  `Description` text COLLATE utf8_bin NOT NULL,
  `Lft` int(11) NOT NULL,
  `Rght` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `Title` (`Title`),
  KEY `Lft` (`Lft`),
  KEY `Rght` (`Rght`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=6 ;

--
-- Dumping data for table `phprbac_roles`
--

INSERT INTO `phprbac_roles` (`ID`, `Title`, `Description`, `Lft`, `Rght`) VALUES
(1, 'root', 'root', 1, 10),
(2, 'Warehouse', '', 2, 7),
(3, 'Warehouse_Owner', '', 3, 4),
(4, 'Warehouse_Employee', '', 5, 6),
(5, 'Lessee', '', 8, 9);

-- --------------------------------------------------------

--
-- Table structure for table `phprbac_userroles`
--

CREATE TABLE IF NOT EXISTS `phprbac_userroles` (
  `UserID` int(11) NOT NULL,
  `RoleID` int(11) NOT NULL,
  `AssignmentDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`UserID`,`RoleID`),
  KEY `RoleID` (`RoleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `phprbac_userroles`
--

INSERT INTO `phprbac_userroles` (`UserID`, `RoleID`, `AssignmentDate`) VALUES
(1, 1, '0000-00-00 00:00:00'),
(2, 3, '2018-10-22 20:05:45');

-- --------------------------------------------------------

--
-- Table structure for table `phprbac_users`
--

CREATE TABLE IF NOT EXISTS `phprbac_users` (
  `UserID` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) COLLATE utf8_bin NOT NULL,
  `Password` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CreationDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`UserID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=3 ;

--
-- Dumping data for table `phprbac_users`
--

INSERT INTO `phprbac_users` (`UserID`, `Username`, `Password`, `CreationDate`) VALUES
(1, 'bhaberman', '202cb962ac59075b964b07152d234b70', '2018-10-22 15:24:17'),
(2, '543', '81448138f5f163ccdba4acc69819f280', '2018-10-22 19:29:08');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `phprbac_rolepermissions`
--
ALTER TABLE `phprbac_rolepermissions`
  ADD CONSTRAINT `phprbac_rolepermissions_ibfk_1` FOREIGN KEY (`RoleID`) REFERENCES `phprbac_roles` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `phprbac_rolepermissions_ibfk_2` FOREIGN KEY (`PermissionID`) REFERENCES `phprbac_permissions` (`ID`) ON DELETE CASCADE;

--
-- Constraints for table `phprbac_userroles`
--
ALTER TABLE `phprbac_userroles`
  ADD CONSTRAINT `phprbac_userroles_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `phprbac_users` (`UserID`) ON DELETE CASCADE,
  ADD CONSTRAINT `phprbac_userroles_ibfk_2` FOREIGN KEY (`RoleID`) REFERENCES `phprbac_roles` (`ID`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
