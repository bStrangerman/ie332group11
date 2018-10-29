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
  ) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1;

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

CREATE TABLE IF NOT EXISTS `phprbac_rolepermissions` (
  `RoleID` int(11) NOT NULL,
  `PermissionID` int(11) NOT NULL,
  `AssignmentDate` int(11) NOT NULL,
  `PermissionAssignmentDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`RoleID`,`PermissionID`),
  KEY `PermissionID` (`PermissionID`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

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

CREATE TABLE IF NOT EXISTS `phprbac_roles` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(128) COLLATE utf8_bin NOT NULL,
  `Description` text COLLATE utf8_bin NOT NULL,
  `Lft` int(11) NOT NULL,
  `Rght` int(11) NOT NULL,
  `OrderNumber` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Title` (`Title`),
  KEY `Lft` (`Lft`),
  KEY `Rght` (`Rght`)
  ) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=6 ;

INSERT INTO `phprbac_roles` (`ID`, `Title`, `Description`, `Lft`, `Rght`, `OrderNumber`) VALUES
  (1, 'root', 'root', 1, 10, ''),
  (2, 'Warehouse', '', 2, 7, ''),
  (3, 'Warehouse_Owner', '', 3, 4, 1),
  (4, 'Warehouse_Employee', '', 5, 6, 2),
  (5, 'Lessee', '', 8, 9, 3),
  (91, 'no_roles', '', 99, 100, ''),
  (99, 'need_setup', '', 199, 200, '');

CREATE TABLE IF NOT EXISTS `phprbac_userroles` (
  `UserID` int(11) NOT NULL,
  `RoleID` int(11) NOT NULL,
  `AssignmentDate` int(11) NOT NULL,
  `RoleAssignmentDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`UserID`,`RoleID`),
  KEY `RoleID` (`RoleID`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS `phprbac_users` (
  `UserID` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) UNIQUE COLLATE utf8_bin NOT NULL,
  `FirstName` varchar(50),
  `LastName` varchar(50),
  `Password` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CreationDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Email` varchar(100) COLLATE utf8_bin NOT NULL,
  `PhoneNumber` varchar(11),
  `Company` varchar(50),
  PRIMARY KEY (`UserID`)
  ) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=3 ;

ALTER TABLE `phprbac_rolepermissions`
  ADD CONSTRAINT `phprbac_rolepermissions_ibfk_1` FOREIGN KEY (`RoleID`) REFERENCES `phprbac_roles` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `phprbac_rolepermissions_ibfk_2` FOREIGN KEY (`PermissionID`) REFERENCES `phprbac_permissions` (`ID`) ON DELETE CASCADE;

ALTER TABLE `phprbac_userroles`
  ADD CONSTRAINT `phprbac_userroles_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `phprbac_users` (`UserID`) ON DELETE CASCADE,
  ADD CONSTRAINT `phprbac_userroles_ibfk_2` FOREIGN KEY (`RoleID`) REFERENCES `phprbac_roles` (`ID`) ON DELETE CASCADE;

CREATE TABLE IF NOT EXISTS Warehouses (
  WarehouseID int(11) NOT NULL auto_increment,
  OwnerID int(11) NOT NULL,
  Address varchar(100),
  ZipCode varchar(5),
  City varchar(50),
  State varchar(2),
  BuildingSize real,
  PRIMARY KEY(WarehouseID),
  FOREIGN KEY(OwnerID) REFERENCES phprbac_users(UserID));

CREATE TABLE IF NOT EXISTS Spaces (
  SpaceID int(11) NOT NULL auto_increment,
  WarehouseID int(11) NOT NULL,
  SpaceSize real,
  MonthlyPrice real,
  YearlyPrice real,
  Active BOOLEAN DEFAULT TRUE,
  PRIMARY KEY(SpaceID),
  FOREIGN KEY(WarehouseID) REFERENCES Warehouses(WarehouseID));

CREATE TABLE IF NOT EXISTS Contracts (
  ContractID int(11) NOT NULL auto_increment,
  SpaceID int(6) NOT NULL,
  LesseeID int(11) NOT NULL,
  StartDate timestamp NOT NULL,
  EndDate timestamp NOT NULL,
  WarehouseRating int(1),
  WarehouseComments varchar(300),
  LesseeRating int(1),
  LesseeComments varchar(300),
  AmountCharged real NOT NULL,
  ContractText varchar(300),
  PRIMARY KEY(ContractID),
  FOREIGN KEY(SpaceID) REFERENCES Spaces(SpaceID) ON DELETE CASCADE,
  FOREIGN KEY(LesseeID) REFERENCES phprbac_users(UserID));

CREATE TABLE IF NOT EXISTS Status (
  StatusID int(11) NOT NULL AUTO_INCREMENT,
  StatusName varchar(50),
  StatusDescription varchar(200),
  PRIMARY KEY (StatusID));

CREATE TABLE IF NOT EXISTS Contract_Status (
  ContractID int(11) NOT NULL,
  StatusID int(11) NOT NULL,
  StatusTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (ContractID, StatusID),
  FOREIGN KEY (ContractID) REFERENCES Contracts(ContractID),
  FOREIGN KEY (StatusID) REFERENCES Status(StatusID));

CREATE TABLE IF NOT EXISTS Attributes (
  AttributeID int(11) NOT NULL auto_increment,
  AttributeName varchar(50),
  AttributeDescription varchar(200),
  lft int(11) NOT NULL,
  rght int(11) NOT NULL,
  PRIMARY KEY(attributeID));

CREATE TABLE IF NOT EXISTS Space_Attributes (
  SpaceID int(11),
  AttributeID int(11),
  PRIMARY KEY(SpaceID, AttributeID),
  FOREIGN KEY(SpaceID) REFERENCES Spaces(SpaceID),
  FOREIGN KEY(AttributeID) REFERENCES Attributes(AttributeID));

CREATE TABLE IF NOT EXISTS Attributes (
  AttributeID int(11) NOT NULL auto_increment,
  AttributeName varchar(50),
  AttributeDescription varchar(200),
  AttributeType int(5),
  lft int(11) NOT NULL,
  rght int(11) NOT NULL,
  PRIMARY KEY(AttributeID));

INSERT INTO Attributes (AttributeName, AttributeType) VALUES
  ('Retail/Industrial', 1),
  ('Office/Industrial', 1),
  ('Industrial', 1),
  ('Fencing', 2),
  ('Floor Drains', 2),
  ('Yard', 2),
  ('Loading Dock', 2);
