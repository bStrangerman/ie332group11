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
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

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

	INSERT INTO `phprbac_userroles` (`UserID`, `RoleID`, `AssignmentDate`) VALUES
	(1, 1, '0000-00-00 00:00:00'),
	(2, 3, '2018-10-22 20:05:45');

	CREATE TABLE IF NOT EXISTS `phprbac_users` (
	  `UserID` int(11) NOT NULL AUTO_INCREMENT,
	  `Username` varchar(50) UNIQUE COLLATE utf8_bin NOT NULL,
	  `Password` varchar(255) COLLATE utf8_bin DEFAULT NULL,
	  `CreationDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
		`Email` varchar(100) COLLATE utf8_bin NOT NULL,
	  PRIMARY KEY (`UserID`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=3 ;

-- NAMES, COMPANIES, Phone Numbers, AND EMAILS IN USER TABLE?

	INSERT INTO `phprbac_users` (`UserID`, `Username`, `Password`, `CreationDate`, `Email`) VALUES
	(1, 'bhaberman', '202cb962ac59075b964b07152d234b70', '2018-10-22 15:24:17', 'bhaberma@purdue.edu'),
	(2, '543', '81448138f5f163ccdba4acc69819f280', '2018-10-22 19:29:08', 'purduepete@purdue.edu');

	ALTER TABLE `phprbac_rolepermissions`
	  ADD CONSTRAINT `phprbac_rolepermissions_ibfk_1` FOREIGN KEY (`RoleID`) REFERENCES `phprbac_roles` (`ID`) ON DELETE CASCADE,
	  ADD CONSTRAINT `phprbac_rolepermissions_ibfk_2` FOREIGN KEY (`PermissionID`) REFERENCES `phprbac_permissions` (`ID`) ON DELETE CASCADE;

	ALTER TABLE `phprbac_userroles`
	  ADD CONSTRAINT `phprbac_userroles_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `phprbac_users` (`UserID`) ON DELETE CASCADE,
	  ADD CONSTRAINT `phprbac_userroles_ibfk_2` FOREIGN KEY (`RoleID`) REFERENCES `phprbac_roles` (`ID`) ON DELETE CASCADE;


	CREATE TABLE IF NOT EXISTS Warehouse (
		warehouseID int(11) NOT NULL auto_increment,
		owner_id int(11) NOT NULL,
		address varchar(100),
		PRIMARY KEY(warehouseID),
		FOREIGN KEY(owner_id) REFERENCES phprbac_users(UserID));

	CREATE TABLE IF NOT EXISTS Spaces (
		spaceID int(11) NOT NULL auto_increment,
		warehouseID int(11) NOT NULL,
		size real,
		price real,
		active BOOLEAN DEFAULT TRUE,
		PRIMARY KEY(spaceID),
		FOREIGN KEY(warehouseID) REFERENCES Warehouse(warehouseID));

	CREATE TABLE IF NOT EXISTS Contracts (
		contractID int(11) NOT NULL auto_increment,
		spaceID int(6) NOT NULL,
		lessee_ID int(11) NOT NULL,
		start_date timestamp NOT NULL,
		end_date timestamp NOT NULL,
		warehouse_rating int(1),
		lessee_rating int(1),
		amount_charged real NOT NULL,
		contract_text varchar(300),
		reserved_time timestamp NOT NULL,
		confirmed_time timestamp NOT NULL,
		approved_time timestamp NOT NULL,
		denied_time timestamp NOT NULL,
		PRIMARY KEY(contractID),
		FOREIGN KEY(spaceID) REFERENCES Spaces(spaceID) ON DELETE CASCADE,
		FOREIGN KEY(lessee_ID) REFERENCES phprbac_users(UserID));

	CREATE TABLE IF NOT EXISTS Attributes (
		AttributeID int(11) NOT NULL auto_increment,
		AttributeName varchar(50),
		AttributeDescription varchar(200),
		lft int(11) NOT NULL,
		rght int(11) NOT NULL,
		PRIMARY KEY(attributeID));


	CREATE TABLE IF NOT EXISTS Space_Attributes (
		spaceID int(11),
		attributeID int(11),
		PRIMARY KEY(spaceID, attributeID),
		FOREIGN KEY(spaceID) REFERENCES Spaces(spaceID),
		FOREIGN KEY(attributeID) REFERENCES Attributes(attributeID));

	CREATE TABLE IF NOT EXISTS Search_Log (
		SearchID int(11) NOT NULL auto_increment,
		UserID int(11),
		SearchTerms varchar(400),
		FromLatitude real,
		FromLongitude real,
		SearchTime timestamp DEFAULT CURRENT_TIMESTAMP,
		PRIMARY KEY (SearchID),
		FOREIGN KEY (UserID) REFERENCES phprbac_users(UserID));
