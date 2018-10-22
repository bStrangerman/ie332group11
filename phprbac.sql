/*
 * Create Tables
 */

CREATE TABLE IF NOT EXISTS `phprbac_permissions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Lft` int(11) NOT NULL,
  `Rght` int(11) NOT NULL,
  `Title` char(64) NOT NULL,
  `Description` text NOT NULL,
  PRIMARY KEY  (`ID`),
  KEY `Title` (`Title`),
  KEY `Lft` (`Lft`),
  KEY `Rght` (`Rght`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `phprbac_roles` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Lft` int(11) NOT NULL,
  `Rght` int(11) NOT NULL,
  `Title` varchar(128) NOT NULL,
  `Description` text NOT NULL,
  PRIMARY KEY  (`ID`),
  KEY `Title` (`Title`),
  KEY `Lft` (`Lft`),
  KEY `Rght` (`Rght`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS `phprbac_rolepermissions` (
  `RoleID` int(11) NOT NULL,
  `PermissionID` int(11) NOT NULL,
  `AssignmentDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY  (`RoleID`,`PermissionID`),
  FOREIGN KEY (`RoleID`) REFERENCES `phprbac_roles` (`ID`) ON DELETE CASCADE,
  FOREIGN KEY (`PermissionID`) REFERENCES `phprbac_permissions` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;	

CREATE TABLE IF NOT EXISTS `phprbac_users` (
  `UserID` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) NOT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `CreationDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY  (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `phprbac_userroles` (
  `UserID` int(11) NOT NULL,
  `RoleID` int(11) NOT NULL,
  `AssignmentDate` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY  (`UserID`,`RoleID`),
  FOREIGN KEY (`UserID`) REFERENCES `phprbac_users` (`UserID`) ON DELETE CASCADE,
  FOREIGN KEY (`RoleID`) REFERENCES `phprbac_roles` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*
 * Insert Initial Table Data
 */

INSERT INTO `phprbac_permissions` (`Lft`, `Rght`, `Title`, `Description`)
VALUES (0, 1, 'root', 'root');

INSERT INTO `phprbac_roles` (`Lft`, `Rght`, `Title`, `Description`)
VALUES (0, 1, 'root', 'root');

INSERT INTO `phprbac_rolepermissions` (`RoleID`, `PermissionID`)
VALUES (1, 1);

INSERT INTO `phprbac_users` (`Username`, `Password`)
VALUES ('bhaberman', MD5('123'));

INSERT INTO `phprbac_userroles` (`UserID`, `RoleID`)
VALUES (1, 1);