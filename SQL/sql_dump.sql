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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

INSERT INTO phprbac_users(Username,FirstName,LastName,Password,Email,PhoneNumber,Company) VALUES
 ('jafpkgchdft','LYDIA','KENNEDY','wzIgry3Y','vwurkqsile@nhtesfv.net',9821254832,'Qualcomm')
,('freksxzypchwx','MINNIE','CONNER','x2M97Cie','x@nu.net',2187142357,'PNC Financial Services Group')
,('uyvigdvhn','DAWN','THOMPSON','Q%PuKDqG','yeblmxakds@adfxc.edu',1649251457,'L Brands')
,('gzvdfqxtrc','MARIA','ALEXANDER','N7a&dLC$','kpthw@itpvjfz.edu',3543719857,'Sears Holdings')
,('jcnutponemg','RUDOLPH','FOX','9rKIHP!)','meufzjqo@glwjf.edu',3193218463,'Dell Technologies')
,('pzxklechyxz','GUADALUPE','STEVENSON','xkd%?sMX','oi@rvcymdzk.edu',2164587918,'Community Health Systems')
,('chxdyzlvr','JIM','LEONARD','i73rhtLb','mgroibazv@eyx.com',3747245793,'TravelCenters of America')
,('xaohxyapvj','AMY','CHANDLER','%dcvh!D&','cr@vzo.com',9422467928,'Michaels Cos.')
,('sirxmokphil','WALTER','BALL','VzHwp$2(','ykfgwjmix@emphrslagu.org',7564282675,'Mondelez International')
,('jopvqzokm','EDWARD','GOODMAN','eN2(A9i%','vgqofxjm@f.com',7541645124,'Intercontinental Exchange')
,('vkygmwjkvf','SANDRA','VEGA','*dOJIT6b','qkjoltpm@pr.net',7169177826,'CDW')
,('mthcuqizg','LUIS','MCBRIDE','yU%&XbAJ','qokb@rmvqn.com',8168645371,'Host Hotels & Resorts')
,('skgaeyfjku','STEPHEN','GONZALEZ','MLwq5a?x','sgzae@dqnrzu.net',3163975824,'Wells Fargo')
,('ctisrioq','JANA','DUNCAN','&yZ*2Da%','oflsgn@x.net',5827613176,'D.R. Horton')
,('pahwtihsr','JACQUELINE','GILL','C28AGE!t','jnlpiqmg@rftc.net',5476294325,'Lear')
,('fnlgzyvdc','TAMI','SULLIVAN','XL)qaDoF','tlfy@tvfsnl.com',5645165689,'Land O''Lakes')
,('nbqiassze','SHERRI','OBRIEN','s3LCV&aS','dvjwyca@guldjeiqny.net',8145298352,'W.R. Berkley')
,('xeniwakdys','JULIAN','ALEXANDER','Mr%et)Ga','vjxnflqt@d.net',2914914568,'Level 3 Communications')
,('svmrmftyeu','DENISE','COPELAND','%!xMDm6*','dfyks@h.net',7693944528,'Macy''s')
,('jlpxfvurk','TYRONE','HERNANDEZ','4g*)z3C9','ibcgdqfr@uwivez.net',9453213278,'UGI')
,('fqxrhkuyfd','MABEL','SIMS','iygf3XL(','prnaesk@upha.com',5629767234,'WellCare Health Plans')
,('dftkidzwhs','MARION','NORRIS','3Tc?DdvP','awyihezxs@kstqrizdea.org',3844282954,'Cisco Systems')
,('ihxodrmpu','FRANCISCO','JENNINGS','vKGqd74p','ojnudy@ltcowqzk.com',9744252439,'EOG Resources')
,('ulsewqxpwhyvei','DWIGHT','WELCH','RjGw*(vF','mn@rhelvfs.edu',5976299247,'Aflac')
,('kmynfagb','GARY','HOWARD','?CbJTQ%U','wub@zi.org',4635983169,'BlackRock')
,('zclvuyhlt','MEREDITH','CASTILLO','yv?Epexf','ayfmx@pbnv.com',5269414238,'Rockwell Automation')
,('vpbtfmw','WALTER','HALL','AxuySEsH','zcmhxkv@isq.edu',5799646147,'AmerisourceBergen')
,('esksotxhr','JOE','MURRAY','mIjrcvFy','kqfhvpne@jdmbo.edu',3189589543,'Oracle')
,('khgrhzdjrpeu','MORRIS','RODRIQUEZ','jRTXVDGe','urnidzs@c.edu',9657849746,'Sempra Energy')
,('byvrjfqzsnw','DOLORES','HOGAN','CNwRltJO','yuafgosnbp@yre.com',6235944876,'CHS')
,('toefayhveiqh','AUDREY','MCCORMICK','E9aP&QlF','uzpbrocj@fca.edu',5479645684,'JetBlue Airways')
,('plhuixagrh','DOMINIC','BRYANT','n%oqxV$O','aejrpgi@t.edu',2797183486,'EMCOR Group')
,('hctjiryftpiq','AUDREY','VAUGHN','pM?NOlaV','dbhkci@htdicq.com',6549757381,'Steel Dynamics')
,('wpgblhazlsxvjf','DEANNA','HAYNES','wvgu%MrR','tdfuqp@nfdu.com',7254127639,'Expeditors International of Washington')
,('psxzlbgtlfkxrh','WAYNE','DAWSON','!d5OiE*k','hrmq@jbpxsq.com',4958494587,'Tyson Foods')
,('zwyqvluhba','IRIS','BARTON','8TKNJ3GI','txcea@bdevja.com',5644639782,'Quanta Services')
,('cguakfeawr','LONNIE','FREEMAN','DhWpwvUu','zlgqnjc@hwctmp.net',8757495238,'DISH Network')
,('wmdekqghwea','KRISTIN','BROCK','!(iZt6RM','jpyo@xgbm.org',9714691465,'Zimmer Biomet Holdings')
,('apbglmxvwyq','MARCELLA','QUINN','ebluf8TV','fn@aoldmtifv.net',3829531438,'Quest Diagnostics')
,('unmpqtanmeps','TIMOTHY','STEPHENS','R9XckFVy','dgnbswxo@nyuwvf.edu',1876783749,'Ally Financial')
,('ahjzxnvoludh','MARGUERITE','HARMON','5cgx8I!T','rxiuyckb@xhwz.edu',1866489738,'PayPal Holdings')
,('ldkrmqzp','JO','CARR','yqVtSDOE','ur@htfcxql.com',3693269132,'Raymond James Financial')
,('rfvvxw','BOBBY','PERRY','b$(CJ6q*','d@gaokvbhic.edu',7536276347,'Live Nation Entertainment')
,('uhtzwbhjgcur','TONY','MEDINA','9sMxY()O','e@jgqfkeoyni.edu',8717689364,'Constellation Brands')
,('hzgvbrvk','TINA','STEVENS','3oA(LUyF','idxsnwj@vq.org',6159131473,'Whole Foods Market')
,('imswujmvyfpw','GEORGE','EVANS','7oeTMZwc','qte@vtwsbeglfy.com',8349611948,'salesforce.com')
,('kbjnsdny','LESLIE','POTTER','XRMUL?l(','vy@slhtzpqd.net',3819622691,'KeyCorp')
,('hkutqqnfijuzd','CORNELIUS','RUIZ','7r4mSQZ!','gsdkh@dqw.com',8517924679,'3M')
,('murvwylsrcpq','VICTOR','HOWELL','!ixeyhNf','jvns@i.org',6724817283,'Visa')
,('usdlpenlhymeqo','CLAY','SHELTON','ojIFkdUc','wvezjy@qeimnopfby.com',1375499714,'Berkshire Hathaway');

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
  AmountCharged real NOT NULL,
  ContractInformation varchar(400),
  ContractText varchar(400),
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
    AttributeType int(5),
    lft int(11) NOT NULL,
    rght int(11) NOT NULL,
    PRIMARY KEY(AttributeID));

CREATE TABLE IF NOT EXISTS Space_Attributes (
  SpaceID int(11),
  AttributeID int(11),
  PRIMARY KEY(SpaceID, AttributeID),
  FOREIGN KEY(SpaceID) REFERENCES Spaces(SpaceID),
  FOREIGN KEY(AttributeID) REFERENCES Attributes(AttributeID));

INSERT INTO Attributes (AttributeName, AttributeType) VALUES
  ('Retail/Industrial', 1),
  ('Office/Industrial', 1),
  ('Industrial', 1),
  ('Fencing', 2),
  ('Floor Drains', 2),
  ('Yard', 2),
  ('Loading Dock', 2);
