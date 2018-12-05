CREATE TABLE IF NOT EXISTS `phprbac_permissions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` char(64) COLLATE utf8_bin NOT NULL,
  `Description` varchar(100) COLLATE utf8_bin NOT NULL,
  `Lft` int(11) NOT NULL,
  `Rght` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `Title` (`Title`),
  KEY `Lft` (`Lft`),
  KEY `Rght` (`Rght`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1;

INSERT INTO `phprbac_permissions` (`ID`, `Title`, `Description`, `Lft`, `Rght`) VALUES
(1, 'root', 'Administrator', 0, 22),
(2, 'add_warehouses', 'Can Add Warehouses', 1, 2),
(3, 'add_spaces', 'Can Add Spaces', 3, 4),
(4, 'add_employees', 'Can Add Warehouse Employees', 5, 6),
(5, 'accept_contract', 'Can Accept Warehouse Contracts', 6, 7),
(6, 'deny_contract', 'Can Deny Warehouse Contracts', 8, 9),
(7, 'remove_warehouse', 'Can Remove Warehouses', 10, 11),
(8, 'remove_space', 'Can Remove Spaces', 12, 13),
(9, 'hide_warehouse', 'Can Hide Warehouses From Listings', 14, 15),
(10, 'hide_space', 'Can Hide Spaces From Listings', 16, 17),
(11, 'remove_employee', 'Can Remove Warehouse Employees', 18, 19),
(12, 'can_lease', 'Can Lease Warehouses', 20, 21);

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
(1, 'root', 'root', 1, 10, NULL),
(2, 'Warehouse', 'Warehouse', 2, 7, NULL),
(3, 'Warehouse_Owner', 'Warehouse Owner', 3, 4, 1),
(4, 'Warehouse_Employee', 'Warehouse Employee', 5, 6, NULL),
(5, 'Lessee', 'Lessee', 8, 9, 3),
(91, 'no_roles', 'No Roles', 99, 100, NULL),
(99, 'need_setup', 'Account Needs Setup', 199, 200, NULL);

CREATE TABLE IF NOT EXISTS `phprbac_rolepermissions` (
  `RoleID` int(11) NOT NULL,
  `PermissionID` int(11) NOT NULL,
  `AssignmentDate` int(11) NOT NULL,
  `PermissionAssignmentDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`RoleID`,`PermissionID`),
  FOREIGN KEY (`RoleID`) REFERENCES `phprbac_roles` (`ID`) ON DELETE CASCADE,
  FOREIGN KEY (`PermissionID`) REFERENCES `phprbac_permissions` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `phprbac_rolepermissions` (`RoleID`, `PermissionID`, `AssignmentDate`) VALUES
(1, 1, '2018-10-22 20:01:37'),
(1, 2, '2018-10-22 20:01:37'),
(1, 3, '2018-10-22 20:01:37'),
(1, 4, '2018-10-22 20:01:37'),
(1, 5, '2018-10-22 20:01:37'),
(1, 6, '2018-10-22 20:01:37'),
(1, 7, '2018-10-22 20:01:37'),
(1, 8, '2018-10-22 20:01:37'),
(1, 9, '2018-10-22 20:01:37'),
(1, 10, '2018-10-22 20:01:37'),
(1, 11, '2018-10-22 20:01:37'),
(1, 12, '2018-10-22 20:01:37'),
(2, 2, '2018-10-22 20:01:37'),
(2, 3, '2018-10-22 20:01:37'),
(2, 4, '2018-10-22 20:01:37'),
(2, 5, '2018-10-22 20:01:37'),
(2, 6, '2018-10-22 20:01:37'),
(2, 7, '2018-10-22 20:01:37'),
(2, 8, '2018-10-22 20:01:37'),
(2, 9, '2018-10-22 20:01:37'),
(2, 10, '2018-10-22 20:01:37'),
(2, 11, '2018-10-22 20:01:37'),
(3, 2, '2018-10-22 20:01:37'),
(3, 3, '2018-10-22 20:01:37'),
(3, 4, '2018-10-22 20:01:37'),
(3, 5, '2018-10-22 20:01:37'),
(3, 6, '2018-10-22 20:01:37'),
(3, 7, '2018-10-22 20:01:37'),
(3, 8, '2018-10-22 20:01:37'),
(3, 9, '2018-10-22 20:01:37'),
(3, 10, '2018-10-22 20:01:37'),
(3, 11, '2018-10-22 20:01:37'),
(4, 5, '2018-10-22 20:01:37'),
(4, 6, '2018-10-22 20:01:37'),
(5, 12, '2018-10-22 20:01:37');

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

CREATE TABLE IF NOT EXISTS `phprbac_userroles` (
  `UserID` int(11) NOT NULL,
  `RoleID` int(11) NOT NULL,
  `AssignmentDate` int(11) NOT NULL,
  `RoleAssignmentDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`UserID`,`RoleID`),
  FOREIGN KEY (`UserID`) REFERENCES `phprbac_users` (`UserID`) ON DELETE CASCADE,
  FOREIGN KEY (`RoleID`) REFERENCES `phprbac_roles` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;



INSERT INTO phprbac_users(Username,FirstName,LastName,Password,Email,PhoneNumber,Company) VALUES
-- Root Password: th!sPwd!s4r00t
('root','ROOT','ACCOUNT','f52bd9cbef6c83042f73d959789f9bd1','atCapacity@purdue.edu',5555555555,'@Capacity')
-- Warehouse Owner Password: th!sPwd!s40wner
,('owner','OWNER','ACCOUNT','f8f01808e127b869e76ae2ef9e046547','ncztga@y.org',9343253675,'Stryker')
-- Lesse Password: th!sPwd!s4Le55ee
,('lessee','LESSEE','ACCOUNT','878fcd3829462665ff1ad75ad0f9ca11','ncztga@y.org',9343253675,'Stryker')
,('tzysqaczefynx','ALFRED','GONZALEZ','6308d8858faef2e47b30c0e80bf3248e','ncztga@y.org',9343253675,'Stryker')
,('gadzwnkor','GILBERT','WEAVER','b01464439410ee0cc2efb574782efa7f','yeop@xpkf.com',1657132174,'Republic Services')
,('xgudcejd','LUCIA','WILKERSON','d144ceb7dc9d2cdc99ff09a9cba265d2','jgm@vuqlimerkb.net',7685821496,'Computer Sciences')
,('bipqkmrijyqsc','DANA','PARK','d63e62a7d3bcb89760275e62dc963042','regxdiplas@mdovh.org',5844962894,'WESCO International')
,('keafgvigluqyd','FREDA','WARNER','24f2b42bea800b94a0262a7a18381d9c','i@qjwho.com',2794675274,'Universal Health Services')
,('awtwlobmk','OLIVER','WASHINGTON','44df6407e1c1678b6570fca4677fc13b','jsgfw@lnfw.net',3455691452,'Southern')
,('mwkvtound','WILLARD','ROGERS','59d094fb6153b0605c18ce7c7be0b78f','atqusm@gdzwxet.org',7823785874,'WEC Energy Group')
,('wrtacgvuxil','MARCELLA','WEAVER','88a1e34b50d5005bcd7f51b47d12edb9','hwzgqefkd@jkotxni.com',2641922864,'PVH')
,('rhkjrdiagy','BELINDA','WHEELER','6d12fcb01b627852cb4a8ea4c2d5bf3e','ce@faqlyzr.com',5783648542,'Robert Half International')
,('xgshsoykaegu','RICKEY','SWANSON','c088d379f1770e300ce565820742fc3c','bmjlr@zcxtaf.com',1787281876,'Alaska Steel Holding')
,('rgebkiw','LEVI','BRIDGES','c2158488f94b10d7c962b7707c2403c0','qcxp@swxonra.edu',1864728134,'Constellation Brands')
,('vimnhct','RUBEN','RODRIGUEZ','74514038b6af28bf78594a82b6476ab8','sopd@s.net',4395178362,'A-Mark Precious Metals')
,('rctsqadfxac','KRISTIE','FLEMING','026c5ffb1edc7feb6652f57cda000d3c','uyjntlvr@hgq.edu',5764759638,'Baxter International')
,('xkqpusbxrow','LYLE','MORTON','a9b7d96631395730db7b4c27ae4f4d62','be@pe.net',7824373861,'Western Refining')
,('tfgjnohzy','MARCELLA','BAILEY','fb44f4679da7af3cacffc7c900c275af','jatufkry@yefn.org',3454631652,'Union Pacific')
,('otqlvyravbsrkd','LEO','RICHARDSON','85801b36692e6787db18a0bd6889db88','doc@guj.org',5147414936,'L Brands')
,('suxotgdvr','PERCY','WATERS','0ff13ba7a029c5ca658f6242366c3df8','byaniolt@caewdtr.edu',6383856398,'AmerisourceBergen')
,('rumktwuslz','KARI','JACOBS','60b2f887454983b84d2679defab966fb','usxbdkofct@wazvmn.org',6255169513,'Kimberly-Clark')
,('qklokjd','LAUREN','MCKENZIE','133845d1235d4464a4e9e045c9f64cc1','ndyczik@uaclrnfwtj.net',2347685613,'Prudential Financial')
,('fydbchu','ALVIN','ROSE','f222dd2d783acf4aa71ea096585d15ad','prto@hwuzim.net',6354283694,'Xcel Energy')
,('abgvrfp','RITA','GRANT','45cec0d443a9109a1e55fe1fffea2abf','gv@pcrt.edu',9424255926,'Ecolab')
,('efanhxnf','BOBBY','WHEELER','660b5486f5f84835f7854942e34fdd02','eny@o.org',6729859318,'Celanese')
,('eaivnokvzsg','CARLOS','MORALES','dc509556e5fb0d994c9ab1450cfc4ebd','yksb@f.org',3545875637,'PBF Energy')
,('qpyxqasvetk','LAWRENCE','MARTIN','414623698d44d181ab16c9359eb6c457','zcwdon@qfz.com',4393484912,'General Electric')
,('cvdrgvphan','MARTA','CARSON','dd0ef38ea8b844b711467bb0892966c7','cg@qkmgudc.edu',4811961295,'Arthur J. Gallagher')
,('mgyltcojmsw','SHIRLEY','BERRY','b723599e7893f19c9d09062214826bc8','hje@xmct.net',4318216758,'New York Life Insurance')
,('qdasctegf','SHAWN','CASTILLO','6b8dbe6d749ea0bc37a921a8b94cf302','rpzwymvjqs@ymzosf.org',9142531847,'Regions Financial')
,('boyfdxfl','TYRONE','MASSEY','687e570582968381194b2ceeb12915cb','zbrgunyj@wumtbnplg.edu',2165916427,'Ryder System')
,('kbkhwyzip','LONNIE','MOODY','2cec87b5ef13e7bd90070e58e6200996','sgcnxpzmo@aldtysq.org',8537343427,'Motorola Solutions')
,('acyxvhdr','BETHANY','MENDOZA','033d06da77cb65a85afa04277ab0213d','shxzf@rz.com',1485132459,'CHS')
,('bgzaumsz','NICK','CASEY','a18cb85b14ef8f532b1f960cf98edc92','q@haknjszle.edu',9239131596,'Fannie Mae')
,('rzcjkxvlgfwt','TYRONE','FORD','87c6aed131137863dc28f382cbeb1877','fwqmb@sdtkb.com',9236271935,'iHeartMedia')
,('oitjysgkutsyxlw','JORGE','BANKS','01730e14c9251f086668a386fda5008e','qnmwgbhtov@uoktan.edu',4874968569,'Facebook')
,('grrpti','JEFF','BENNETT','06197b38b1bc69973b1d140f9d79c093','i@fca.org',3246811283,'Corning')
,('rpbmiwtxu','KEVIN','MASON','b69d30f25e628874a7fe5c13ec02e113','mnatjpvqco@zj.org',1979414675,'Chesapeake Energy')
,('gdmkjufdsj','MICHEAL','RILEY','cc39dd6dcd3fea9049b10ee4ac42b8d8','rmc@odj.edu',2315193692,'CenterPoint Energy')
,('jaocmiqfyh','CLAUDE','JONES','9447928b6ed219c3ff7e025d52a4409e','jcthaw@xcif.edu',5628798523,'Toys "R"� Us')
,('buyvsejuh','VINCENT','MEYER','2379fc755a92c0d678b063cf4c533c69','ijpeldoh@yf.org',4934313421,'EMCOR Group')
,('krcesgbfdt','ANGELA','LITTLE','2e0cf8d6cf33aed2ad459f57dd6c5d25','fhbitdlvo@vk.com',8654979835,'Energy Transfer Equity')
,('adtbnleur','ANGIE','BARTON','4af042fa1b4447687583698301a804eb','cgyl@aj.org',8437183786,'Newell Brands')
,('meigthy','SIMON','MCGEE','17983ea0f8fa1f063cf488066a9c1c8f','xuwq@ot.edu',4562458317,'Yum Brands')
,('nytxzstgknyc','DARRELL','ALLISON','963eacc33143f71593c7e206ed5b6569','k@ubyasgd.edu',1266982365,'Hertz Global Holdings')
,('njmuex','JOSEFINA','VARGAS','12ad7d0774660e351b39c276a569cb58','xhiltnyw@oltgz.com',8676312941,'National Oilwell Varco')
,('bscdvqa','JOSE','BALL','23f12697d7b71b1201055f13d623a38a','upk@nzkxtpa.net',6213573741,'iHeartMedia')
,('tjqgrspt','ALEJANDRO','KELLY','f32e69a8c38bd475786565f4c82d5745','hmezpw@a.edu',1326432543,'Level 3 Communications')
,('lzescrumklyifnp','CAROL','GARNER','aeb1a68d947983ba96e18eade7a93449','nusfivd@hfygmtspxi.edu',4593729546,'Hershey')
,('ufvcflhqa','JAVIER','REEVES','01bd617523e89d869d3225a6e1a25e20','eldxhjavy@n.org',4798156981,'Nvidia')
,('quhnvywnzpjc','SPENCER','PHELPS','12b4ec1ee6962606173c785d814d6e3b','ydqjeap@yw.edu',4125171574,'LKQ')
,('gawiya','LORI','CARPENTER','64de7bdb72d810184cc50f786f7523ca','cqe@ojkvfe.edu',8657699547,'Archer Daniels Midland')
,('xikoyynzcq','KYLE','LAWSON','23cda2bc71c1c3dce900545ba2db9e98','fbx@ofied.edu',6247364325,'Morgan Stanley')
,('sxlidkojqr','EUGENE','COLLINS','3e9971197a3d700531c0edf4fdf29944','u@ljwou.net',5319485698,'WestRock')
,('mrxswocemvzgiw','MORRIS','GILL','9a78369a500642baf44dc20c5b25fc5f','pk@dsgq.com',1377565472,'Navistar International')
,('rmqzijpgr','GUADALUPE','WONG','8b142bf1a62ce978b32235f8ddd52a6f','rt@wptobluai.com',7382418975,'New York Life Insurance')
,('srvulkixjz','TONY','SUMMERS','a3cd8e314d0202ee429046eb85718dd1','quyohfvxgd@ufql.org',9133258263,'PepsiCo')
,('zprowygsezdnmu','BOBBY','LYONS','1edfbf9264747b2f849c55ef7c3fe419','kftvn@lsojribpzm.org',8255163981,'Estee Lauder')
,('hsolxqonewc','ALMA','FLORES','d130f70bf93697171d19e3e22d5e3bee','pnafty@orwanlst.org',3762481837,'Huntington Ingalls Industries')
,('tepsncyfmeng','BILL','CHRISTENSEN','00ca9d90ebf1ec964c7a745558b48444','oyx@yoqcfhgvlt.org',6192784758,'Genworth Financial')
,('qzfupwmd','NEAL','GRIFFIN','e45c1da86de48a6cc100330645e230ec','qmi@czr.com',8946321685,'Leidos Holdings')
,('ickqhboyv','MICHELE','JAMES','3d5c3ad614553a2dee17ab974cd93fe6','ft@bifqmrdn.net',8731641328,'Berkshire Hathaway')
,('aesqkbtcpzuy','JANIS','STRICKLAND','2f0149c8032f540ce9593324f98dc56d','ybmglcuszx@jplmb.net',4162418145,'Lockheed Martin')
,('qgmthnqugxlwby','MEREDITH','KELLEY','cd7a57b2f03ba7f38da140827a4cb477','zqlusmdg@p.edu',2748432174,'Rockwell Automation')
,('kylozqcdmjvqwk','FERNANDO','EDWARDS','0934bca8baad569a77001faa69e73ae6','tp@opmywgd.com',3713877623,'Navistar International')
,('vtxgzuuyxdmb','CYNTHIA','WALSH','e6aa0e557c2a58d2abd695b260108c4d','daqms@uwvjlicmaq.net',7352645781,'PepsiCo')
,('hejinoilkz','WILLARD','LEE','8b0800713109544969e3c843a1a0999b','yrctvd@mosrtqc.net',8575727512,'Lithia Motors')
,('qsksqr','ROOSEVELT','SIMPSON','e7524588c7c87a6c3630c2964fe5728b','bfdhczk@a.org',9232956412,'Level 3 Communications')
,('ydshcgpcde','STEVEN','COX','5cff0cd1c5ca7971215b3dc6faace1d8','p@af.com',2944867431,'Eversource Energy')
,('xmtjywmjdkrhs','LYNN','SPARKS','3a86ad92b8a5510a2b1d8797fc674729','bgnq@nxu.org',1486177865,'Alleghany')
,('yeovmgirdlfbhwp','HECTOR','GIBBS','03e2264c0c6f0a673c80f6d8184228e6','bdw@tj.edu',3817397921,'PayPal Holdings')
,('usqylveap','FORREST','WILLIAMS','1a9ee8475e8bea96e6ffa832e4a33898','ah@fc.org',7416585832,'Alaska Steel Holding')
,('teduiwsy','MARCIA','HAYNES','f713d93cdcd905415a7b7237160ad319','g@dyur.org',7263176281,'W.R. Berkley')
,('rltorcj','EDUARDO','MORALES','34c740d4e65f01ff01b9ac9d5b381a15','kjio@Texas.org',2479417136,'Kraft Heinz')
,('ucnyvuem','LILA','HART','a98eb84d1639dfded4a30a98fd39c961','igefvq@cj.net',7459454539,'Alcoa')
,('vbnahicf','LORA','CUMMINGS','a4c8d5b75992ac025d38daf8f9303adf','mgukh@rewg.net',4187386432,'Procter & Gamble')
,('scibsyxvitgp','DOMINICK','HOFFMAN','1e4b1659e32842772f26f43e6eee2a47','r@laqyjocn.edu',5377185296,'Synchrony Financial')
,('hsacuwmwgk','DARREN','MUNOZ','f066bfcf43620d73bc14049460897129','gsvruxjmti@lb.org',5148626417,'Oneok')
,('vshxgf','VERNON','STOKES','3146cf6bf2d804fc5aad19057a1d2cd7','heoycfg@gzoyd.org',4291837164,'CMS Energy')
,('csihbkuqka','BOYD','ANDREWS','77db22f479cfaa515adaa0add94058d0','mivsnoxcdf@rlc.net',8633188354,'Parker-Hannifin')
,('bgjaqspuyrfcj','COLLEEN','TERRY','bc7df905e9cf35e933629bf70245fa01','utwrons@gokzl.com',7835671853,'Lockheed Martin')
,('hcoqsnavbfu','GAIL','MCGEE','be6bbc8b963c594508a3a5e8ca2dfdd2','mwgcli@oazbgyku.org',8252894579,'Oshkosh')
,('mypuw','VIRGINIA','JAMES','10395078de7c52f38915f296b952609f','pvywi@ouqc.net',3976435342,'Nordstrom')
,('ktgjvehcpd','EMANUEL','COLLIER','861517c900728d6a33c9be6125dc70da','pjfnt@tvkpbhmjnq.net',3281941362,'Express Scripts Holding')
,('pxojf','ELISA','BURKE','2c465a155afe74dbcab8413b9ce3e7ee','drynw@gvmxba.net',9435363956,'Citizens Financial Group')
,('myonsxujpbzgy','ROBYN','BARBER','62390ed0b5c577867dc9acd3b8db020a','ixnygqvkh@ryvao.net',4253148726,'Liberty Mutual Insurance Group')
,('kegezdvbnm','JONATHAN','BRIGGS','341a44a023f76698445fdebb37a1b968','pdkjn@e.com',6721394582,'Pfizer')
,('reivawhxmwzgliq','DELLA','WOOD','2020cab5daa9a94b46adbd4e067459fc','u@l.edu',1256472385,'Nucor')
,('ulhbrndg','CLAUDE','NORRIS','c16b58d4435d48dc9bb0c39dd9b7e0be','yeckfoxmz@aq.org',4734698517,'FirstEnergy')
,('zodosmbpcq','DAWN','BURKE','fcdf164f35a1ae1f83874cac719eab72','xrsvbqg@xzepiby.com',4863584968,'CST Brands')
,('nbaxzom','KIRK','LYNCH','9a3f1abc96e58c9287724ba15a98f2f3','yevhow@mvkwlnthaf.org',2751634597,'Micron Technology')
,('ufyatilvo','RODNEY','SANTOS','f43ac69ae4669e87ac7da4c5e3e67b94','ykcfzxihdb@ubqdw.org',8436945312,'Michaels Cos.')
,('ijkpmbgo','SANTIAGO','VALDEZ','a6f1cbd2c045368fccfb964e82e3de2e','femxhpdwrj@atpbnhw.edu',4373473765,'Exelon')
,('pusjzt','CHRISTINE','GRIFFITH','c9f7e4d6742a8b05ed744527e91c4b1f','wytc@Wyoming.org',9824769127,'General Motors')
,('iobgvsaqnj','RONNIE','STOKES','1883d21e353122a0886dfe3b02b2dfc3','rabyogdt@gmkdrwni.edu',7983715368,'Devon Energy')
,('odiblarqsn','JAVIER','SOTO','329b4bd432aa8e5e97f2d5d66983a297','dnm@udnf.edu',8959636327,'Tenet Healthcare')
,('kcjqvp','LUCAS','SHELTON','b0c69c1d93b092b1ead288223c87678c','ye@glyqwctbs.edu',5828396124,'HRG Group')
,('kotbnmndromvu','ROBYN','ERICKSON','59acedb690292a36dfb2a3d4a8eed4bc','nwige@eadnjqfzik.com',1848346295,'CVS Health')
,('qruyjmftkpul','RAUL','SCHMIDT','ae4f78b3148fb008568e2d889527fab8','kdtq@lrmcgowxp.org',3281371739,'Toys "R"� Us')
,('bqcpwiqtae','HAZEL','ROBERTS','0e781a336d5c18c9460b7fca15243823','rdxihmwev@oviz.net',3789788729,'Bank of America Corp.')
,('jabcgrsxmj','MIRIAM','WADE','1b1f42ec841e239d294dcafddb19fd85','k@iak.edu',2474583549,'Kohl''s')
,('whqukhcgvw','BETSY','SCOTT','c31aaba6e9440ba273f48ccc78e14cc2','ibpwxqfjol@rkmnfucwi.org',9572499584,'Berry Global Group')
,('wvqcmni','DUANE','OLIVER','c3fa52ea1b7f7ce5f4dfd3ce0900c8bc','vdsbphiqz@fcshyt.net',5176955648,'Owens-Illinois')
,('bqgenuktjo','MAX','BOWMAN','5dc382f8d4ee8ce8e6e074def6bb29f8','ymptswxod@arymxvn.net',5838561568,'NRG Energy')
,('gnzvdpyfi','JORGE','BRADLEY','18b70c696b450715617519b6c7525e58','xbk@qpinjfmxy.edu',1342941284,'Albertsons Cos.')
,('zrxihoqvps','DARREL','RODGERS','228460d8653bbb13418e4f7138d9829a','o@xfags.org',8268513461,'Western & Southern Financial Group')
,('cneyrlkudsxl','CHARLENE','TRAN','0d9a8929a3c4fe1daff542d385a32c07','nfjeyl@kbeqp.edu',3686259215,'New York Life Insurance')
,('oaybqxdhsz','CLINT','FRANCIS','64ab70bb590b2095badadb618a358056','qszr@ogsukcd.edu',8942154751,'Genworth Financial')
,('zyxuxoser','LAUREN','FLETCHER','f0acd75a579d5cd7d1085271e2af30dd','sot@whqlmpibed.net',9859847914,'IBM')
,('ijbuscbj','JESUS','PATRICK','cb5d77a7ba95da15277bbf68c98d701c','frmz@fgu.com',3283599147,'Stryker')
,('uidkynncftdje','NANCY','MOODY','0fce5384d73d2fa02d562da898c19295','eosr@qksmdta.net',9631846385,'Activision Blizzard')
,('easnkhprm','DENISE','BURKE','f6fd7b4b58c97a20a0fecb66725bb709','mel@vct.net',2393642518,'Berkshire Hathaway')
,('lzkociywf','EDDIE','WILSON','575865fd561f8ae0a5fc06a68402ca8e','ebsytxgc@leizoruknx.edu',4523964175,'First Data')
,('hrsozxg','TONY','ELLIS','d1a4c0be38e9729f3922bf94741d48e2','tfdvwy@plsiva.edu',4267321527,'Lowe�??s')
,('fhksstkfm','CLAUDE','LEWIS','b07a727d5367413f452cc9aa23e3fd7b','azbrtgj@igsvlht.org',6841579381,'Netflix')
,('aeqmlincfvzqwu','JEROME','JACOBS','9e13b6c42f310c697a6306e2f814b851','txvkl@xnpmb.edu',5827547938,'Harley-Davidson')
,('moruvspd','JARED','CHANDLER','de5b5a7f1dae7e3dc82b43491effa9d7','pcodinewtk@w.com',6192697129,'Halliburton')
,('hshqi','STEVEN','CAMPBELL','d3382256316f97774d62b438481c3d8c','sxu@vcetqm.com',8974239712,'Hewlett Packard Enterprise')
,('npuoistmv','SALVADOR','WILKINS','9e09b1e4779381e2bd2f734d172fb176','qskd@mvtwhxg.com',9849144928,'Centene')
,('twdzafuz','ANDY','PAYNE','bfa865024735c468dcf5507a35d3ef93','zxvebicyml@g.edu',4577369275,'Hilton Worldwide Holdings')
,('hkgimjgxlq','JULIE','MULLINS','48b23b4e0ba6f7eae49affddff1eb06a','wc@pmtznwqgvo.org',7829279427,'GameStop')
,('btziwdyzitdrq','PETER','BRYAN','eb36ebbd2a63bf9a345ff5d7ac808a0c','r@pjiovedbmt.edu',4971651982,'Jabil Circuit')
,('spualqdcpumy','ANNA','BROWN','46ba6945b5b33277bf27b3a48f4cc17f','ngvms@h.net',4277617315,'Sherwin-Williams')
,('kghfgyw','DANIELLE','WELCH','17a858ca82c6290d82f87c44a887ed92','vpbdcyi@uwailtvjs.edu',9572654983,'HRG Group')
,('uwymfkzpwx','ROSEMARY','WARD','849ab9f954c9085f500ab10ebe39ee91','aypjlfntbu@zncrb.edu',8232747398,'Corning')
,('lvdwfnav','MARCELLA','REEVES','739a7f527a5417fcd80c503a5833b971','ospdgrhmfv@ecvotm.org',4176974369,'Pfizer')
,('igxryif','EVAN','PAUL','bbf5a97cf82f899741191d2f06a13223','wobidyruka@efi.net',4958191924,'Western Digital')
,('tvlfhxksgjpad','BOBBIE','TYLER','f82e9e8dad01c631e8d07ca62ca8916a','xswjltfb@bmjuczn.edu',2712533721,'TreeHouse Foods')
,('fbdexhvyetlark','ERIKA','CROSS','568bfd3382ecb84d80f21cc5079e1f37','wr@zfeaqunj.com',2315631326,'Mutual of Omaha Insurance')
,('xhrgxjycwtd','FRANCES','FOX','bf4a082c26b254f3eaba12dc707e0368','f@ocf.org',3151592936,'Hertz Global Holdings')
,('tbjzqkyhrg','DOREEN','HOLMES','fba573ed992557045f4ba33b297f9662','wpoqhzbk@dkplh.edu',9847428769,'NGL Energy Partners')
,('mclzepveub','JAMIE','VALDEZ','e0015e1734592bf4baba063528073e0b','jpen@jgca.edu',9731376497,'Ralph Lauren')
,('rlasvbrpjex','LULA','PADILLA','e02d4b3c4bc838c4601d97331e100f56','jdauctbi@g.com',9383844357,'Fluor')
,('jwqgytrjy','NATALIE','MEYER','be84efe8935888fed3642a890e400da7','aeg@jrns.com',8939814872,'Best Buy')
,('xwgdpbewnx','SALVATORE','BASS','6c81a00dc464985a5aef8bce35d6745e','ugaz@of.com',2174682439,'NA')
,('ijqohfkgafmnsz','STACEY','SILVA','d5a330463974a57d859ee694b7c24977','hv@iqoaelpngf.edu',1754681425,'Nvidia')
,('xfudlerworcpyxz','KRISTY','CANNON','674dca79aa3dc45a770cc33d010a7618','i@nfskmj.edu',8655912473,'Colgate-Palmolive')
,('txwurzjfczmdoil','EMILIO','BRADLEY','01340fd9682d6cf3ded85c8ff2dd7994','tblnumcfzj@dsn.edu',2316796754,'Avery Dennison')
,('xaehdgzuwzxaimp','MARIE','MORRISON','5b407573554ba7f24a2f5b60730bc7ed','nrjugv@sxlgtpdfqo.com',6234575381,'Edison International')
,('xlezmkgebd','KATHERINE','FRANK','b46f66e594a89ceb4f20ad44312c1f2e','ovlnrcbqpi@jqydrsahgl.com',2934621462,'Auto-Owners Insurance')
,('ezuftxi','ALLISON','SALAZAR','833a16569d8d580f01f2099f04e541a2','kwabgf@prlzas.com',5187384918,'Markel')
,('gfltwpaqzcpr','STEWART','BARTON','9098c9d0d1cde3958e6432f8c941073e','gvn@pr.net',9179852347,'Gilead Sciences')
,('ksynrilmct','JENNA','HENRY','e397d851e58b1bda6911b1f03233734e','syovwma@asjw.org',1546856315,'American Electric Power')
,('lnmuzxbjvzoi','BRYAN','KING','8b45f876c6ee1fc9e7d01878378fe56a','korqd@tirjhxze.net',9532382534,'DuPont')
,('jagpdxzepflr','GILBERT','BOYD','2f25f338db1cafcfcc2a6bfc63dea639','rcmgv@nekzdis.net',7859819658,'Harris')
,('nbqrefihjxa','HECTOR','HODGES','b85531b00845cfb22ef834044dc59d28','kvdoiq@inblmod.edu',1958437312,'Coca-Cola')
,('ktprjkdiy','COURTNEY','HENDERSON','4a678be13c3d7bff6f9477f9b13f1bc2','yokmjftxvz@ksuqotvhjd.com',1981969146,'Motorola Solutions')
,('tgwsqmawimel','JEANNIE','MENDOZA','45b371721e5a9a85c1361e02055eadb7','cbnjtd@mzoldjs.org',4924383768,'Dr Pepper Snapple Group')
,('lbnawgtiaxclj','BOB','SIMS','71c368cd0f6ea29c348656adcb31100e','sybdm@qdmig.org',4625143527,'HCA Holdings')
,('aomgramjei','LOIS','ALLISON','e72e9b33b12f93a0f686181981572465','ryqempdztx@gfh.net',7182392438,'Dominion Energy')
,('cklbfc','TODD','JENNINGS','b5a54f0ecb0df0b68c5ba7469a101ab0','octz@pbmxkaevnz.net',3819267956,'Albertsons Cos.')
,('ftvzwecznbts','DIANNE','GOODWIN','666890f5e2b27e5b2376f41f2e115585','tnodphs@ayl.org',2963479345,'Expedia')
,('kuvrohtxtpweyi','ROSEMARY','PADILLA','04aa871f7001ba208a042e77eea38fb5','tavfloy@kzesufgbpj.com',1758514539,'Whirlpool')
,('sblhpdubjyklo','ROLANDO','BRADLEY','e770d4e30fab3d3043b032e4df5e48ed','pyiujcrfhz@uoczfpta.org',5439426819,'Michaels Cos.')
,('dqjgtkljao','DANIELLE','VEGA','e95e68bf9084076badc72daabe212ffc','wthk@gfzh.edu',6542477912,'NetApp')
,('olrsvyjepzlb','SHEILA','MUNOZ','abdc0a215963722347e678087c6d20c1','mlftyiek@bqfxnhzoky.edu',1822891283,'Kindred Healthcare')
,('qpjbtqdiac','MABEL','MANN','fe6c3fcf350c971e6aee367607b60b49','wcpqfdnt@lxmtkvoerc.edu',3178632891,'Kraft Heinz')
,('ujyouvwy','BENNY','FLOWERS','da55ffed8d64e53c3f31e64e2dc0ed05','rcqkfnu@dqrehf.edu',9524864275,'DuPont')
,('akiovceab','ELBERT','PETERSON','7c932c7e2fe53cea9f31dfc6c09401e7','scnrj@asc.edu',1272596159,'Air Products & Chemicals')
,('pmicqcwnvkzxj','BLANCA','MONTGOMERY','63f566d5cd8b077560791340f4897cc1','dmfrs@g.net',5924586418,'Windstream Holdings')
,('pkilgvqyxeuo','LUZ','BRIDGES','ce4cae8b95cf89acb23e7cb0465a7cd1','siue@fzpnig.org',1623129481,'Omnicom Group')
,('csetcyh','ESTELLE','ROMERO','1163c9231d34f8e4e79eb3a8a61bd24c','xwknd@wvpkbldts.net',3179655269,'Ecolab')
,('ypnbxeheaunbk','HANNAH','SUMMERS','8de20a20aaa0db26b37a552f995c79f3','qubey@nke.net',8398647821,'Intercontinental Exchange')
,('kqpwwvlkcx','BRANDI','HOLLAND','0f663f6d112759cdb47275e494623adf','sirjcpzxq@vn.com',2964797654,'Nordstrom')
,('ulhxsvt','CARL','CURTIS','164cf0e6cda8b8bfde633650ee742de0','q@nydmrhqkgp.com',4894953794,'DuPont')
,('irpfxjifwkzes','OLIVER','HICKS','9bd400e86a00562d28bd5073a87ed6da','qnko@ol.com',6897868649,'Spirit AeroSystems Holdings')
,('awvbfgpxsv','TASHA','MILES','c78cc9ba524f3555f6e0ce8e3e90cd0c','vphea@cr.org',8259868541,'L Brands')
,('xbiolwkcedg','RAMON','TYLER','ebad52deec81cac6f6ad89932661292e','cw@bzv.org',3671653217,'Danaher')
,('exouqsqwgpeun','NORMA','COLLIER','4ae2f9446683e5ae273dcf7c53e0685d','yebcpvt@mtihslcgd.net',6275647936,'Weyerhaeuser')
,('guxzbqabcmn','OMAR','SIMON','c413b1bec007a493e74669f7f45b1ad9','isdl@pifq.edu',1255465176,'Sherwin-Williams')
,('uvboameufbijpd','VICTORIA','JOHNSTON','c93a5441d640deb3574b14629504e1a3','v@y.edu',5462193714,'AmTrust Financial Services')
,('nzcyhsjtgi','SAMMY','FRAZIER','f313b9e98e916c3083eb4f9a90a19576','yul@bapl.com',2735373812,'Whirlpool')
,('lncufiggdvcplx','AUSTIN','SINGLETON','3ab10a298fc9b75311e401530d153c19','fdikqzu@hvqf.net',4211488415,'Leidos Holdings')
,('fqgyb','KARI','CAMPBELL','66b617437102351430131502c1a19ace','kxlthcmso@eow.net',3947985317,'Oneok')
,('lglkvyaqc','MALCOLM','BOWERS','841d0fcf51ebba76c247bf306b929dd1','fpebw@y.com',5233975136,'CMS Energy')
,('lryaokisf','SAMMY','RODRIGUEZ','cf3e802fde9181f6f64924211b2e141a','vr@qarv.com',1235323571,'Liberty Media')
,('xecvcgpz','FELIPE','MITCHELL','22566c4a1216e21818f9ddbfc1e37d66','um@nvjdzmc.org',6521267154,'Western Refining')
,('mhrvwfavspfbwk','TERRANCE','WEBB','01cb29346f3a0ddf73f283df7931596e','ixycd@mred.org',2186839358,'Spirit AeroSystems Holdings')
,('wkqltoic','OWEN','PEREZ','8145654058221f3fe11004f7b4d7b642','umk@tyxzlanbmp.net',9754277641,'Cigna')
,('dhjnfgpw','AMELIA','BURGESS','8d1a7f158fa3dc3f063a8d45b022bc06','vsqj@xygvzdoqmt.org',6252791764,'Harris')
,('ysnjapuonf','GLEN','MARSH','445f4e9f98c30627c6c0723aff1c713f','skwoyveg@zkacjvbf.net',1351649678,'Reinsurance Group of America')
,('mjzoezjm','PAULINE','OLIVER','3673dfb57585a6077e2ad30f618fc415','c@excbfh.edu',3189171968,'Mattel')
,('yvyawco','JACK','REEVES','c64ab200c5025a33087beb4fcd08a748','eu@ivgl.edu',2985136278,'Devon Energy')
,('etzvrdilfjxm','JOEL','BARNETT','eff6cf80519301d9172d0bd736e99c5f','ledi@o.org',9644174625,'Newell Brands')
,('sgqywqhv','MARY','MANN','ee57206b5d76b85534858fee31a9bbeb','tqjrpgcfm@cqwdg.org',9244514965,'CBRE Group')
,('rbftrl','JASMINE','JENNINGS','be606fdfea07000e627c916c96926e73','micxvenzj@zkb.com',8242763548,'Dominion Energy')
,('aeotxmdba','GAIL','CRAWFORD','3aea6858d1934cef0a20ef2f91701364','mnjpfgl@tnpaimwje.com',6298567261,'KeyCorp')
,('sleutlskqf','FAYE','HUNT','0d6728f0656b076c803a628a685cf1aa','qbuytadmwe@zwtjskyhe.com',5398266754,'BorgWarner')
,('uprsley','GERTRUDE','WONG','43c6ab83a623f54bcd2cbc78e54db8d9','cjorfzsue@jxcuetn.edu',9182641357,'Berry Global Group')
,('crslfbheqyw','NORMAN','PAYNE','ddadbefbbf48c7108f39b7201de1f2bf','lmypwqasgk@kjgzdf.org',9318549618,'FedEx')
,('imbnsdpusyjon','WOODROW','NICHOLS','6d5f10e7edac3333092e120dfa5236b9','xvzfqljoh@h.com',1488952843,'Dominion Energy')
,('ehkjmehvyq','YOLANDA','WILLIAMS','92ced6885c72e6aec2ca2a1958b84b5a','mwc@xijwgebl.com',7147836492,'Arthur J. Gallagher')
,('ysrbklrc','NORA','JENSEN','421a2c93d141416e0e0cb7b1eeda9148','if@hnvceyljp.org',4819137921,'Capital One Financial')
,('huxqkzflpaw','ANGELA','GREENE','dd222ee43d0989ded6733d438b6c9adf','gjdkyhvqlx@ghotrfw.net',4654283219,'Foot Locker')
,('uldvhzycqkrow','LYDIA','LEE','0e5fc7c2578b03c95e459f243ae7c724','zlerygux@zlousc.com',4766947219,'UnitedHealth Group')
,('nudcslbk','ELIAS','GUZMAN','5ba5005f78cce5328a9e15086c0f33dc','l@iket.org',8595763521,'Marathon Petroleum')
,('cripkro','JUANITA','SHAW','f16853edf67acfd654ace5c02590f866','fetgj@oygih.edu',1872844217,'Targa Resources')
,('bgsfsqtzh','CECELIA','WEBER','409098ce5392df88230efc2b6eb324cb','osp@bjskfdgo.net',6311424379,'UnitedHealth Group')
,('uofrqe','SAMUEL','POWERS','952f2190e0695a2ba8e861d5b630966b','gdmruntbo@rsugkqbz.com',9166975274,'Alaska Air Group')
,('obhxijcryshdukm','JULIAN','LAMBERT','90ab649f45c43ba175fac93d3ab8eb4d','updlqag@uv.com',6352672371,'AmerisourceBergen')
,('gklvlqu','BOB','LINDSEY','d9a99d4b93142e626971998cc07ec895','faubgo@gehzk.com',9853959651,'CSX')
,('zkasxxgpkzbfe','DOUG','SANTOS','8394204cc6aa457d96b303487917d078','chnmayk@qkfd.org',6374185936,'Gilead Sciences')
,('pxlbqblvswt','VELMA','FLETCHER','5b8b817b90742ef2f6628c7048202cc0','xuj@ikrqjzbl.com',8458166215,'Deere')
,('ezlsoj','RANDALL','ROBERTS','2018801445d6d9284b3ca9f5e18058eb','ejb@yqu.edu',2762844593,'FedEx')
,('kpumxcwpxalz','CURTIS','JOHNSTON','66ebed2a8eb7f725c9381a1389d06334','liz@efqotjpu.net',8493174358,'Raytheon')
,('bdwujyxmp','DENNIS','PHILLIPS','4b40e25e850f91544c404cbd4cca498e','bolarnt@u.org',7157428742,'First Data')
,('kgbidwvbpcjud','BERTHA','GUERRERO','bc2bf803e915c5bde25c5f9ff4706511','wka@mnsrdcavjg.org',7421755298,'VF')
,('jqdlsnthdxfi','MAMIE','THORNTON','75314142430d696c9f43f1b2a9747bc1','mgnk@qbcpoeslzt.com',9757562483,'Abbott Laboratories')
,('spbqcehy','HAZEL','HART','01e513f7e3cba0fd9135ff7f90e84963','zajkp@jpym.edu',2753791942,'Fiserv')
,('jdtuhwlputm','RENE','GREEN','604ebb6f4e4b4b94b953e0f4ea955efe','awgqxo@aiho.edu',7623686582,'Icahn Enterprises')
,('zggmzo','BESSIE','BAILEY','86e55e830c499ddaaad3f1acdc334ce3','uy@rgeo.com',1525633897,'Western Union')
,('mjsnolaj','MARIO','BOYD','75110e5b6a4481a66345956cc8d62eb0','glxkpyzj@yh.net',5799549745,'Ingredion')
,('jmxhwq','KYLE','RICHARDSON','815ab82e40533a91e5aefc1deb1e9d66','uidtq@jowfevxk.net',1495929172,'Quanta Services')
,('yatoxnmwpcagxuv','TERRI','CAIN','14004d80991e0e4077428340c289ea64','qg@yoxh.org',1238278542,'Baxter International')
,('cdjikpslue','VICTOR','CALDWELL','b7e83323af436d98811f1024daee6fda','x@v.org',1482713567,'Foot Locker')
,('yzwskqujfp','CARY','SUTTON','eb7afdf1271062631a6b9cd72fa1e406','exvonpir@jek.org',2365419586,'Masco')
,('vfscfpulw','BONNIE','TUCKER','40a67e59e1c744608e46eafe5b742842','udnfjmhy@mxne.org',4527532871,'Veritiv')
,('rhxswfejmq','DOLORES','PEREZ','d023437d070b91db03615bd6f1f97ea7','edfru@lmhrgyeods.org',8943952135,'Chevron')
,('kaysvwrshzj','ROBYN','GARZA','c7c56be2746d5c02000c518c27128640','wyuldz@pzdbtgkwe.edu',3841232495,'WellCare Health Plans')
,('itxrbter','DAVID','JENSEN','34637d6d46807d10f49ef058ded5890c','rqhaei@ajlw.com',2644874176,'World Fuel Services')
,('vpqbcykzlpk','ANTONIO','UNDERWOOD','9ab9a1ad96d648b31a0a0357229ae45e','wydzrkfva@iydrxka.org',2397265192,'A-Mark Precious Metals')
,('amqnhtuqnkyav','CHRISTOPHER','DAVIDSON','ae68fb9f5183337d8336158fbc8948db','lfa@qxg.org',5123757459,'Hanesbrands')
,('beqdmiol','MICHEAL','SCHNEIDER','1e0af42d2fe2eb6b1e7ebf62f948c608','rcud@raexij.com',1723275471,'salesforce.com')
,('eoyrsxhiuwrvon','VICTOR','WOODS','b31e23aecd483af92ff59d9aa9bd38d1','mjeqbiwstu@kz.edu',4732359841,'Voya Financial')
,('jfazukay','ANGIE','PAYNE','8464268830ab4385b22b3e54a2f888c4','mwszjnyoht@oneyfds.net',3513546152,'Ascena Retail Group')
,('pdnsgkqt','LAURA','MCGUIRE','fde4747d8076407060e611371672d09f','byruiq@ilh.edu',9174657953,'National Oilwell Varco')
,('twisepkyitq','BOBBIE','COX','8e65c7051d9291195c90297af8067152','kltrycp@bjadsxhio.edu',3597143742,'Alaska Air Group')
,('miwvpbpjqsecg','ERICA','WATSON','24bd177ebbc5872e2562b461a6620672','lfosgyadzw@dyhgn.com',8173878497,'Quanta Services')
,('pqrptzh','VIRGIL','HERRERA','b88a830e32ec6a0b20b49a0de4b0aba1','wb@umfeqakvi.com',3563672317,'Realogy Holdings')
,('ywmcblflqi','CEDRIC','SANTIAGO','ee07e06ed5bf7fa6b14360096492a61d','xbz@kdu.edu',1256348172,'Anixter International')
,('qncbljutdml','AUSTIN','MORAN','5c2bde715ed8533ba4282e8ae0acef9c','gxceakdu@ob.edu',1522439213,'Citizens Financial Group')
,('tqjavxofugzv','LEO','MONTGOMERY','52eea52306621609040e1edd7d7d33bb','dclp@fib.net',8797164386,'Marsh & McLennan')
,('pqrauwnhzl','JOSH','CASTRO','cb797c43ec1b2bcd0497aa33fc06a514','jcdvbw@btmisplo.org',7158645718,'Baker Hughes')
,('qmxdp','SHIRLEY','HAYES','072f90afd82067f6f923a3d65847d907','rzkvp@fugo.org',6231461754,'Discover Financial Services')
,('ktwpxv','PATSY','PENA','661cff3109ab7a88ce9f86da92a50864','bc@z.org',4517621594,'Hilton Worldwide Holdings')
,('dncwcmugrbpe','PEARL','PHILLIPS','652b2acf80dd1b7d0b98e5c6652a8105','eni@oshxbvytp.com',2467641859,'EOG Resources')
,('tlhiyxrvosh','BERNICE','HARDY','a7caf6fb9164d3161932f05a1008e462','vilb@tixyzcn.edu',1491254132,'Genworth Financial')
,('vcinjqktheqd','ALEXIS','JAMES','6ab94c775f7626bbc6426ebf1080d86c','uytvi@bxqw.org',2363929714,'Leidos Holdings')
,('acdgbsh','TANYA','BROOKS','e663a4397e49317086aa598c57923cb9','ijacqmzt@raob.org',1858241675,'Vistra Energy')
,('yphavwthl','MAY','GOODWIN','ea0a57697e456edabeb94f62b4a61531','z@wkqbgdoaf.com',9379712735,'FedEx')
,('uifzblhvzjefg','CANDACE','GRAVES','a92ae8d0e3348dfc82c0fd12013a9e22','gmsuifrlje@fro.org',9543577154,'Jacobs Engineering Group')
,('aryeqvpc','EDWIN','CASTILLO','4013a0b73460bfc2f4f58fd3507012e0','oghp@tmr.com',4371736281,'Builders FirstSource')
,('njjwtlx','VIOLET','DRAKE','d49f8fb6a452141864503d72dd5ac96a','i@ph.com',2395971354,'Danaher')
,('trpebwxy','MABEL','BUCHANAN','d2659387cc8ee052443a3594f1a9545c','u@up.org',2367625397,'Best Buy')
,('vwzrkvsnct','SALVADOR','HENRY','62e81248ae372c8bd5837cddd87a9736','oulks@ac.com',7343979216,'Genuine Parts')
,('cficmovwlx','BEN','PHILLIPS','7e582e8bce0ff1eab8faaad7310ed09f','owxrmucv@tyzukedq.org',4788364356,'Costco')
,('kgznhbxdcp','MARLON','RUIZ','be54e56ffa1d7b544fc2863d0068b3e4','gmb@adtu.net',6344686754,'Chesapeake Energy')
,('iycqpxaukj','DEBBIE','FRANK','b2cfe0e9ccf1294976be40008829e31f','rltb@vgrnzp.org',9422977926,'XPO Logistics')
,('jcoynqowi','EILEEN','LEONARD','d2019b42bc10d44fb1a4ccfaa978c404','ucwpnoger@vzmx.net',6756257631,'Reynolds American')
,('omtzopjm','FRANCIS','BARKER','3b87d26cead441ab26e6d450e5085582','fudlmaxevo@ft.net',2565365694,'Host Hotels & Resorts')
,('sqhegmjfcxgjhps','TERRENCE','JORDAN','07208b9e3c4ed01aed434d2c5935ab54','nfludsrwc@xv.net',1282438326,'Unum Group')
,('vudityoygqcaz','CAMERON','DRAKE','8a2ef69418cbc0fbf7b515057c01aeea','xtuapz@egxzs.net',4653498956,'Core-Mark Holding')
,('ybapdgh','GUILLERMO','FISHER','46576dc13a7fbadbaaf51e4e4e081985','adr@fdur.edu',8761676954,'Celgene')
,('uctkmfhuwx','JON','PEARSON','68e9f23e3c4982dd022cdcb27b2bfc1b','uqsvldwh@ylbpv.com',1622357165,'Applied Materials')
,('cfhjmseunmclzk','NORMA','TOWNSEND','a837589a464797c93680f4b6fe20f958','egnomujq@qskhuyaxvn.net',9533682746,'Applied Materials')
,('tfqvazokiq','RUBEN','GRAHAM','df87854c98a5c17a54e90a77ec108253','gsatj@ambeskv.edu',9138914852,'Edison International')
,('horatw','ARTURO','WAGNER','d34b6bec988a3b3d686a7163f960fd65','ryqz@n.net',7496329374,'Fifth Third Bancorp')
,('ipqntitocqmga','PAT','ROWE','3bfcc9507f4814408527b3207f0976ad','atpmcw@l.edu',7146212491,'United Technologies')
,('icfcskgal','PATTI','GONZALES','7c80d4f6841d8748c8ce03138f7eec83','dpw@kxmcqszf.edu',9561544269,'CHS')
,('aqbjmclmfkzjn','LUCAS','HUBBARD','1ce15b87a1bbb2cca7323f4875a5af66','qflacjt@ljgfws.org',9736217543,'Starbucks')
,('jxqvhfiuont','SAMANTHA','SUMMERS','ccf80f6631a63f668cce07fb2ad5d320','kfrbldziat@dtxpq.org',2812565428,'Exxon Mobil')
,('zeckodbpjev','JANIE','PIERCE','f8c0e9a76d48509ab6b4c8f2f40e6eb3','pdvfmh@tfmbs.org',8943576835,'Ryder System')
,('epodusv','KRISTA','HOLT','57ab0b3b199375d938f4df130ab397d0','teqmiju@prxgzmysa.net',7865719712,'New York Life Insurance')
,('yxktpomkheojq','DEBBIE','LINDSEY','6b03688dceae889a3323ab8f045b37cf','lejucxhsdq@crdpn.edu',6272873956,'ConocoPhillips')
,('jtckxzkucx','KRISTINE','MCBRIDE','a97f9d6c2d42bc3d7b0bd5f6bbbf4793','vq@gdashc.net',3518535789,'Realogy Holdings')
,('onruzcazg','NICOLE','ROBERSON','e0a8c9d31dc4f379ca1d3b60ae30b149','ezjxom@xmq.org',2139357423,'Dollar Tree')
,('jkzlugtrxmhnatu','RONNIE','DAY','6a9ad491fbb9c07953f54a747f09c34c','bzp@vybfmsk.net',1485612897,'Alaska Steel Holding')
,('hpvvqulraw','GERTRUDE','FORD','696b57258b2837b58233605309b67f9c','xchbin@oxrpl.com',1621522361,'PBF Energy')
,('ukifoabmj','BRENT','MORGAN','0fee8a16c847c990cd3aa1e7460c2e8e','aqzl@qpahz.org',8351383165,'Nike')
,('maflpunjo','ALVIN','LEE','4bbeccb7501642bdb47463751f50a0b9','wkimjtx@yjukfbpsc.com',5397123476,'St. Jude Medical')
,('jlhjzelf','HATTIE','FREEMAN','71f1a5b9faa8809cf27feb13f1a21294','lzcusfpq@lpsrfgc.edu',7469512789,'Nucor')
,('dhyvlsdrqz','RENE','DRAKE','5ab95f4e72497a66979fb47232e7148d','tpbcxzyh@bruioh.com',3411399741,'Praxair')
,('udikqrgmhxpv','DAISY','HOLMES','902ba0daedea5de09beb9f37d2dac297','cmveany@kitsfcz.org',3194514921,'Wells Fargo')
,('bjwcdtlmjypfcg','KRISTINE','POOLE','3f7ef84b20b4452358f8b96e0b5727e1','dvixrabg@wxkb.com',8131426157,'Huntington Ingalls Industries')
,('duqavlcdolcujhg','LORENZO','CASTILLO','0f19dca6354bb70a847e238117ab4b9c','cxthwuk@moj.edu',6931651984,'iHeartMedia')
,('gewszejbqtxam','EDWIN','WARREN','690644d1b743c1e76835033ea0364336','jwvr@gjyuidpbek.edu',5425842678,'Kroger')
,('qvknesafhw','AMOS','COBB','2b69afb43216fa9af7c1b68c9293ded2','fknd@ojhw.net',3471899756,'Halliburton')
,('qghbmwi','MARGIE','PHILLIPS','bf9a30c2a978c0c318bb084c49bd3d86','v@dfwtih.org',3271932547,'Jones Financial (Edward Jones)')
,('ywmyhzueto','MEGAN','FRANK','12aae0848ede2c6f54e294b0be792f2f','xewydihq@cozxmaksg.org',2634973197,'Anixter International')
,('yosrgik','CARL','WEAVER','98c12d06b1f3f93afbffeb1028afcda7','devrsio@uqem.net',9415822498,'Freeport-McMoRan')
,('ikseocez','LOWELL','MILES','c26950f160ff707921fbf7557f7f1590','xk@ykngd.edu',1437196587,'Western Digital')
,('fectpjgqtvs','ANGEL','STANLEY','af02de6950606063762b96365b422eff','ywedmv@yphnqdlr.edu',1894731652,'Honeywell International')
,('eytqpofxheywnv','MINNIE','NORTON','b5e86e0c92b22e471be572aab4aa9e77','v@gfjdvscma.edu',1377591732,'Prudential Financial')
,('jolmob','AMOS','WELLS','493a26192cb849b46d5f432a0fd7372d','q@byuld.net',5345921965,'Arthur J. Gallagher')
,('qtnwhkcb','DEBRA','MCGEE','e27ec3c5b93379eba12c53676e245656','kwztnog@mqae.net',8933527458,'JetBlue Airways')
,('zhrxfiu','MAY','ROSE','6a3730768cfa04212a71f31d9155c843','vtiwxzc@eftrji.org',5676823758,'Allstate')
,('ycdpoqxhva','SAM','VAUGHN','46b06e0aba0787733f81eec68d13c2bd','p@gfbisa.net',2568421328,'Assurant')
,('jfirdwjy','JULIUS','MONTGOMERY','ed1eb4d996ff4a688d3cd22e86d95bd4','meionur@s.org',8269738463,'Expeditors International of Washington')
,('guntmaxnczlorb','BEVERLY','MCKINNEY','73cd808a94b1d82c48ff428bb2dd9d7c','rjbqwmcypx@eukgvhaqj.net',4922768174,'Travelers Cos.')
,('kuhgzcfvdau','SYLVIA','PRICE','82d4503d684bcc9b89849ff47366c977','pxc@y.org',4251634869,'Toys "R"� Us')
,('xlawkugb','CARMEN','FULLER','4298ec48a4eaba7241438c0f19c3f681','nma@bwfmt.net',8566916725,'Berkshire Hathaway')
,('xztmsefwbu','KATHERINE','RODRIGUEZ','f78f90fc96b4e045006501f1c6d14c0b','npixg@d.com',4869464319,'Anadarko Petroleum')
,('kqiqbmhoya','NORMAN','TAYLOR','55f906afff85b1d47e1edd97ab6cc345','woftlecr@x.net',8465986953,'Realogy Holdings')
,('enizmtunga','GWENDOLYN','MCCARTHY','1d4b6f2cdaacc390f6ad6986e3df779c','qwa@tuiegnhr.edu',2847141628,'United Continental Holdings')
,('abfosibtf','JO','SCOTT','a5bd0785e822505e0b6ac494218903d7','iqvcesgfau@pxtqfcay.edu',1649154753,'Quest Diagnostics')
,('lteqbv','EILEEN','HERNANDEZ','25c52c863ba8817d0832cd121d4c3ec9','prdimg@eju.edu',5149169153,'AES')
,('vxmdxqwyfa','EDMOND','LYONS','d230b4965d245bd961d09a0a014c9e00','l@zbdenvkr.org',7482498567,'Charter Communications')
,('udakycelfp','MATHEW','BUSH','522451860bce0ea8ab5a67c785cad610','jr@j.edu',4216435843,'Lam Research')
,('fgdkxxkqjgary','NANCY','HOLT','8349b2e0b032c0cb6a6a4dfeec5cca53','mczfyjlwt@wbhrunj.net',6412845492,'IBM')
,('yhpufandek','OLIVE','MONTGOMERY','1de65d94886d84e303ca15507856e06b','hqxtyen@krwtuo.net',5896456497,'United Natural Foods')
,('mxloljcqmg','KRYSTAL','MUNOZ','3305e572c56a47ed39bc370c57972c44','bmhcxqau@zwbcpegl.edu',4353487954,'Quanta Services')
,('saropde','SADIE','FULLER','b027ca17c58e91577ea7255c3de0ca59','uznd@wltoq.org',6589826472,'AbbVie')
,('vhgtnubjgnse','GUADALUPE','FLEMING','46c2b0e748bc213b359942812702562b','zp@ocr.org',9617266583,'Alphabet')
,('mqangivjnigkr','KATHLEEN','HARPER','2d7cb12bb10f6d6296bbac3ff2ec47fc','ycnkh@p.edu',1657138142,'Energy Transfer Equity')
,('griedtybcdeaz','WALLACE','LEONARD','bc8b333b9569c1eeaced9ec3d97693bc','kmg@xsze.edu',7188535619,'Mondelez International')
,('dgmtwnyer','ALBERT','PARSONS','cacd31a9e5c4ea0a0d22f37d2a84217c','dvjwy@irt.com',3169821495,'Hilton Worldwide Holdings')
,('wrfintyew','ANGELO','CHAPMAN','7f341ab46ef052374a67bde5b21edb57','ayqfzckwt@cqfa.net',9688631268,'HRG Group')
,('mjydhi','JAMIE','JENSEN','df6f0f6d1cd41be2436606a83319218f','pyq@sobdclkp.org',6239527642,'Jones Lang LaSalle')
,('lpjsv','ARTURO','DENNIS','e9e89b7e3207a7bd55d61646ced4de0b','jsh@dxkzp.edu',2864128629,'Western & Southern Financial Group')
,('dmsxh','LIONEL','WATERS','4cba49a7adaf5808f5c2a4527ddd2c79','msoeyrzwxf@kjcg.net',5791841892,'Mutual of Omaha Insurance')
,('imuhtpb','JUDITH','HANSON','bd9b850c96f608fdf45db3be65eca030','opqbckg@ifo.com',5693261328,'CST Brands')
,('xqqdzv','DOUG','JACKSON','c08e4d583b7863c7891feba625751a1b','mwhtnlev@jxeg.edu',1543743179,'Republic Services')
,('mjuafhuwekx','JENNY','OWENS','e1c72ffb32a93aa621d6f98cba75abbe','auphyl@alxirdvyk.edu',6197349354,'Thermo Fisher Scientific')
,('vqygrm','ROBIN','FORD','1c1e4f1fd7d718c2165c067d1b6ab056','zuohvfpd@lxj.com',5936258739,'Raymond James Financial')
,('jhxzudvtczl','DARNELL','BARNES','09745d5f7a246529950e4c8b3e31379f','lvasrmt@yfbtrpqx.edu',9565377296,'Abbott Laboratories')
,('dotgredkmi','ROXANNE','BREWER','d9bfe7a1d29379e3fbafe64938782f71','hjxolw@ndc.edu',4522478596,'Bristol-Myers Squibb')
,('meshpzifmlgos','PATRICIA','MILLER','95ac0c75c16c7ac29c0abe2fc94a7036','sowgnc@kucmxzo.net',2191923652,'Vistra Energy')
,('izmbsrhp','LLOYD','SPENCER','fb7a0408513601bf15adb995decbe6bd','gfsea@y.org',3794915671,'Abbott Laboratories')
,('peipsqnofk','KARA','TOWNSEND','5da83b92d9784c13bbe019fa34e0cd08','q@l.com',8455961836,'3M')
,('bczrwuo','JODY','SILVA','2185d005c099a98070009d8739797ab0','dcyikgo@rk.org',3595747483,'American Express')
,('ulitcn','BOB','VEGA','7456dbe30883bf388a7ed20de3561ff2','yidjrfuz@hnlpgxbcat.net',8366427456,'Campbell Soup')
,('hbotjsocmj','MARLENE','SCHNEIDER','df04dc85fcd16a29becfb2c837b2cf82','dnsg@bgtisvr.org',3485397419,'Erie Insurance Group')
,('sfzcwkhurix','NELSON','FLEMING','0d21967fcb063b200bc3988962c87fc6','itydcgmh@vnxruft.net',4359573158,'Harris')
,('khlfykmlvj','MARILYN','PEREZ','3fc514381265c7b8575c53d97960a904','hfalr@eihzvmn.com',8529712948,'Amphenol')
,('ynscbbuzl','COLIN','CASEY','01490a907dcc2dbec6cc4e3b45848c7a','ahblgc@jsupvac.org',6938538243,'Constellation Brands')
,('nefgqpjizrwj','SUSAN','DUNCAN','e39107fec89c2178a9d6c207b08c96d8','tme@cuti.net',2986372583,'Hartford Financial Services Group')
,('nmjqih','LEWIS','CARROLL','d308c323217e631dbf576ff3a85937f4','clvbrifegk@dt.edu',5892688619,'Applied Materials')
,('uzndrheaysc','SANDRA','COHEN','c61f74a8c25b5e6cb2cfde46b3e8c2da','odfrwv@gtleui.net',2493417158,'AbbVie')
,('ahlzifxubzl','BERT','BAILEY','b7d09f62cd8cd6e54ac40af5085bc002','upfyirc@flrhux.com',7629529178,'C.H. Robinson Worldwide')
,('dnjcaukmpvlbrq','ROLANDO','HOGAN','60fd6afb7ba7b3f312029222ce19f837','hgi@wmnrlqe.org',1635386283,'XPO Logistics')
,('adezckfkz','DARIN','MASON','e8773c4d8bc647c45fae4b200f8d9103','whazd@hsq.net',2136183781,'AGCO')
,('ckawombfdhs','ROSEMARIE','COLE','2c3896ad352b136a87ad8e9912f16d06','vnb@sekhfpzol.org',6727346812,'Owens Corning')
,('pzyamwudnoq','MINDY','HUDSON','09a665fc8291c929d5e6aa48a88d8e20','t@uzs.com',2535163612,'C.H. Robinson Worldwide')
,('cpukmjocn','ISRAEL','WOOD','0bccb614c1b04a6c00e903cb9ea28fcd','to@wbxdajrco.net',2165838624,'Nationwide')
,('kichsxjgym','VICKI','RAMOS','a5e217b49a119135f0f41d0389b61dd5','ul@vxyk.com',1246137642,'Rockwell Automation')
,('xlrqogdsuw','JOEY','FLOWERS','5ef16a69c7c15a7c2d11e836b93ea794','f@ecavypz.net',4563583487,'Fidelity National Financial')
,('jvtyfcrcbzyjnwr','CHARLES','STEVENSON','2fb3a1d29ee9d22563869ab4e22802f6','zqimpgkyo@zeqjxrlip.com',2185361597,'Walgreens Boots Alliance')
,('tbvnphrelmpozd','PAULA','NUNEZ','0e8ca68d9e4becab2d5857679ccbb319','nuzgx@mjobl.net',8412836792,'Monsanto')
,('ibewsjbgsjm','LUZ','BRADY','8bdbe0d34553c1015b9b9cdf4a7eb70b','zhegairk@n.edu',8573292834,'Raytheon')
,('ghsacwt','VIVIAN','FRAZIER','07f06079b18051cd2344d71c9e9aaf7a','jalgy@rwhyfaved.com',2761848596,'W.R. Berkley')
,('tsyencmevfjgrs','DIANNE','WELLS','84f0efe0990211ec2b40a6a3d356db7d','kifujsatpq@htdm.com',4875939631,'Liberty Interactive')
,('glkgoqlth','GLORIA','DELGADO','b3957ac7b8a609c1fcf3928bccae644a','xlre@u.org',3818525786,'Time Warner')
,('gjwvxtvzf','MIRIAM','GRANT','38823b2eeeda8b7b0567faa1c6aa181e','snzypm@apdi.org',6728399625,'Bank of New York Mellon')
,('oiszbyxvsp','CALVIN','LOVE','29019a8b053f25d1b7769fd450c2683e','xken@cae.net',2488592946,'Sempra Energy')
,('qporjdmygsctl','BRITTANY','BOONE','eb7fa024fd936aee057344865d85d374','n@ec.edu',5625139562,'Avery Dennison')
,('dabsqunpemhqg','MELBA','ROBERTSON','84a1501b9d247d834323709912c87a97','qkdxgfj@scko.net',5376818531,'McKesson')
,('ajfirptgheao','CLARK','MOORE','e495f0811b3b479e97816566b2d70a46','axqvj@q.net',3425136792,'Tenet Healthcare')
,('znyckpcdzup','GLENN','PEREZ','e024058e3ac69b19210aa4387dd44d23','xdt@gwxveuofa.net',5811746723,'Rite Aid')
,('xmlrkuqrpan','GRETCHEN','MAXWELL','a627da462be4cd733f5851cf3ab035b8','wxuyv@oabtr.edu',5738351327,'CBRE Group')
,('vskeltaukzy','CEDRIC','BARRETT','f8d5490c534cf07b75fea50c40227d06','pndwcgekys@vflog.org',4875835873,'Reliance Steel & Aluminum')
,('qocvftr','GERALD','ZIMMERMAN','7467daa99afff5709a4ca457e1007b10','ovbcyuzg@hiwor.com',3963879736,'CBRE Group')
,('iutczofjqbr','WILLIAM','FOSTER','3d0a84ec2fc2cafc52aaab27ce8dc3fa','kpfvmwt@xcy.edu',4523157491,'Lear')
,('ohwaciducnzdtlv','WM','MITCHELL','6a3749a2405ed5289bc7f8143b6db771','fpwy@ijw.net',6122385219,'Essendant')
,('hkmufzhnpc','JUDITH','WELCH','0ef6f2e8ba74da53012c618e17118f29','rvqg@ytwmnlcfx.edu',6187354876,'Thermo Fisher Scientific')
,('cwfagenaksld','KRISTIE','BROOKS','2223ece4323cc921e7f438750feb1813','jpxquotgk@leasbjx.net',8747412819,'MetLife')
,('puveogifb','HARVEY','PATRICK','4b2055da9c7419a9317538a66c9ffa25','iyd@qonhk.net',4262716584,'Intel')
,('dicrtzyp','MONIQUE','WARNER','01e4d1bd0755f0343ad0c47f2daaf7f9','x@gtlekf.net',1351326731,'Ball')
,('cuswae','SUSIE','REEVES','b6ed2ab30f2598bf74fbe96a17191f04','eqdrfsvaj@qmbiart.org',8747233782,'Micron Technology')
,('tyythflu','RICHARD','CASEY','ab2aac90e7f5c0a788381862c7934d6b','xzoylkw@tpr.edu',5235378594,'A-Mark Precious Metals')
,('ucxeakzbto','DELLA','DUNCAN','2a6b3de52380f6b4fe4d64b110d21668','nk@k.net',9846813524,'First Data')
,('tpgnrqsbnf','RUDY','SIMS','8a884dee98236dba367b6c18f8bd7d47','rvsu@zixjy.edu',1329879354,'Costco')
,('bpjgzhhyz','CONRAD','CARROLL','32b3fc6a0ab687b2758457627a582f81','yxouetg@kvpg.com',4699486257,'U.S. Bancorp')
,('lkvtycojeli','IRVING','BERRY','40ebe350708d9a0c791e702d8cf44c9c','jymptheu@ae.net',2488232178,'McDonald''s')
,('xeuvlkhzvb','ROBIN','ADKINS','c2c8f615b490be284aaee05ff321e417','bngq@bfvxycek.org',4377483865,'Henry Schein')
,('osnuwyqofgct','DIANE','NGUYEN','144825cd134fa83786ade4800c3fb4b2','mzolbpkn@bwanxme.net',6235317436,'ManpowerGroup')
,('qwrvajdpxjcvy','MARC','HAMILTON','7da504832d25087658b0e595040b44d1','wqgf@bswlipnu.net',8946744286,'HRG Group')
,('iofwaurdaeib','ED','ARNOLD','4170911b49277d4a9a870b4fe9f77006','uhfwqyrlv@wjsoyu.org',4633819743,'PVH')
,('qwvowlfnzho','GILBERT','RUSSELL','7d47ee64c23d1ea16be8e5e7e8874300','faqp@vew.org',8654766189,'Genuine Parts')
,('asiwxqburelngzc','ALBERTO','WILSON','9961b5701774d8fc0e35a57bf264b69c','eyxsbrak@ficmhnzr.com',6259635216,'Eversource Energy')
,('lutkqnwf','NA','CHAPMAN','f488c53315ccce939b8f271aeaee3dfe','wutxqfdljs@mjukywz.edu',7489681694,'Liberty Media')
,('vmdwofqtfsk','EMMETT','SCHMIDT','99b0346ddf956e5a9c8750b5a30f304d','mhdazv@eobhmaq.com',1254711764,'Cigna')
,('dyoxjjhl','TOMAS','GRAY','24249c508f3c1de29b0c97b959888e3a','d@ovx.org',1487483168,'Union Pacific')
,('imtxpeatkom','ALICIA','POPE','0a89cb99869ad1e9980abe5026a785b4','sauvlkco@gsentb.org',7516358369,'Albertsons Cos.')
,('uvpocrihgp','ROGELIO','JOHNSTON','568e2bf1e5433a192b58f146bcdc13d0','wghaqkvo@lgbzdwqmx.org',2349327182,'HP')
,('qxmbdquef','MABEL','RIVERA','ad4ff7ca5312a2fd11d5e30c217f74d9','mcz@whzk.org',9587136492,'Hilton Worldwide Holdings')
,('qjtiakhuwqvp','LINDSEY','CHANDLER','75dcf0b48af085365da80e2dee845629','sucqw@uqmn.com',4122636741,'Avery Dennison')
,('ndtkmbfgd','BETHANY','GREER','9390a16df7fc23c1cc9041252d359ee4','dm@qcrnxkeb.com',3786859148,'Whirlpool')
,('dkuqsprqh','TYLER','CUNNINGHAM','59154435b0169d2f85dc7f857354cd81','tgbheulicf@oa.org',8965933178,'Bank of America Corp.')
,('vqlscoj','SYLVIA','CASTILLO','6437889aab398b7c3d7118b6e081b684','apmqcsfj@rwutqjmi.com',2866858263,'Express Scripts Holding')
,('pqoiafvezcpr','CONSTANCE','MCCORMICK','6118bb4e181a00f9647cdbb0ba318f80','pmoiqrvgzx@kvpqblhx.net',4678718723,'Energy Transfer Equity')
,('qzrvycb','FRANKLIN','HUBBARD','e6f36c536d1c4e0a0636d403e0ad0210','zknjyqh@dbiefgwmlt.com',2971425687,'Masco')
,('zvmbgs','BEULAH','HOLLOWAY','94a5aa6528679b8f46604eb562d922bc','gbo@iocj.org',9835372341,'Jones Financial (Edward Jones)')
,('kdjrlyszbxv','FREDDIE','NEWMAN','4c607632914bdbf1c1bc7197192086fb','hvxplqmacg@htlanc.edu',7324358673,'Kelly Services')
,('oszrhty','ANTOINETTE','HANSON','5b2483fd9981c93ca905b7c5adc12f26','jzpk@zalrkymhfe.org',5847614259,'Sherwin-Williams')
,('ucpkqekpda','DOMINGO','WAGNER','d8b2617caa5fb67798a876e23bc311f0','ltzmdk@meprj.edu',4915714187,'Owens-Illinois')
,('smdzgunpydml','EULA','STEWART','40528d29be149cb9447532c85f15b95d','tqudliwk@wicqdhx.edu',7165489164,'Cincinnati Financial')
,('jhizjvbwxh','MAGGIE','SCOTT','39fcd5d6047ffd1e32d6e14c2a08facf','txmkazonl@fojwnastdz.net',3269379248,'Computer Sciences')
,('anjdug','MATTHEW','ANDERSON','5600e4124986d2c688033447716f9fd1','jf@mkzhilgd.com',4653685413,'Estee Lauder')
,('pewrle','GLENDA','RAMSEY','e1088de094160dfd4850f93692ab19a7','npmzd@lmrxb.org',3125898592,'Travelers Cos.')
,('jwaszogzkln','JOHANNA','VALDEZ','f9d7d26c3777e5ebb79840c2edbd0b3c','wtcapksfne@ay.net',8695721645,'Twenty-First Century Fox')
,('dsprieumcro','CALEB','PADILLA','0bb9700edafdfb9a999583482175497c','d@gnc.org',4371467619,'Baxter International')
,('ztrnynbxgyrl','DOROTHY','HILL','6a5cb2fa611141dc1e5bc75a7367b081','qnmd@okva.org',6182647913,'Air Products & Chemicals')
,('iuelnil','WHITNEY','WATKINS','4e94d96ad16ae305d3940cc1b0ca089a','xs@ciapwyfd.net',1328497136,'Estee Lauder')
,('bdwsn','JOSE','BUTLER','dad1dea13ff612b4ce0498a2d1e944d4','gwzuivxrbh@xvikyuhen.net',8618535436,'First American Financial')
,('yajgsgqim','MARCELLA','BARNETT','ee40458838809f722adf5aecef1517d2','kjpo@txfbaq.com',5216978712,'Honeywell International')
,('jlhdpqacz','NATHAN','BALLARD','1f35b1e9c524ff05c7a2f409668a302c','qpvxi@jmolb.org',4729726943,'McDonald''s')
,('fhrdkhu','MARTHA','WALTON','9b20b0e045fb7b6bc1aae5b4a584b021','tsrlwzqy@igobe.net',1246927915,'WESCO International')
,('coglm','MARLON','REYNOLDS','44849c96954e037e97ab8c411cae8ce3','yo@b.org',6896199542,'Allstate')
,('wnzuotqsb','KENNETH','HAYNES','40a37e9f531f102db6fad30271e51e9f','qrnl@qgow.edu',4159153621,'C.H. Robinson Worldwide')
,('gsvmyikkfmcovia','GRACE','HOLT','fed4fdf7a8fdb89dff21e6bc2d4d90fc','ctimfha@kojy.org',5492131976,'Anixter International')
,('moefixh','ADA','YATES','cf16c4bd90062f2883565085d4fa8240','shpwre@bgcnwsm.com',9566891894,'Tesoro')
,('dwgkpfedk','HOMER','CARSON','0d4c38197959ee3f957ab73bb12588a6','sxodwr@cdiowaxghs.net',5141283267,'Dick''s Sporting Goods')
,('atuelgixqtz','HAROLD','MCKINNEY','77e8cadd9cfa6181d662ae89e15bb541','Kansas@ef.org',7657266719,'Synchrony Financial')
,('ptiyumzuspglb','NELSON','SANTIAGO','0bcaa9c3684f335748740dad7ac2ef9b','jrzdhx@Iowa.com',6515716951,'Graybar Electric')
,('aztadgefbpl','TERRELL','MORENO','82563ff30a3a8f487254b4360209fa56','nwsqpvjbzx@kzxoupg.com',7647518942,'Ally Financial')
,('blavtb','TIM','MARTINEZ','80f9839e37d3c4d4bf5a7249b5b74c0d','ykpbvmu@psx.com',3499453496,'Time Warner')
,('rfmjkqez','LEONA','PIERCE','ae1cbe663d5f7572f00ca04077ead7ac','vnkdtqwlh@hzey.org',5988418396,'Philip Morris International')
,('zhuytdpfwym','HORACE','CHAPMAN','080237c8041951c81786f0b922cc2f71','yv@ugvok.edu',9244163186,'Raymond James Financial')
,('igxvfbuhsrt','JODY','ALVAREZ','426ff79279c279014167d7ff76f260b7','b@ayxncpde.org',5467955672,'American Electric Power')
,('vsakmrhab','COREY','SANTOS','22aa2e129b2a608b1c1439f43d9db65e','zuqhpbyl@fwqhrtapgm.org',3744628614,'Alaska Air Group')
,('icoaqem','JOANN','KENNEDY','592df850de3c32ffef5fb416851d6189','ohpitlwu@kwdxl.com',6545974753,'Arrow Electronics')
,('alwfje','HOLLY','BARTON','b4bebc0c6235e9a1e6fdfe255c9832d9','fxh@eiduwpqhoj.net',4724326924,'Enterprise Products Partners')
,('lkwxedbjgqz','MARTHA','BOWMAN','e9ad8a40854099bf7e14ee64597f33d3','fxna@ugdklta.edu',3974159587,'Tesoro')
,('jqtrvfpqilwy','JODY','RAMSEY','f6e334abdb3432b5b1c1e090809158f0','t@ikfyzjmt.net',5324215419,'Simon Property Group')
,('iocxuqkoq','GUADALUPE','GIBSON','65e5c8a433b8e99290914e5b5c0e6657','qjrmhy@jgc.org',2571746489,'eBay')
,('uranxmq','JOSEFINA','SINGLETON','ed81d40741bad46d8ed82ec77095debf','mjeypldh@inhbrtvwop.net',6749141436,'Berkshire Hathaway')
,('vflrxbve','DORIS','HAMMOND','d9e6844efb0716a51d395c4f0ebf5a9a','rjxmh@y.org',2632496793,'Kimberly-Clark')
,('vckefa','CINDY','CHRISTENSEN','634251600d0070f3d2416434b5012d80','wcei@qsvy.com',4392689623,'Jones Financial (Edward Jones)')
,('desigbvfxe','ELSIE','HAMILTON','5eab9689c82201bdd627366763cc1a85','wjtxm@xbnsywpvig.org',9589274968,'Marathon Petroleum')
,('dfgwt','MONIQUE','WADE','2911e325edf0d3e34a676e47f4eab9ef','jyswnz@pfw.com',9277611569,'Newell Brands')
,('xnvjkbtcrl','DOREEN','TURNER','b0632ec8c49cd1ffe8cdd7ebec671995','kwlanxubtd@ybavrqnu.edu',7685913742,'Yum China Holdings')
,('nqcriwxvbo','ANDRE','ALLISON','ac7c6c7fbd2609b5e1604e78788e092d','kxoidbpqgj@qbr.edu',7621671352,'Mattel')
,('ybaertxdvogne','SUE','GRAVES','84bd291881931e20d894bf1644ffa344','nbzhmvi@uwamhzqgko.org',2719541985,'Dollar Tree')
,('muwevpvswbyj','ANGIE','GILBERT','9921c8e075545405d7c628fef82c5df7','zlbms@wo.org',3464819584,'Hewlett Packard Enterprise')
,('yszxtjyvwafs','MANUEL','ARNOLD','91afdae8cadcb6ad347d3db9c52ef5f3','t@hdzkvqb.net',8523243598,'Cigna')
,('jzqaireb','NICHOLAS','BUSH','a06fd55b69f1ec4307e0ac7994f42c82','wthokgm@icaeym.edu',2576823169,'Avis Budget Group')
,('fddxqjo','SUZANNE','CRAWFORD','70360a2b5c9ccfa0d1fb7dfcc47bcf21','gzhr@nfqrw.edu',4587266754,'CBS')
,('buncolxtrmg','BERTHA','HAMPTON','914d7a603a7dea2361dd8e4e6c63eb44','wgtxicvku@qfikh.edu',6722943864,'Lincoln National')
,('hzbqupwhkuzeyp','BERT','BROWN','68f2e24506ce8f347780ad46ad812b24','vyqdmstip@mbxjyh.edu',4176271975,'Mosaic')
,('pcdizqtpilm','RUTH','HOLLOWAY','4e676d5f26168f31b8afb318b5e8b93c','r@usznidtg.net',3124185746,'Marathon Petroleum')
,('jufvzihqycm','KAREN','SIMON','2d12ae35e37a1d4adcd4341488484c3d','brveuqmaxi@a.org',2574739621,'AmTrust Financial Services')
,('owgcjdiek','DANA','DAVIDSON','811aa684c41386b0aac9779f822fe26a','kcd@atpv.edu',6189283864,'Anadarko Petroleum')
,('rqcjyltrnbyuj','CHESTER','RICE','2a4deac620ccdece42ecf9fc4b46210c','i@ufqx.net',7594213154,'Assurant')
,('mdjzfgxnqekm','CHARLENE','WELCH','694b3a47cdc5b3c1443b13f9b0a7fa78','bdrtkse@ahb.net',8429576872,'Kelly Services')
,('qyxjvkcdmqyu','SOPHIA','OSBORNE','4a721dfa7f0edcbb89870ed3c278bb9c','cslbtikfm@rbtefyh.net',7948462547,'Boeing')
,('dsrhxpnvijpm','DONNA','BALL','3eef3c19c278b0c41c2ddb95ce353096','zmbydjrka@slxu.edu',1676323279,'XPO Logistics')
,('bljupywoqj','DARIN','BOYD','46db75d408c65d67bf7e8146a036c117','bvzyki@elxckozgd.com',6354162964,'Genuine Parts')
,('cbdmrvcgn','CHRISTIE','GOODMAN','dff1176d06908b97ae1f54cc142a3586','thjq@frok.com',5832865637,'Jacobs Engineering Group')
,('xkesfodkqu','DENISE','CROSS','ff74a67b9c0f3be6522a128893c6df1c','mexlhvjk@uzncxygs.edu',1293526241,'Microsoft')
,('nwckijy','ISABEL','CASTILLO','a049a735830835aa5f8fe836775d02c2','a@hfkwt.edu',1599177164,'First Data')
,('rispdhwdvfike','CRYSTAL','RILEY','c43f993d5cb66a25aee8762333618d13','tjuidpks@znxtkhqr.net',7358171392,'Computer Sciences')
,('pcyofunmd','HOPE','WOODS','ce8744b10950129fff549da32dcb5fd2','wbnmgjy@lnvgea.net',3985738915,'Huntington Ingalls Industries')
,('ghpvxkmkmzil','RUTH','MURRAY','b8b50e0256666d06e80cd3968c114659','fjhvcm@qacfk.net',9383949267,'Avnet')
,('kehoupgibcztjn','ALFRED','NORTON','1bc9446797040ab2f755448d0d1662fb','hvcyo@gxdpkljm.com',2867984871,'DISH Network')
,('bmcstgvat','MAXINE','SAUNDERS','ddbd7eb7a24b9b62b7ce17642ecd0429','nzlyxhgfrj@uxszp.edu',9782164239,'Devon Energy')
,('fkmkqtvxei','ARNOLD','BELL','e37f65f979fff47ad8caeb4b48c5134e','qkx@emg.edu',4989756281,'Mondelez International')
,('dsvock','TANYA','HICKS','5e50138cad9b656827428c94ff2c9421','gmzsipu@burasfy.com',7958576938,'Mondelez International')
,('nvohauoapf','LANA','HANSEN','1105b007c9a6c3c885c8bc5e85fa42d3','brpinmszo@otcfenrl.net',9586726431,'Calpine')
,('kuprvfczji','WILLIE','ADAMS','6967cffee4d63e66e4c3241818c78127','Arkansas@tjkcvh.net',3675629653,'Tyson Foods')
,('tgffhsyugq','LILA','TAYLOR','f6fab93aa2353ad1edb010b88c24af90','udajbit@czyxgmhajv.edu',5239764862,'Kraft Heinz')
,('zbpsfgdcf','KATHRYN','WEBB','b4cc3d9fd702610de54a6aec3f9eb10e','gfqe@xilsdnvr.edu',2792531683,'Textron')
,('kfpspjz','SHELLEY','FLOWERS','1616f6d3d46ae07bbf3edcfbd23b1faa','bn@rmpofht.edu',3275173856,'Crown Holdings')
,('dtzpekue','GINGER','CORTEZ','1337961d2bf675dc70dc9af7a81c5a4f','ezcv@suij.net',2495915429,'TJX')
,('qsjulwdbjrzk','ERVIN','MOSS','fc9fdf093d354be7a59294ddeba92068','ywpax@stochkzprx.org',8474924152,'Nordstrom')
,('oqzkwhimqvlu','JOHNNIE','WASHINGTON','23477e8aa1128960ddeb51fe3cce5201','wgxcsvqpdm@kzhcqub.org',2514511854,'SunTrust Banks')
,('erthukovwi','ALLAN','LUNA','4e43612c86849b8109ff49c0e939b71d','bhkdrj@gkx.com',4857421394,'ManpowerGroup')
,('midaqfbip','KRISTI','HARRIS','3660457518ef14270f0b81e4aedbbd82','trmfpsbvd@qpgwuo.com',7542947195,'Valero Energy')
,('blwinqzl','JOHN','GEORGE','910ecd15b1d1b04f1ff1ad08c0d4cf22','lbahwgpqo@jvcwmkbsdo.org',7542976974,'CH2M Hill')
,('buizrqyeig','KARL','STEVENS','3d7c36f60eefc3af02610ec3d2cd51a6','iabshogx@cdsql.net',7828534571,'Citigroup')
,('tuxbniuphkdv','VICKY','MCDANIEL','c9b27224e73ebe054cdfb7180a02a6fa','lizkaseqc@fxevdt.net',2942637548,'Quest Diagnostics')
,('fgxafr','NEIL','KING','724c68e15aafcb263d0802c8334cae7e','uxigvnb@yrpcuixnmw.net',6589216852,'Packaging Corp. of America')
,('inczitnm','JEAN','WILKINS','bd46401823ba4de1f988f088f561381a','my@qiclzo.org',6578454385,'VF')
,('tgjcozvocek','SHIRLEY','CHANDLER','de664f4c6ca2ee66175f1b8d5e7ad033','ckjdr@zjaqycsfuw.net',5963798492,'Chesapeake Energy')
,('mpqohcbxi','GLENN','COHEN','0ad0d9319655aaf33e2f51363a91cc55','ze@whj.org',4597328712,'BB&T Corp.')
,('tjudhmmpbftg','WILLIE','JAMES','036db83d5558b3998f8209f2c0642009','l@nefompjdqh.com',1582379751,'J.P. Morgan Chase')
,('eingfkiowvbhr','MARGARET','KING','435a2ea77dd679ae24855f474856f745','l@j.com',1378566184,'Oracle')
,('susbdr','JOSE','BAILEY','a79b65e049e4e8283f96b29460517f18','c@nsazjrkqu.net',9466283876,'Oneok')
,('yixeiqsturh','BERNADETTE','FIGUEROA','b3ddaecf1d1a2a1b16bf2d03691b8cdd','heyt@fn.net',1341685721,'Lam Research')
,('ehxypcakhuw','ALBERTA','FITZGERALD','6a0b39ea1fee07a0aaef3a643e54dd15','orgiv@cfsgixeph.net',3748464671,'Jacobs Engineering Group')
,('ogxvcqjfc','TAYLOR','MOORE','a1a5f65a2ad8ee2aae43cc5539143ef4','s@qwgpnzl.com',2397215429,'Foot Locker')
,('obmeljanrouzqf','ELISA','WADE','af68cdb82aa9a4ec024ee8974fc86817','ih@dztmh.com',3922813586,'AES')
,('ksgic','ALBERT','TATE','3d9100d5c47baf667787aa6867f5eab7','yzxgnrf@oxpc.org',2816526183,'WEC Energy Group')
,('widvaenfk','JASON','CHAMBERS','c0601f0e6a27bf237dab1815811441e3','q@fozjkwbsn.org',5789824915,'Nordstrom')
,('alsmcuvwfs','CEDRIC','MENDEZ','3b2202def04001ca783d29efc151c7d1','hix@nkxzgqo.com',8712388579,'Laboratory Corp. of America')
,('ogfmdovebqf','VERONICA','GROSS','659a7221969d410fec44d255b152099d','bwzjli@dlnotf.org',9562571267,'Hershey')
,('mcjpcza','HARRIET','DOUGLAS','e11c111b3d4f6cfe1a4becf843c39830','poxdw@d.org',6276421296,'CH2M Hill')
,('swmilxtetzixfpa','ELEANOR','OWENS','8f275786991eddca1308fbeff66ae0da','ra@yodhxez.edu',1252763791,'CenturyLink')
,('agfnoi','DELORES','CLARK','5eef31a898ed6dfdd1911374c88f1b55','ih@uwng.com',7536732863,'Voya Financial')
,('avdiqljcl','TRACY','JACOBS','41e66440b307e384444519b9f387dedd','ufo@qbtxh.org',6725144698,'Tesoro')
,('rxuogtfrnptomj','MELBA','BENSON','a65113692c1d0ef4b7f87fd44ed649f7','pazkcx@bwnsry.org',3474972364,'Ross Stores')
,('avncerxhtu','RYAN','LAMBERT','5368eddc80ed93de3e361cd65524f217','uolzkpcq@josdlrxkp.org',7235789257,'Coca-Cola')
,('qdtrinld','IGNACIO','MASSEY','7dd3ce000f298d841ac19742e1322289','qwgularn@agecj.edu',8752483179,'BlackRock')
,('slkumyazmbk','EDMOND','MOSS','97671c3114f0931cfc6462b7f456de60','btkc@aeqrmi.edu',3484173429,'NVR')
,('mnjgstvnus','CHRISTY','EDWARDS','7d5666cb9723ec5fd485696c84e2e824','jpizfwvrc@ynxozkqw.com',8625865247,'Marathon Petroleum')
,('dkmajb','ROSE','BATES','eb7a24cdd90cd07b47cbba5c0c92e0ce','yg@vd.org',1385478362,'Murphy USA')
,('gwpsaqfnlchkey','LUKE','PATTERSON','3c7f8b8026b77f5aeb6dc5938cf999a0','qitsy@emozu.com',3747854329,'Altria Group')
,('chgcedfmz','TAMARA','WARREN','868ef2208c34ecbe00cd191568ef409e','pzemtubh@rbluyi.com',8399164263,'Illinois Tool Works')
,('ejumztj','RANDAL','PALMER','ca96341d0ef82b73615b305b55e9175b','acmjkorieu@zgk.com',5492484817,'Lennar')
,('jacvespfnzltb','JORGE','STEWART','521f882a3ef13b851f947ba99bd36291','fwybvkeodm@ythfim.org',9816352985,'Yahoo')
,('pkhmyotsu','ANDREA','ROBERSON','1efb8f5f19d706043403db57d8e154c1','Tennessee@a.org',3848724617,'Host Hotels & Resorts')
,('azjrbgbhmaznj','DEWEY','KELLER','1e63198df951aa9c1197b7e32b4e37d7','hlg@dxgow.com',8121477632,'American Tower')
,('ynqztn','SANDY','SIMMONS','c26fad621c383fc9e01bad4d826fbd0e','gpdt@hsfb.edu',3623547432,'Dean Foods')
,('pbkcwa','BERNICE','REID','b0e01d4272eb9e334e3c9b90c435a17a','buesqjdw@inc.edu',4622416748,'Aflac')
,('bkdxandeqrbp','JOHNNIE','LOGAN','16857633c11f4983408ee2c077a1fb19','dfahri@fabjy.net',7921566594,'XPO Logistics')
,('itpsmklipuny','MARION','OBRIEN','88d17baf2c592e5dc136de2de7c5de2c','dwenzgtcs@cob.net',1899638473,'Cardinal Health')
,('acolksvogt','JACQUELYN','BAILEY','c9691d9df1f350ed09dfce5ee9f16ba5','ngeu@yrpwk.org',9842757153,'First Data')
,('blavxnamhk','KELVIN','RICHARDSON','32fdac826362d3a90c71de7352734009','qpdhevtix@wqymsuoi.org',4877391359,'Colgate-Palmolive')
,('ljophvscnphbl','VICKIE','STONE','b60077aa6ab367c8a293fb056089b164','uzxo@dwtrmlkx.edu',6272788361,'Omnicom Group')
,('viwajkhrdeugabl','CORA','BOWMAN','7ee351ea4edc62275ce144fa7d2a427d','mdbl@qsx.com',2946148613,'Windstream Holdings')
,('rycdhtplbz','LYDIA','JEFFERSON','881f85b8de8b2d703622b410e0c4fb67','dwgnti@psk.org',7853123291,'State Street Corp.')
,('toerxcvnkozi','LAMAR','CUMMINGS','a07ef3b11ad8e6c9428305ef9253f3e7','xcmvnrdziu@ygomxpcqbw.com',4837565142,'Discovery Communications')
,('igkaurxbepufv','ESSIE','FIGUEROA','db0fa79810bfc9a887eafb77511bce6f','ycowj@jcbsgin.org',2389654389,'Reinsurance Group of America')
,('tjiftkjpyd','SONIA','ROBERTS','6f613101636895a63ffd3cdde680ae6b','baqfsj@mstgbvxal.edu',7867659856,'First American Financial')
,('vjkrotoen','DOUGLAS','GARNER','0057ac0cce49e4d6451b7ded162d192d','zjxlmyf@ws.net',7348163945,'INTL FCStone')
,('lwbjaesqcx','LINDSAY','FOWLER','7b71e69c88272e5eea5774e52fb267df','dyqwo@uzbklqh.org',9512968123,'Philip Morris International')
,('cxvewzbeta','ORA','RILEY','eb91488cbc612ace9b71dbcc29bbf502','lh@ynhtlkv.org',6856784165,'Chesapeake Energy')
,('ombvdco','RANDY','SIMS','49f4061401f7bf65e3b957c6202882b2','Nevada@se.net',1681438957,'Yum China Holdings')
,('lqwxvomuks','SONIA','GREGORY','5e819520f4c45acba40ba107712a2e0e','jtihpbw@cdzgraxiv.com',3585866594,'Thrivent Financial for Lutherans')
,('ioakdaghvy','FLORA','PEARSON','250b55dec6d8da7b1e2047b76cffd707','kdlnmjif@cuy.org',8735766823,'Home Depot')
,('sycwrubovghayu','NICK','JENKINS','7207bf79b0d475a7448505d29d85d3d1','e@bnxadut.edu',9234176431,'Terex')
,('cnlwpqzpifxzur','TODD','EVANS','6e554ae4a186d8fcf647544f198a676b','vlbt@wfyqgla.com',3762473728,'Illinois Tool Works')
,('ehdcofaob','ALFRED','MARSHALL','4b92bb085f83b281004c9df8796006df','lyaqwjt@lhqxmibe.edu',4799526394,'LKQ')
,('hryhqa','SETH','HARPER','04ee6de31034ba7f64c2fd82026da191','w@ljzgrti.net',4268493416,'United Technologies')
,('lyqdetuvby','KIRK','KNIGHT','426f79b126842337a53206394b044511','trchxgom@byouqz.com',9859743518,'Qualcomm')
,('bcjuoz','BENNY','YOUNG','b2a39a388dd05f33b7eb1257fc2e1940','rud@uwdm.com',1582313278,'Veritiv')
,('cxpiarmrpencidv','RANDALL','GARDNER','4b366eb7b3eec5d8ef499f7b2ca8a59d','uqjiecz@pcnuzgoiwm.edu',9274892643,'Prudential Financial')
,('xpwrjzr','ELEANOR','WARNER','9142e6fb64400f588d464430464bb382','zw@iuyw.org',8151931834,'Yum Brands')
,('vzndifrqt','FANNIE','FOX','c1ed9955bd3bf99c97d8860664245e6a','isucxr@zrphndkmj.net',3752857869,'Harley-Davidson')
,('iszkqhxo','PAULETTE','COHEN','b357df4d5a89ab90f76779876b432224','s@jqc.org',8268974589,'General Mills')
,('khudhpyq','GEOFFREY','GILL','a776f00387e49334364fc1aa6f7f7095','rpkscuzoq@hsqd.org',7696851842,'Tech Data')
,('hvjdimuwar','KELLY','HUNT','310d3e7a0437b04fa87adead6d891195','tgkqd@mudtv.edu',6398956724,'Casey''s General Stores')
,('omazigok','DELBERT','COLON','5c6b62acb0258b635a97c227acf58d37','jf@w.net',8931965769,'Amgen')
,('pkcbgzh','LISA','MULLINS','5661f69a3912253fd6339fc176a5a0a9','l@threoyskm.edu',9383174915,'Kimberly-Clark')
,('frmslnviuqlej','YVONNE','LOGAN','4747da0819f482e354a3575b7b0ab077','f@ildjyxe.net',2879464693,'Erie Insurance Group')
,('olmlyfz','DOROTHY','MOORE','afbb0a6a61677f79c9e9da1fbf0b66e3','grymcsio@rzeyus.edu',4912439148,'Fidelity National Information Services')
,('ksfbtmqxtn','MOLLY','WONG','8b0562c0c92fba65a9c738c8b86feff8','qmshb@omqezlkc.edu',5375873786,'Exelon')
,('oncrgwiuzdq','TINA','FLETCHER','341e1978c1cf3ba1f4a51e9d86e24a18','s@q.org',3643456814,'State Street Corp.')
,('qykrmsvbh','PATRICK','PATTERSON','a36287790abfdcc4a4aaa3002fb9c0b0','zvwyoe@zjtfvwrhox.net',1389619235,'Arconic')
,('fsztiraskvcdt','SOPHIE','CUNNINGHAM','01ff7448be9eef2e999fd11f8b7ee894','bmdwxak@sgukai.net',7545876458,'NCR')
,('kzuobkqfzpv','BRIAN','BARKER','12f57c10494ea6992ff78dcfdd3442b0','qp@pw.edu',7182677461,'Icahn Enterprises')
,('izegtyj','GUSTAVO','ROBERSON','7894d3aa08097aa0fc00750102c88c63','vf@rohgk.edu',7626196354,'Auto-Owners Insurance')
,('hyxsaqctvbso','MARSHALL','HARRISON','97aea25a54aaaba8c13d72a849f8ab57','snh@tajvlgsrid.edu',5678142694,'Genuine Parts')
,('qkatxgmslebgnw','NELLIE','SANDERS','1207a05602a6ef86a2337a52fb2cac00','hqydcwp@fltv.org',8264765921,'Nvidia')
,('hmbnixhrtjodyv','MALCOLM','HILL','a903332027fd6c3b1c724d5ef01f37c9','drncx@vezotyx.org',5245728943,'Toys "R"� Us')
,('hecmhi','LYNDA','RICHARDS','739dad47ac697cf0cd066f5e6d43fa25','dyajmvkqi@uztwa.com',2173198453,'Symantec')
,('qujtsg','EVERETT','MORALES','79b2f1d3511ac0a865c241855a41179d','wbnxcm@bkadpuw.net',9184214623,'Colgate-Palmolive')
,('ypioxtmuhcf','HOLLY','CRAWFORD','b6a69a5cec2fc85efbd469bef45b06bd','qh@cwjm.net',4867241957,'Symantec')
,('fgvwqxyxswaqfg','SHIRLEY','CLARKE','7870fb352f45427e435bd5fbee007b1a','wdnv@hfiaowupj.edu',7591677128,'CMS Energy')
,('xugro','WILBUR','BRADLEY','852d8a9fc47933cd6d50cfaf99ee80fc','fazkytbvpc@a.edu',5927959153,'Big Lots')
,('gpasjrpxo','KATE','EVANS','b7d4626a790f3ca9618983aa26116359','a@ivpgx.com',2433254917,'WellCare Health Plans')
,('otirainxvbq','DANNY','RAY','82c74f5a8c384c8acbc5d373befda8c6','svuct@tb.edu',4597267654,'Calpine')
,('htsusxdnqia','STACEY','HAYNES','ba7a7603d22ad1e9f0aec43e202890cf','gt@eix.org',2458972486,'XPO Logistics')
,('grpmtlefugzbcq','KAREN','CRUZ','12849011ace062896580a6166c4d268b','zbvgrqyxdc@wmkdyfx.net',6821722745,'Freddie Mac')
,('wrihp','BEULAH','NORMAN','f523cd4e22abe74bdbb62f5aba5a10e6','qcj@vpcenhuk.net',8762599186,'Bank of New York Mellon')
,('cyhaefgzxltpn','CLAY','MCBRIDE','a3981c4e1609ff1f8c7e1f53df31cc68','kjanhzt@znwijufmgt.edu',5292796271,'Genesis Healthcare')
,('qvpaxwvqn','TOMAS','PEARSON','70dc4baa81aadab76de4965df4f77329','dcawjlfek@cqrysixhek.com',6257838361,'Verizon')
,('inphxp','PERRY','HARRISON','749d3b54ef2477b5c5b8e3400a643d45','paolhqns@fdguvisbhe.edu',3163584715,'CH2M Hill')
,('fijrlodij','TRACEY','HAMILTON','d2027224ee302ee7aaea89fcdc3d16e2','erwodp@wnorltmqfg.com',8491978237,'Gap')
,('nseszt','BRAD','FLETCHER','b33457a2a82c349a47ca357129647e39','Louisiana@hx.com',5283679156,'Arthur J. Gallagher')
,('jhydmsqkusd','COLLEEN','FITZGERALD','55c5f432ad4ce285e795016c82181552','etkid@vmxpdboc.edu',2697583971,'Halliburton')
,('plhemxqo','SUZANNE','DENNIS','2c89872cdd6e229118305e99d2292257','cafvrlyx@gm.com',5898377826,'Applied Materials')
,('vdkmpw','FLORA','KING','11b033fe7838e20be06a88e2f69d213c','unvl@zrqgikwsvd.com',5768469217,'Symantec')
,('xzqdrsfgcq','LISA','MACK','b5674cbe4014bda6886d0a2efff026ac','czwidg@angtsiqwxv.net',1755821865,'Procter & Gamble')
,('dbkgnjlo','KRISTINA','BLAKE','e5e406b766c021798f08b10b5521edae','oiyfgk@rb.edu',7946254571,'Sonic Automotive')
,('jrwusnowk','ANTONIO','GREER','f1201e99648bdab311701dea6d1d6192','tvzpyqxfk@npevgiz.edu',8274938796,'Land O''Lakes')
,('ihxlqrmagubxc','ERIC','EVANS','95a822cb1ad5cd4fddef6893d2c5e1a8','upgdliz@swhzanyli.com',2459353946,'United Rentals')
,('cwadtnjkq','ANITA','BARRETT','2f0809746d8dd21a911b7e60794cf3a7','ogbdx@afvirto.edu',3798699547,'Peter Kiewit')
,('bcdeoaqs','EARL','SCOTT','09f9a08a045f13c9b15aec32c4da6063','jcydqfr@h.net',7485738635,'U.S. Bancorp')
,('kqceklh','ALISON','GOMEZ','048135b5216d3c09a71ff213c8e1c39e','jez@zjt.edu',5931935623,'Dana')
,('ftyiaesgf','CHRIS','MATTHEWS','a86a7262a9088b49ae79f45e9f11c2ca','fjro@ifgzdlxyno.com',3181238546,'State Farm Insurance Cos.')
,('hvvfloj','JANE','BARNES','e169f55a538faf124462096f549210a9','jzcvxtorui@wk.net',6397399427,'Ameriprise Financial')
,('xhyheq','LEAH','RODGERS','112d741375777b65f2c47005ca3da145','spdqtkguin@f.org',1293819651,'Marsh & McLennan')
,('ditfaudyiqsm','CALVIN','GREEN','c985127d1e4e291958c971ef51f54401','ynbclie@nomispljvh.edu',2363978237,'Stryker')
,('yzvoct','OPAL','BOWERS','42d71ab922f13353ba1ff01aff48b175','hfipamrqwj@m.org',5677456359,'NVR')
,('gdcny','AUDREY','ROBINSON','48b92a20d434c5473fbf6b98fe1da6c9','zljqdp@m.com',7395417391,'Northrop Grumman')
,('fimvtmkyu','CARMEN','TYLER','6b6f202586ae6b40dca45ece960e69dd','kevzbf@ymrgklfcqd.edu',7548769412,'Quanta Services')
,('oekzkob','CLYDE','CAMPBELL','095c5cf81d6cbfe543ecfa490d825aba','hirtz@g.org',5781263491,'Apple')
,('qkmynzaruvo','DONNA','WELCH','2f5930c6e3d0f56dea7ed19a6a4752e6','ywqtbhpe@nb.com',1354782817,'Oracle')
,('hqpmklgdsf','JAY','GARDNER','713c3742d93e6f493d9f0904236714aa','njracqmuo@dimquwstl.edu',6972899674,'Group 1 Automotive')
,('ezswtvif','ROBERTA','GEORGE','3bf04aa0297ca3f5f2b24af792418eee','vglbnrjm@pzslxy.com',3948794386,'Cisco Systems')
,('ngctkgjqd','TONYA','GARNER','fbdd137683d9a7328eb4b2dc9f1be15b','sfnigupk@qu.edu',8133596573,'Sanmina')
,('ekolibo','FRANCIS','TOWNSEND','fc273a61c6646066959a0fd2a6853f7a','ujb@ncoyi.org',1739213864,'Veritiv')
,('lyhnurkpzl','DEBORAH','SALAZAR','58100294037825c4b4aaca2a31e44f50','fowqxacv@cekvap.org',7384362654,'Genuine Parts')
,('yuuodpsmev','JACKIE','GUTIERREZ','ceef2e0878baf9d46974b334236b17e2','iufb@zsedu.edu',8611768325,'Dollar General')
,('xaglctoj','MELODY','SHELTON','b2a80e7e147f2d360931813290242276','invja@jfzgy.org',1867912637,'Oneok')
,('dgatemraklh','AMOS','AGUILAR','6289cb082b231a4d74fec410860b8dd5','kjatfrd@vihdytw.net',9641789256,'Dominion Energy')
,('tlpojvszd','RANDALL','COOPER','748abcf5b699db508f32e842b2600960','fceysavr@urpfqn.org',4256154352,'Mastercard')
,('lcurvukyzq','RON','SALAZAR','40898c172b70ad0830d37782cad5de12','tjrfl@hjlydatswp.edu',5169469125,'Marathon Petroleum')
,('takympzgcf','PATTY','MENDEZ','b7ba5619244485516312d5c88924b089','tcupk@cueft.org',4633785326,'American Tower')
,('utgbwvdgsa','JANE','YATES','bcbf3ab7b564806729af8cac1197a6b5','qkfu@fuoxa.org',7856313915,'Packaging Corp. of America')
,('tsgirda','DARRYL','CASTILLO','6d0c33f646eecf3a27bc276ec745f7a3','Delaware@gkycxbq.org',5325628296,'Energy Transfer Equity')
,('bpxmoieprog','GUADALUPE','WARREN','9f9df4373eb5cf01db1f53bcfa257f18','sqiogpbn@pxwubvz.edu',5973179576,'Western Digital')
,('zksgrkohazx','CARRIE','ADAMS','75a7fc2c4ad243a12040a810859dc881','pymafiowz@rwbk.edu',9846373729,'Loews')
,('fcnsvbemcq','DARNELL','MORGAN','48b770386182646704034eed333cab3e','leyh@jzryvmn.net',6287422945,'KeyCorp')
,('wgzibrylnwxig','EDUARDO','STRICKLAND','b8ac2067197bb690dfd08e74b011f45e','exy@mvsgu.net',9236259532,'NCR')
,('kvnlxqyg','LORENZO','SCOTT','feb470f9c9404283fe985c1757871bcb','xq@yrfjmdc.net',5824571527,'Massachusetts Mutual Life Insurance')
,('ntrbfdbyklt','CHARLOTTE','GUERRERO','1b38475c6c8f5afb539f3ddfdabca753','yjhglwo@ucbmwxge.edu',4387894159,'FirstEnergy')
,('uqmkwgveanj','ALLEN','BARKER','0dbe30cd4d2f039c722153017b9bda50','dc@a.edu',4715437326,'CBS')
,('uxylbeopk','EDWIN','LOGAN','bd9a0ae3baae6a68e807cf3402683463','pvcgrhdxqi@xvcybrfqdj.com',2581366321,'Microsoft')
,('vcmduazc','LEE','GONZALEZ','60890fdfd90340d444ae791ad42b71ee','f@fukj.net',8253748231,'Big Lots')
,('khtxwbnthn','BROOKE','WILKINS','5c2ce41ed00aaf70c7073554ceb598ff','pgmfz@hnvarduy.net',6942356941,'McDonald''s')
,('fjnqpidawegn','DIXIE','WILSON','89fc42e126885f8233f280e2152d3622','yuqvjdik@awevldofx.org',8242936748,'Packaging Corp. of America')
,('pofrzpjvoa','RUDOLPH','WEBSTER','e953ee4d0965a591eb93186214833d5c','fmdpklvic@ytefxi.net',4761937832,'Cisco Systems')
,('eboobtwyie','EDMUND','ADAMS','a977a8da69981a7f8449712ede93ce26','c@i.org',9145132538,'Lam Research')
,('uwgvalpnsa','KIM','FLOYD','02a9184679d76023d7629fe5c4e507e1','timnl@pzmbkqinj.org',9536533956,'Praxair')
,('tgecaji','EILEEN','CHANDLER','c5f91c36b032e3abadec3ce3aa1fa8a5','rain@wqbfyehs.net',1345645827,'Altria Group')
,('vepfwobts','DEBRA','PIERCE','3ec3a09fccdda2bf9426c76a51f35a2b','athi@hnbqirwfxa.edu',1561381298,'VF')
,('uqowfkshwo','ADA','AUSTIN','3b9248395fa000c23a08c76f4983e8cb','dqklzfhyiw@nxgfqljtzs.com',8346453165,'Northwestern Mutual')
,('glmygufei','LOREN','WATERS','2174a3156974ff83fa3b39433dec683a','xhvkf@ehcm.org',9134978625,'United Rentals')
,('ifsceqmzya','GAIL','ELLIOTT','2231b36cd896b39ea1f7fff3a4be3402','dnyapv@u.net',6121455839,'AutoZone')
,('yxzrmjtgmc','INEZ','SANTOS','6e6cf686c24c2ab35ef3efa9c52601ef','wjq@vy.edu',1297682498,'Ingredion')
,('qksyhezuizh','KATE','WADE','45aeb54998b79f188bcb55fcf0abbfff','xiukaczh@jefsdigm.edu',1788299457,'Costco')
,('xhpkrzv','VAN','DAY','3e4352fa67f63d16820422967866dc87','nhz@wusqoahljn.edu',1982711257,'Paccar')
,('givhuotqzi','CHELSEA','DIAZ','7ed60decf3bdad2ebe32cf22d3610b7d','jyqguanevs@lbihcvwj.edu',2133262987,'CenterPoint Energy')
,('fmaetrjdcuk','GARRETT','PERKINS','fcdc82062c63da002b59e2bb8d1c6ea6','nweyxap@dgesui.com',5819164958,'Patterson')
,('ozxkklrycspz','PHYLLIS','SHAW','e1c33fd7bc0e4ce033b0b0b9ebde90eb','teo@g.net',5391746594,'Danaher')
,('ywxebmiwczdu','DONALD','SINGLETON','0cd65c187c513fca7595a23167b9a31f','bnmie@tgsmyvna.net',3915131475,'UGI')
,('coktznqmufpxe','OSCAR','LEWIS','e7bc8fce04123f7f5d56f7b389bee3c8','kdobn@lyegpd.org',2841857821,'Boeing')
,('bnpumvxpgwnduha','ARTURO','GARCIA','bb01d02269787af3ac53d15c2450edbc','isc@fjqlkx.net',3426822468,'O''Reilly Automotive')
,('foqallrongct','BARRY','TATE','8addd906c31e46b19869f671c560f5a8','ptr@skxliotr.org',2786184526,'Essendant')
,('tfimusnlpk','TERRY','HARDY','336bd8534ca48263ebb3742d3d850168','b@tmsdirvgf.org',6322415763,'Tyson Foods')
,('wjohkmayw','KRISTI','HART','d92723338d597020187276d1331840c0','xcsm@isulvw.edu',3626544721,'Freddie Mac')
,('gztomhtjuvrm','RANDY','TURNER','7cfddee8c19d96a621e091b8d10db74e','helsd@drtqjges.net',6396421682,'PNC Financial Services Group')
,('dcqnjxzgies','HUBERT','WEBB','0dd0fc8001d667d2af15c2644cf0425b','xwnfji@qmjdnybeps.org',9652141843,'Northwestern Mutual')
,('tokesmuvbr','DARIN','FULLER','744c3bb8450ce08411a4a86877a2dd7c','ys@mbpirls.edu',7629423279,'Eastman Chemical')
,('hjgawcxbe','TIM','DOYLE','a532347900e4aedc3b9d0eed6c6a993b','veupthd@swzr.com',8927968573,'Las Vegas Sands')
,('sjleosy','MAE','RYAN','595b82b602124a0c68ba735e1d5b0e23','px@eglrtkv.edu',4235494198,'Autoliv')
,('zycdedphk','JORDAN','LITTLE','7f619313b2cffc4d3e24c2b2306787c4','fqgmd@p.net',3574322649,'Lockheed Martin')
,('plxsnxepszq','ALEXANDRA','GOODMAN','02c44f206d3d62bb163cb192d1957ac7','xr@wk.com',7563759827,'Merck')
,('pdkfecwzvhd','GUADALUPE','HODGES','7230b897a7c9254356ea82214f96ed93','wmbigkv@dcq.com',2511438957,'SpartanNash')
,('wbhqtdzv','EVELYN','MORALES','8228290ee9f80b1a62037f728867905f','z@ejzctk.org',1835687958,'CenterPoint Energy')
,('pgeoaxpve','BRETT','HALE','eefcc084b49ad5a222ee0f4076f6e0a4','k@iumahd.com',7462977346,'Jones Financial (Edward Jones)')
,('namhblqujva','JAMIE','JENKINS','a5194a37fcba4e3e598e24100136da19','iz@ryv.net',9611761824,'Exxon Mobil')
,('txxdh','ARLENE','PENA','2a9a200ad8cd5222e896dc9fd4502246','g@upzrhx.edu',9375685241,'Procter & Gamble')
,('nsogmzfq','LISA','DELGADO','2513789113f740f236b8e157ee07e73c','rnukmvsa@cislkbn.com',9638419876,'Verizon')
,('wmyknopqjft','DUANE','RICHARDSON','ce98f5b4a6fdf448d0c00a4f2322ceb9','qh@mafnu.edu',4519361573,'Live Nation Entertainment')
,('ipzcnmbgjcvxy','JULIUS','RIVERA','f0092704951efde28de1681b87277d20','kguopem@hdmuqek.org',5646347618,'Ecolab')
,('axzguecztxfv','BILLIE','KLEIN','7b9ec5249c4c61cac6467ba4a0b5cde8','zt@z.org',8232589172,'TravelCenters of America')
,('ypvvwhl','SABRINA','MULLINS','2e69ce141e87e175dc98fc8fcbd42cc9','dm@xwbsv.org',8323492346,'Ameren')
,('jgxfezdq','ORLANDO','RODGERS','557268f72053c4182741e38a021074dc','yu@eapis.org',1987342641,'Dr Pepper Snapple Group')
,('plghj','MATTIE','JAMES','92692fcfe013631cc57c69af75b827af','huv@bf.net',6743161598,'WellCare Health Plans')
,('reubaoew','JULIAN','MORTON','2012ec378434e47361e694aee5bd7dd4','dvjenf@ndspyzf.net',1249813452,'Oneok')
,('voziyrnixch','DARRIN','ALLEN','b7d37cdfbec326f2122a2e885d06cce9','gzsta@z.edu',2131841568,'Harley-Davidson')
,('sxuicadwsx','STANLEY','MACK','5888e0c38995a91c04f235acf0e35b68','upzg@enl.org',9311397631,'Owens & Minor')
,('upaelcsdoi','JOHNNY','CARSON','f01a7e0ea2b947f0989b2f9d99183ab8','iebqlmndjk@zjqondiavr.net',4672133471,'NCR')
,('ltneigzbhr','IRMA','STEVENS','0958f477c4f0026da8f50ed37b84a9ca','wkchnip@xwkmyj.net',7542567418,'HollyFrontier')
,('jkvjeg','SALVADOR','PRATT','cf0f08e925f49e952bede494f06a5f65','oarjvkq@zljprsk.com',5231821756,'Arrow Electronics')
,('cgkzqhndftiwm','SALLY','HORTON','1f564c4c3864f1459683c793248e09f1','j@bhjnw.org',8359389368,'Celanese')
,('rkwgbotiml','CATHY','HUBBARD','2d2945e66e3dd913ffcaac7006958308','zbfvwjx@shgbnjofaz.com',5876916134,'Emerson Electric')
,('zuxgdstu','ASHLEY','COPELAND','fb0bcb4f473a3d90284f3b9209018ddf','po@xwszdlhcqy.org',3894292395,'Office Depot')
,('xyejbhbmikfe','FELIPE','HOLMES','29e3867d5c5f637160c61e0537c1f7de','hcnr@icw.com',9353292491,'HRG Group')
,('qfcbidokpwmsxi','PRESTON','WAGNER','01fac0745358da132336c83ee2ac4f4d','sgmqbd@tzxikpeqm.org',2373267163,'Public Service Enterprise Group')
,('cxpfugisj','HEATHER','CONNER','457fa1e1791777db32f18b9733ee2d3b','enmvyid@xncvudreqi.net',1486342795,'WESCO International')
,('dmhkwbafpcmgds','SHELIA','HINES','4d7138672bc537b7b252e798cc4d55fa','ba@pdzymkojlb.com',7159326172,'Visa')
,('rpqmgxozv','KARI','BARNES','81e1c1013f97405a6496c4b1e2e71287','d@bacjozmtr.org',5279132793,'Mosaic')
,('syjmngkzechax','ALICIA','BOYD','e27653c812cbbab841ef27c5b27c834c','gwx@kvgeznd.edu',9836459846,'Booz Allen Hamilton Holding')
,('lmqhzwawdjtqmax','ELAINE','FOSTER','c6517b9caf4da7a40d804e4015bb1250','udlb@oza.org',3695643279,'C.H. Robinson Worldwide')
,('ksiencqhtgdr','BENNIE','HOLMES','86d4184aef1ab84287fcc3dd847a1220','yzfp@wueyomqt.org',9318544513,'Parker-Hannifin')
,('vgyrw','INEZ','CARROLL','92e9d4da94a65a676248e0888a28369f','fijnbu@xmks.edu',8963174967,'Jabil Circuit')
,('mwngtjvtafmgr','ERNESTINE','WATERS','316bd6db1e40287d724b6e4cf4e1cceb','wizyqh@tmjfh.net',7932766137,'Cummins')
,('nwfsotryanvd','JAMIE','OBRIEN','feb1712e39fc7c89fb08348d45def9d1','rxwojz@xji.com',7925237839,'Kimberly-Clark')
,('yhztvaimklqgtd','FREDERICK','BALLARD','fd86ee91c111e2644de1104687410497','glhv@dhturanj.com',6132353275,'HRG Group')
,('myfxbtvno','SEAN','BANKS','74125a7e2604bc11accd22557584ba19','pvnw@udohe.org',3974313269,'W.R. Berkley')
,('tbixbomf','AMOS','WILKINS','70e73bbb6c2d4f1b35b388aef202ab4a','fprkb@bjtnruoza.org',5916846941,'AIG')
,('yfaegdeuy','MARION','TAYLOR','8ea0f73d61e24f0980d2c6ff60e20893','fyjbp@evsf.com',4894693921,'Quintiles IMS Holdings')
,('shmtexf','RONNIE','MARSH','55cbd1d1375e33f187c179f20a03198f','szlyci@ewlytonsj.com',6745727536,'Western & Southern Financial Group')
,('qtwzhlim','MARIAN','WALLACE','9d525db089da5a7324fce9b1529884cc','ezqs@ivj.org',1722156325,'Yum China Holdings')
,('rcwhfkdymxunz','KAYLA','MALONE','a5750916353a7623879a5567a000ee89','ujdrzeoxcw@nfaclspew.org',5173274591,'Booz Allen Hamilton Holding')
,('zwjyfhdbijf','ALEXANDER','STEVENSON','8547403f7e000579a479cc34d8a40232','rjkidh@jlczebpf.com',3919154589,'Hershey')
,('tsbwaqail','IRA','HAMMOND','9c520d8d71011f54c646624299109401','qenybhcui@yel.com',9516541625,'CHS')
,('zydrupljv','HANNAH','SULLIVAN','3195c649ea07e61ea84d53aa89ab2d36','iklxeqwrf@qcdznjk.org',8979481385,'Visa')
,('uizdlgsof','MELBA','ELLIOTT','e972997788ec1e81d65d38054b4ee372','zymhvnscgd@hxvorsg.net',5492144597,'AmerisourceBergen')
,('axoergvvheaik','STELLA','MARTIN','21ea8c33539b20e5f5a59b69f5fc340e','rpheyl@mtgubizjwf.net',2937393751,'Qualcomm')
,('arctirdlv','KEN','BARKER','ee19111fca1f9e8c340098a4c12acda4','kpoftq@vzcxilntuq.net',9186179254,'3M')
,('xukajozrlixhoj','EVERETT','MCCARTHY','623f6c77a2ebc978563906c547995084','ljycpswd@vls.edu',4922184791,'CST Brands')
,('lawjyvozopykud','DAVE','JENKINS','cfcc51241540234cadb3e3f74ec77964','b@druwegk.net',4957359218,'NextEra Energy')
,('hkvjtqrfvsz','TAMI','WATSON','51add0e22c8b6ba0b9f3489d3d45b3c2','lesdahq@vxmbhkn.com',1493457495,'Boeing')
,('cdxmfpwbxys','SHELIA','PHILLIPS','40e5ee0414f792e2c561e45dc3a5ee65','vpe@wfck.com',3614921925,'Burlington Stores')
,('godmcoun','ROBERTA','FORD','19d3de478ec186b0455610f4ff35a3c5','tovhbmiqyp@sewf.org',5495247961,'Oshkosh')
,('qwhvihlvof','SUZANNE','GARDNER','b8a9aaee8e486611c495aa32705cf573','xapgwyc@rvmfnwpbki.org',7144157416,'Allstate')
,('zdftlfpeczk','MARCIA','FLOYD','3e0babc4eba8a153d1a2aad8043b0b7f','caopynvwx@cghadtwybj.org',3813142753,'Supervalu')
,('lsbzupelsw','GERARD','HUNT','c43cbe8bb85b91eae792424a136dc7c1','vzg@viu.com',4353698567,'LKQ')
,('knvbdhvnfmz','CLYDE','ROGERS','9f8682c347446a642019b677ea536d85','lqxdykjasz@Wyoming.net',5978393847,'Office Depot')
,('ehvytmle','MYRON','DANIELS','76ed1727966847aa2b4390bb5cf8ae40','yigmbt@abxhwins.net',4732386397,'Xcel Energy')
,('ysluhcehjrpq','TRACY','CHAPMAN','f78a948d0fea63b95d152e2c75991289','fcrqotmnp@xv.net',2635144851,'Union Pacific')
,('nfwrogmwot','JEAN','HARPER','0afc143d287a01477572bbbc16cbfe30','txl@rbqaw.net',2756917152,'Auto-Owners Insurance')
,('gsprudshcqeiml','RUFUS','BUTLER','0d8c14ef57f5cafd3464295bda3cb2f1','qulh@xbokjuv.org',1364311842,'AbbVie')
,('vwkkvjusnqe','HILDA','TERRY','8f1c7e49696a91ff26acdfe3b166d58f','xpfto@oaqx.net',3923679176,'Humana')
,('koyaqhpzwqauj','JULIA','MARTINEZ','76b0d270001e70832be2b84b7ead8b8d','epqoxzms@udqbncrei.net',1931735432,'DuPont')
,('uyemoihwi','PHILLIP','COOK','a9a4121019d54c6f8d620aaab368d11d','rtcsdb@xmlfb.org',4917852945,'AES')
,('daryhtfzqd','CAROLINE','VAUGHN','43585a591faf0c112233bf21dc465b76','dbjfqlxri@a.net',6712197283,'Icahn Enterprises')
,('gmfbjpvc','JESUS','ALLISON','435e125e7913397283e558c66778ef05','hglkdscb@s.net',3986232318,'News Corp.')
,('vljkgdxr','TAMMY','PATTERSON','607d22f7f49faf0a70a7f6b383dc8c11','jbwhaz@ya.net',2938123857,'Raytheon')
,('zfhihx','TONI','SALAZAR','f9dcb146a60d27d9aa95111a4446d932','jxfkyhr@lrdcjq.net',8236438376,'AutoNation')
,('zbgxicbxpovw','LOUISE','SPENCER','ddaf13eb69c360a9d1aac425918e23b3','yowkx@hjtbksiy.org',8461824637,'AIG')
,('hfsdphdwzsvb','BOB','WILSON','d721443f1fe36b45883d22f0408089b5','rqvmjwibzg@rv.com',6289318672,'Energy Transfer Equity')
,('btfixravd','MICHAEL','PEARSON','9d223657455660f8a1cf9d1ea0d627aa','cj@tngc.com',6317545398,'PG&E Corp.')
,('ijegkbaldpot','KURT','MCDONALD','d7b0311c484d71a0327f43cf58e65bc6','z@hedr.org',2481751654,'Ascena Retail Group')
,('kaviycokvmberg','LORENZO','WALLACE','9d6548743c685c1cc9a70af4908e47a6','vhmtwoefg@doxk.org',8191964817,'Dillard''s')
,('tobvsiywnk','IGNACIO','DAWSON','b1314b6f36ffd8d44c46714124d4a5f8','be@e.edu',2677245628,'Travelers Cos.')
,('ilcfvawzhd','VANESSA','DAY','b05e8b7d15853099748e89a07d8203ad','paelb@ealhku.com',5897911642,'Exelon')
,('kwhadueqsbit','CECILIA','AUSTIN','569a6d46503a07095af4a0ef13f4db03','wagvqtsuo@o.org',4534324162,'Citizens Financial Group')
,('qpugvlfzyc','DANNY','PEARSON','9dbd92e374b47543bbf70210a25606dc','aumfw@hlbuqaixcf.com',8959465273,'Icahn Enterprises')
,('xcvusqmrat','MONICA','QUINN','95099182b3f692b4c5ae973209049b85','lhxz@y.net',2564518296,'United Technologies')
,('abareupdh','COLLEEN','MAY','0d0474f276b81084c8bd325edac06504','jy@univlo.net',9561653416,'United Continental Holdings')
,('dmldgwp','GENEVA','LAMBERT','ac7dc6d4b45fe4b72f6d24e844d31acd','ebqo@k.edu',5196274718,'Rite Aid')
,('tdqdauxq','LORENA','JENSEN','6b691440e6b0726fdd05c004bb115f5c','e@mgqtdlr.net',9623822647,'Consolidated Edison')
,('liqbkwocm','CLAUDE','CUNNINGHAM','b1cbaff33fefb42193c404fb1f1a0540','ja@hiztoyenfl.com',2516896527,'Halliburton')
,('ikbawqkg','DARREN','CHAMBERS','12b111ea89a2630e2082eb8bd629d1fd','szwukxmpb@smy.org',2867858413,'State Farm Insurance Cos.')
,('ajpigsnycb','CHARLES','HANSON','82f93f7c876f47350e3e2dbd34836a11','gnfy@w.org',4311989456,'Humana')
,('btthr','NINA','BLAKE','5f014a2995ada1984a8db0bcf83b8e5c','raxeyp@qlopf.edu',4561875294,'Best Buy')
,('vbqbuqdjrvl','SAUL','BURGESS','8c0ff2a336dbea89ea80025cd1040983','mzvwpxqsl@pfzmxhj.com',3458239857,'Western & Southern Financial Group')
,('namqhmw','SANTOS','HAWKINS','7f722ccfeaca4deff640b7b85d6ff024','dizkac@wyd.edu',1689812693,'Icahn Enterprises')
,('pxaiordqob','MITCHELL','CASTRO','ad44222b5c7c43d6a208d9097dbce119','wckixyvzrf@tiknho.org',2899866843,'Alaska Air Group')
,('zjcxaplwo','PEGGY','THOMAS','05f94a265461528d0766cd20811bcb46','meacuvpyix@vpqtgserjd.edu',5631474987,'Level 3 Communications')
,('kpuaswhzk','KAYLA','FLORES','70114d7bccb225dddead0ea7287f3c7b','ojfwyrbnk@tbx.org',6759854396,'NetApp')
,('cuebyvws','MIGUEL','BOWMAN','f0ecfb9a3cf5295031f5d22e69fcf005','t@bha.net',7658133249,'PPG Industries')
,('cwtkwzserdx','BRETT','TAYLOR','a4f84a86788b852a2706ad573b8aa89f','vo@syhlfmabz.org',3716158196,'Insight Enterprises')
,('ouizebhox','PATRICK','MULLINS','fa47a74fe1348a6ca91a57b4f6a89eb1','tayj@fvxyqksh.net',6135631932,'J.P. Morgan Chase')
,('mxpqckzeisuaf','KRISTA','SCHULTZ','275dba6c100b5575e528da65acc9dcab','ujpmfvtw@jwcuz.com',6394978691,'Rockwell Automation')
,('hqfnpqt','VICTOR','SCHULTZ','21c08d520d664d250958eac94e8b39be','dmjfrogx@ltvzqxk.org',1851378129,'INTL FCStone')
,('tkbwfrcogysw','ORA','WALTERS','e57f0e2aec926e27574d6bbf330ea0a0','qtxgnv@pjinbw.edu',3769675368,'Lincoln National')
,('lapjta','ALISON','SANTIAGO','836bc925e6ca0fa57113500206584408','dw@qiufxwo.net',6578796538,'Dollar Tree')
,('yjdswrbsi','IDA','MULLINS','ba20457b0e33951377fa3664591ddfd3','ruejptbv@qbdjopmfv.edu',7655829741,'Booz Allen Hamilton Holding')
,('apsbvjdjafdgwm','ESSIE','JONES','3651e2aa7f96b915519f259b6f72de83','qwkxjthvf@j.net',2592982756,'Liberty Mutual Insurance Group')
,('szedojqrmigc','ROGER','ROSS','3518e34c530a1f4bbe31e6f2930e0d96','nysdcteqg@kgyhqzfi.net',7682178459,'Alcoa')
,('jzvdfgi','BECKY','WELLS','dfcdde8ea6507fa42da1d95171779ed5','xg@kustw.com',4312139163,'Citigroup')
,('rxpsxrcdzt','MICHELE','REYES','b136ec5b0aa4c012c9131363c883c230','jmzevlxa@qpzdvf.com',8644386547,'Jones Lang LaSalle')
,('pyzqmukfdzj','JERRY','LYONS','3de23f05971484179865303ba7fbe806','zeoc@qkw.com',9579567486,'Newell Brands')
,('fbwhwdt','DORA','TAYLOR','ea6fbe58e3eeb6813f6d2e321a9c9253','jnvbfeqkyt@ozki.com',2132191245,'Nvidia')
,('zcrendpxlawc','CRAIG','BERRY','368ab56d1c2c7d471cb099bd45a58de8','lzsybocmt@wg.net',2945369823,'Consolidated Edison')
,('xowdzeky','EVERETT','BURNS','4b01813fb95127c1042a25a0bb62971e','jmtipelxny@jfqpvdtbkw.net',4168424936,'Bank of America Corp.')
,('xyuhkfyjxmp','DELORES','MORTON','8c72ea69c92b04ff81ce973e4c9a845e','k@pixzbsy.com',8242698596,'Thermo Fisher Scientific')
,('pfgqrsjfnqs','ANGELINA','GOODMAN','e575553823bd68c30fa6cf96136a1176','cu@yf.org',2532987413,'Citigroup')
,('ohulmyt','MICHEAL','GONZALES','11101a9032bf8dcbf619e1ecda66a732','af@uy.edu',5839265248,'Erie Insurance Group')
,('jemiqwdtqmpe','ELLEN','BROWN','96e715fd655e55455d9fea0525cc5661','auqjyl@tf.com',6982674567,'CenterPoint Energy')
,('qoehnikyov','SPENCER','BRADY','38bb522cea09a80d686be7be6e7e47fa','qwuk@eoanywkgvz.edu',9476146487,'Consolidated Edison')
,('vkwzxsqxlyea','BRENDA','FLEMING','45fef10cc3e8f4fe1401af15f42edf8f','c@ufsrbwghe.com',1388566249,'US Foods Holding')
,('fbadliudshir','MICHELLE','COOPER','d2a47a391efc2cf8e7d7232e619da17d','tq@ftrk.com',6237817295,'Starbucks')
,('wkqjlkem','CARRIE','WALLACE','361dd42d1b80438f7cc2ddb1c51af3f7','rfyzv@f.edu',5942386873,'USAA')
,('jfbihnmexldm','SYLVESTER','ALVAREZ','e7b6a3130743c9bc6a4762db3e8ed208','kfmzubxr@wvmxbezns.edu',3477569185,'Entergy')
,('qulolts','CRISTINA','RODRIQUEZ','1f9a846dea66e6cdb3661ac09de8429f','lk@szr.edu',1494876354,'Tesoro')
,('xjfnvpdfw','CASEY','KLEIN','d3965876682f30ca272cc2692d7e52a1','ihmauxyc@xay.net',7687259514,'L Brands')
,('damvrjdpa','MEGAN','HAMPTON','f4d80d3c11d9cfd4e77c8455295c4309','sklgdre@f.com',8192759574,'L Brands')
,('igebtkonp','MAY','CARTER','c47bff76dcb8ff4b1b5bf3c66b7385b3','uljv@dzjv.edu',7569765362,'Southwest Airlines')
,('ocvzyrfahp','ROLANDO','DAY','e00093dd4dde0e219038a7e60f8f8220','fh@sbawiyv.com',9254858325,'Ball')
,('aumkwxnqz','NOEL','BISHOP','b9cc46757facbcb9ff2466e1c3239978','qzm@dzrq.net',8631524537,'CenterPoint Energy')
,('xhscvblw','DAVE','LITTLE','8117df62cedf0a5f064a57ec7dbd3fb8','f@iqnthdoeyv.com',2812455743,'TJX')
,('pnikjtoxz','CAROLE','BROOKS','ffed622d11d2ac245adda281277385b4','dk@kng.net',4678462713,'American Airlines Group')
,('trmvtzejhw','KELLIE','FOSTER','1fc474566b6e6158456009d8f0cd15a7','lpv@htyzws.net',4283427541,'Harman International Industries')
,('xusjtqoxqsklr','MATTIE','BUTLER','9c3bc0df9f2dd8f05db4d770e1f29931','bvfoik@iflamnbzce.com',6214258639,'Adobe Systems')
,('sdqnjpz','WALTER','KLEIN','501b364ff94731e5d3e7e62c11debe52','vfaczw@lostm.edu',5622316415,'Icahn Enterprises')
,('yucmrbnfid','JANE','MCBRIDE','927685a68f2160a83d5bc5b893612b75','jsukpydo@bcme.edu',3927367481,'Global Partners')
,('mhobiectpds','GENE','RICHARDSON','05fd09990a9b5406e7e21cdfba174fea','bztx@bilwgfrmh.org',8529373987,'Olin')
,('qkhctdzekfjg','TINA','PATTON','b80d9391e7a07524e219bb45285ae595','fxvk@hoqgzjs.net',1821975943,'Western Refining')
,('iypzdytbq','GEORGIA','MAY','6607fc45c5ae131a6b1f6e4023ca57b9','bqvkzcr@qyrhujax.com',4853568974,'Aetna')
,('hlcigprq','ANDREA','MAY','b2841fa509c88e5f7b583f3b56eb4a78','mwsiejhzba@gtj.net',1845465982,'CarMax')
,('dcbqltxybsjh','MERCEDES','TUCKER','016a6689c3e6044ec0403264dd2bcab3','bpd@bhgdeckjtr.com',9587654375,'Simon Property Group')
,('ewqxsohd','DEANNA','VALDEZ','fa9d91df291b016b296905832ac0b851','mlkiqwz@i.com',1984857481,'MGM Resorts International')
,('vylgnzifxsrq','WILLARD','CUMMINGS','3f2ebdf8d8349295c7d2c913b2622130','yqfvmds@sirtblj.com',6835144857,'Erie Insurance Group')
,('mjruwadtj','STEWART','GREER','f5ecda52e4cc00a7c8f407ab3e60bc79','jlpdsrhv@zestkygx.org',6185492974,'Charter Communications')
,('apxrqevtlbo','PRISCILLA','PIERCE','0e5877d0850b4b6323a82e0ba6e3287c','mwpae@lmzjistho.edu',8254121897,'Duke Energy')
,('fhtygat','ANTHONY','BRIDGES','a2d29de1d56bd29414126dd6acf742da','sliqzguo@b.com',1347165879,'Raytheon')
,('phfxja','ALICIA','STEPHENS','2ef53aa5491c850d489637d895931c4a','hynrxlkmv@vsjcuz.org',8646191789,'Eversource Energy')
,('kcfghdea','KRISTINE','MANNING','ba47663b0daeda0bfbaebc5dd1e3be33','lbytd@erikuby.org',9264963871,'Coca-Cola')
,('kplfzzkt','STEVE','MANN','4e128513916a70f339b77c2dd89d2199','es@vtwdmbr.com',1674925823,'Jones Lang LaSalle')
,('uhfqiojnlc','AUBREY','MURRAY','2b8e4b79184d00db3b2f310a7f38b879','eglhkmdw@j.com',8344824895,'United Rentals')
,('pizhaiw','LEO','SULLIVAN','ad0c28a1727e4881b01dcf8aa526bb49','sdibhogktu@kh.org',2742744739,'Target')
,('trbnpbmwqu','MARCELLA','KNIGHT','fbe006b7e6def97dad0462d20d361916','qmcgvidbp@jlsx.edu',1526797215,'Kellogg')
,('sjuiyavmd','MONICA','BROOKS','95ae0c2981d73fd6a4af2c3bbdcd47cf','mut@ximned.net',5646436129,'Entergy')
,('wfagjstrpf','ANDY','BARKER','7eb9df9deb00f51e53c314fbe508bbe8','peklvd@yx.edu',1472541287,'Autoliv')
,('hcydjolwuyk','SCOTT','SIMS','d304d9417e5115bf812973c80256f59c','ohezvk@eqvxru.com',2868527932,'General Electric')
,('ayxiuvmgl','JEANNETTE','HOLT','204ff3f304a1e796ad2033a4d22f9623','nsrgfdx@oji.com',3797427953,'NRG Energy')
,('lmnuyrbsoenamgr','JOYCE','GROSS','3a8ef3e7ac57d9c31210ec0efdac02fb','xnd@nmuidgsy.org',5794124258,'Rite Aid')
,('amwan','KIMBERLY','NORRIS','726ae89d4b9e8d2d78e9ff8015f14042','utsogrynf@qwa.com',9831389237,'American Electric Power')
,('afsqjokxq','JENNA','BANKS','342481a233db272ac0e9cbb7856b8b11','gb@clspj.net',4632717938,'L3 Technologies')
,('vgorc','DENNIS','ERICKSON','829be786a0ce552e00faf88fdae76f27','wlmfoxb@xrpetuhosc.org',1821488751,'Dollar Tree')
,('jleypli','ARCHIE','WRIGHT','e52422c768d38a8d3b600afd208fbabe','hd@t.edu',9353746497,'Oneok')
,('invrbflaj','RUBY','OWEN','d146353d253243c1cf27fe2827f2db0a','mopycx@pmgicb.org',6754218951,'Exelon')
,('snloknioqt','ELEANOR','WHEELER','93ab1bafacf175003811244d1484f08b','ldrxypq@drjope.edu',5941439852,'ConocoPhillips')
,('bpwvzbaijy','ERIN','BARNES','2c6b8c8233485b504e92a4feb1e89fac','vdoyrcsl@cshnlru.org',8457294379,'United States Steel')
,('wuoyecafzgoyc','BLAKE','YOUNG','f38ab68f40c98af01a8ec169ae45d3b6','txnrcwlzha@v.org',4274292361,'Delek US Holdings')
,('eluyimng','CARROLL','QUINN','efb544ba546642f547bda3fd25299b2b','ukzl@pi.edu',2896848372,'Robert Half International')
,('dbcoknvcgwmoeu','MARVIN','PRICE','6928a15b1d38f159cc05267c7589fafa','zkwvb@vjyuzkp.org',1392936274,'Jabil Circuit')
,('cdaornw','IAN','WILCOX','869934ed58ae837e6ced98ff30218845','rn@pdtg.net',4275832168,'United States Steel')
,('bcotuedoefnk','MARGARITA','CLARKE','0f0b4202c3041d628d3a3f7d09d48762','h@rzwos.edu',7524632398,'Reinsurance Group of America')
,('nzljquwcprxk','ELAINE','GARZA','d3ee9675b2b3cad71df978838dcb748e','iosytwebxh@kiplytxc.org',8762863972,'General Dynamics')
,('dtozky','MARYANN','MCKENZIE','2ae0fa0673c4f4addc9dbd6b75d1fa32','vqrylai@ywhrqkv.edu',2613255914,'Delta Air Lines')
,('cvjyhntxecqjmd','GEORGE','PORTER','119c4d9d8d405ac23907d6938d09316a','kypctguq@osrjky.com',2838121638,'NetApp')
,('xmheqyxwag','PEARL','LITTLE','2a34a64b1d2892abf67ed655d88c8de5','krsgciuwnm@wbufkojpm.com',3825639185,'Huntington Ingalls Industries')
,('wyhclkfrohl','JERRY','OWEN','84efb55567d1ba57556306a0f6a6ef7f','qfnealxp@v.net',5314857912,'Penske Automotive Group')
,('waynbpjxbsm','ANTHONY','CRAWFORD','751b16fe1db33178cdf644b54ae34a1f','cluotj@p.edu',2753289481,'Bed Bath & Beyond')
,('wnrvpfkuiqsm','ALLISON','LOPEZ','ee87f51db30f9cad5fbfefbb017c2ac2','auj@owybgnutsz.org',5898545479,'Masco')
,('rwhddwkuvofx','AMELIA','TOWNSEND','3ce61ac22ff0da5c162dce67b7580e28','zhqrfubyl@tgefduanq.com',7649133825,'Archer Daniels Midland')
,('jebohsrz','OMAR','RAY','82a4379f5d996f0545554749d437b64c','klbzx@sxqdroej.net',2738621263,'Starbucks')
,('fpchswxt','LORENZO','NGUYEN','cf9fef6af03c1f816d6f2f04bc21870f','hmfuxie@fuqlt.com',8498432176,'Synnex')
,('ztyqjfyick','RAMONA','HINES','1564b8d8a547fef34dff81426ff7003a','lhoisf@yli.com',3841562974,'WellCare Health Plans')
,('ivjarxsiokpdw','CHRISTINA','WRIGHT','15c52a313c29809194ccd1a48c044fc9','wjqaebxnk@z.com',5135412517,'Veritiv')
,('ewifpgnecivabjf','SHANNON','COLE','542ef9612d1fc48ef9e9d00c1745bc91','biqkch@bhemn.net',5261286754,'Sears Holdings')
,('qjhgbieqvp','MARJORIE','NELSON','ab3add5c37f41dc3c485d9639dd4d712','henf@ku.edu',6379833925,'Cummins')
,('ilahdpaojt','DIANNE','MCBRIDE','2c5e8ebd20141246826ee5c9d7b3b642','isqtoxcvk@anf.edu',9438196372,'Time Warner')
,('gefdbnuyz','JAMIE','BUTLER','736db18073cd1e3d6a0d791c4fd166b0','etgfqb@cgzxjphlqf.net',3579518395,'J.P. Morgan Chase')
,('duvefxc','KELLY','NICHOLS','c84b84b6262b0177fa9e3416f192dd11','mheobpjy@vieuy.org',1376812143,'TIAA')
,('ekytbzme','TASHA','TOWNSEND','8cea76d0a281faa1726803464079c24d','zenpx@hy.com',9382911439,'Citizens Financial Group')
,('zjwtdfcetknyi','ELIZABETH','TODD','fab6ee70d3ee4d584fb776851cda89f0','tijkpovng@zyt.net',7632567529,'Avery Dennison')
,('lpetljsry','MAURICE','PRICE','30bb255ab059c5a6f3bb13c2252c8d41','flupdjc@tuevns.edu',9823463598,'Sealed Air')
,('wnbvshpaol','GINGER','MILLS','5ad2787c6c4ac75114644e5cc6c0e3a6','duve@gxjlatefn.edu',5863825398,'Packaging Corp. of America')
,('trdklzw','TROY','MCBRIDE','7f70f8285c2f4807921a432b83830afb','ksfpd@six.net',1433596791,'Activision Blizzard')
,('cgxnlauxltiw','STACY','WALTERS','5245551e95777bbd3ea20373b7e55fc2','f@kbuvhmf.org',6739818523,'Biogen')
,('osxauzrlvasg','PERCY','CRAWFORD','d0174c8749f94365ebd15e11b8baf4da','dvinyo@nhdfoxlge.com',4295675391,'Dow Chemical')
,('kpwigpye','GWEN','NEWTON','d3eecd0cbf5a2d2e02a301664d68175d','mdebvrs@fd.net',9257354217,'General Electric')
,('kioyzvuglqiet','RAY','BARNES','0687788a21dec02248d6cf7944dd7dc2','lhitgfys@yvm.org',3574673756,'Guardian Life Ins. Colorado. of America')
,('ofqlaiozxulav','ISMAEL','JACOBS','181ddf8bfdf3703cebe9b0fdbba4a82e','xfjtorcedy@q.org',4816799783,'NVR')
,('tzdnetucejo','ELBERT','HAWKINS','2380aa9b4f5a777ac8aefb1e1c19d81c','iycr@n.org',8471755971,'PPG Industries')
,('nqqjvus','JUAN','MCDONALD','b9e7d6aaea315e9c48267ad00b3ea10d','axgswje@brhu.com',9819648514,'Adobe Systems')
,('hgklgd','BRYAN','GOODMAN','57467552620de436a6544765ca3f8ce6','pjxkfyni@xfw.edu',8549611586,'Kellogg')
,('unasycqzuh','RONALD','JACOBS','d663d7cba8b1ac8481e4f227f9c93d4a','rphnqya@rocvflk.com',7451355786,'Raytheon')
,('fnwmfwnchj','TERRANCE','BALDWIN','c7f30ff97967171aea7a96f212286316','fvqehpb@zldwsb.net',5365761456,'Anadarko Petroleum')
,('bmxtngzmoky','JASMINE','HAYNES','7ea2296f28f991bd68d2ea47d872afc6','gds@wksyfrdgc.edu',9648167214,'Unum Group')
,('egpdaiwgd','JEANETTE','HARRIS','e0a4bf6f42102f291116f7ad151ece3b','ztqghjk@arixwje.net',2681672493,'American Electric Power')
,('yjcodlquvotk','SETH','WOOD','a460607e9b50a2d11d7897247f79ee39','jzk@dhoisrpayl.com',9629389247,'Goldman Sachs Group')
,('ywsxedbhqlfw','LEVI','GOMEZ','50d3b596e0152ec28e126e1a0ef2ed0d','aluqhwf@diqgxtk.net',7683751754,'Home Depot')
,('qjknzgopevtckl','JODI','CUNNINGHAM','3099c837627cfa5c227a49b35375160a','ynitb@lzxuh.net',8174913924,'Regions Financial')
,('czhuvcadqm','LAVERNE','WASHINGTON','84eb8953907aa3d0df26663b4cfaf7e5','ezq@e.edu',2649626921,'Ameriprise Financial')
,('gseopvri','ISABEL','THORNTON','52d50be0cbe6bfccf69141a46ed617ea','ksogjyb@iwzcuexhm.com',3974828523,'State Farm Insurance Cos.')
,('yirmtfk','DREW','RILEY','1d5b2d7067e2e8885ee66be07d027037','ntwaovshg@zdoiu.org',4192565418,'Sonic Automotive')
,('snkqkiaulhv','CHRISTY','PHELPS','4b95a24a5b9d70f662d57d9f03afaf66','ysfkdzwhnv@h.net',6459211739,'KeyCorp')
,('xaltzpswiljadpk','BETH','MASSEY','f96cb9c75cfb894ea98ea1a60fe94faa','xghnpti@n.edu',9211825482,'UPS')
,('igxmnjhl','MARCIA','TODD','18559dd6883c2dfbe043cbb207554ece','atqiey@fvm.org',3561951738,'L Brands')
,('lbheyqmkbspr','TERI','SHERMAN','76da986320d2cd2b7f9aaff40a14ca16','mpbdgjqxi@mk.edu',9346898475,'Devon Energy')
,('vknswhqder','FREDDIE','WILLIS','f68f270d7152631ca9ce2fd47d899447','wyr@jczrofhkqs.net',1356524715,'Citizens Financial Group')
,('tpkvlxjizu','RUBY','STEWART','7c2aa4bbecc069d53b1486716236d4cc','avp@i.net',2649139682,'Edison International')
,('mjouvhwdbcjs','JUSTIN','STEVENSON','a1c558514030f4de11c88f2197dc8509','vmolj@pkynl.org',4816452849,'Mosaic')
,('vkzfjptdwio','MARYANN','ROMERO','33884df48316e5b9858a13822b8de641','br@kdutjniwl.org',5219866915,'Veritiv')
,('gnfujtbdnl','ROSE','MASSEY','51c677516cfe79a020c200790b4b2e41','omufd@grteanwjx.net',4596155924,'Time Warner')
,('gponafsuwklvabx','TERI','CARLSON','54f7b667a96c2232e56be18a34129136','duhnpbxa@hmptgqc.com',6575917413,'Insight Enterprises')
,('ltvwklua','LANCE','HAMPTON','556ed540ed4c8ad367c6a6057a7608f8','unq@awygvein.net',5848219317,'Capital One Financial')
,('sbeygsuvpf','RENEE','NORRIS','464beb94143bb9daf04a6844c35d505f','dipjx@ywmginofc.com',7864737384,'Centene')
,('sljxfbr','DANNY','MARSHALL','bc7ebde0bb563a055eb5c8788d8e0358','omuakjr@snyq.net',2196849532,'Dow Chemical')
,('aimqlyosea','TOMMIE','OLIVER','0b2d04c0b1728091c38a556e2e00ed22','xdp@ajnhse.edu',5744962769,'Cummins')
,('tfecsk','NICOLE','BURKE','9a83bb173076c6ca97f5481ff35b66b6','rigvdzwmc@bwclftegn.edu',4821596392,'Alleghany')
,('ntekpqsinzgsdpm','ANTONIO','HALL','f5ab553635f1121e8cb20ef24854502f','nbyj@cwytl.com',8128611354,'Markel')
,('xyhjnseacf','LUCIA','DIXON','d98bdc38a30ccd356b4c83a6fc76c427','ezf@tzip.edu',4324852864,'Northwestern Mutual')
,('euasvly','CHRISTINE','HOWELL','46ffef1a02140b33168b09da7de77d2f','vqshzanlc@gho.net',7323498724,'Ross Stores')
,('fwtnuyrlkf','BRANDI','GUERRERO','bb335e0816dcf22b1d1b21f562aed315','dhy@ea.net',8577418361,'Yum Brands')
,('bvoyihudvbjktiu','ERIK','BRADY','ee2343bf689e18732ea31b6edf5ecc43','h@ac.org',2539542519,'Crown Holdings')
,('lntuzvxolex','CHARLOTTE','DANIELS','edb98f73467dd90223b8593c289a9013','byfp@ouzdf.org',1634678657,'Halliburton')
,('zsgjhvipc','NORMA','HALL','611f05e3da8e3af8141e5c8c7d01bbda','xfsz@hjxvaue.org',7393474378,'Group 1 Automotive')
,('jazlndfdmkrfev','CARY','HARRINGTON','73d37c5edc1caf46824876e35d6ab3bb','tfdcrjew@gcvbkqxjnd.com',4129856542,'salesforce.com')
,('wltbdejspwute','SHERRY','ROGERS','8649d22874e8e5124ced331a2da850d8','wkomlivqz@clg.org',3657125639,'Ross Stores')
,('mdgqbgztpl','INEZ','HANSON','465e51b2485ca9e1b566155d230cb5ce','jempw@acbgtsqo.net',3898954937,'AGCO')
,('wrxqadfku','BRIAN','COBB','ae6075c54cd548b65da59d7a719ebcc8','jyrgh@upnhvm.com',6177647145,'Waste Management')
,('avplgkdows','DOUGLAS','CONNER','ea0db116ce70fb88a60d237d55402da1','mlbzpc@qk.org',6128417935,'Quintiles IMS Holdings')
,('qrdsthxrfod','RUBEN','GOMEZ','8dd6e7821d0a72642d7bea51f1d2c474','aosuy@xdzaufoip.com',5467494176,'Unum Group')
,('myzojhxfpoz','RICK','BAKER','7f7b7e2884ec8553446bc80bbefee8e8','ikt@nxhuvjds.edu',6959631865,'AECOM')
,('chgojfgsnzyp','ERMA','GRAHAM','fb4b4a1dcae7c5db3caa79f6bdd50690','v@rcspkgmzn.com',1728243647,'Vistra Energy')
,('ejsifvo','GEORGIA','COLON','c577d75d66024e912121aa62195937ad','Wisconsin@ayglvfxzok.net',7595313968,'Valero Energy')
,('hsdwhvayixe','SONJA','CRAIG','bec87f110125e175dee53beba1df7afc','zwdajutk@xznvcymjh.net',8319865741,'Western Digital')
,('qnsvthinrjw','IVAN','PATRICK','a1e13056b29d92f54c0341bf8a97a81c','wjzybeqmi@lshrcqkt.edu',1451537615,'First Data')
,('fkmzbrvyr','HILDA','ALVAREZ','2df17b96a26130dbcca6242bfecc80e8','bur@tuhvcgpoe.com',4364386214,'Ally Financial')
,('mzgbchqbiyzdfn','ERVIN','FERNANDEZ','8c72dece96aeeeadbe8ba55b0698e4ee','mz@qndfba.net',4831363954,'Weyerhaeuser')
,('stgndixf','CARLTON','BOYD','5e0686632faa4cc9c5636b0938a61748','vniqfgu@ewctyxrqf.org',7265327164,'St. Jude Medical')
,('vwnfskvga','HOMER','NEAL','0546fd950d7f3041be10adb7b6080aad','sfa@p.com',5725731634,'Intercontinental Exchange')
,('vquamoxtusgi','GENEVA','POWELL','dc0d89532c1332706c3593f900647ded','cyz@kgzvixf.org',2763247264,'Farmers Insurance Exchange')
,('dmajlfxwzygb','MATTHEW','HORTON','43740ca3d7d4d18b17b11c2bc7cb6f80','ohwryamsbv@h.net',9857315482,'Williams')
,('fxvgtnlawq','LEROY','BUTLER','ae66f9547ce7d5254d622b5af157aa65','hioadygc@orinxl.edu',8455795731,'W.R. Berkley')
,('jaugznmqkyw','PEARL','FORD','21ca5432676caffa147853c19cdf5f91','pozjyk@scjdwyfe.net',7896239412,'TIAA')
,('jfhuxpdpf','PETE','RAMSEY','12c0142c218f9267bdd5572d584bde5a','algbwjns@eniqyfsoxp.org',3713428153,'Tenneco')
,('nzcgwcgsnum','LOLA','PATTERSON','885892c8d3a7901c0bbc32753bd15d6e','itd@vfesmljrn.com',1271425176,'Anixter International')
,('xeavmukdcrjave','TONY','RODGERS','8e69571978669c25903363956dd8967e','pnfg@ymc.net',4216411367,'HCA Holdings')
,('bfzrveh','GREGORY','LYONS','5a861021ff9894e866bf9c8b13371e70','pstv@aqznbmdwkl.edu',8526914763,'J.B. Hunt Transport Services')
,('hglixassnd','CHRISTIE','LOVE','1e87aa1976b72e008f4312ec6233bb6e','mdbcfaixzu@nsfju.org',6499278265,'Aramark')
,('vxxuyk','ELVIRA','GREGORY','a74d560002335d357895d96f83960ed9','qolri@mjpf.net',5413676531,'Best Buy')
,('jnxqoonr','RICK','WILKERSON','43afaeb2f205c12579d1f82f7304fc9a','crgvhujzmo@a.edu',1392896359,'MetLife')
,('xbuwkvl','ALFRED','CHAVEZ','9c7abdf6130af06f55eb0c62df761111','apvlitu@wpvdoa.edu',9172471768,'Twenty-First Century Fox')
,('crphqfgpmhsjk','JOSH','MARSHALL','c342f73b4feabec4f89fb075e6f1cad5','lr@ulx.org',4595841583,'PNC Financial Services Group')
,('ilbiady','DUSTIN','SCHULTZ','1e67728f790ebfdd169433b1249b120e','ix@fqjaek.com',6477264975,'BB&T Corp.')
,('mzyxwzi','TOM','FRANKLIN','ccb64bf3130c537d1524f77a81fbc3c5','lcszmitb@chxgpkimq.org',4289689361,'WellCare Health Plans')
,('dyxtdp','GENEVA','BISHOP','42eec9f272af210d1b5ebcbaf7472367','fge@pxyvj.edu',3754812198,'Coca-Cola')
,('wrdbpxi','JOHNNY','COBB','35e27cd656d3f1230147ef871a1cb7eb','mc@ciavog.net',9348532475,'J.C. Penney')
,('sntcailq','MONICA','THOMAS','58816b842681c4c8d9cde934a27235bf','fk@ncehjfiavk.edu',5692474198,'World Fuel Services')
,('qmnbpkoyjxsefk','ELMER','BELL','c4ef6adbf006d2fc1e97c55f5cbf4021','zyxkjuahpv@huw.net',8451834876,'Tyson Foods')
,('rwukijk','TOMMY','RICHARDSON','400ee81c436b7c3639aa73dab275f7e6','rjwu@beoyzd.net',3798732679,'Reinsurance Group of America')
,('atdpjkiwgfr','JEREMY','BURKE','57f2a5e0914fa76f1a67a73b69a50258','enjtqrfdx@qkwatprg.org',4362611823,'Philip Morris International')
,('kmsxuhno','TYRONE','GREER','9560a03dc31b43b0851835ba677650f3','n@nbmehvsur.org',4735235783,'UPS')
,('intgek','CLAY','MORGAN','9b6aea3f1fc5a2efb96054bfc031b535','eibyjznso@gspue.edu',9289266483,'Dean Foods')
,('ljrcocsyjodk','SARA','FLOYD','5e0a578a4f628b1ee7b5338579589662','euworzvys@nwor.edu',2816436213,'ConocoPhillips')
,('nrozyeoqf','RAQUEL','WILLIS','28fe19e3c6068c1a301fd80ae46ef3a1','ifqjakzyr@qgr.edu',7192384298,'ConocoPhillips')
,('esugvutlseb','MARIANNE','KING','e09c4eb8aabc961500d8de03ef2d6977','gscqtemh@yzer.edu',6522675249,'Univar')
,('xopjqyxevr','TERESA','FOWLER','a7556204a13365664f3bc789fe4a6896','degzljuax@k.com',7687343719,'Charter Communications')
,('qdukypahmet','SHARI','ALLISON','ad0fecbf7cc0a9fc39d59198ab160a96','picy@lsbvzi.org',5328575416,'MetLife')
,('ojyltbmurlhkg','MABLE','HAMILTON','184803a52c8202732c6d2c92b694434c','icyehf@kfa.com',7493594673,'Cigna')
,('dkdvy','REX','SHAW','cb0fccca25eee522e15d8fd748b3b688','xvrsfgpaj@t.edu',6527245394,'Insight Enterprises')
,('fpkgjhnqj','DELLA','HERNANDEZ','27fe1cb85af3c4456c7921cab7b712e2','dxovei@tuzb.net',3752482853,'AbbVie')
,('hdzbyrmqneiot','ROSEMARIE','MURPHY','e56433b986e30f585afbfed5cf0aeec8','jb@vhi.net',5242687596,'Jones Lang LaSalle')
,('rhmklzh','KELVIN','GILBERT','f60dd754063cc2dcc94507028b7b3229','tq@ygh.edu',6132347562,'Whirlpool')
,('zpmqvtlziyh','NOEL','FLETCHER','b7354ea12c3b3537d9988f8e258948f4','l@jpwdc.com',3758424361,'State Street Corp.')
,('rgjfwbnaxkfjt','LEAH','PARK','9e40b58779ebdc97b7b8405923910d05','vsicuxpydh@zyngs.edu',7122593258,'Bank of New York Mellon')
,('kjughqnokwmlpv','SADIE','YOUNG','aac363877d455e27b526d03839aa88a4','mrj@pusgtr.com',9361725169,'Molina Healthcare')
,('mthuqo','KIM','HUNTER','4338db3c7bf1ce767155521e903b887a','whcd@onqjdeis.org',8926131394,'Unum Group')
,('fnbpy','JEFF','ESTRADA','6b9a0358a2cf6ce302a54897afcf9232','wd@vf.com',6937297913,'Dominion Energy')
,('lhkpmnjbqxiune','RUFUS','RODRIGUEZ','b11c7efe4dc665957a9406ee29375923','Idaho@hjfsxvdac.edu',8169585379,'Intel')
,('ljscnpr','TERESA','FERNANDEZ','d5c87ab701a6eb304867e81effc6185f','okgqesap@vaq.com',2463717348,'Ameren')
,('abzlrsekiwm','MYRTLE','CANNON','05fcb408f27961517b1b0b364ce0a3fb','antkhdpeij@yusno.com',3684162896,'Marathon Petroleum')
,('cryavzqr','DOMINGO','SANDOVAL','270f5315309289fb1cb34b671aa266ff','rocewamlx@jlpeagqcnk.com',4979232683,'Ross Stores')
,('oiecfncau','DORA','JIMENEZ','1e1e51e9e2513f1a3617febaa8c51480','aejudihmx@k.edu',2457294928,'Sherwin-Williams')
,('nvljczdjpuxgza','WILBUR','BARKER','fd3a02b441d5be1a5685ca0840cf6f94','iop@f.org',5342917148,'Motorola Solutions')
,('txpvefjkjsabdlf','GREGORY','HAMMOND','87f59b591c32712fc3fe197249dfd5b6','gfnwics@isewypakxu.net',9647818291,'Bank of New York Mellon')
,('fdkckdi','HELEN','HALE','b5a02cf31d5d60c88b706ac52c0ca7fe','xtzuwcnbs@hbu.com',2368931295,'J.P. Morgan Chase')
,('dxjoitnmp','ROMAN','EDWARDS','a8e3ba526fe5f3021cd20030e790691d','zu@ximp.org',5874961743,'Ecolab')
,('ajepbauhxc','BRUCE','MATHIS','a1f6e60f77b5719233c29e380290a9c8','ksqg@cekafpzjb.edu',2534166219,'Republic Services')
,('prmkoghyb','ANDRES','NGUYEN','a2dab2932092c524e6a3e25bad98c9a7','hmtwzrafci@gxhw.edu',3793252764,'Phillips 66')
,('fkcxkmb','MONIQUE','PADILLA','2a77a867b515143fb220d0ac14da92e7','kcuhinm@odkrfz.edu',2415496819,'CBRE Group')
,('ukvgtducbf','RICK','STEPHENS','2981b854d3137b3a5d7c12cd59b3019b','h@cwpgjivhk.net',4586327283,'TravelCenters of America')
,('ctawipgpolr','KATE','GONZALES','dffb7c79e3e893062c72d7f2c0741bc6','feqslgh@kpiuhalto.org',1755127489,'UnitedHealth Group')
,('umpnvzgnvezt','KIRK','HAYNES','83f54a13d2173cb7b2436d28022a5a7f','dx@sfwgxqotra.net',2352673412,'Thermo Fisher Scientific')
,('atheitrveob','KENNY','CARROLL','1de915806e5a4dd7ee907782f6c36c9d','wgksp@qyrglz.net',5389719587,'Patterson')
,('kmvtlvakgfhxq','CARL','MYERS','e4d45c2f097ed1089a3cc85460557e8c','xwfmhclpr@qwjlkyeurs.com',5741385176,'Textron')
,('gnvzgbq','PATTY','FOX','23ab9981e39509d7c0b6014475afc056','txbzr@yzqofjcwe.com',8124573671,'Spirit AeroSystems Holdings')
,('pjgjgczu','RAMIRO','WOLFE','209bee86679c4a8da4970d6e46e4a9e9','h@hxvordbs.net',4595917192,'Essendant')
,('rqokbexdgaqi','ALLISON','NEWTON','d5eaeb3459266e8e80e71af1e3658114','xld@g.com',3284312451,'Occidental Petroleum')
,('ylgwopfzeuh','PETER','SPARKS','5a77a583d626c8e194cf9581e21466ab','egb@jvl.net',4139729748,'Home Depot')
,('fjnagoresi','JOSEPH','HOLLAND','d8b67558c9d95c40b81a319fa4d569fb','t@ozecgm.org',8597685123,'Nordstrom')
,('mrxefgzfvtd','DOMINICK','COX','06335107a2ac6f70f61aaa7c801e9dfd','xwcnbfgmzt@mwvyluognk.net',1257342391,'HP')
,('yspolr','SUSIE','LOGAN','06ff6662a52fed7a4d1a933425713056','adwe@pegjyk.edu',9372643578,'Cigna')
,('xptwf','MARLENE','FRAZIER','7c307bbc9249718a7074e4e74b5f8ecf','xbhajel@d.net',1454355896,'Xcel Energy')
,('bdrepvuryceni','MOSES','ORTEGA','fdca73f4162e4d20adea4ab445941786','og@xukpv.org',4321628517,'Northwestern Mutual')
,('nkoxesuiqbg','WOODROW','HOWARD','4d94ff4605053631a9f072180e58829f','y@crsaxh.org',4615362948,'Interpublic Group')
,('zdsbargoxldvp','SHELLY','ROBINSON','c9a94e454aa6fee71669797d461d8453','y@xgqimcnvry.edu',4571931647,'General Mills')
,('yclekasmqdguc','VICKIE','HUFF','366f3ae3b582856da4d8e5806ff56643','e@igf.net',9523747852,'Olin')
,('jioapnwjxnoily','WENDELL','BERRY','6de9b6437e83dde4868b8081a8bd3cad','k@rktohd.net',5477198461,'Praxair')
,('jncaebvofy','ELENA','FERNANDEZ','f377c4ec60205840f1ae4a623c4a4c86','o@ehjlvpfs.org',9238293928,'Illinois Tool Works')
,('cxwkunzjir','ANGELICA','HERRERA','21352e38efaf9ba558022627f76d080a','egpnbz@hn.edu',5613758295,'General Motors')
,('cexsdvjogy','BYRON','MATHIS','3aa9058d0bdc3e656e88e6e2cd831d5e','p@r.edu',4316786521,'Farmers Insurance Exchange')
,('dovefbniurg','JEFFERY','PATRICK','73cfeacb33d605a2aef97a654a844b63','zfh@tjcrhau.org',2738568673,'Micron Technology')
,('rjhaxocgaof','JUSTIN','MCGEE','41360cc4c29eaeedbbf14fee92d7433d','mzle@xewqnyjhud.org',3973516379,'Public Service Enterprise Group')
,('zkpwygah','MACK','WONG','fd6d1f06b6a0d9a70510811dc8a78409','lrmpohvub@fvg.org',1792849587,'CHS')
,('jubqahgspurb','DELLA','MOSS','3b0b24b4893cacd34e1296d03ba688e0','ktpfiwlgva@sedom.org',1787361592,'Chevron')
,('jymjbqnsyc','LUCAS','BALL','bc75edd87509734ebc9787c15028ee38','w@rga.com',4256935164,'Intercontinental Exchange')
,('ukebfpoac','MARC','MOODY','b453393e9e3954ca84cb77f4f07d3b50','ixyk@ouamebvs.org',6429271859,'Prudential Financial')
,('xhdaghjz','DOREEN','PARSONS','0ad3387836ff89e7473fbff6330a32f8','dlgeiubzt@fxat.com',3423464961,'American Airlines Group')
,('jhtspieomfj','JORGE','GREENE','4c2b067879f37efdf2945b7658d6a805','oye@x.net',2914123215,'Murphy USA')
,('xvlxz','CANDACE','LAMBERT','ef720198028f76b148af5f18523b167b','facp@qblmrps.com',8366588231,'Aramark')
,('ufklrn','MAE','COLLINS','b2c6339642bb6ec0b5d9f038d1d3faea','yqr@hnbe.com',6799384721,'R.R. Donnelley & Sons')
,('jqucopqzowi','EMMA','MENDOZA','bd2df009455553ae583ccc2b5c6b4ad7','rjwhlxd@yh.com',1867348594,'PepsiCo')
,('udktzejdhywt','ANDREW','PARK','41ae17cc3b82bb888a3d9f2e498195a4','o@iaw.edu',4585164372,'Marsh & McLennan')
,('ipnlefqjz','LINDSAY','OWENS','be80752fef9f57131803830c98f0e1af','qu@t.org',5319874289,'Archer Daniels Midland')
,('ujaecmns','KATHLEEN','BURTON','a794841fa219d0928d1d3c90f8ac6c6e','qkrhzofjsm@adyikh.org',5268535982,'Insight Enterprises')
,('avecoqumsntj','HARVEY','ALLISON','9b655996d46e98ef17077648a6fca930','wl@p.com',6522153462,'Delta Air Lines')
,('ejurlcjgbprlv','DOUGLAS','RODGERS','6c230535cdca0c9f10efc7254452027d','jqnhafimbo@txaimdsluy.org',7621298697,'HollyFrontier')
,('uyagwdpxarkhd','MARLON','MASON','07fd86cbf65216f9d62c3d67c9338724','gp@nt.org',5327458271,'L Brands')
,('sxugfzg','ALLAN','ADAMS','a52505b3101cb34674bc6977a551094d','tymnad@gyw.net',1295287432,'Union Pacific')
,('utycpxhztib','LILLIAN','ROBINSON','3fece686575559ade34eaffcc5680955','kr@pxutdw.org',2316524518,'Liberty Interactive')
,('rgyxedcoekmwh','HECTOR','KELLY','26c11893e034672fe56ef5575c5124e0','njzsmubtly@jystmgcpk.org',2419724178,'Energy Transfer Equity')
,('zalfpkbqlcaxwr','DARLENE','MARTIN','6bb9419c5245fa2a6e5bb1823e41b32c','dfqmv@x.com',8163574567,'Tesoro')
,('bxfgkfwx','BERNADETTE','PAYNE','a54edc71fd8769d52b172b5bfe6afb7a','am@swa.com',9713246851,'Dominion Energy')
,('hatnbhsdotg','NELLIE','HARVEY','4b4f893e6a6259859a6e75f835b12fb9','lozcvw@baup.edu',4789366431,'Centene')
,('yoezfsgeuhk','JAKE','EDWARDS','301c1fcac9b4f977229c04457b5ddd23','gpsyqax@bwt.edu',9858126218,'Stanley Black & Decker')
,('qkzmu','ELIZABETH','DAVIS','e99631310929e111683dd8579f5df15b','d@qlr.org',5745495273,'MetLife')
,('anwxpkhjsub','CATHERINE','CAIN','bceeb86ac477f23aa13285a876f49f84','ot@moctxnprs.com',6784853172,'Microsoft')
,('ptksxditmw','LILLIE','FORD','a946c8bce6533fccd7931834f7db367b','vzwnr@qimuwzjvkl.com',3841869423,'Norfolk Southern')
,('efjnotehsy','KRISTY','BRYAN','94272496cc8d25959a5f4b419de76b88','wlk@hm.net',8193513659,'Microsoft')
,('vseiueus','JULIO','SHAW','1dc21f2d6253dd558b0ed1f7782efb8b','be@ubvlkxswo.net',8496825423,'Rockwell Collins')
,('kcqwifgdv','ELAINE','KELLEY','e6908d043f3effe682109219e06caeb4','vieqpnsau@pitucdsekg.net',6494782593,'Sherwin-Williams')
,('knheiq','SAUL','FOSTER','07d2400d1dbc3581ed2008245cfe6abb','jneixa@aptqr.net',8638746429,'Las Vegas Sands')
,('nwuonm','EVELYN','DAY','d8a7d4a7a9badfa7f6156b60fbcee31c','vdzfse@vjbhrslnyw.com',7296893914,'Targa Resources')
,('nxgvwjhanvfcre','JOHNNY','GRIFFIN','14300637af0d965916d5c83473ab5781','bimhucz@dctpknhgqv.org',6837859563,'AGCO')
,('npcobdwpuckhx','DEBRA','WALLACE','deba3278abebba6235ec4d546dd7af41','avdshnjt@ohspwxqegf.edu',7937342314,'Darden Restaurants')
,('znjprfeawtnblry','ELMER','BUCHANAN','67f86b41353a93ac308c26d6915e9848','ajbz@picruyq.org',4895469821,'Auto-Owners Insurance')
,('gblijhnfe','MARCUS','SCHMIDT','f2accd88a20b13cd4f9f8624e94fc58a','fnepoxit@lqyadhnfur.com',6277429674,'Liberty Media')
,('osrsqdfgmc','MERCEDES','FERNANDEZ','8dad2444d2192e7c6f1db93a67d7c3b5','eazpxuvoy@kxa.edu',4137862753,'Citigroup')
,('djegnvfurwxtscf','EMANUEL','GEORGE','404415ada1ab891e8aadda6e9e0fe0d0','cs@csjviuhg.com',6956932685,'Williams')
,('vwoksstpmvr','LYNDA','VARGAS','5a2b4ba8cd4e5552ed5ab8d11a7b415b','ztimunsr@ygfxarcz.net',7294219216,'Calpine')
,('sqrstzeo','TASHA','WARREN','18d2d83fd627dca302e760070189ba08','wplogfvt@mlzrfytjh.edu',4321753971,'Nike')
,('yiujzhsajsi','DOMINIC','BUSH','e0d129d9e9777af3266a23542ab06e40','sygfmlphx@npmlrav.com',9161854197,'BlackRock')
,('gjainelhtv','ANDREA','FLEMING','a2052f2416a00bd296fb5fca2449cedc','jhqgkefadp@izuvfbnt.net',6492469852,'Hanesbrands')
,('uglmjvvilokfry','CARROLL','DAY','b555308ca2eaac63a35460931eb24e4f','yj@wvlgreo.com',2174798634,'Gap')
,('qijkulyn','ANDREA','JENNINGS','3711f6a9a027ca9e8bd8809995d97e6b','gqjmuo@wtrpa.edu',2855342861,'Huntsman')
,('huzbmstqiymzn','RAMIRO','KENNEDY','e35956a71bf0b0ae2e6f1d04bdf096c4','ntl@jaqzplw.edu',9752497815,'Monsanto')
,('gaqrbyvmldnq','JOANNA','MUNOZ','0bf23c8aa7985637b4f639fe1293ec3c','yskt@aovubd.com',9522919146,'Boeing')
,('qxulvmktpur','KRISTI','CLARK','4f6592eab707254f5d467b14eb8980c9','sqetcxjnir@ohdra.edu',7984127194,'Fiserv')
,('ifvpfgc','ANA','CLAYTON','ec870ea856ed0c874fa166975f0cc1e9','xydamkgrlc@gkohi.com',4974371298,'Berry Global Group')
,('tnvubweitmurlwf','EVELYN','PENA','60e7785c5ad1dc60059cf371dc6fcaa8','itjmpvkzqn@cdqyevrkli.net',6397815247,'CenturyLink')
,('nuofvip','EDMUND','HOLMES','3f454effa08fbd64c69df6d468ebbce7','luk@howv.org',5644123462,'Ingredion')
,('esdnjbasf','BENJAMIN','GROSS','dc5289cd667e15126297aa8fae534bf4','rbympv@dvebql.org',4732749378,'Arthur J. Gallagher')
,('dukcika','TREVOR','MORAN','06fcc2c15e2da55f909456dcd29e8af9','cdu@zfrpoqwylh.net',6484187195,'Hertz Global Holdings')
,('mhvkcpzstxd','Alabama','BOWERS','4ead5bd12320e1aab92c7f2ed936d628','hzdqktg@hktrdezpv.com',6215921397,'Facebook')
,('cdimubbza','ROLANDO','GARNER','5ab4f8a8adaaed7a00b67a17e9d522b8','yburmav@c.org',9353869358,'Huntington Ingalls Industries')
,('cvnrbizxr','CECIL','THOMPSON','7bc78a2debc779aea6642bb13f42cbec','vdncq@eds.net',1383957483,'Rockwell Collins')
,('mwcnguzaqdy','SHARI','STEVENSON','63e48a1e6d6f757fde92d5105a382535','kjz@zqmgbel.net',8167512918,'CalAtlantic Group')
,('dpexzsr','GUY','GUZMAN','c53c15df34c0dada8ecddad3f5e0e4ea','qhc@xncuhieq.edu',4851533512,'Arthur J. Gallagher')
,('iwbeozzresmlc','LLOYD','MENDEZ','bfaf9cdf030172484b3166b6ef47ce5f','yci@rgwdsfblta.org',3717524752,'Ryder System')
,('itkfqogrclx','ROXANNE','MATHIS','15181aba19b44693aa7aa03d58a3942a','ixlo@m.org',5929238417,'MGM Resorts International')
,('sczhajplgebnr','TOMMY','COLON','c0b23f724e23e743444379fa378434f0','nhmdpsfvga@hqgxuynldf.edu',2369675427,'Eastman Chemical')
,('ftipuajtmkizb','LOWELL','STEWART','07878e7dc93cffb6761416617050d056','it@nk.com',4268576941,'Southwest Airlines')
,('mbcexqasefk','NATHAN','HUDSON','b64d55f5b7a74cfa70772ebd272ffaea','vpszeykd@mguik.net',7453269435,'CBRE Group')
,('oiczxgufyuwe','MARY','PHELPS','afc99d2b5a0fc6ff5509d246d9cc5afd','f@f.org',7438692915,'Dominion Energy')
,('ubzvkdir','SHELIA','DENNIS','7c318361afb62fd5053482e49bfbfa1e','lzghajsic@gtw.edu',7948654861,'M&T Bank Corp.')
,('twkapz','KELLI','FLETCHER','24c1c2500e240092ab5e699a8680c392','tbj@vrzydtjk.org',3493914261,'Colgate-Palmolive')
,('ujraeyesrcwid','JUDY','BRYANT','563803578959cbb2fc9f35a785c71de7','loxmqeh@wkxchgf.net',3922156485,'Ingredion')
,('zdsiozbl','TERI','NEWMAN','9b4894e16be7d937fc51e374da0d3f52','rpthxkjg@bysrgt.org',7243896458,'VF')
,('zfmwlqwai','ELSIE','LITTLE','b81a69509027fce70bb76b8155f0a715','xplymc@uvbrjymtw.net',3622974195,'Centene')
,('xaasncdf','REBECCA','HOUSTON','7038ac8b0048d69769c7056c8a72024b','j@btelkhoxf.edu',6482899543,'Lam Research')
,('ustambhispnb','LUTHER','GARRETT','e57cb80d4e12a21b9ae29ddc2e008e3e','qlzhxv@yrfivqmbwa.org',2482369542,'Lithia Motors')
,('bzhiszcmo','TOMMIE','REYNOLDS','7d8eaceb548f798c5ff18ef8436a53e8','xrjnk@klrw.edu',4256355364,'Owens-Illinois')
,('deiunfbcfq','PAT','MILLER','657024ac33ac62edd18360a269a12f38','bpd@dgfanjtuw.edu',9533162985,'Western & Southern Financial Group')
,('bxrjpwnhc','JUDY','FOWLER','53f7ba213b3d53d7f732d5fefedb8007','wrckqyna@iayk.edu',1891855972,'Jones Financial (Edward Jones)')
,('wcxkubhcr','TIM','MOSS','11bb8701c01ccbb80e676061eaa56142','nplcekmzd@dbovrs.org',2616476347,'NetApp')
,('cuoxlzvwu','LAMAR','HUGHES','bd04b6d8cfa8c00635c6d73e1ea26ffe','w@uorzbi.com',2974539561,'A-Mark Precious Metals')
,('lxsfwkscenrtk','MYRTLE','WILSON','fdf02b346d92afcb4173292fe57bed22','jznfhwvb@ehlkxsg.org',2897828291,'Huntsman')
,('diretnuvok','DEREK','POWELL','8a3dd4c302206c55a56ca29fd2843a22','jhewqryia@e.org',2869758497,'GameStop')
,('ngrmunyb','IRENE','DENNIS','4de59b0024cd09dd0df65ecdcf59aef6','b@oe.net',8325393658,'Genworth Financial')
,('ulethux','DORA','BURKE','f557b0ae1d30225b37194825b5eae35a','vjqhydie@tmxlrne.net',4131399827,'Dominion Energy');


INSERT INTO phprbac_userroles(UserID,RoleID) VALUES

(1,1),
(1,2),
(1,3),
(2,3),
(3,5)
,(4,3)
,(5,3)
,(6,3)
,(7,3)
,(8,3)
,(9,3)
,(10,3)
,(11,3)
,(12,3)
,(13,3)
,(14,3)
,(15,3)
,(16,3)
,(17,3)
,(18,3)
,(19,3)
,(20,3)
,(21,3)
,(22,3)
,(23,3)
,(24,3)
,(25,3)
,(26,3)
,(27,3)
,(28,3)
,(29,3)
,(30,3)
,(31,3)
,(32,3)
,(33,3)
,(34,3)
,(35,3)
,(36,3)
,(37,3)
,(38,3)
,(39,3)
,(40,3)
,(41,3)
,(42,3)
,(43,3)
,(44,3)
,(45,3)
,(46,3)
,(47,3)
,(48,3)
,(49,3)
,(50,3)
,(51,3)
,(52,3)
,(53,3)
,(54,3)
,(55,3)
,(56,3)
,(57,3)
,(58,3)
,(59,3)
,(60,3)
,(61,3)
,(62,3)
,(63,3)
,(64,3)
,(65,3)
,(66,3)
,(67,3)
,(68,3)
,(69,3)
,(70,3)
,(71,3)
,(72,3)
,(73,3)
,(74,3)
,(75,3)
,(76,3)
,(77,3)
,(78,3)
,(79,3)
,(80,3)
,(81,3)
,(82,3)
,(83,3)
,(84,3)
,(85,3)
,(86,3)
,(87,3)
,(88,3)
,(89,3)
,(90,3)
,(91,3)
,(92,3)
,(93,3)
,(94,3)
,(95,3)
,(96,3)
,(97,3)
,(98,3)
,(99,3)
,(100,3)
,(101,3)
,(102,3)
,(103,3)
,(104,3)
,(105,3)
,(106,3)
,(107,3)
,(108,3)
,(109,3)
,(110,3)
,(111,3)
,(112,3)
,(113,3)
,(114,3)
,(115,3)
,(116,3)
,(117,3)
,(118,3)
,(119,3)
,(120,3)
,(121,3)
,(122,3)
,(123,3)
,(124,3)
,(125,3)
,(126,3)
,(127,3)
,(128,3)
,(129,3)
,(130,3)
,(131,3)
,(132,3)
,(133,3)
,(134,3)
,(135,3)
,(136,3)
,(137,3)
,(138,3)
,(139,3)
,(140,3)
,(141,3)
,(142,3)
,(143,3)
,(144,3)
,(145,3)
,(146,3)
,(147,3)
,(148,3)
,(149,3)
,(150,3)
,(151,3)
,(152,3)
,(153,3)
,(154,3)
,(155,3)
,(156,3)
,(157,3)
,(158,3)
,(159,3)
,(160,3)
,(161,3)
,(162,3)
,(163,3)
,(164,3)
,(165,3)
,(166,3)
,(167,3)
,(168,3)
,(169,3)
,(170,3)
,(171,3)
,(172,3)
,(173,3)
,(174,3)
,(175,3)
,(176,3)
,(177,3)
,(178,3)
,(179,3)
,(180,3)
,(181,3)
,(182,3)
,(183,3)
,(184,3)
,(185,3)
,(186,3)
,(187,3)
,(188,3)
,(189,3)
,(190,3)
,(191,3)
,(192,3)
,(193,3)
,(194,3)
,(195,3)
,(196,3)
,(197,3)
,(198,3)
,(199,3)
,(200,3)
,(201,3)
,(202,3)
,(203,3)
,(204,3)
,(205,3)
,(206,3)
,(207,3)
,(208,3)
,(209,3)
,(210,3)
,(211,3)
,(212,3)
,(213,3)
,(214,3)
,(215,3)
,(216,3)
,(217,3)
,(218,3)
,(219,3)
,(220,3)
,(221,3)
,(222,3)
,(223,3)
,(224,3)
,(225,3)
,(226,3)
,(227,3)
,(228,3)
,(229,3)
,(230,3)
,(231,3)
,(232,3)
,(233,3)
,(234,3)
,(235,3)
,(236,3)
,(237,3)
,(238,3)
,(239,3)
,(240,3)
,(241,3)
,(242,3)
,(243,3)
,(244,3)
,(245,3)
,(246,3)
,(247,3)
,(248,3)
,(249,3)
,(250,3)
,(251,3)
,(252,3)
,(253,3)
,(254,3)
,(255,3)
,(256,3)
,(257,3)
,(258,3)
,(259,3)
,(260,3)
,(261,3)
,(262,3)
,(263,3)
,(264,3)
,(265,3)
,(266,3)
,(267,3)
,(268,3)
,(269,3)
,(270,3)
,(271,3)
,(272,3)
,(273,3)
,(274,3)
,(275,3)
,(276,3)
,(277,3)
,(278,3)
,(279,3)
,(280,3)
,(281,3)
,(282,3)
,(283,3)
,(284,3)
,(285,3)
,(286,3)
,(287,3)
,(288,3)
,(289,3)
,(290,3)
,(291,3)
,(292,3)
,(293,3)
,(294,3)
,(295,3)
,(296,3)
,(297,3)
,(298,3)
,(299,3)
,(300,3)
,(301,3)
,(302,3)
,(303,3)
,(304,3)
,(305,3)
,(306,3)
,(307,3)
,(308,3)
,(309,3)
,(310,3)
,(311,3)
,(312,3)
,(313,3)
,(314,3)
,(315,3)
,(316,3)
,(317,3)
,(318,3)
,(319,3)
,(320,3)
,(321,3)
,(322,3)
,(323,3)
,(324,3)
,(325,3)
,(326,3)
,(327,3)
,(328,3)
,(329,3)
,(330,3)
,(331,3)
,(332,3)
,(333,3)
,(334,3)
,(335,3)
,(336,3)
,(337,3)
,(338,3)
,(339,3)
,(340,3)
,(341,3)
,(342,3)
,(343,3)
,(344,3)
,(345,3)
,(346,3)
,(347,3)
,(348,3)
,(349,3)
,(350,3)
,(351,3)
,(352,3)
,(353,3)
,(354,3)
,(355,3)
,(356,3)
,(357,3)
,(358,3)
,(359,3)
,(360,3)
,(361,3)
,(362,3)
,(363,3)
,(364,3)
,(365,3)
,(366,3)
,(367,3)
,(368,3)
,(369,3)
,(370,3)
,(371,3)
,(372,3)
,(373,3)
,(374,3)
,(375,3)
,(376,3)
,(377,3)
,(378,3)
,(379,3)
,(380,3)
,(381,3)
,(382,3)
,(383,3)
,(384,3)
,(385,3)
,(386,3)
,(387,3)
,(388,3)
,(389,3)
,(390,3)
,(391,3)
,(392,3)
,(393,3)
,(394,3)
,(395,3)
,(396,3)
,(397,3)
,(398,3)
,(399,3)
,(400,3)
,(401,5)
,(402,5)
,(403,5)
,(404,5)
,(405,5)
,(406,5)
,(407,5)
,(408,5)
,(409,5)
,(410,5)
,(411,5)
,(412,5)
,(413,5)
,(414,5)
,(415,5)
,(416,5)
,(417,5)
,(418,5)
,(419,5)
,(420,5)
,(421,5)
,(422,5)
,(423,5)
,(424,5)
,(425,5)
,(426,5)
,(427,5)
,(428,5)
,(429,5)
,(430,5)
,(431,5)
,(432,5)
,(433,5)
,(434,5)
,(435,5)
,(436,5)
,(437,5)
,(438,5)
,(439,5)
,(440,5)
,(441,5)
,(442,5)
,(443,5)
,(444,5)
,(445,5)
,(446,5)
,(447,5)
,(448,5)
,(449,5)
,(450,5)
,(451,5)
,(452,5)
,(453,5)
,(454,5)
,(455,5)
,(456,5)
,(457,5)
,(458,5)
,(459,5)
,(460,5)
,(461,5)
,(462,5)
,(463,5)
,(464,5)
,(465,5)
,(466,5)
,(467,5)
,(468,5)
,(469,5)
,(470,5)
,(471,5)
,(472,5)
,(473,5)
,(474,5)
,(475,5)
,(476,5)
,(477,5)
,(478,5)
,(479,5)
,(480,5)
,(481,5)
,(482,5)
,(483,5)
,(484,5)
,(485,5)
,(486,5)
,(487,5)
,(488,5)
,(489,5)
,(490,5)
,(491,5)
,(492,5)
,(493,5)
,(494,5)
,(495,5)
,(496,5)
,(497,5)
,(498,5)
,(499,5)
,(500,5)
,(501,5)
,(502,5)
,(503,5)
,(504,5)
,(505,5)
,(506,5)
,(507,5)
,(508,5)
,(509,5)
,(510,5)
,(511,5)
,(512,5)
,(513,5)
,(514,5)
,(515,5)
,(516,5)
,(517,5)
,(518,5)
,(519,5)
,(520,5)
,(521,5)
,(522,5)
,(523,5)
,(524,5)
,(525,5)
,(526,5)
,(527,5)
,(528,5)
,(529,5)
,(530,5)
,(531,5)
,(532,5)
,(533,5)
,(534,5)
,(535,5)
,(536,5)
,(537,5)
,(538,5)
,(539,5)
,(540,5)
,(541,5)
,(542,5)
,(543,5)
,(544,5)
,(545,5)
,(546,5)
,(547,5)
,(548,5)
,(549,5)
,(550,5)
,(551,5)
,(552,5)
,(553,5)
,(554,5)
,(555,5)
,(556,5)
,(557,5)
,(558,5)
,(559,5)
,(560,5)
,(561,5)
,(562,5)
,(563,5)
,(564,5)
,(565,5)
,(566,5)
,(567,5)
,(568,5)
,(569,5)
,(570,5)
,(571,5)
,(572,5)
,(573,5)
,(574,5)
,(575,5)
,(576,5)
,(577,5)
,(578,5)
,(579,5)
,(580,5)
,(581,5)
,(582,5)
,(583,5)
,(584,5)
,(585,5)
,(586,5)
,(587,5)
,(588,5)
,(589,5)
,(590,5)
,(591,5)
,(592,5)
,(593,5)
,(594,5)
,(595,5)
,(596,5)
,(597,5)
,(598,5)
,(599,5)
,(600,5)
,(601,5)
,(602,5)
,(603,5)
,(604,5)
,(605,5)
,(606,5)
,(607,5)
,(608,5)
,(609,5)
,(610,5)
,(611,5)
,(612,5)
,(613,5)
,(614,5)
,(615,5)
,(616,5)
,(617,5)
,(618,5)
,(619,5)
,(620,5)
,(621,5)
,(622,5)
,(623,5)
,(624,5)
,(625,5)
,(626,5)
,(627,5)
,(628,5)
,(629,5)
,(630,5)
,(631,5)
,(632,5)
,(633,5)
,(634,5)
,(635,5)
,(636,5)
,(637,5)
,(638,5)
,(639,5)
,(640,5)
,(641,5)
,(642,5)
,(643,5)
,(644,5)
,(645,5)
,(646,5)
,(647,5)
,(648,5)
,(649,5)
,(650,5)
,(651,5)
,(652,5)
,(653,5)
,(654,5)
,(655,5)
,(656,5)
,(657,5)
,(658,5)
,(659,5)
,(660,5)
,(661,5)
,(662,5)
,(663,5)
,(664,5)
,(665,5)
,(666,5)
,(667,5)
,(668,5)
,(669,5)
,(670,5)
,(671,5)
,(672,5)
,(673,5)
,(674,5)
,(675,5)
,(676,5)
,(677,5)
,(678,5)
,(679,5)
,(680,5)
,(681,5)
,(682,5)
,(683,5)
,(684,5)
,(685,5)
,(686,5)
,(687,5)
,(688,5)
,(689,5)
,(690,5)
,(691,5)
,(692,5)
,(693,5)
,(694,5)
,(695,5)
,(696,5)
,(697,5)
,(698,5)
,(699,5)
,(700,5)
,(701,5)
,(702,5)
,(703,5)
,(704,5)
,(705,5)
,(706,5)
,(707,5)
,(708,5)
,(709,5)
,(710,5)
,(711,5)
,(712,5)
,(713,5)
,(714,5)
,(715,5)
,(716,5)
,(717,5)
,(718,5)
,(719,5)
,(720,5)
,(721,5)
,(722,5)
,(723,5)
,(724,5)
,(725,5)
,(726,5)
,(727,5)
,(728,5)
,(729,5)
,(730,5)
,(731,5)
,(732,5)
,(733,5)
,(734,5)
,(735,5)
,(736,5)
,(737,5)
,(738,5)
,(739,5)
,(740,5)
,(741,5)
,(742,5)
,(743,5)
,(744,5)
,(745,5)
,(746,5)
,(747,5)
,(748,5)
,(749,5)
,(750,5)
,(751,5)
,(752,5)
,(753,5)
,(754,5)
,(755,5)
,(756,5)
,(757,5)
,(758,5)
,(759,5)
,(760,5)
,(761,5)
,(762,5)
,(763,5)
,(764,5)
,(765,5)
,(766,5)
,(767,5)
,(768,5)
,(769,5)
,(770,5)
,(771,5)
,(772,5)
,(773,5)
,(774,5)
,(775,5)
,(776,5)
,(777,5)
,(778,5)
,(779,5)
,(780,5)
,(781,5)
,(782,5)
,(783,5)
,(784,5)
,(785,5)
,(786,5)
,(787,5)
,(788,5)
,(789,5)
,(790,5)
,(791,5)
,(792,5)
,(793,5)
,(794,5)
,(795,5)
,(796,5)
,(797,5)
,(798,5)
,(799,5)
,(800,5)
,(801,5)
,(802,5)
,(803,5)
,(804,5)
,(805,5)
,(806,5)
,(807,5)
,(808,5)
,(809,5)
,(810,5)
,(811,5)
,(812,5)
,(813,5)
,(814,5)
,(815,5)
,(816,5)
,(817,5)
,(818,5)
,(819,5)
,(820,5)
,(821,5)
,(822,5)
,(823,5)
,(824,5)
,(825,5)
,(826,5)
,(827,5)
,(828,5)
,(829,5)
,(830,5)
,(831,5)
,(832,5)
,(833,5)
,(834,5)
,(835,5)
,(836,5)
,(837,5)
,(838,5)
,(839,5)
,(840,5)
,(841,5)
,(842,5)
,(843,5)
,(844,5)
,(845,5)
,(846,5)
,(847,5)
,(848,5)
,(849,5)
,(850,5)
,(851,5)
,(852,5)
,(853,5)
,(854,5)
,(855,5)
,(856,5)
,(857,5)
,(858,5)
,(859,5)
,(860,5)
,(861,5)
,(862,5)
,(863,5)
,(864,5)
,(865,5)
,(866,5)
,(867,5)
,(868,5)
,(869,5)
,(870,5)
,(871,5)
,(872,5)
,(873,5)
,(874,5)
,(875,5)
,(876,5)
,(877,5)
,(878,5)
,(879,5)
,(880,5)
,(881,5)
,(882,5)
,(883,5)
,(884,5)
,(885,5)
,(886,5)
,(887,5)
,(888,5)
,(889,5)
,(890,5)
,(891,5)
,(892,5)
,(893,5)
,(894,5)
,(895,5)
,(896,5)
,(897,5)
,(898,5)
,(899,5)
,(900,5)
,(901,5)
,(902,5)
,(903,5)
,(904,5)
,(905,5)
,(906,5)
,(907,5)
,(908,5)
,(909,5)
,(910,5)
,(911,5)
,(912,5)
,(913,5)
,(914,5)
,(915,5)
,(916,5)
,(917,5)
,(918,5)
,(919,5)
,(920,5)
,(921,5)
,(922,5)
,(923,5)
,(924,5)
,(925,5)
,(926,5)
,(927,5)
,(928,5)
,(929,5)
,(930,5)
,(931,5)
,(932,5)
,(933,5)
,(934,5)
,(935,5)
,(936,5)
,(937,5)
,(938,5)
,(939,5)
,(940,5)
,(941,5)
,(942,5)
,(943,5)
,(944,5)
,(945,5)
,(946,5)
,(947,5)
,(948,5)
,(949,5)
,(950,5)
,(951,5)
,(952,5)
,(953,5)
,(954,5)
,(955,5)
,(956,5)
,(957,5)
,(958,5)
,(959,5)
,(960,5)
,(961,5)
,(962,5)
,(963,5)
,(964,5)
,(965,5)
,(966,5)
,(967,5)
,(968,5)
,(969,5)
,(970,5)
,(971,5)
,(972,5)
,(973,5)
,(974,5)
,(975,5)
,(976,5)
,(977,5)
,(978,5)
,(979,5)
,(980,5)
,(981,5)
,(982,5)
,(983,5)
,(984,5)
,(985,5)
,(986,5)
,(987,5)
,(988,5)
,(989,5)
,(990,5)
,(991,5)
,(992,5)
,(993,5)
,(994,5)
,(995,5)
,(996,5)
,(997,5)
,(998,5)
,(999,5)
,(1000,5);

CREATE TABLE IF NOT EXISTS Warehouses (
  WarehouseID int(11) NOT NULL auto_increment,
  OwnerID int(11) NOT NULL,
  Address varchar(100) NOT NULL,
  ZipCode varchar(5),
  City varchar(50),
  State varchar(15) NOT NULL,
  Latitude FLOAT( 10, 6 ) NOT NULL ,
  Longitude FLOAT( 10, 6 ) NOT NULL ,
  BuildingSize real,
  WarehouseInformation varchar(500),
  PRIMARY KEY(WarehouseID),
  FOREIGN KEY(OwnerID) REFERENCES phprbac_users(UserID) ON DELETE CASCADE);

  CREATE TABLE IF NOT EXISTS Spaces (
    SpaceID int(11) NOT NULL auto_increment,
    WarehouseID int(11) NOT NULL,
    SpaceSize real,
    MonthlyPrice real,
    Active BOOLEAN DEFAULT TRUE,
    SpaceInformation varchar(500),
    DateAdded TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(SpaceID),
    FOREIGN KEY(WarehouseID) REFERENCES Warehouses(WarehouseID) ON DELETE CASCADE);

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
      FOREIGN KEY(SpaceID) REFERENCES Spaces(SpaceID) ON DELETE RESTRICT,
      FOREIGN KEY(LesseeID) REFERENCES phprbac_users(UserID) ON DELETE RESTRICT);

      CREATE TABLE IF NOT EXISTS Status (
        StatusID int(11) NOT NULL AUTO_INCREMENT,
        StatusName varchar(50),
        StatusDescription varchar(200),
        PRIMARY KEY (StatusID));

        INSERT INTO `Status` (`StatusID`, `StatusName`, `StatusDescription`) VALUES
        (1, 'Reserved', 'This contract is marked as Reserved for a specific length of time by a potential lessee.'),
        (2, 'Pending', 'This contract is marked as Pending, awaiting for the approval of the warehouse.'),
        (3, 'Approved', 'This contract is marked as Approved by the warehouse.'),
        (4, 'Denied', 'This contract is Denied by the warehouse.');

        CREATE TABLE IF NOT EXISTS Contract_Status (
          ContractID int(11) NOT NULL,
          StatusID int(11) NOT NULL,
          StatusTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
          PRIMARY KEY (ContractID, StatusID),
          FOREIGN KEY (ContractID) REFERENCES Contracts(ContractID) ON DELETE CASCADE,
          FOREIGN KEY (StatusID) REFERENCES Status(StatusID) ON DELETE RESTRICT);

          CREATE TABLE IF NOT EXISTS Attributes (
            AttributeID int(11) NOT NULL auto_increment,
            AttributeName varchar(50),
            AttributeDescription varchar(200),
            AttributeType int(5),
            lft int(11) NOT NULL,
            rght int(11) NOT NULL,
            AttributeIcon varchar(75),
            PRIMARY KEY(AttributeID));

            CREATE TABLE IF NOT EXISTS Space_Attributes (
              SpaceID int(11),
              AttributeID int(11),
              PRIMARY KEY(SpaceID, AttributeID),
              FOREIGN KEY(SpaceID) REFERENCES Spaces(SpaceID) ON DELETE CASCADE,
              FOREIGN KEY(AttributeID) REFERENCES Attributes(AttributeID) ON DELETE RESTRICT);

              INSERT INTO `Warehouses` (`WarehouseID`, `OwnerID`, `Address`, `ZipCode`, `City`, `State`, `BuildingSize`, `Latitude`, `Longitude`, `WarehouseInformation`) VALUES
              (1, 2, '512 N Energy Dr.', '82901', 'Rock Springs', 'Wyoming', 10400, 41.593910, -109.218040, 'Tires'),
              (2, 2, '331 Lexington Ave.', '82007', 'Cheyenne', 'Wyoming', 15300, 41.125847, -104.757111, ''),
              (3, 2, '311 Progress Cir.', '82007', 'Cheyenne', 'Wyoming', 21112, 41.129181, -104.739792, ''),
              (4, 2, '220 Evelyn St', '82007', 'Cheyenne', 'Wyoming', 79767, 41.118847, -104.847015, ''),
              (5, 2, '217 W 5th St.', '82007', 'Cheyenne', 'Wyoming', 1960, 41.122398, -104.809509, ''),
              (6, 2, '1451 Buiness Cir.', '82716', 'Gillette', 'Wyoming', 7344, 44.335594, -105.522110, ''),
              (7, 2, '2700 N US Hwy 14', '53545', 'Gillette', 'Wyoming', 16740, 42.718220, -88.989586, ''),
              (8, 2, '1938 Wyott Dr.', '82007', 'Cheyenne', 'Wyoming', 210518, 41.110703, -104.833420, 'Tires'),
              (9, 2, '2632 Industry Dr.', '82007', 'Cheyenne', 'Wyoming', 14520, 41.139729, -104.703697, ''),
              (10, 2, '1010 Falcon Ave', '82604', 'Mills', 'Wyoming', 28390, 42.845985, -106.383080, ''),
              (11, 2, '1120 Logan Ave', '82001', 'Cheyenne', 'Wyoming', 2600, 41.135948, -104.794067, ''),
              (12, 2, '1920 Missile Dr.', '82001', 'Cheyenne', 'Wyoming', 12600, 41.131065, -104.830460, ''),
              (13, 2, '1800 Opportunity Blvd', '82601', 'Casper', 'Wyoming', 11000, 42.863728, -106.350189, ''),
              (14, 3, '802-810 N Foster Rd', '82601', 'Casper', 'Wyoming', 7500, 42.858768, -106.339653, ''),
              (15, 4, '1733 E Yellowstone Hwy', '82601', 'Casper', 'Wyoming', 7700, 42.853069, -106.301994, ''),
              (16, 5, '190 S College Dr.', '82007', 'Cheyenne', 'Wyoming', 12000, 41.115818, -104.768700, ''),
              (17, 6, '518 N US Highway 14-16', NULL, 'Gillette', 'Wyoming', 11800, 0.000000, 0.000000, ''),
              (18, 7, '3851 E Collins Rd', '82718', 'GIllette', 'Wyoming', 8860, 44.290333, -105.447006, ''),
              (19, 8, '620 N US Highway 14-16', '82716', 'Gillette', 'Wyoming', 18000, 44.299118, -105.528252, ''),
              (20, 9, '612 N US Highway 14-16', '82716', 'Gillette', 'Wyoming', 14800, 44.293152, -105.511284, ''),
              (21, 10, '1935 Cooper St', NULL, 'Missoula', 'Montana', 2400, 0.000000, 0.000000, ''),
              (22, 11, '2601 Overland Ave.', NULL, 'Billings', 'Montana', 4403, 0.000000, 0.000000, ''),
              (23, 11, '5360 Southgate Dr.', NULL, 'Billings', 'Montana', 25000, 0.000000, 0.000000, ''),
              (24, 12, '54 Ginger Bear Ln', '59718', 'Bozeman', 'Montana', 3600, 45.706242, -111.187134, ''),
              (25, 13, '7201 Expressway', '59808', 'Missoula', 'Montana', 20000, 46.932110, -114.097092, ''),
              (26, 14, '1943 Main St', NULL, 'Billings', 'Montana', 10060, 0.000000, 0.000000, ''),
              (27, 15, '610 W Griffin Dr.', '59715', 'Bozeman', 'Montana', 8000, 45.700050, -111.044319, ''),
              (28, 15, '330-334 Fuller Ave', '59601', 'Helena', 'Montana', 2300, 46.590309, -112.039192, ''),
              (29, 16, '706 Daniels St', '59101', 'Billings', 'Montana', 119757, 45.757915, -108.555382, ''),
              (30, 17, '5 Wall St', '59634', 'Montana City', 'Montana', 11200, 46.538433, -111.946648, ''),
              (31, 93, '2330 N Frontae Rd', '59101', 'Billings', 'Montana', 13200, 45.809185, -108.426964, ''),
              (32, 93, '3102 W Broadway St', NULL, 'Missoula', 'Montana', 11872, 0.000000, 0.000000, ''),
              (33, 93, 'Yukon Ln', NULL, 'Belgrade', 'Montana', 19100, 0.000000, 0.000000, ''),
              (34, 93, '311 N Grove St', '59804', 'Missoula', 'Montana', 10000, 46.872513, -114.042450, ''),
              (35, 93, '1922 Airport CT', '59404', 'Great Falls', 'Montana', 5950, 47.487305, -111.351524, ''),
              (36, 93, '8462 Highway 200', NULL, 'Bonner', 'Montana', 587800, 0.000000, 0.000000, ''),
              (37, 93, '3750 Wise Ln', '59101', 'Billings', 'Montana', 19200, 45.702271, -108.622192, ''),
              (38, 93, '5229 King Ave W', '59106', 'Billings', 'Montana', 40800, 45.755714, -108.651138, ''),
              (39, 93, '12211 Spring Brook Dr', NULL, 'Eagle River', 'Alaska', 4360, 0.000000, 0.000000, ''),
              (40, 93, '7613 W Buttercup Dr', '99623', 'Wasilla', 'Alaska', 6622, 61.576134, -149.642075, ''),
              (41, 93, '4721 E Bogard Rd', NULL, 'Wasilla', 'Alaska', 10800, 0.000000, 0.000000, ''),
              (42, 93, '2125 E 79th ave', NULL, 'Anchorage', 'Alaska', 56945, 0.000000, 0.000000, ''),
              (43, 93, '3201 International St', '99701', 'Fairbanks', 'Alaska', 8000, 64.818634, -147.750244, ''),
              (44, 93, '250 N Post Rd', NULL, 'Anchorage', 'Alaska', 10300, 0.000000, 0.000000, ''),
              (45, 93, '6200 A St', NULL, 'Anchorage', 'Alaska', 3504, 0.000000, 0.000000, ''),
              (46, 93, '8001Petersburg St', NULL, 'Anchorage', 'Alaska', 29550, 0.000000, 0.000000, ''),
              (47, 93, '4025 W 50th Ave', NULL, 'Anchorage', 'Alaska', 23487, 0.000000, 0.000000, ''),
              (48, 93, '34995 Kustatan St', '99669', 'Kenai', 'Alaska', 6304, 60.487690, -151.193893, ''),
              (49, 93, '000 Halliburton Dr', NULL, 'Nikiski', 'Alaska', 9204, 0.000000, 0.000000, ''),
              (50, 93, '1220-1320 E 68th Ave', NULL, 'Anchorage', 'Alaska', 29872, 0.000000, 0.000000, ''),
              (51, 93, '40902 Kalifornsky Beach Rd', '99611', 'Kenai', 'Alaska', 3600, 60.515038, -151.193649, ''),
              (52, 93, '1549 Davison St', '99705', 'Fairbanks', 'Alaska', 4500, 64.798264, -147.549210, ''),
              (53, 93, '351 E 104th Ave', NULL, 'Anchorage', 'Alaska', 59252, 0.000000, 0.000000, ''),
              (54, 93, '1101 Well St', '99701', 'Fairbanks', 'Alaska', 25000, 64.849152, -147.726089, ''),
              (55, 93, '550 W 64th Ave', NULL, 'Anchorage', 'Alaska', 62668, 0.000000, 0.000000, ''),
              (56, 93, '2799 Rampart Dr', NULL, 'Anchorage', 'Alaska', 10500, 0.000000, 0.000000, ''),
              (57, 93, '1910 1st Ave N', NULL, 'Fargo', 'North Dakota', 14169, 0.000000, 0.000000, ''),
              (58, 93, '10285 3rd St SW', NULL, 'Killdeer', 'North Dakota', 10000, 0.000000, 0.000000, ''),
              (59, 93, '601 Gilbertson St SE', '58852', 'Tioga', 'North Dakota', 7000, 48.387325, -102.934570, ''),
              (60, 93, '4946 Hwy 85', NULL, 'Williston', 'North Dakota', 19240, 0.000000, 0.000000, ''),
              (61, 93, '4942 Highway 85', NULL, 'Williston', 'North Dakota', 12000, 0.000000, 0.000000, ''),
              (62, 93, '5072 Bennett Loop', NULL, 'Williston', 'North Dakota', 11900, 0.000000, 0.000000, ''),
              (63, 93, '2530 132nd Ave NW', NULL, 'Arnegard', 'North Dakota', 10000, 0.000000, 0.000000, ''),
              (64, 93, '5302 22nd Ave W', NULL, 'Williston', 'North Dakota', 12151, 0.000000, 0.000000, ''),
              (65, 93, '896 22nd Ave N', '58075', 'Wahpeton', 'North Dakota', 38250, 46.292015, -96.611626, ''),
              (66, 93, '1910 50th St W', NULL, 'Williston', 'North Dakota', 39000, 0.000000, 0.000000, ''),
              (67, 93, '205 42nd St SE', NULL, 'Minot', 'North Dakota', 279328, 0.000000, 0.000000, ''),
              (68, 93, '1150 S 46th St', '58201', 'Grand Forks', 'North Dakota', 40026, 47.910103, -97.097023, ''),
              (69, 93, '3804 Nebraska 17th Ave', NULL, 'Watford City', 'North Dakota', 11300, 0.000000, 0.000000, ''),
              (70, 93, '3217 111th Ave SW', NULL, 'Dickinson', 'North Dakota', 10000, 0.000000, 0.000000, ''),
              (71, 93, '6416 Wilckum Rd', '58801', 'Williston', 'North Dakota', 17850, 48.145279, -103.612892, ''),
              (72, 93, '629 20th Ave', '58701', 'Minot', 'North Dakota', 10500, 48.211964, -101.283073, ''),
              (73, 93, '5806 Baldwin ln', NULL, 'Williston', 'North Dakota', 14000, 0.000000, 0.000000, ''),
              (74, 93, '4001 32nd St N', '58102', 'Fargo', 'North Dakota', 293496, 46.933960, -96.829338, ''),
              (75, 93, '3911 37th Ave S', NULL, 'Fargo', 'North Dakota', 26000, 0.000000, 0.000000, ''),
              (76, 93, '16 Heidi Ln', NULL, 'Ross', 'North Dakota', 7200, 0.000000, 0.000000, ''),
              (77, 93, '2655 6th Ave S', '33712', 'Saint Petersburg', 'Florida', NULL, 27.764833, -82.669586, ''),
              (78, 93, '1825 Sunset Point Rd', '33765', 'Clearwater', 'Florida', 8000, 27.989691, -82.762177, ''),
              (79, 93, '2655 6th Ave S', '33712', 'Saint Petersburg', 'Florida', NULL, 27.764833, -82.669586, ''),
              (80, 93, '3749 Wd Judge Rd', '32808', 'Orlando', 'Florida', 110400, 28.563120, -81.421272, ''),
              (81, 93, '408 Brookmeade Dr', '32539', 'Crestview', 'Florida', 59086, 30.738317, -86.562630, ''),
              (82, 93, '5814 Merritt Brown Rd', '32404', 'Panama City', 'Florida', 5708, 30.238726, -85.557953, ''),
              (83, 93, '8286 Western Way Cir', NULL, 'Jacksonville', 'Florida', 54000, 0.000000, 0.000000, ''),
              (84, 93, '2815 Mercury Rd', NULL, 'Jacksonville', 'Florida', 8400, 0.000000, 0.000000, ''),
              (85, 93, '13907 Arnold Rhoden Rd', '32087', 'Sanderson', 'Florida', 113546, 30.251339, -82.255013, ''),
              (86, 93, '115 S 2nd St', '32034', 'Fernandina Beach', 'Florida', 18699, 30.669357, -81.464546, ''),
              (87, 93, '4541 St Augustine Rd', NULL, 'Jacksonville', 'Florida', 55000, 0.000000, 0.000000, ''),
              (88, 93, '904 S 20th St', NULL, 'Tampa', 'Florida', 59498, 0.000000, 0.000000, ''),
              (89, 93, '1020 Holland Dr', '33487', 'Boca Raton', 'Florida', 36410, 26.406157, -80.107872, ''),
              (90, 93, '8601 NW 54th St', '33166', 'Doral', 'Florida', 16000, 25.823162, -80.336540, ''),
              (91, 93, '14501 58th St N', '33760', 'Clearwater', 'Florida', 26000, 27.903803, -82.712204, ''),
              (92, 93, '1736 E Main St', '34748', 'Leesburg', 'Florida', 14400, 28.816748, -81.847122, ''),
              (93, 93, '4140 SW 30th Ave', NULL, 'Fort Lauderdale', 'Florida', 135000, 0.000000, 0.000000, ''),
              (94, 93, '51 Hypoluxo Rd', '33462', 'Latana', 'Florida', 56382, 26.570902, -80.054314, ''),
              (95, 93, '2222 NW 14th St', NULL, 'Miami', 'Florida', 4920, 0.000000, 0.000000, ''),
              (96, 93, '6942 NW 7 Ave', NULL, 'Miami', 'Florida', 14690, 0.000000, 0.000000, ''),
              (97, 93, '5800 NW 163rd St', '33014', 'Miami Lakes', 'Florida', 108507, 25.920933, -80.294983, ''),
              (98, 93, '1312 Randall Ave', NULL, 'Bronx', 'New York', 10000, 0.000000, 0.000000, ''),
              (99, 93, '2115 Jericho Tpke', NULL, 'New Hyde Park', 'New York', 20980, 0.000000, 0.000000, ''),
              (100, 93, '10 Ludlow St', NULL, 'Yonkers', 'New York', 6880, 0.000000, 0.000000, ''),
              (101, 93, '5000 Airport Executive Park', '10954', 'Nanuet', 'New York', 40000, 41.108418, -74.028114, ''),
              (102, 93, '157 21st St', NULL, 'Bronx', 'New York', 5000, 0.000000, 0.000000, ''),
              (103, 93, '146 Hanse Ave', NULL, 'Freeport', 'New York', 82717, 0.000000, 0.000000, ''),
              (104, 93, '45 Ryan Ave', NULL, 'Port Chester', 'New York', 16400, 0.000000, 0.000000, ''),
              (105, 93, '1404 Portland Ave', NULL, 'Rochester', 'New York', 3260, 0.000000, 0.000000, ''),
              (106, 93, '295 W Main', '13820', 'Oneonta', 'New York', 20280, 42.455551, -75.060188, ''),
              (107, 93, '2070 Route 52', NULL, 'Hopewell Junction', 'New York', 371480, 0.000000, 0.000000, ''),
              (108, 93, '631 State Route 15 N', NULL, 'Lake Hopatcong', 'New York', 10400, 0.000000, 0.000000, ''),
              (109, 93, '79 Carlough Rd', NULL, 'Bohemia', 'New York', 12500, 0.000000, 0.000000, ''),
              (110, 93, '93 Garvies Point Rd', '11542', 'Glen Cove', 'New York', 85000, 40.859833, -73.642502, ''),
              (111, 93, '46 Metropolitan Ave', NULL, 'Ridgewood', 'New York', 35312, 0.000000, 0.000000, ''),
              (112, 93, '333 N Bedford Rd', NULL, 'Mount Kisco', 'New York', 604095, 0.000000, 0.000000, ''),
              (113, 93, '57 Seaview Blvd', NULL, 'Port Washington', 'New York', 130853, 0.000000, 0.000000, ''),
              (114, 93, '100 Wells Ave', NULL, 'Congers', 'New York', 25000, 0.000000, 0.000000, ''),
              (115, 93, '1538 Old country Rd', NULL, 'Plainview', 'New York', 10000, 0.000000, 0.000000, ''),
              (116, 93, '230 Richardson St', NULL, 'Brooklyn', 'New York', 2500, 0.000000, 0.000000, ''),
              (117, 93, '1600 E Orangethorpe Ave', '92831', 'Fullerton', 'California', 200162, 33.858635, -117.899452, ''),
              (118, 93, '5960 Franklin Blvd', NULL, 'Sacramento', 'California', 14900, 0.000000, 0.000000, ''),
              (119, 93, '308 Palm', '93101', 'Santa Barbara', 'California', 3078, 34.418926, -119.689819, ''),
              (120, 93, '2413 Amsler', '90505', 'Torrance', 'California', 17000, 33.801975, -118.326096, ''),
              (121, 93, '16253 Gale ave', '91745', 'City of Industry', 'California', 124282, 34.009094, -117.951622, ''),
              (122, 93, '1690 Brandywine ave', '91911', 'Chula Vista', 'California', 69960, 32.595921, -117.030304, ''),
              (123, 93, '912 E 1st street', NULL, 'Pomona', 'California', 20200, 0.000000, 0.000000, ''),
              (124, 93, '3440 Airway drive', '95403', 'Santa Rosa', 'California', 21925, 38.475594, -122.737648, ''),
              (125, 93, '9685 Distribution Ave', NULL, 'San Diego', 'California', 34834, 0.000000, 0.000000, ''),
              (126, 93, '1201 Minnesota Drive', NULL, 'San Fransisco', 'California', 40000, 0.000000, 0.000000, ''),
              (127, 93, '29816 Avienda De las Banderas', '92688', 'Rancho Santa Margarita', 'California', 6180, 33.627609, -117.609558, ''),
              (128, 93, '1201 46th Ave', NULL, 'Oakland', 'California', 26048, 0.000000, 0.000000, ''),
              (129, 93, '1611 17th St', NULL, 'Oakland', 'California', 17862, 0.000000, 0.000000, ''),
              (130, 93, '745 8th Ave', '94606', 'Oakland', 'California', 41535, 37.791065, -122.254829, ''),
              (131, 93, '1450 W 228th St', NULL, 'Torrance', 'California', 12238, 0.000000, 0.000000, ''),
              (132, 93, '2325 Charter', NULL, 'Stockton', 'California', 13250, 0.000000, 0.000000, ''),
              (133, 93, '22815 Frampton', NULL, 'Torrance', 'California', 13442, 0.000000, 0.000000, ''),
              (134, 93, '3555 W Lomita Blvd', '90505', 'Torrance', 'California', 7650, 33.816254, -118.346649, ''),
              (135, 93, '2610 Columbia St', '90503', 'Torrance', 'California', 51023, 33.843353, -118.335419, ''),
              (136, 93, '9909 Hibert St', NULL, 'San Diego', 'California', 1920, 0.000000, 0.000000, ''),
              (137, 93, '4888 Ronson Connecticut', NULL, 'San Diego', 'California', 1300, 0.000000, 0.000000, ''),
              (138, 93, '6231 E Stassney Ln', '78744', 'Austin', 'Texas', 130002, 30.199549, -97.717674, ''),
              (139, 93, '13802 Turbine Dr', NULL, 'Austin', 'Texas', 15920, 0.000000, 0.000000, ''),
              (140, 93, '1912 Smith Rd', NULL, 'Austin', 'Texas', 13000, 0.000000, 0.000000, ''),
              (141, 93, '10751 Mapleridge Dr', NULL, 'Dallas', 'Texas', 10100, 0.000000, 0.000000, ''),
              (142, 93, '2931 Irving Blvd', '75247', 'Dallas', 'Texas', 32068, 32.809975, -96.853432, ''),
              (143, 93, '2930 Ladybird Ln', NULL, 'Dallas', 'Texas', 50000, 0.000000, 0.000000, ''),
              (144, 93, '530 Portwall St', NULL, 'Houston', 'Texas', 144620, 0.000000, 0.000000, ''),
              (145, 93, '8303 Knight Rd', NULL, 'Houston', 'Texas', 90000, 0.000000, 0.000000, ''),
              (146, 93, '3522 Bacor', NULL, 'Houston', 'Texas', 8000, 0.000000, 0.000000, ''),
              (147, 93, '9600 Technology Blvd', NULL, 'Fort Worth', 'Texas', 20160, 0.000000, 0.000000, ''),
              (148, 93, '500 Rainhead Rd', NULL, 'Fort Worth', 'Texas', 35213, 0.000000, 0.000000, ''),
              (149, 93, '7333 N Jack Newell Blvd', NULL, 'Fort Worth', 'Texas', 37320, 0.000000, 0.000000, ''),
              (150, 93, '2921 Suffolk Dr', NULL, 'Fort Worth', 'Texas', 3000, 0.000000, 0.000000, ''),
              (151, 93, '415 Texas Ave', NULL, 'Texas City', 'Texas', 5200, 0.000000, 0.000000, ''),
              (152, 93, '312 31st St', NULL, 'Texas City', 'Texas', 12100, 0.000000, 0.000000, ''),
              (153, 93, '3700 Thompson St', NULL, 'Austin', 'Texas', 9000, 0.000000, 0.000000, ''),
              (154, 93, '12112 Anderson Mill Rd', NULL, 'Austin', 'Texas', 6000, 0.000000, 0.000000, ''),
              (155, 93, '4018 Caven Rd', NULL, 'Austin', 'Texas', 17600, 0.000000, 0.000000, ''),
              (156, 93, '1718 N Fry Rd', NULL, 'Houston', 'Texas', 18330, 0.000000, 0.000000, ''),
              (157, 132, '827 W 34th St', NULL, 'Houston', 'Texas', 5500, 0.000000, 0.000000, '');

              UPDATE Warehouses
              SET Latitude = '32.72665', Longitude = '-97.61729'
              WHERE WarehouseID = 1;
              UPDATE Warehouses
              SET Latitude = '39.76821', Longitude = '-84.21908'
              WHERE WarehouseID = 2;
              UPDATE Warehouses
              SET Latitude = '41.12918', Longitude = '-104.73972'
              WHERE WarehouseID = 3;
              UPDATE Warehouses
              SET Latitude = '32.58496', Longitude = '-96.86586'
              WHERE WarehouseID = 4;
              UPDATE Warehouses
              SET Latitude = '49.31658', Longitude = '-123.07943'
              WHERE WarehouseID = 5;
              UPDATE Warehouses
              SET Latitude = '44.33557', Longitude = '-105.52237'
              WHERE WarehouseID = 6;
              UPDATE Warehouses
              SET Latitude = '44.32147', Longitude = '-105.52941'
              WHERE WarehouseID = 7;
              UPDATE Warehouses
              SET Latitude = '41.11075', Longitude = '-104.83266'
              WHERE WarehouseID = 8;
              UPDATE Warehouses
              SET Latitude = '41.1397', Longitude = '-104.7037'
              WHERE WarehouseID = 9;
              UPDATE Warehouses
              SET Latitude = '25.82325', Longitude = '-80.30003'
              WHERE WarehouseID = 10;
              UPDATE Warehouses
              SET Latitude = '43.68767', Longitude = '-79.35319'
              WHERE WarehouseID = 11;
              UPDATE Warehouses
              SET Latitude = '41.13111', Longitude = '-104.83022'
              WHERE WarehouseID = 12;
              UPDATE Warehouses
              SET Latitude = '42.86447', Longitude = '-106.3472'
              WHERE WarehouseID = 13;
              UPDATE Warehouses
              SET Latitude = '39.63149', Longitude = '-85.45454'
              WHERE WarehouseID = 14;
              UPDATE Warehouses
              SET Latitude = '42.85297', Longitude = '-106.30181'
              WHERE WarehouseID = 15;
              UPDATE Warehouses
              SET Latitude = '30.85063', Longitude = '-87.778'
              WHERE WarehouseID = 16;
              UPDATE Warehouses
              SET Latitude = '44.29803', Longitude = '-105.52847'
              WHERE WarehouseID = 17;
              UPDATE Warehouses
              SET Latitude = '41.35628', Longitude = '-88.36401'
              WHERE WarehouseID = 18;
              UPDATE Warehouses
              SET Latitude = '44.29878', Longitude = '-105.5279'
              WHERE WarehouseID = 19;
              UPDATE Warehouses
              SET Latitude = '44.29858', Longitude = '-105.52808'
              WHERE WarehouseID = 20;
              UPDATE Warehouses
              SET Latitude = '46.87908', Longitude = '-114.01947'
              WHERE WarehouseID = 21;
              UPDATE Warehouses
              SET Latitude = '45.75', Longitude = '-108.58229'
              WHERE WarehouseID = 22;
              UPDATE Warehouses
              SET Latitude = '45.75313', Longitude = '-108.55008'
              WHERE WarehouseID = 23;
              UPDATE Warehouses
              SET Latitude = '45.70485', Longitude = '-111.18786'
              WHERE WarehouseID = 24;
              UPDATE Warehouses
              SET Latitude = '46.93196', Longitude = '-114.09733'
              WHERE WarehouseID = 25;
              UPDATE Warehouses
              SET Latitude = '33.75055', Longitude = '-80.21884'
              WHERE WarehouseID = 26;
              UPDATE Warehouses
              SET Latitude = '45.6995', Longitude = '-111.04392'
              WHERE WarehouseID = 27;
              UPDATE Warehouses
              SET Latitude = '49.24175', Longitude = '-98.53916'
              WHERE WarehouseID = 28;
              UPDATE Warehouses
              SET Latitude = '30.58237', Longitude = '-91.1584'
              WHERE WarehouseID = 29;
              UPDATE Warehouses
              SET Latitude = '46.53843', Longitude = '-111.94675'
              WHERE WarehouseID = 30;
              UPDATE Warehouses
              SET Latitude = '30.40067', Longitude = '-90.08764'
              WHERE WarehouseID = 31;
              UPDATE Warehouses
              SET Latitude = '29.18575', Longitude = '-82.17498'
              WHERE WarehouseID = 32;
              UPDATE Warehouses
              SET Latitude = '43.75127', Longitude = '-79.46878'
              WHERE WarehouseID = 33;
              UPDATE Warehouses
              SET Latitude = '41.24594', Longitude = '-89.93413'
              WHERE WarehouseID = 34;
              UPDATE Warehouses
              SET Latitude = '47.48728', Longitude = '-111.35157'
              WHERE WarehouseID = 35;
              UPDATE Warehouses
              SET Latitude = '36.73725', Longitude = '-84.94483'
              WHERE WarehouseID = 36;
              UPDATE Warehouses
              SET Latitude = '45.70229', Longitude = '-108.62213'
              WHERE WarehouseID = 37;
              UPDATE Warehouses
              SET Latitude = '45.75644', Longitude = '-108.65107'
              WHERE WarehouseID = 38;
              UPDATE Warehouses
              SET Latitude = '61.3308', Longitude = '-149.5552'
              WHERE WarehouseID = 39;
              UPDATE Warehouses
              SET Latitude = '61.57608', Longitude = '-149.64227'
              WHERE WarehouseID = 40;
              UPDATE Warehouses
              SET Latitude = '61.61127', Longitude = '-149.33096'
              WHERE WarehouseID = 41;
              UPDATE Warehouses
              SET Latitude = '61.14929', Longitude = '-149.84259'
              WHERE WarehouseID = 42;
              UPDATE Warehouses
              SET Latitude = '64.81864', Longitude = '-147.75049'
              WHERE WarehouseID = 43;
              UPDATE Warehouses
              SET Latitude = '61.22669', Longitude = '-149.84547'
              WHERE WarehouseID = 44;
              UPDATE Warehouses
              SET Latitude = '61.16466', Longitude = '-149.88215'
              WHERE WarehouseID = 45;
              UPDATE Warehouses
              SET Latitude = '61.147941', Longitude = '-149.84507'
              WHERE WarehouseID = 46;
              UPDATE Warehouses
              SET Latitude = '61.175813', Longitude = '-149.96199'
              WHERE WarehouseID = 47;
              UPDATE Warehouses
              SET Latitude = '60.485708', Longitude = '-151.19443'
              WHERE WarehouseID = 48;
              UPDATE Warehouses
              SET Latitude = '60.725271', Longitude = '-151.31334'
              WHERE WarehouseID = 49;
              UPDATE Warehouses
              SET Latitude = '61.158998', Longitude = '-149.83281'
              WHERE WarehouseID = 50;
              UPDATE Warehouses
              SET Latitude = '60.515033', Longitude = '-151.1938'
              WHERE WarehouseID = 51;
              UPDATE Warehouses
              SET Latitude = '64.798346', Longitude = '-147.54955'
              WHERE WarehouseID = 52;
              UPDATE Warehouses
              SET Latitude = '61.12677', Longitude = '-149.87671'
              WHERE WarehouseID = 53;
              UPDATE Warehouses
              SET Latitude = '64.848906', Longitude = '-147.72692'
              WHERE WarehouseID = 54;
              UPDATE Warehouses
              SET Latitude = '61.162679', Longitude = '-149.88943'
              WHERE WarehouseID = 55;
              UPDATE Warehouses
              SET Latitude = '61.220497', Longitude = '-149.82731'
              WHERE WarehouseID = 56;
              UPDATE Warehouses
              SET Latitude = '46.87659', Longitude = '-96.811328'
              WHERE WarehouseID = 57;
              UPDATE Warehouses
              SET Latitude = '47.372021', Longitude = '-102.739605'
              WHERE WarehouseID = 58;
              UPDATE Warehouses
              SET Latitude = '48.387342', Longitude = '-102.93453'
              WHERE WarehouseID = 59;
              UPDATE Warehouses
              SET Latitude = '48.13185', Longitude = '-103.72228'
              WHERE WarehouseID = 60;
              UPDATE Warehouses
              SET Latitude = '48.131289', Longitude = '-103.72226'
              WHERE WarehouseID = 61;
              UPDATE Warehouses
              SET Latitude = '48.150034', Longitude = '-103.71893'
              WHERE WarehouseID = 62;
              UPDATE Warehouses
              SET Latitude = '47.780393', Longitude = '-103.41866'
              WHERE WarehouseID = 63;
              UPDATE Warehouses
              SET Latitude = '48.193629', Longitude = '-103.65606'
              WHERE WarehouseID = 64;
              UPDATE Warehouses
              SET Latitude = '46.292041', Longitude = '-96.611686'
              WHERE WarehouseID = 65;
              UPDATE Warehouses
              SET Latitude = '48.1476', Longitude = '-103.6181'
              WHERE WarehouseID = 66;
              UPDATE Warehouses
              SET Latitude = '48.233754', Longitude = '-101.22911'
              WHERE WarehouseID = 67;
              UPDATE Warehouses
              SET Latitude = '47.910065', Longitude = '-97.097493'
              WHERE WarehouseID = 68;
              UPDATE Warehouses
              SET Latitude = '47.918288', Longitude = '-97.645835'
              WHERE WarehouseID = 69;
              UPDATE Warehouses
              SET Latitude = '46.8792', Longitude = '-102.7896'
              WHERE WarehouseID = 70;
              UPDATE Warehouses
              SET Latitude = '48.344528', Longitude = '-103.61991'
              WHERE WarehouseID = 71;
              UPDATE Warehouses
              SET Latitude = '48.211234', Longitude = '-101.447619'
              WHERE WarehouseID = 72;
              UPDATE Warehouses
              SET Latitude = '48.256393', Longitude = '-103.60858'
              WHERE WarehouseID = 73;
              UPDATE Warehouses
              SET Latitude = '46.934936', Longitude = '-96.828303'
              WHERE WarehouseID = 74;
              UPDATE Warehouses
              SET Latitude = '46.822841', Longitude = '-96.843236'
              WHERE WarehouseID = 75;
              UPDATE Warehouses
              SET Latitude = '48.3111', Longitude = '-102.5466'
              WHERE WarehouseID = 76;
              UPDATE Warehouses
              SET Latitude = '27.76484', Longitude = '-82.66961'
              WHERE WarehouseID = 77;
              UPDATE Warehouses
              SET Latitude = '27.98944', Longitude = '-82.76228'
              WHERE WarehouseID = 78;
              UPDATE Warehouses
              SET Latitude = '27.764839', Longitude = '-82.669609'
              WHERE WarehouseID = 79;
              UPDATE Warehouses
              SET Latitude = '28.56312', Longitude = '-81.42127'
              WHERE WarehouseID = 80;
              UPDATE Warehouses
              SET Latitude = '30.73864', Longitude = '-86.5622'
              WHERE WarehouseID = 81;
              UPDATE Warehouses
              SET Latitude = '30.23878', Longitude = '-85.558'
              WHERE WarehouseID = 82;
              UPDATE Warehouses
              SET Latitude = '30.21762', Longitude = '-81.56504'
              WHERE WarehouseID = 83;
              UPDATE Warehouses
              SET Latitude = '30.27213', Longitude = '-81.62865'
              WHERE WarehouseID = 84;
              UPDATE Warehouses
              SET Latitude = '30.25135', Longitude = '-82.255013'
              WHERE WarehouseID = 85;
              UPDATE Warehouses
              SET Latitude = '39.95982', Longitude = '-84.170273'
              WHERE WarehouseID = 86;
              UPDATE Warehouses
              SET Latitude = '30.27444', Longitude = '-81.63869'
              WHERE WarehouseID = 87;
              UPDATE Warehouses
              SET Latitude = '27.943316', Longitude = '-82.437943'
              WHERE WarehouseID = 88;
              UPDATE Warehouses
              SET Latitude = '36.7415', Longitude = '-78.92848'
              WHERE WarehouseID = 89;
              UPDATE Warehouses
              SET Latitude = '25.82312', Longitude = '-80.33673'
              WHERE WarehouseID = 90;
              UPDATE Warehouses
              SET Latitude = '27.90383', Longitude = '-82.71195'
              WHERE WarehouseID = 91;
              UPDATE Warehouses
              SET Latitude = '38.29008', Longitude = '-85.80257'
              WHERE WarehouseID = 92;
              UPDATE Warehouses
              SET Latitude = '26.07069', Longitude = '-80.18148'
              WHERE WarehouseID = 93;
              UPDATE Warehouses
              SET Latitude = '26.57089', Longitude = '-80.05436'
              WHERE WarehouseID = 94;
              UPDATE Warehouses
              SET Latitude = '35.48359', Longitude = '-97.55093'
              WHERE WarehouseID = 95;
              UPDATE Warehouses
              SET Latitude = '25.94492', Longitude = '-80.20536'
              WHERE WarehouseID = 96;
              UPDATE Warehouses
              SET Latitude = '25.92009', Longitude = '-80.295'
              WHERE WarehouseID = 97;
              UPDATE Warehouses
              SET Latitude = '40.812', Longitude = '-73.88552'
              WHERE WarehouseID = 98;
              UPDATE Warehouses
              SET Latitude = '40.8447', Longitude = '-73.27773'
              WHERE WarehouseID = 99;
              UPDATE Warehouses
              SET Latitude = '40.71504', Longitude = '-73.99083'
              WHERE WarehouseID = 100;
              UPDATE Warehouses
              SET Latitude = '41.10843', Longitude = '-74.02797'
              WHERE WarehouseID = 101;
              UPDATE Warehouses
              SET Latitude = '40.66331', Longitude = '-73.99619'
              WHERE WarehouseID = 102;
              UPDATE Warehouses
              SET Latitude = '40.6479', Longitude = '-73.5733'
              WHERE WarehouseID = 103;
              UPDATE Warehouses
              SET Latitude = '40.99569', Longitude = '-73.66139'
              WHERE WarehouseID = 104;
              UPDATE Warehouses
              SET Latitude = '43.19191', Longitude = '-77.58403'
              WHERE WarehouseID = 105;
              UPDATE Warehouses
              SET Latitude = '40.87133', Longitude = '-73.428'
              WHERE WarehouseID = 106;
              UPDATE Warehouses
              SET Latitude = '41.5401', Longitude = '-73.830109'
              WHERE WarehouseID = 107;
              UPDATE Warehouses
              SET Latitude = '42.30241', Longitude = '-77.24522'
              WHERE WarehouseID = 108;
              UPDATE Warehouses
              SET Latitude = '40.77373', Longitude = '-73.0924'
              WHERE WarehouseID = 109;
              UPDATE Warehouses
              SET Latitude = '40.86023', Longitude = '-73.64199'
              WHERE WarehouseID = 110;
              UPDATE Warehouses
              SET Latitude = '42.28123', Longitude = '-71.1329'
              WHERE WarehouseID = 111;
              UPDATE Warehouses
              SET Latitude = '41.21975', Longitude = '-73.71984'
              WHERE WarehouseID = 112;
              UPDATE Warehouses
              SET Latitude = '40.81499', Longitude = '-73.66054'
              WHERE WarehouseID = 113;
              UPDATE Warehouses
              SET Latitude = '30.75986', Longitude = '-98.66293'
              WHERE WarehouseID = 114;
              UPDATE Warehouses
              SET Latitude = '40.747308', Longitude = '-73.590756'
              WHERE WarehouseID = 115;
              UPDATE Warehouses
              SET Latitude = '40.718979', Longitude = '-73.94191'
              WHERE WarehouseID = 116;
              UPDATE Warehouses
              SET Latitude = '33.857842', Longitude = '-117.9158'
              WHERE WarehouseID = 117;
              UPDATE Warehouses
              SET Latitude = '38.517974', Longitude = '-121.47027'
              WHERE WarehouseID = 118;
              UPDATE Warehouses
              SET Latitude = '34.418868', Longitude = '-119.6899'
              WHERE WarehouseID = 119;
              UPDATE Warehouses
              SET Latitude = '33.801501', Longitude = '-118.32651'
              WHERE WarehouseID = 120;
              UPDATE Warehouses
              SET Latitude = '34.008843', Longitude = '-117.95157'
              WHERE WarehouseID = 121;
              UPDATE Warehouses
              SET Latitude = '32.59571', Longitude = '-117.03006'
              WHERE WarehouseID = 122;
              UPDATE Warehouses
              SET Latitude = '34.05913', Longitude = '-117.73266'
              WHERE WarehouseID = 123;
              UPDATE Warehouses
              SET Latitude = '38.4756', Longitude = '-122.73745'
              WHERE WarehouseID = 124;
              UPDATE Warehouses
              SET Latitude = '32.88283', Longitude = '-117.16309'
              WHERE WarehouseID = 125;
              UPDATE Warehouses
              SET Latitude = '37.75494', Longitude = '-122.38945'
              WHERE WarehouseID = 126;
              UPDATE Warehouses
              SET Latitude = '33.62784', Longitude = '-117.60933'
              WHERE WarehouseID = 127;
              UPDATE Warehouses
              SET Latitude = '37.77081', Longitude = '-122.21288'
              WHERE WarehouseID = 128;
              UPDATE Warehouses
              SET Latitude = '37.8132', Longitude = '-122.29285'
              WHERE WarehouseID = 129;
              UPDATE Warehouses
              SET Latitude = '37.80234', Longitude = '-122.23887'
              WHERE WarehouseID = 130;
              UPDATE Warehouses
              SET Latitude = '33.81636', Longitude = '-118.30283'
              WHERE WarehouseID = 131;
              UPDATE Warehouses
              SET Latitude = '37.93041', Longitude = '-121.32408'
              WHERE WarehouseID = 132;
              UPDATE Warehouses
              SET Latitude = '33.81832', Longitude = '-118.29999'
              WHERE WarehouseID = 133;
              UPDATE Warehouses
              SET Latitude = '33.79865', Longitude = '-118.27612'
              WHERE WarehouseID = 134;
              UPDATE Warehouses
              SET Latitude = '33.84338', Longitude = '-118.33582'
              WHERE WarehouseID = 135;
              UPDATE Warehouses
              SET Latitude = '32.91304', Longitude = '-117.11239'
              WHERE WarehouseID = 136;
              UPDATE Warehouses
              SET Latitude = '32.83155', Longitude = '-117.14662'
              WHERE WarehouseID = 137;
              UPDATE Warehouses
              SET Latitude = '30.2011', Longitude = '-97.72123'
              WHERE WarehouseID = 138;
              UPDATE Warehouses
              SET Latitude = '30.43094', Longitude = '-97.6809'
              WHERE WarehouseID = 139;
              UPDATE Warehouses
              SET Latitude = '30.25998', Longitude = '-97.67579'
              WHERE WarehouseID = 140;
              UPDATE Warehouses
              SET Latitude = '32.88203', Longitude = '-96.69831'
              WHERE WarehouseID = 141;
              UPDATE Warehouses
              SET Latitude = '32.80942', Longitude = '-96.85241'
              WHERE WarehouseID = 142;
              UPDATE Warehouses
              SET Latitude = '32.87896', Longitude = '-96.87967'
              WHERE WarehouseID = 143;
              UPDATE Warehouses
              SET Latitude = '29.78082', Longitude = '-95.27655'
              WHERE WarehouseID = 144;
              UPDATE Warehouses
              SET Latitude = '29.68393', Longitude = '-95.39947'
              WHERE WarehouseID = 145;
              UPDATE Warehouses
              SET Latitude = '29.81969', Longitude = '-95.66823'
              WHERE WarehouseID = 146;
              UPDATE Warehouses
              SET Latitude = '32.61576', Longitude = '-97.3285'
              WHERE WarehouseID = 147;
              UPDATE Warehouses
              SET Latitude = '32.83665', Longitude = '-97.346848'
              WHERE WarehouseID = 148;
              UPDATE Warehouses
              SET Latitude = '32.79076', Longitude = '-97.219353'
              WHERE WarehouseID = 149;
              UPDATE Warehouses
              SET Latitude = '32.68686', Longitude = '-97.35937'
              WHERE WarehouseID = 150;
              UPDATE Warehouses
              SET Latitude = '31.04874', Longitude = '-95.12493'
              WHERE WarehouseID = 151;
              UPDATE Warehouses
              SET Latitude = '29.38019', Longitude = '-94.94108'
              WHERE WarehouseID = 152;
              UPDATE Warehouses
              SET Latitude = '30.26584', Longitude = '-97.69657'
              WHERE WarehouseID = 153;
              UPDATE Warehouses
              SET Latitude = '30.46006', Longitude = '-97.82901'
              WHERE WarehouseID = 154;
              UPDATE Warehouses
              SET Latitude = '30.20671', Longitude = '-97.7294'
              WHERE WarehouseID = 155;
              UPDATE Warehouses
              SET Latitude = '29.79109', Longitude = '-95.71716'
              WHERE WarehouseID = 156;
              UPDATE Warehouses
              SET Latitude = '29.81683', Longitude = '-95.41478'
              WHERE WarehouseID = 157;


              INSERT INTO `Spaces` (`SpaceID`, `WarehouseID`, `SpaceSize`, `MonthlyPrice`, `Active`, `DateAdded`, `SpaceInformation`) VALUES
              (1, 1, 10400, 1.06, 1, '2018-11-16 23:28:32', ''),
              (2, 2, 8800, 0.58, 1, '2018-11-16 23:28:32', ''),
              (3, 3, 5500, 0.58, 1, '2018-11-16 23:28:32', ''),
              (4, 4, 8080, 0.53, 1, '2018-11-16 23:28:32', ''),
              (5, 4, 9161, 0.53, 1, '2018-11-16 23:28:32', ''),
              (6, 4, 17246, 0.5, 1, '2018-11-16 23:28:32', ''),
              (7, 5, 1920, 0.54, 1, '2018-11-16 23:28:32', ''),
              (8, 6, 7344, 0.82, 1, '2018-11-16 23:28:32', 'Tires'),
              (9, 7, 16740, 0.63, 1, '2018-11-16 23:28:32', ''),
              (10, 8, 3300, 0.65, 1, '2018-11-16 23:28:32', ''),
              (11, 8, 3300, 0.65, 1, '2018-11-16 23:28:32', ''),
              (12, 8, 3300, 0.65, 1, '2018-11-16 23:28:32', ''),
              (13, 8, 12700, 0.42, 1, '2018-11-16 23:28:32', ''),
              (14, 8, 20100, 0.42, 1, '2018-11-16 23:28:32', ''),
              (15, 8, 16900, 0.38, 1, '2018-11-16 23:28:32', ''),
              (16, 8, 50500, 0.38, 1, '2018-11-16 23:28:32', ''),
              (17, 8, 16600, 0.38, 1, '2018-11-16 23:28:32', ''),
              (18, 8, 33600, 0.38, 1, '2018-11-16 23:28:32', ''),
              (19, 8, 7500, 1, 1, '2018-11-16 23:28:32', ''),
              (20, 9, 14520, 0.85, 1, '2018-11-16 23:28:32', ''),
              (21, 10, 10700, 0.75, 1, '2018-11-16 23:28:32', ''),
              (22, 11, 1600, 1.25, 1, '2018-11-16 23:28:32', ''),
              (23, 11, 1000, 1, 1, '2018-11-16 23:28:32', ''),
              (24, 12, 2300, 0.55, 1, '2018-11-16 23:28:32', ''),
              (25, 12, 3040, 0.54, 1, '2018-11-16 23:28:32', ''),
              (26, 13, 11000, 0.83, 1, '2018-11-16 23:28:32', ''),
              (27, 14, 2500, 0.83, 1, '2018-11-16 23:28:32', ''),
              (28, 15, 3150, 0.57, 1, '2018-11-16 23:28:32', ''),
              (29, 16, 9000, 0.83, 1, '2018-11-16 23:28:32', ''),
              (30, 17, 2040, 1, 1, '2018-11-16 23:28:32', ''),
              (31, 17, 2040, 1, 1, '2018-11-16 23:28:32', ''),
              (32, 18, 8800, 1.21, 1, '2018-11-16 23:28:32', ''),
              (33, 19, 3000, 1.04, 1, '2018-11-16 23:28:32', ''),
              (34, 20, 3360, 1, 1, '2018-11-16 23:28:32', ''),
              (35, 21, 2400, 1, 1, '2018-11-16 23:28:32', ''),
              (36, 22, 4403, 0.81, 1, '2018-11-16 23:28:32', ''),
              (37, 23, 25000, 0.54, 1, '2018-11-16 23:28:32', ''),
              (38, 24, 3600, 0.79, 1, '2018-11-16 23:28:32', ''),
              (39, 25, 20000, 0.79, 1, '2018-11-16 23:28:32', ''),
              (40, 26, 1330, 0.79, 1, '2018-11-16 23:28:32', ''),
              (41, 26, 800, 0.79, 1, '2018-11-16 23:28:32', ''),
              (42, 26, 2500, 0.79, 1, '2018-11-16 23:28:32', ''),
              (43, 26, 3500, 0.79, 1, '2018-11-16 23:28:32', ''),
              (44, 26, 1800, 0.79, 1, '2018-11-16 23:28:32', ''),
              (45, 27, 2650, 0.94, 1, '2018-11-16 23:28:32', ''),
              (46, 28, 500, 0.5, 1, '2018-11-16 23:28:32', ''),
              (47, 28, 500, 0.5, 1, '2018-11-16 23:28:32', ''),
              (48, 28, 500, 0.5, 1, '2018-11-16 23:28:32', ''),
              (49, 28, 500, 0.5, 1, '2018-11-16 23:28:32', ''),
              (50, 29, 20000, 0.75, 1, '2018-11-16 23:28:32', ''),
              (51, 29, 1000, 0.75, 1, '2018-11-16 23:28:32', ''),
              (52, 30, 11200, 0.42, 1, '2018-11-16 23:28:32', ''),
              (53, 31, 13200, 0.85, 1, '2018-11-16 23:28:32', ''),
              (54, 32, 2173, 0.87, 1, '2018-11-16 23:28:32', ''),
              (55, 33, 12275, 0.83, 1, '2018-11-16 23:28:32', ''),
              (56, 34, 5000, 0.6, 1, '2018-11-16 23:28:32', ''),
              (57, 35, 3725, 0.42, 1, '2018-11-16 23:28:32', ''),
              (58, 36, 22000, 0.38, 1, '2018-11-16 23:28:32', ''),
              (59, 37, 19200, 0.08, 1, '2018-11-16 23:28:32', ''),
              (60, 38, 2400, 0.5, 1, '2018-11-16 23:28:32', ''),
              (61, 38, 2400, 0.5, 1, '2018-11-16 23:28:32', ''),
              (62, 38, 2400, 0.5, 1, '2018-11-16 23:28:32', ''),
              (63, 39, 4360, 2.3, 1, '2018-11-16 23:28:32', ''),
              (64, 40, 5912, 1, 1, '2018-11-16 23:28:32', ''),
              (65, 41, 6320, 1.23, 1, '2018-11-16 23:28:32', ''),
              (66, 42, 34984, 1.1, 1, '2018-11-16 23:28:32', ''),
              (67, 43, 6000, 1, 1, '2018-11-16 23:28:32', ''),
              (68, 44, 10300, 1.15, 1, '2018-11-16 23:28:32', ''),
              (69, 45, 3500, 1.25, 1, '2018-11-16 23:28:32', ''),
              (70, 46, 29550, 0.99, 1, '2018-11-16 23:28:32', ''),
              (71, 47, 3127, 1.25, 1, '2018-11-16 23:28:32', ''),
              (72, 48, 6304, 0.62, 1, '2018-11-16 23:28:32', ''),
              (73, 49, 9204, 1.06, 1, '2018-11-16 23:28:32', ''),
              (74, 50, 1952, 1.18, 1, '2018-11-16 23:28:32', ''),
              (75, 51, 3600, 1.45, 1, '2018-11-16 23:28:32', ''),
              (76, 52, 4500, 1, 1, '2018-11-16 23:28:32', ''),
              (77, 53, 59252, 1.27, 1, '2018-11-16 23:28:32', ''),
              (78, 54, 7500, 0.7, 1, '2018-11-16 23:28:32', ''),
              (79, 55, 62668, 1.1, 1, '2018-11-16 23:28:32', ''),
              (80, 56, 10500, 1.15, 1, '2018-11-16 23:28:32', ''),
              (81, 57, 14169, 0.58, 1, '2018-11-16 23:28:32', ''),
              (82, 58, 10000, 0.81, 1, '2018-11-16 23:28:32', ''),
              (83, 59, 7000, 1.25, 1, '2018-11-16 23:28:32', ''),
              (84, 60, 19240, 1.17, 1, '2018-11-16 23:28:32', ''),
              (85, 61, 12000, 1.17, 1, '2018-11-16 23:28:32', ''),
              (86, 62, 9900, 1.13, 1, '2018-11-16 23:28:32', ''),
              (87, 62, 2000, 1.13, 1, '2018-11-16 23:28:32', ''),
              (88, 63, 10000, 1.08, 1, '2018-11-16 23:28:32', ''),
              (89, 64, 12151, 1.25, 1, '2018-11-16 23:28:32', ''),
              (90, 65, 38000, 0.44, 1, '2018-11-16 23:28:32', ''),
              (91, 66, 3500, 1.17, 1, '2018-11-16 23:28:32', ''),
              (92, 66, 3500, 1.17, 1, '2018-11-16 23:28:32', ''),
              (93, 66, 3500, 1.17, 1, '2018-11-16 23:28:32', ''),
              (94, 67, 7200, 1, 1, '2018-11-16 23:28:32', ''),
              (95, 68, 40026, 0.58, 1, '2018-11-16 23:28:32', ''),
              (96, 69, 11300, 1.5, 1, '2018-11-16 23:28:32', ''),
              (97, 70, 5000, 1, 1, '2018-11-16 23:28:32', ''),
              (98, 71, 4000, 1.5, 1, '2018-11-16 23:28:32', ''),
              (99, 72, 4000, 0.38, 1, '2018-11-16 23:28:32', ''),
              (100, 73, 5000, 1.17, 1, '2018-11-16 23:28:32', ''),
              (101, 74, 54500, 0.46, 1, '2018-11-16 23:28:32', ''),
              (102, 75, 14000, 0.49, 1, '2018-11-16 23:28:32', ''),
              (103, 75, 4960, 0.88, 1, '2018-11-16 23:28:32', ''),
              (104, 75, 7040, 0.52, 1, '2018-11-16 23:28:32', ''),
              (105, 76, 7200, 0.79, 1, '2018-11-16 23:28:32', ''),
              (106, 77, 0, 0.47, 1, '2018-11-16 23:28:32', ''),
              (107, 78, 7976, 1.17, 1, '2018-11-16 23:28:32', ''),
              (108, 79, 0, 0.47, 1, '2018-11-16 23:28:32', ''),
              (109, 80, 28078, 0.55, 1, '2018-11-16 23:28:32', ''),
              (110, 81, 59064, 0.44, 1, '2018-11-16 23:28:32', ''),
              (111, 82, 5708, 0.56, 1, '2018-11-16 23:28:32', ''),
              (112, 83, 5400, 0.65, 1, '2018-11-16 23:28:32', ''),
              (113, 83, 2700, 0.65, 1, '2018-11-16 23:28:32', ''),
              (114, 83, 2700, 0.65, 1, '2018-11-16 23:28:32', ''),
              (115, 84, 8400, 0.63, 1, '2018-11-16 23:28:32', ''),
              (116, 85, 113546, 0.27, 1, '2018-11-16 23:28:32', ''),
              (117, 86, 6315, 0.58, 1, '2018-11-16 23:28:32', ''),
              (118, 87, 2200, 0.66, 1, '2018-11-16 23:28:32', ''),
              (119, 88, 24722, 0.5, 1, '2018-11-16 23:28:32', ''),
              (120, 88, 14007, 0.5, 1, '2018-11-16 23:28:32', ''),
              (121, 89, 1108, 1.58, 1, '2018-11-16 23:28:32', ''),
              (122, 89, 1108, 1.58, 1, '2018-11-16 23:28:32', ''),
              (123, 89, 2119, 1.58, 1, '2018-11-16 23:28:32', ''),
              (124, 90, 1000, 1.25, 1, '2018-11-16 23:28:32', ''),
              (125, 91, 26000, 0.58, 1, '2018-11-16 23:28:32', ''),
              (126, 92, 14400, 0.58, 1, '2018-11-16 23:28:32', ''),
              (127, 93, 41200, 0.75, 1, '2018-11-16 23:28:32', ''),
              (128, 93, 21880, 0.75, 1, '2018-11-16 23:28:32', ''),
              (129, 94, 56382, 0.66, 1, '2018-11-16 23:28:32', ''),
              (130, 95, 1220, 0.96, 1, '2018-11-16 23:28:32', ''),
              (131, 96, 14690, 1.24, 1, '2018-11-16 23:28:32', ''),
              (132, 97, 18005, 0.79, 1, '2018-11-16 23:28:32', ''),
              (133, 98, 5000, 1.5, 1, '2018-11-16 23:28:32', ''),
              (134, 99, 10000, 2.08, 1, '2018-11-16 23:28:32', ''),
              (135, 99, 3900, 2.08, 1, '2018-11-16 23:28:32', ''),
              (136, 99, 2880, 2.08, 1, '2018-11-16 23:28:32', ''),
              (137, 99, 4200, 2.08, 1, '2018-11-16 23:28:32', ''),
              (138, 100, 6880, 1.08, 1, '2018-11-16 23:28:32', ''),
              (139, 101, 2310, 1.08, 1, '2018-11-16 23:28:32', ''),
              (140, 102, 5000, 2.46, 1, '2018-11-16 23:28:32', ''),
              (141, 103, 39614, 0.79, 1, '2018-11-16 23:28:32', ''),
              (142, 104, 16400, 1.45, 1, '2018-11-16 23:28:32', ''),
              (143, 105, 988, 1.92, 1, '2018-11-16 23:28:32', ''),
              (144, 106, 1200, 0.75, 1, '2018-11-16 23:28:32', ''),
              (145, 107, 304514, 0.67, 1, '2018-11-16 23:28:32', ''),
              (146, 108, 4000, 1.17, 1, '2018-11-16 23:28:32', ''),
              (147, 108, 6200, 1.17, 1, '2018-11-16 23:28:32', ''),
              (148, 109, 12500, 1, 1, '2018-11-16 23:28:32', ''),
              (149, 110, 2800, 1, 1, '2018-11-16 23:28:32', ''),
              (150, 111, 1000, 1.95, 1, '2018-11-16 23:28:32', ''),
              (151, 111, 1400, 1.95, 1, '2018-11-16 23:28:32', ''),
              (152, 111, 800, 1.95, 1, '2018-11-16 23:28:32', ''),
              (153, 112, 55000, 1.17, 1, '2018-11-16 23:28:32', ''),
              (154, 112, 45258, 1.17, 1, '2018-11-16 23:28:32', ''),
              (155, 113, 130853, 0.96, 1, '2018-11-16 23:28:32', ''),
              (156, 114, 12500, 0.83, 1, '2018-11-16 23:28:32', ''),
              (157, 114, 2500, 0.83, 1, '2018-11-16 23:28:32', ''),
              (158, 115, 6500, 0.88, 1, '2018-11-16 23:28:32', ''),
              (159, 115, 6477, 0.88, 1, '2018-11-16 23:28:32', ''),
              (160, 116, 1800, 3.33, 1, '2018-11-16 23:28:32', ''),
              (161, 117, 15017, 1.25, 1, '2018-11-16 23:28:32', ''),
              (162, 118, 14900, 0.5, 1, '2018-11-16 23:28:32', ''),
              (163, 119, 3078, 1.85, 1, '2018-11-16 23:28:32', ''),
              (164, 120, 5000, 1.15, 1, '2018-11-16 23:28:32', ''),
              (165, 121, 13526, 1.15, 1, '2018-11-16 23:28:32', ''),
              (166, 122, 43942, 0.79, 1, '2018-11-16 23:28:32', ''),
              (167, 123, 18719, 0.55, 1, '2018-11-16 23:28:32', ''),
              (168, 124, 8000, 4, 1, '2018-11-16 23:28:32', ''),
              (169, 125, 6512, 0.99, 1, '2018-11-16 23:28:32', ''),
              (170, 126, 20000, 1.5, 1, '2018-11-16 23:28:32', ''),
              (171, 127, 6180, 1.25, 1, '2018-11-16 23:28:32', ''),
              (172, 128, 4000, 2, 1, '2018-11-16 23:28:32', ''),
              (173, 129, 10000, 1.25, 1, '2018-11-16 23:28:32', ''),
              (174, 130, 20000, 0.89, 1, '2018-11-16 23:28:32', ''),
              (175, 131, 6300, 0.91, 1, '2018-11-16 23:28:32', ''),
              (176, 132, 61250, 0.55, 1, '2018-11-16 23:28:32', ''),
              (177, 133, 12000, 0.84, 1, '2018-11-16 23:28:32', ''),
              (178, 134, 7650, 1.35, 1, '2018-11-16 23:28:32', ''),
              (179, 135, 25000, 0.88, 1, '2018-11-16 23:28:32', ''),
              (180, 136, 1920, 1, 1, '2018-11-16 23:28:32', ''),
              (181, 137, 1000, 1.45, 1, '2018-11-16 23:28:32', ''),
              (182, 138, 21600, 0.64, 1, '2018-11-16 23:28:32', ''),
              (183, 139, 10320, 0.58, 1, '2018-11-16 23:28:32', ''),
              (184, 140, 3100, 1, 1, '2018-11-16 23:28:32', ''),
              (185, 141, 10100, 0.58, 1, '2018-11-16 23:28:32', ''),
              (186, 142, 8949, 0.63, 1, '2018-11-16 23:28:32', ''),
              (187, 143, 15000, 0.38, 1, '2018-11-16 23:28:32', ''),
              (188, 144, 144620, 0.27, 1, '2018-11-16 23:28:32', ''),
              (189, 145, 60000, 0.5, 1, '2018-11-16 23:28:32', ''),
              (190, 146, 3000, 0.8, 1, '2018-11-16 23:28:32', ''),
              (191, 147, 10000, 0.37, 1, '2018-11-16 23:28:32', ''),
              (192, 148, 9521, 0.52, 1, '2018-11-16 23:28:32', ''),
              (193, 149, 23342, 0.41, 1, '2018-11-16 23:28:32', ''),
              (194, 150, 3000, 0.58, 1, '2018-11-16 23:28:32', ''),
              (195, 151, 5200, 0.64, 1, '2018-11-16 23:28:32', ''),
              (196, 152, 12100, 0.7, 1, '2018-11-16 23:28:32', ''),
              (197, 153, 3000, 1.23, 1, '2018-11-16 23:28:32', ''),
              (198, 154, 2000, 1.15, 1, '2018-11-16 23:28:32', ''),
              (199, 155, 17600, 0.75, 1, '2018-11-16 23:28:32', ''),
              (200, 156, 3313, 1.08, 1, '2018-11-16 23:28:32', ''),
              (201, 157, 2500, 1, 1, '2018-11-16 23:28:32', '');

              CREATE TABLE IF NOT EXISTS Pictures(
                PictureID int(11) AUTO_INCREMENT,
                FileName varchar(200) UNIQUE NOT NULL,
                PRIMARY KEY(PictureID)
              );

              CREATE TABLE IF NOT EXISTS Warehouse_Pictures(
                PictureID int(11),
                WarehouseID int(11),
                PRIMARY KEY(PictureID, WarehouseID),
                FOREIGN KEY(PictureID) REFERENCES Pictures(PictureID),
                FOREIGN KEY(WarehouseID) REFERENCES Warehouses(WarehouseID)
              );


              INSERT INTO Pictures (FileName, PictureID) VALUES
              ('image1.jpg',1)
              ,('image2.jpg',2)
              ,('image3.jpg',3)
              ,('image4.jpg',4)
              ,('image5.jpg',5)
              ,('image6.jpg',6)
              ,('image7.jpg',7)
              ,('image8.jpg',8)
              ,('image9.jpg',9)
              ,('image10.jpg',10)
              ,('image11.jpg',11)
              ,('image12.jpg',12)
              ,('image13.jpg',13)
              ,('image14.jpg',14)
              ,('image15.jpg',15)
              ,('image16.jpg',16)
              ,('image17.jpg',17)
              ,('image18.jpg',18)
              ,('image19.jpg',19)
              ,('image20.jpg',20)
              ,('image21.jpg',21)
              ,('image22.jpg',22)
              ,('image23.jpg',23)
              ,('image24.jpg',24)
              ,('image25.jpg',25)
              ,('image26.jpg',26)
              ,('image27.jpg',27)
              ,('image28.jpg',28)
              ,('image29.jpg',29)
              ,('image30.jpg',30)
              ,('image31.jpg',31)
              ,('image32.jpg',32)
              ,('image33.jpg',33)
              ,('image34.jpg',34)
              ,('image35.jpg',35)
              ,('image36.jpg',36)
              ,('image37.jpg',37)
              ,('image38.jpg',38)
              ,('image39.jpg',39)
              ,('image40.jpg',40)
              ,('image41.jpg',41)
              ,('image42.jpg',42)
              ,('image43.jpg',43)
              ,('image44.jpg',44)
              ,('image45.jpg',45)
              ,('image46.jpg',46)
              ,('image47.jpg',47)
              ,('image48.jpg',48)
              ,('image49.jpg',49)
              ,('image50.jpg',50)
              ,('image51.jpg',51)
              ,('image52.jpg',52)
              ,('image53.jpg',53)
              ,('image54.jpg',54)
              ,('image55.jpg',55)
              ,('image56.jpg',56)
              ,('image57.jpg',57)
              ,('image58.jpg',58)
              ,('image59.jpg',59)
              ,('image60.jpg',60)
              ,('image61.jpg',61)
              ,('image62.jpg',62)
              ,('image63.jpg',63)
              ,('image64.jpg',64)
              ,('image65.jpg',65)
              ,('image66.jpg',66)
              ,('image67.jpg',67)
              ,('image68.jpg',68)
              ,('image69.jpg',69)
              ,('image70.jpg',70)
              ,('image71.jpg',71)
              ,('image72.jpg',72)
              ,('image73.jpg',73)
              ,('image74.jpg',74)
              ,('image75.jpg',75)
              ,('image76.jpg',76)
              ,('image77.jpg',77)
              ,('image78.jpg',78)
              ,('image79.jpg',79)
              ,('image80.jpg',80)
              ,('image81.jpg',81)
              ,('image82.jpg',82)
              ,('image83.jpg',83)
              ,('image84.jpg',84)
              ,('image85.jpg',85)
              ,('image86.jpg',86)
              ,('image87.jpg',87)
              ,('image88.jpg',88)
              ,('image89.jpg',89)
              ,('image90.jpg',90)
              ,('image91.jpg',91)
              ,('image92.jpg',92)
              ,('image93.jpg',93)
              ,('image94.jpg',94)
              ,('image95.jpg',95)
              ,('image96.jpg',96)
              ,('image97.jpg',97)
              ,('image98.jpg',98)
              ,('image99.jpg',99)
              ,('image100.jpg',100)
              ,('image101.jpg',101)
              ,('image102.jpg',102)
              ,('image103.jpg',103)
              ,('image104.jpg',104)
              ,('image105.jpg',105)
              ,('image106.jpg',106)
              ,('image107.jpg',107)
              ,('image108.jpg',108)
              ,('image109.jpg',109)
              ,('image110.jpg',110)
              ,('image111.jpg',111)
              ,('image112.jpg',112)
              ,('image113.jpg',113)
              ,('image114.jpg',114)
              ,('image115.jpg',115)
              ,('image116.jpg',116)
              ,('image117.jpg',117)
              ,('image118.jpg',118)
              ,('image119.jpg',119)
              ,('image120.jpg',120)
              ,('image121.jpg',121)
              ,('image122.jpg',122)
              ,('image123.jpg',123)
              ,('image124.jpg',124)
              ,('image125.jpg',125)
              ,('image126.jpg',126)
              ,('image127.jpg',127)
              ,('image128.jpg',128)
              ,('image129.jpg',129)
              ,('image130.jpg',130)
              ,('image131.jpg',131)
              ,('image132.jpg',132)
              ,('image133.jpg',133)
              ,('image134.jpg',134)
              ,('image135.jpg',135)
              ,('image136.jpg',136)
              ,('image137.jpg',137)
              ,('image138.jpg',138)
              ,('image139.jpg',139)
              ,('image140.jpg',140)
              ,('image141.jpg',141)
              ,('image142.jpg',142)
              ,('image143.jpg',143)
              ,('image144.jpg',144)
              ,('image145.jpg',145)
              ,('image146.jpg',146)
              ,('image147.jpg',147)
              ,('image148.jpg',148)
              ,('image149.jpg',149)
              ,('image150.jpg',150);

              INSERT INTO Warehouse_Pictures(WarehouseID,PictureID) VALUES
              (1,1)
              ,(1,2)
              ,(2,3)
              ,(3,4)
              ,(3,5)
              ,(4,6)
              ,(4,7)
              ,(5,8)
              ,(6,9)
              ,(6,10)
              ,(6,11)
              ,(7,12)
              ,(7,13)
              ,(8,14)
              ,(9,15)
              ,(9,16)
              ,(10,17)
              ,(10,18)
              ,(11,19)
              ,(11,20)
              ,(11,21)
              ,(11,22)
              ,(12,23)
              ,(13,24)
              ,(13,25)
              ,(14,26)
              ,(14,27)
              ,(15,28)
              ,(15,29)
              ,(15,30)
              ,(16,31)
              ,(16,32)
              ,(16,33)
              ,(17,34)
              ,(17,35)
              ,(17,36)
              ,(17,37)
              ,(18,38)
              ,(18,39)
              ,(19,40)
              ,(19,41)
              ,(20,42)
              ,(21,43)
              ,(22,44)
              ,(22,45)
              ,(22,46)
              ,(22,47)
              ,(23,48)
              ,(24,49)
              ,(24,50)
              ,(24,51)
              ,(25,52)
              ,(25,53)
              ,(25,54)
              ,(25,55)
              ,(25,56)
              ,(26,57)
              ,(26,58)
              ,(27,59)
              ,(27,60)
              ,(28,61)
              ,(28,62)
              ,(28,63)
              ,(29,64)
              ,(29,65)
              ,(29,66)
              ,(30,67)
              ,(30,68)
              ,(31,69)
              ,(31,70)
              ,(31,71)
              ,(32,72)
              ,(33,73)
              ,(33,74)
              ,(33,75)
              ,(33,76)
              ,(34,77)
              ,(34,78)
              ,(35,79)
              ,(35,80)
              ,(35,81)
              ,(36,82)
              ,(37,83)
              ,(37,84)
              ,(38,85)
              ,(38,86)
              ,(38,87)
              ,(39,88)
              ,(39,89)
              ,(40,90)
              ,(40,91)
              ,(41,92)
              ,(41,93)
              ,(41,94)
              ,(42,95)
              ,(42,96)
              ,(42,97)
              ,(43,98)
              ,(44,99)
              ,(44,100)
              ,(44,101)
              ,(45,102)
              ,(45,103)
              ,(46,104)
              ,(46,105)
              ,(46,106)
              ,(47,107)
              ,(47,108)
              ,(47,109)
              ,(48,110)
              ,(48,111)
              ,(48,112)
              ,(49,113)
              ,(49,114)
              ,(49,115)
              ,(50,116)
              ,(51,117)
              ,(51,118)
              ,(51,119)
              ,(51,120)
              ,(52,121)
              ,(52,122)
              ,(53,123)
              ,(53,124)
              ,(53,125)
              ,(54,126)
              ,(55,127)
              ,(55,128)
              ,(56,129)
              ,(57,130)
              ,(57,131)
              ,(57,132)
              ,(58,133)
              ,(58,134)
              ,(58,135)
              ,(59,136)
              ,(59,137)
              ,(60,138)
              ,(60,139)
              ,(61,140)
              ,(61,141)
              ,(61,142)
              ,(61,143)
              ,(62,144)
              ,(63,145)
              ,(63,146)
              ,(64,147)
              ,(64,148)
              ,(64,149)
              ,(64,150)
              ,(65,124)
              ,(65,125)
              ,(66,126)
              ,(67,127)
              ,(67,128)
              ,(68,129)
              ,(69,130)
              ,(60,131)
              ,(70,132)
              ,(70,133)
              ,(70,134)
              ,(70,135)
              ,(71,136)
              ,(71,137)
              ,(72,138)
              ,(72,139)
              ,(72,140)
              ,(72,141)
              ,(72,142)
              ,(1,147)
              ,(2,14)
              ,(3,103)
              ,(4,56)
              ,(5,87)
              ,(6,18)
              ,(7,104)
              ,(8,91)
              ,(9,6)
              ,(10,48)
              ,(11,72)
              ,(12,107)
              ,(13,32)
              ,(14,127)
              ,(15,27)
              ,(16,149)
              ,(17,44)
              ,(18,66)
              ,(19,75)
              ,(20,131)
              ,(21,13)
              ,(22,29)
              ,(23,30)
              ,(24,93)
              ,(25,118)
              ,(26,19)
              ,(27,97)
              ,(28,33)
              ,(29,24)
              ,(30,89)
              ,(31,123)
              ,(32,128)
              ,(33,5)
              ,(34,12)
              ,(35,30)
              ,(36,2)
              ,(37,58)
              ,(38,12)
              ,(39,81)
              ,(40,27)
              ,(41,128)
              ,(42,32)
              ,(43,22)
              ,(44,125)
              ,(45,34)
              ,(46,25)
              ,(47,61)
              ,(48,71)
              ,(49,34)
              ,(50,136)
              ,(51,121)
              ,(52,85)
              ,(53,70)
              ,(54,100)
              ,(55,71)
              ,(56,13)
              ,(57,22)
              ,(58,78)
              ,(59,51)
              ,(60,61)
              ,(61,79)
              ,(62,2)
              ,(63,91)
              ,(64,6)
              ,(65,85)
              ,(66,57)
              ,(67,14)
              ,(68,125)
              ,(69,13)
              ,(70,83)
              ,(71,32)
              ,(72,54)
              ,(73,34)
              ,(74,91)
              ,(75,118)
              ,(76,20)
              ,(77,38)
              ,(78,101)
              ,(79,18)
              ,(80,9)
              ,(81,128)
              ,(82,26)
              ,(83,139)
              ,(84,22)
              ,(85,75)
              ,(86,84)
              ,(87,119)
              ,(88,72)
              ,(89,89)
              ,(90,22)
              ,(91,66)
              ,(92,103)
              ,(93,107)
              ,(94,57)
              ,(95,78)
              ,(96,133)
              ,(97,51)
              ,(98,51)
              ,(99,118)
              ,(100,30)
              ,(101,34)
              ,(102,73)
              ,(103,61)
              ,(104,7)
              ,(105,23)
              ,(106,21)
              ,(107,116)
              ,(108,117)
              ,(109,123)
              ,(110,74)
              ,(111,69)
              ,(112,56)
              ,(113,143)
              ,(114,108)
              ,(115,145)
              ,(116,80)
              ,(117,67)
              ,(118,22)
              ,(119,63)
              ,(120,133)
              ,(121,47)
              ,(122,107)
              ,(123,68)
              ,(124,34)
              ,(125,30)
              ,(126,69)
              ,(127,57)
              ,(128,148)
              ,(129,127)
              ,(130,91)
              ,(131,135)
              ,(132,134)
              ,(133,69)
              ,(134,19)
              ,(135,82)
              ,(136,25)
              ,(137,11)
              ,(138,15)
              ,(139,107)
              ,(140,59)
              ,(141,35)
              ,(142,72)
              ,(143,133)
              ,(144,52)
              ,(145,138)
              ,(146,106)
              ,(147,83)
              ,(148,97)
              ,(149,85)
              ,(150,19)
              ,(151,109)
              ,(152,150)
              ,(153,95)
              ,(154,39)
              ,(155,115)
              ,(156,115)
              ,(157,114)
              ,(158,13)
              ,(159,31)
              ,(160,11)
              ,(161,38)
              ,(162,108)
              ,(163,52)
              ,(164,81)
              ,(165,81)
              ,(166,96)
              ,(167,22)
              ,(168,116)
              ,(169,68)
              ,(170,140)
              ,(171,84)
              ,(172,47)
              ,(173,6)
              ,(174,125)
              ,(175,135)
              ,(176,81)
              ,(177,120)
              ,(178,93)
              ,(179,100)
              ,(180,102)
              ,(181,108)
              ,(182,99)
              ,(183,91)
              ,(184,121)
              ,(185,74)
              ,(186,125)
              ,(187,10)
              ,(188,78)
              ,(189,42)
              ,(190,57)
              ,(191,24)
              ,(192,30)
              ,(193,141)
              ,(194,7)
              ,(195,46)
              ,(196,132)
              ,(197,14)
              ,(198,38)
              ,(199,3)
              ,(200,123)
              ,(201,26)
              ,(202,64)
              ,(203,104)
              ,(204,80)
              ,(205,112)
              ,(206,88)
              ,(207,143)
              ,(208,77)
              ,(209,126)
              ,(210,143)
              ,(211,148)
              ,(212,97)
              ,(213,145)
              ,(214,116)
              ,(215,25)
              ,(216,75)
              ,(217,52)
              ,(218,139)
              ,(219,61)
              ,(220,100)
              ,(221,145)
              ,(222,16)
              ,(223,29)
              ,(224,119)
              ,(225,92)
              ,(226,125)
              ,(227,92)
              ,(228,75)
              ,(229,66)
              ,(230,85)
              ,(231,137)
              ,(232,148)
              ,(233,69)
              ,(234,51)
              ,(235,92)
              ,(236,98)
              ,(237,128)
              ,(238,37)
              ,(239,6)
              ,(240,53)
              ,(241,139)
              ,(242,42)
              ,(243,7)
              ,(244,24)
              ,(245,31)
              ,(246,63)
              ,(247,42)
              ,(248,130)
              ,(249,14)
              ,(250,7)
              ,(251,85)
              ,(252,70)
              ,(253,31)
              ,(254,43)
              ,(255,104)
              ,(256,108)
              ,(257,6)
              ,(258,116)
              ,(259,42)
              ,(260,123)
              ,(261,26)
              ,(262,119)
              ,(263,123)
              ,(264,112)
              ,(265,94)
              ,(266,72)
              ,(267,100)
              ,(268,13)
              ,(269,132)
              ,(270,28)
              ,(271,82)
              ,(272,20)
              ,(273,85)
              ,(274,75)
              ,(275,118)
              ,(276,48)
              ,(277,145)
              ,(278,137)
              ,(279,45)
              ,(280,125)
              ,(281,126)
              ,(282,70)
              ,(283,132)
              ,(284,53)
              ,(285,112)
              ,(286,76)
              ,(287,85)
              ,(288,64)
              ,(289,76)
              ,(290,72)
              ,(291,132)
              ,(292,138)
              ,(293,38)
              ,(294,149)
              ,(295,136)
              ,(296,43)
              ,(297,87)
              ,(298,52)
              ,(299,149)
              ,(300,144)
              ,(301,72)
              ,(302,127)
              ,(303,110)
              ,(304,85)
              ,(305,10)
              ,(306,6)
              ,(307,11)
              ,(308,47)
              ,(309,59)
              ,(310,109)
              ,(311,125)
              ,(312,24)
              ,(313,43)
              ,(314,10)
              ,(315,50)
              ,(316,43)
              ,(317,115)
              ,(318,145)
              ,(319,91)
              ,(320,35)
              ,(321,54)
              ,(322,102)
              ,(323,53)
              ,(324,46)
              ,(325,71)
              ,(326,66)
              ,(327,65)
              ,(328,2)
              ,(329,72)
              ,(330,36)
              ,(331,124)
              ,(332,51)
              ,(333,102)
              ,(334,130)
              ,(335,113)
              ,(336,75)
              ,(337,92)
              ,(338,138)
              ,(339,9)
              ,(340,132)
              ,(341,64)
              ,(342,112)
              ,(343,16)
              ,(344,85)
              ,(345,6)
              ,(346,32)
              ,(347,145)
              ,(348,7)
              ,(349,89)
              ,(350,80)
              ,(351,43)
              ,(352,101)
              ,(353,129)
              ,(354,48)
              ,(355,78)
              ,(356,31)
              ,(357,101)
              ,(358,104)
              ,(359,144)
              ,(360,39)
              ,(361,80)
              ,(362,29)
              ,(363,14)
              ,(364,102)
              ,(365,110)
              ,(366,145)
              ,(367,103)
              ,(368,111)
              ,(369,124)
              ,(370,6)
              ,(371,113)
              ,(372,9)
              ,(373,40)
              ,(374,59)
              ,(375,112)
              ,(376,69)
              ,(377,67)
              ,(378,142)
              ,(379,26)
              ,(380,131)
              ,(381,107)
              ,(382,49)
              ,(383,140)
              ,(384,7)
              ,(385,32)
              ,(386,4)
              ,(387,47)
              ,(388,125)
              ,(389,148)
              ,(390,86)
              ,(391,116)
              ,(392,63)
              ,(393,147)
              ,(394,39)
              ,(395,71)
              ,(396,143)
              ,(397,44)
              ,(398,40)
              ,(399,30)
              ,(400,109)
              ,(401,8)
              ,(402,133)
              ,(403,117)
              ,(404,32)
              ,(405,123)
              ,(406,41)
              ,(407,7)
              ,(408,95)
              ,(409,9)
              ,(410,64)
              ,(411,15)
              ,(412,82)
              ,(413,85)
              ,(414,138)
              ,(415,80)
              ,(416,51)
              ,(417,93)
              ,(418,27)
              ,(419,26)
              ,(420,98)
              ,(421,62)
              ,(422,84)
              ,(423,80)
              ,(424,113)
              ,(425,9)
              ,(426,100)
              ,(427,16)
              ,(428,103)
              ,(429,62)
              ,(430,26)
              ,(431,108)
              ,(432,73)
              ,(433,97)
              ,(434,146)
              ,(435,82)
              ,(436,111)
              ,(437,89)
              ,(438,27)
              ,(439,133)
              ,(440,54)
              ,(441,144)
              ,(442,25)
              ,(443,60)
              ,(444,61)
              ,(445,107)
              ,(446,49)
              ,(447,118)
              ,(448,94)
              ,(449,94)
              ,(450,3)
              ,(451,148)
              ,(452,62)
              ,(453,41)
              ,(454,61)
              ,(455,24)
              ,(456,66)
              ,(457,41)
              ,(458,129)
              ,(459,40)
              ,(460,78)
              ,(461,121)
              ,(462,16)
              ,(463,140)
              ,(464,147)
              ,(465,134)
              ,(466,63)
              ,(467,72)
              ,(468,129)
              ,(469,146)
              ,(470,93)
              ,(471,93)
              ,(472,50)
              ,(473,133)
              ,(474,141)
              ,(475,11)
              ,(476,57)
              ,(477,12)
              ,(478,61)
              ,(479,144)
              ,(480,107)
              ,(481,113)
              ,(482,67)
              ,(483,96)
              ,(484,110)
              ,(485,60)
              ,(486,135)
              ,(487,10)
              ,(488,130)
              ,(489,66)
              ,(490,112)
              ,(491,30)
              ,(492,13)
              ,(493,31)
              ,(494,27)
              ,(495,132)
              ,(496,27)
              ,(497,142)
              ,(498,127)
              ,(499,97)
              ,(500,8)
              ,(501,44)
              ,(502,1)
              ,(503,21)
              ,(504,2)
              ,(505,144)
              ,(506,136)
              ,(507,11)
              ,(508,15)
              ,(509,6)
              ,(510,129)
              ,(511,90)
              ,(512,146)
              ,(513,79)
              ,(514,100)
              ,(515,94)
              ,(516,145)
              ,(517,63)
              ,(518,60)
              ,(519,135)
              ,(520,29)
              ,(521,139)
              ,(522,4)
              ,(523,1)
              ,(524,85)
              ,(525,85)
              ,(526,100)
              ,(527,98)
              ,(528,103)
              ,(529,142)
              ,(530,125)
              ,(531,72)
              ,(532,28)
              ,(533,147)
              ,(534,111)
              ,(535,46)
              ,(536,2)
              ,(537,9)
              ,(538,24)
              ,(539,124)
              ,(540,92)
              ,(541,92)
              ,(542,133)
              ,(543,92)
              ,(544,89)
              ,(545,143)
              ,(546,16)
              ,(547,139)
              ,(548,120)
              ,(549,64)
              ,(550,38)
              ,(551,41)
              ,(552,16)
              ,(553,18)
              ,(554,101)
              ,(555,106)
              ,(556,101)
              ,(557,80)
              ,(558,128)
              ,(559,56)
              ,(560,91)
              ,(561,98)
              ,(562,79)
              ,(563,101)
              ,(564,143)
              ,(565,123)
              ,(566,143)
              ,(567,108)
              ,(568,7)
              ,(569,77)
              ,(570,127)
              ,(571,97)
              ,(572,52)
              ,(573,106)
              ,(574,35)
              ,(575,136)
              ,(576,70)
              ,(577,43)
              ,(578,123)
              ,(579,15)
              ,(580,93)
              ,(581,109)
              ,(582,15)
              ,(583,120)
              ,(584,147)
              ,(585,38)
              ,(586,7)
              ,(587,136)
              ,(588,20)
              ,(589,86)
              ,(590,51)
              ,(591,109)
              ,(592,75)
              ,(593,1)
              ,(594,120)
              ,(595,93)
              ,(596,27)
              ,(597,56)
              ,(598,55)
              ,(599,143)
              ,(600,56)
              ,(601,115)
              ,(602,6)
              ,(603,108)
              ,(604,80)
              ,(605,67)
              ,(606,149)
              ,(607,60)
              ,(608,130)
              ,(609,8)
              ,(610,131)
              ,(611,41)
              ,(612,99)
              ,(613,90)
              ,(614,69)
              ,(615,136)
              ,(616,64)
              ,(617,100)
              ,(618,42)
              ,(619,82)
              ,(620,120)
              ,(621,18)
              ,(622,74)
              ,(623,81)
              ,(624,107)
              ,(625,128)
              ,(626,82)
              ,(627,111)
              ,(628,91)
              ,(629,74)
              ,(630,71)
              ,(631,93)
              ,(632,147)
              ,(633,23)
              ,(634,79)
              ,(635,101)
              ,(636,29)
              ,(637,95)
              ,(638,140)
              ,(639,7)
              ,(640,141)
              ,(641,77)
              ,(642,49)
              ,(643,11)
              ,(644,59)
              ,(645,17)
              ,(646,125)
              ,(647,37)
              ,(648,29)
              ,(649,34)
              ,(650,134)
              ,(651,86)
              ,(652,34)
              ,(653,52)
              ,(654,114)
              ,(655,106)
              ,(656,97)
              ,(657,101)
              ,(658,83)
              ,(659,38)
              ,(660,117)
              ,(661,50)
              ,(662,74)
              ,(663,123)
              ,(664,109)
              ,(665,83)
              ,(666,88)
              ,(667,80)
              ,(668,147)
              ,(669,13)
              ,(670,108)
              ,(671,4)
              ,(672,38)
              ,(673,90)
              ,(674,7)
              ,(675,31)
              ,(676,3)
              ,(677,75)
              ,(678,31)
              ,(679,73)
              ,(680,46)
              ,(681,46)
              ,(682,129)
              ,(683,23)
              ,(684,77)
              ,(685,71)
              ,(686,136)
              ,(687,111)
              ,(688,3)
              ,(689,97)
              ,(690,98)
              ,(691,9)
              ,(692,20)
              ,(693,139)
              ,(694,76)
              ,(695,106)
              ,(696,56)
              ,(697,19)
              ,(698,33)
              ,(699,54)
              ,(700,90)
              ,(701,133)
              ,(702,8)
              ,(703,15)
              ,(704,83)
              ,(705,111)
              ,(706,59)
              ,(707,17)
              ,(708,149)
              ,(709,4)
              ,(710,113)
              ,(711,70)
              ,(712,55)
              ,(713,121)
              ,(714,34)
              ,(715,30)
              ,(716,13)
              ,(717,132)
              ,(718,137)
              ,(719,43)
              ,(720,57)
              ,(721,58)
              ,(722,106)
              ,(723,127)
              ,(724,60)
              ,(725,82)
              ,(726,66)
              ,(727,78)
              ,(728,91)
              ,(729,137)
              ,(730,72)
              ,(731,56)
              ,(732,95)
              ,(733,84)
              ,(734,12)
              ,(735,7)
              ,(736,88)
              ,(737,10)
              ,(738,37)
              ,(739,139)
              ,(740,15)
              ,(741,107)
              ,(742,38)
              ,(743,87)
              ,(744,31)
              ,(745,57)
              ,(746,42)
              ,(747,131)
              ,(748,140)
              ,(749,141)
              ,(750,23)
              ,(751,83)
              ,(752,47)
              ,(753,80)
              ,(754,17)
              ,(755,29)
              ,(756,68)
              ,(757,13)
              ,(758,23)
              ,(759,78)
              ,(760,121)
              ,(761,123)
              ,(762,101)
              ,(763,46)
              ,(764,34)
              ,(765,105)
              ,(766,143)
              ,(767,3)
              ,(768,20)
              ,(769,137)
              ,(770,15)
              ,(771,141)
              ,(772,39)
              ,(773,149)
              ,(774,106)
              ,(775,108)
              ,(776,137)
              ,(777,68)
              ,(778,90)
              ,(779,145)
              ,(780,135)
              ,(781,17)
              ,(782,116)
              ,(783,130)
              ,(784,106)
              ,(785,104)
              ,(786,127)
              ,(787,113)
              ,(788,30)
              ,(789,11)
              ,(790,8)
              ,(791,88)
              ,(792,105)
              ,(793,43)
              ,(794,57)
              ,(795,143)
              ,(796,105)
              ,(797,124)
              ,(798,85)
              ,(799,135)
              ,(800,41)
              ,(801,11)
              ,(802,102)
              ,(803,53)
              ,(804,107)
              ,(805,129)
              ,(806,108)
              ,(807,44)
              ,(808,86)
              ,(809,95)
              ,(810,62)
              ,(811,145)
              ,(812,32)
              ,(813,15)
              ,(814,114)
              ,(815,146)
              ,(816,139)
              ,(817,8)
              ,(818,149)
              ,(819,88)
              ,(820,89)
              ,(821,21)
              ,(822,19)
              ,(823,117)
              ,(824,128)
              ,(825,3)
              ,(826,5)
              ,(827,50)
              ,(828,121)
              ,(829,9)
              ,(830,42)
              ,(831,26)
              ,(832,105)
              ,(833,56)
              ,(834,41)
              ,(835,129)
              ,(836,32)
              ,(837,77)
              ,(838,69)
              ,(839,96)
              ,(840,21)
              ,(841,61)
              ,(842,102)
              ,(843,58)
              ,(844,42)
              ,(845,4)
              ,(846,51)
              ,(847,56)
              ,(848,134)
              ,(849,80)
              ,(850,28)
              ,(851,74)
              ,(852,78)
              ,(853,12)
              ,(854,97)
              ,(855,115)
              ,(856,59)
              ,(857,2)
              ,(858,149)
              ,(859,84)
              ,(860,77)
              ,(861,128)
              ,(862,131)
              ,(863,72)
              ,(864,150)
              ,(865,92)
              ,(866,72)
              ,(867,147)
              ,(868,95)
              ,(869,75)
              ,(870,96)
              ,(871,78)
              ,(872,108)
              ,(873,77)
              ,(874,69)
              ,(875,25)
              ,(876,15)
              ,(877,143)
              ,(878,11)
              ,(879,77)
              ,(880,108)
              ,(881,31)
              ,(882,34)
              ,(883,124)
              ,(884,23)
              ,(885,7)
              ,(886,98)
              ,(887,26)
              ,(888,46)
              ,(889,77)
              ,(890,100)
              ,(891,24)
              ,(892,16)
              ,(893,33)
              ,(894,73)
              ,(895,74)
              ,(896,139)
              ,(897,66)
              ,(898,70)
              ,(899,124)
              ,(900,31)
              ,(901,25)
              ,(902,61)
              ,(903,109)
              ,(904,57)
              ,(905,93)
              ,(906,103)
              ,(907,98)
              ,(908,77)
              ,(909,136)
              ,(910,71)
              ,(911,110)
              ,(912,25)
              ,(913,75)
              ,(914,95)
              ,(915,92)
              ,(916,71)
              ,(917,27)
              ,(918,94)
              ,(919,65)
              ,(920,91)
              ,(921,43)
              ,(922,138)
              ,(923,56)
              ,(924,72)
              ,(925,122)
              ,(926,142)
              ,(927,76)
              ,(928,133)
              ,(929,132)
              ,(930,102)
              ,(931,43)
              ,(932,18);

              CREATE TABLE IF NOT EXISTS Notification_Types_Types (
                TypeTypeID int(11) AUTO_INCREMENT,
                TypeTypeShortName varchar(12) UNIQUE,
                TypeTypeName varchar(30),
                TypeTypeIcon varchar(30),
                PRIMARY KEY(TypeTypeID)
              );


              INSERT INTO Warehouses(OwnerID,Address,ZipCode,City,State,Latitude,Longitude,BuildingSize) VALUES
              (170,'984 Poland Ave',44511,'YOUNGSTOWN','Ohio',41.09,-80.64,40314)
              ,(118,'1553 2nd St',99812,'STATE OF ALASKA','Alaska',58.28,-134.4,38825)
              ,(6,'23867 S Whiteside Rd',67570,'PRETTY PRAIRE','Kansas',37.78,-98.01,21213)
              ,(4,'737 Academy Rd',24258,'HILTONS','Virginia',36.65,-82.46,33286)
              ,(71,'20 Knoll St',6878,'RIVERSIDE','Connecticut',41.03,-73.58,36692)
              ,(357,'6330 Dodge St',68106,'OMAHA','Nebraska',41.26,-96.01,15812)
              ,(203,'38 Grapevine Pl',12110,'NEWTONVILLE','New York',42.74,-73.74,37567)
              ,(302,'600 Ave R Nebraska',33882,'WINTER HAVEN','Florida',28.04,-81.72,23575)
              ,(52,'910 SW 3rd Ave',73448,'MARIETTA','Oklahoma',33.93,-97.12,22505)
              ,(131,'199 Rodeo Rd',65020,'GREENVIEW','Missouri',38,-92.74,32228)
              ,(136,'51 Old Richmond Rd',40729,'VICTORY','Kentucky',37.18,-84.11,30316)
              ,(188,'920 E 4th St',68978,'SUPERIOR','Nebraska',40.02,-98.06,37915)
              ,(273,'11801 Rebel Pass',37934,'CONCORD FARR','Tennessee',35.87,-84.17,35812)
              ,(141,'58397 Stevens St',48048,'NEW HAVEN','Michigan',42.73,-82.79,16312)
              ,(376,'17363 31st Dr SE',98012,'BOTHELL','Washington',47.84,-122.19,13892)
              ,(134,'3798 Shenot Rd',15095,'BULK MAIL CTR','Pennsylvania',40.64,-80.09,13215)
              ,(27,'1399 Shelly Ln',8003,'WOODCREST','New Jersey',39.9,-74.99,18016)
              ,(150,'225 Funny Farm Rd',16667,'SAINT CLAIRSVILLE','Pennsylvania',40.18,-78.53,17696)
              ,(308,'1188 S Tippecanoe Ave',92412,'SAN BERNARDINO','California',34.08,-117.26,29195)
              ,(100,'4858 Garland Ave',75270,'DALLAS','Texas',32.79,-96.76,17709)
              ,(395,'143 Cragford Rd',36251,'ASHLAND','Alabama',33.27,-85.83,16685)
              ,(233,'42 Depot St',13649,'HELENA','New York',44.92,-74.72,22257)
              ,(149,'2050 E Windsor Rd',13813,'NINEVEH','New York',42.19,-75.6,23330)
              ,(281,'5162 Danielsville St',30647,'ILA','Georgia',34.17,-83.29,32439)
              ,(157,'501 Saint Andrews Ln',80027,'LOUISVILLE','Colorado',39.96,-105.14,15932)
              ,(105,'231 Roosevelt St',49028,'BRONSON','Michigan',41.87,-85.19,19292)
              ,(101,'5080 Washington Ave',60163,'MELROSE PARK','Illinois',41.88,-87.91,23810)
              ,(121,'10023 Nebraska Beech St',97220,'MAYWOOD PK','Oregon',45.55,-122.56,40635)
              ,(29,'153 Melbourne St',13850,'TWIN ORCHARDS','New York',42.08,-76.05,11347)
              ,(358,'698 Saint Clair Ave',43228,'LINCOLN VILLAGE FIN UNIT','Ohio',39.98,-82.98,17468)
              ,(250,'376 SW 1st Connecticut',33063,'COCONUT CREEK','Florida',26.23,-80.13,32589)
              ,(5,'1782 Morgan St',71070,'SALINE','Louisiana',32.16,-92.97,40788)
              ,(124,'101 Roundhouse Rd',17872,'HUNTER','Pennsylvania',40.78,-76.55,34128)
              ,(199,'3900 Crittenden St',20783,'LANGLEY PARK','Maryland',38.95,-76.95,30544)
              ,(138,'1169 Bonita Ave',94040,'Montana VIEW','California',37.38,-122.08,19790)
              ,(108,'638 W French Pl',78234,'FORT SAM HOUSTON','Texas',29.45,-98.5,19960)
              ,(292,'1129 2nd St SE',52498,'CEDAR RAPIDS','Iowa',41.97,-91.66,13589)
              ,(141,'7485 Mystic Lake Rd',48632,'LAKE','Michigan',43.85,-85,25698)
              ,(380,'8725 S Main St',13431,'POLAND','New York',43.22,-75.06,25633)
              ,(53,'517 W Delaware Ave',8310,'BUENA VISTA TOWNSHIP','New Jersey',39.52,-74.94,40505)
              ,(25,'1572 Alabama Tahoe Blvd',96158,'SOUTH LAKE TAHOE','California',38.92,-119.96,20872)
              ,(143,'778 SE 8th St',34478,'OCALA','Florida',29.18,-82.13,39966)
              ,(355,'198 E Avant',78017,'DIVOT','Texas',28.66,-99.17,38295)
              ,(328,'5320 Harbor Light Dr',77539,'DICKINSON','Texas',29.45,-95.06,32866)
              ,(35,'313 E Horner St',36502,'MCCULLOUGH','Alabama',31.02,-87.49,28885)
              ,(385,'1457 S Chambers Rd',80015,'CENTENNIAL','Colorado',39.69,-104.81,38085)
              ,(8,'274 E Washington St',65084,'GLENSTED','Missouri',38.43,-92.84,34854)
              ,(17,'1298 8th Ave',98101,'SEATTLE','Washington',47.61,-122.33,25626)
              ,(189,'177 Pine View Acers',27252,'GOLDSTON','North Carolina',35.59,-79.32,25406)
              ,(44,'1684 Main St',38849,'ALMA','Mississippi',34.44,-88.66,11934)
              ,(302,'9471 Burning Oaks Ln',20635,'HELEN','Maryland',38.41,-76.73,25072)
              ,(299,'623 Cinnaminson St',8076,'RIVERTON','New Jersey',40.01,-75.01,22993)
              ,(208,'1940 Utah 118',56629,'MANITOU','Minnesota',48.62,-94.1,23251)
              ,(174,'20 Westchester Dr',11789,'SCOTTS BEACH','New York',40.95,-72.96,14266)
              ,(332,'46 Conover Ave',7110,'NUTLEY','New Jersey',40.81,-74.15,35253)
              ,(268,'1091 S Vance St',27330,'BUFFALO LAKE','North Carolina',35.47,-79.18,22948)
              ,(322,'638 W French Pl',78270,'SAN ANTONIO','Texas',29.45,-98.5,39214)
              ,(272,'329 Sweetcreek Dr',63021,'SHERMAN','Missouri',38.59,-90.55,36909)
              ,(281,'673 2nd Ave N',37241,'REGIONS BANK','Tennessee',36.17,-86.78,36592)
              ,(172,'198 Niobrara Ave',68977,'STAMFORD','Nebraska',40.13,-99.59,19154)
              ,(79,'120 McKinley Dr',11951,'VILLAGE OF MASTIC BEACH','New York',40.76,-72.84,31952)
              ,(247,'562 W Youmans St',31418,'SAVANNAH','Georgia',32.08,-81.1,22568)
              ,(41,'1064 Shelburne Rd',5403,'S BTV','Vermont',44.44,-73.21,32670)
              ,(284,'253 E Water St',41041,'FLEMINGSBURG','Kentucky',38.42,-83.73,20287)
              ,(364,'23 Hughes St Nebraska',32548,'OKALOOSA IS','Florida',30.42,-86.61,23005)
              ,(32,'1711 Bluebonnet Place Cir',77061,'HOUSTON','Texas',29.76,-95.38,40310)
              ,(312,'1927 Berkshire Ln',80917,'Colorado SPGS','Colorado',38.86,-104.76,19725)
              ,(73,'743 Myrtle Rd',8902,'NORTH BRUNSWICK','New Jersey',40.45,-74.48,14466)
              ,(171,'299 E Grand Ave',45458,'CENTERVILLE','Ohio',39.77,-84.19,16071)
              ,(89,'298 S Maple St',8096,'DEPTFORD TOWNSHIP','New Jersey',39.83,-75.15,36244)
              ,(175,'2 Quarry Ln',4033,'FREEPORT','Maine',43.85,-70.1,25215)
              ,(301,'1776 S Monroe St',46803,'FORT WAYNE','Indiana',41.07,-85.13,18585)
              ,(92,'398 Lakeside Dr',4575,'W BOOTHBAY HA','Maine',43.85,-69.65,14211)
              ,(373,'3098 Illinois Ave',76544,'MONTAGUE VILLAGE','Texas',31.09,-97.71,18084)
              ,(257,'201 Nunley Rd',24884,'SQUIRE','West Virginia',37.26,-81.56,38924)
              ,(326,'7744 Lake Tahoe Ave',92159,'SAN DIEGO','California',32.8,-117.03,18820)
              ,(124,'21899 S Western Ave',90501,'TORRANCE','California',33.83,-118.31,30609)
              ,(393,'889 Ward Ave',96808,'HON','Hawaii',21.3,-157.85,24738)
              ,(258,'550 E F St',93581,'TEHACHAPI','California',35.13,-118.44,25156)
              ,(283,'1446 Kosciusko Blvd',46323,'HESSVILLE','Indiana',41.62,-87.49,29372)
              ,(308,'1499 Arkansas Connecticut',22192,'PRINCE WILLIAM','Virginia',38.63,-77.26,32857)
              ,(390,'183 Allison Rd',13337,'OAKSVILLE','New York',42.71,-74.98,10898)
              ,(331,'63 Church St',17236,'MARKES','Pennsylvania',39.83,-77.9,33367)
              ,(54,'2638 Hayes St',33025,'PEMBROKE PINES','Florida',26.02,-80.16,29172)
              ,(375,'101 Washington St',71901,'FOUNTAIN LAKE','Arkansas',34.5,-93.05,18838)
              ,(49,'924 Taylor Rd',17312,'CRALEY','Pennsylvania',39.95,-76.54,20398)
              ,(279,'375 E Chestnut St',27371,'MORATOCK','North Carolina',35.36,-79.89,10083)
              ,(302,'12978 Townwood Dr',77247,'HOUSTON','Texas',29.64,-95.43,19854)
              ,(256,'1364 S Maryland Ave',65890,'SPRINGFIELD','Missouri',37.19,-93.28,26901)
              ,(183,'3144 Canyon Valley Trl',75094,'ALLEN','Texas',33.04,-96.74,14974)
              ,(183,'889 Ward Ave',96848,'HONO','Hawaii',21.3,-157.85,22359)
              ,(278,'1753 NW 70th Ave',33148,'EASTERN AIRLINES','Florida',25.79,-80.31,13733)
              ,(160,'468 S 1st St',72459,'RAVENDEN','Arkansas',36.23,-91.25,24381)
              ,(380,'2738 Saint Marys St',27675,'WESTGATE','North Carolina',35.82,-78.65,25350)
              ,(99,'37 Albert Ave',19018,'PRIMOS','Pennsylvania',39.92,-75.29,15513)
              ,(379,'598 Arikaree Ave',69045,'WAUNETA','Nebraska',40.41,-101.37,21178)
              ,(90,'741 SW Main St',71322,'BUNKIE','Louisiana',30.95,-92.18,16642)
              ,(357,'1298 Tanner Ave',31554,'BICKLEY','Georgia',31.51,-82.63,12551)
              ,(101,'101 Kater Ave',47060,'WEST HARRISON','Indiana',39.26,-84.82,27447)
              ,(338,'140 Cedar St',6147,'HARTFORD','Connecticut',41.76,-72.68,10540)
              ,(183,'252 E 3rd St',16693,'GANISTER','Pennsylvania',40.46,-78.2,23641)
              ,(75,'137 4th St',16933,'KELLYTOWN','Pennsylvania',41.8,-77.07,32229)
              ,(364,'257 W Asher St',22701,'HAYWOOD','Virginia',38.47,-78,34688)
              ,(213,'2302 10th Ave S',55418,'ST ANTHNY VLG','Minnesota',44.96,-93.26,37877)
              ,(275,'300 SW 4th St',33261,'NORTH MIAMI BEACH','Florida',25.77,-80.2,35337)
              ,(47,'3101 1st Ave S',35295,'ALA GAS CORP','Alabama',33.52,-86.79,36168)
              ,(324,'858 Hanover St',77957,'EDNA','Texas',28.97,-96.64,35588)
              ,(253,'510 Shelby Dry Fork',41562,'SUTTON','Kentucky',37.42,-82.49,30772)
              ,(262,'99 Hunter Dr',35553,'DOUBLE SPRINGS','Alabama',34.14,-87.4,37249)
              ,(275,'2979 E Las Hermanas St',90221,'EAST RANCHO DOMINGUEZ','California',33.87,-118.21,30635)
              ,(114,'100 Sanders St',73041,'GOTEBO','Oklahoma',35.07,-98.87,37896)
              ,(323,'1111 Throckmorton St',76199,'FT WORTH','Texas',32.75,-97.33,11725)
              ,(386,'2222 40th Pl',50062,'MELCHER-DALLAS','Iowa',41.2,-93.27,21984)
              ,(249,'2874 L St',68508,'LINCOLN','Nebraska',40.81,-96.68,33205)
              ,(191,'1927 Berkshire Ln',80951,'COLORADO SPGS','Colorado',38.86,-104.76,34576)
              ,(165,'12721 Chicago St',36530,'MIFLIN','Alabama',30.41,-87.6,19843)
              ,(354,'98 Northbound Gratiot Ave',48046,'MOUNT CLEMENS','Michigan',42.59,-82.88,14124)
              ,(222,'708 S Palm Ave',34243,'SARASOTA','Florida',27.33,-82.54,26142)
              ,(4,'8055 Colorado Rd 48',34797,'HOWEY Indiana THE HILLS','Florida',28.74,-81.82,38457)
              ,(68,'10097 Franktown Rd',23413,'WEIRWOOD','Virginia',37.47,-75.86,18261)
              ,(103,'1 E Cherry St',11722,'S HAUPPAUGE','New York',40.78,-73.19,21522)
              ,(362,'117 Hardy Hill Rd',15431,'DUNBAR','Pennsylvania',39.97,-79.61,15824)
              ,(280,'109 Central Ave',10580,'RYE','New York',40.98,-73.69,20621)
              ,(320,'875 Prairie Ave SE',55321,'COKATO','Minnesota',45.07,-94.18,10420)
              ,(296,'275 Potter St',48861,'MULLIKEN','Michigan',42.76,-84.89,38350)
              ,(391,'7266 US Hwy 27',32038,'FORT WHITE','Florida',29.92,-82.71,32112)
              ,(67,'6290 Davis Blvd',76180,'FORT WORTH','Texas',32.86,-97.21,33423)
              ,(190,'47-65 45th St',11104,'LONG ISLAND CITY','New York',40.74,-73.92,18593)
              ,(268,'773 S 2nd St',76656,'GOODVILLE','Texas',31.2,-97.03,11436)
              ,(229,'47 Wood Park Ln',12090,'WALLOOMSAC','New York',42.9,-73.35,18265)
              ,(355,'2 Commanche Cir',72525,'HARDY','Arkansas',36.3,-91.53,32067)
              ,(72,'399 Marvin Ave',65014,'CLEAVESVILLE','Missouri',38.3,-91.63,34662)
              ,(299,'4601 S Thousand Oaks Dr',84124,'MURRAY','Utah',40.67,-111.79,34249)
              ,(108,'3886 Lewisberry Rd',17339,'PINETOWN','Pennsylvania',40.13,-76.86,27110)
              ,(363,'99 Covewood Cir',72212,'LITTLE ROCK','Arkansas',34.72,-92.35,23459)
              ,(249,'5299 Frew St',15289,'PITTSBURGH','Pennsylvania',40.44,-79.94,13475)
              ,(153,'94 Galloway Rd',10990,'WARWICK','New York',41.25,-74.35,34860)
              ,(381,'358 Hartford Ave',50367,'CITIGROUP','Iowa',41.57,-93.61,15345)
              ,(159,'1455 4th Ave',11040,'NORTH HILLS','New York',40.73,-73.68,10265)
              ,(234,'300 Williams St',49251,'LESLIE','Michigan',42.45,-84.43,36491)
              ,(266,'138 Woodhaven Dr',39365,'UNION','Mississippi',32.57,-89.11,15687)
              ,(42,'16 Camp Yankee Rd',6282,'WOODSTOCK VALLEY','Connecticut',41.92,-72.1,24155)
              ,(216,'276 Dick Rd',48834,'FENWICK','Michigan',43.14,-85.08,14493)
              ,(29,'25898 Brush Creek Rd',97336,'CRAWFORDSVILLE','Oregon',44.35,-122.85,36169)
              ,(357,'1825 E Heather Ave',85234,'GILBERT','Arizona',33.36,-111.75,37021)
              ,(266,'1215 S Country Club Dr',87301,'MANUELITO','New Mexico',35.52,-108.73,16586)
              ,(57,'521 E 12th St',88101,'CANNON AFB','New Mexico',34.41,-103.2,33151)
              ,(246,'9780 E Baseline Rd',85208,'MESA','Arizona',33.38,-111.63,25714)
              ,(179,'300 SW 4th St',33157,'SOUTH MIAMI HEIGHTS','Florida',25.77,-80.2,27359)
              ,(147,'898 Hampton Connecticut',33327,'PLANTATION','Florida',26.11,-80.39,25747)
              ,(88,'27 Nelson Ave',12866,'SARATOGA SPRINGS','New York',43.06,-73.77,33078)
              ,(274,'901 E 4th St',73015,'CARNEGIE','Oklahoma',35.1,-98.59,10888)
              ,(128,'276 Bacons Neck Rd',8323,'GREENWICH TOWNSHIP','New Jersey',39.39,-75.36,32767)
              ,(152,'248 Fourth St',56757,'STEPHEN','Minnesota',48.45,-96.87,34628)
              ,(185,'62 Reed Dr',39422,'BAY SPRINGS','Mississippi',31.98,-89.28,39691)
              ,(370,'539 Buena Vista St',51002,'HANOVER','Iowa',42.67,-95.3,20814)
              ,(306,'3882 Martin Farm Rd',30024,'JOHNS CREEK','Georgia',34.05,-84.07,26455)
              ,(197,'355 Renwick Ave',13205,'COLVIN','New York',43.04,-76.14,11316)
              ,(35,'1111 Throckmorton St',76193,'FORT WORTH','Texas',32.75,-97.33,37254)
              ,(177,'10 Garwood Rd',7452,'GLEN ROCK','New Jersey',40.95,-74.12,35730)
              ,(392,'300 SW 4th St',33174,'SWEETWATER','Florida',25.77,-80.2,16426)
              ,(131,'10154 Martin Luther King Blvd',80225,'LAKEWOOD','Colorado',39.76,-104.87,21767)
              ,(221,'889 Ward Ave',96844,'UNIVERSITY OF HAWAII','Hawaii',21.3,-157.85,16534)
              ,(63,'1711 Bluebonnet Place Cir',77030,'HOUSTON','Texas',29.76,-95.38,14827)
              ,(353,'758 W 12th St',32406,'PANAMA CITY','Florida',30.17,-85.67,38673)
              ,(266,'737 Academy Rd',24258,'HILTONS','Virginia',36.65,-82.46,22100)
              ,(232,'2255 N 37th St',53237,'MILWAUKEE','Wisconsin',43.06,-87.96,27124)
              ,(59,'3854 Rome Rd',13142,'PULASKI','New York',43.56,-76.12,19765)
              ,(141,'98 Rutgers Slip',10055,'NEW YORK','New York',40.71,-73.99,34195)
              ,(369,'14515 Shireen Dr',44149,'CLEVELAND','Ohio',41.31,-81.85,15960)
              ,(215,'241499 Walnut St',73658,'EAGLE CITY','Oklahoma',35.93,-98.7,22920)
              ,(375,'901 2nd St SE',57345,'HOWELL','South Dakota',44.52,-99.43,25602)
              ,(397,'310 Turner McCall Blvd',30161,'ROME','Georgia',34.26,-85.18,28565)
              ,(173,'398 S 8th St',54405,'ABBOTSFORD','Wisconsin',44.94,-90.31,20957)
              ,(346,'699 Bellmont St',62863,'COWLING','Illinois',38.41,-87.77,24425)
              ,(366,'98 Rutgers Slip',10018,'NEW YORK','New York',40.71,-73.99,40372)
              ,(4,'545 E Eastwood Dr',67001,'ANDALE','Kansas',37.79,-97.62,13965)
              ,(337,'1023 S Kansas St',66966,'SCANDIA','Kansas',39.79,-97.78,29357)
              ,(215,'312 Willow Tree Ln',35175,'UNION GROVE','Alabama',34.4,-86.44,40468)
              ,(3,'305 Rockaway Ave',11580,'VALLEY STREAM','New York',40.66,-73.7,40677)
              ,(376,'1307 15th St',25779,'HUNTINGTON','West Virginia',38.41,-82.43,39872)
              ,(221,'487 Hidden Ridges Way',54113,'COMBINED LCKS','Wisconsin',44.26,-88.31,24143)
              ,(104,'502 Mc Cabes Way',47353,'ROSEBURG','Indiana',39.63,-84.92,15974)
              ,(282,'5708 Hwy Y',63036,'FRENCH VILLAGE','Missouri',37.97,-90.38,12286)
              ,(18,'98 Eves Dr',5148,'LONDONDERRY','Vermont',43.22,-72.8,13428)
              ,(367,'499 Person St',28301,'EASTOVER','North Carolina',35.05,-78.87,37518)
              ,(8,'758 W 12th St',32408,'PANAMA CITY BEACH','Florida',30.17,-85.67,23241)
              ,(321,'1881 Holly View Dr',23062,'GLOUCESTER POINT','Virginia',37.26,-76.49,25106)
              ,(339,'666 Greenbrier Dr',22406,'FREDBG','Virginia',38.29,-77.48,35048)
              ,(239,'5504 Homestead Rd',24149,'FAIRVIEW','Virginia',37.02,-80.43,30447)
              ,(260,'34 Hudson St',2217,'BOSTON','Massachusetts',42.35,-71.06,29302)
              ,(173,'624 3rd St SE',50401,'PORTLAND','Iowa',43.15,-93.19,35206)
              ,(235,'197 Coal St',18705,'PLAINS','Pennsylvania',41.24,-75.87,10982)
              ,(235,'38 Pumphouse Rd',5443,'LINCOLN','Vermont',44.13,-73.08,21659)
              ,(253,'388 E South St',62075,'WENONAH','Illinois',39.3,-89.28,11689)
              ,(1,'503 Carbon Glow Rd',41616,'DAVID','Kentucky',37.16,-82.95,20765)
              ,(206,'669 E Eagle St',14240,'BUFFALO','New York',42.88,-78.85,20192)
              ,(398,'577 Parkhill Dr',59112,'Montana DAKOTA UTIL Colorado','Montana',45.79,-108.53,13971)
              ,(3,'6713 Brecksville Rd',44131,'VALLEY VIEW','Ohio',41.38,-81.64,35387)
              ,(321,'790 Ladner St',39475,'PINE RIDGE','Mississippi',31.14,-89.4,37268)
              ,(97,'50 E Railroad St',46747,'SALEM CENTER','Indiana',41.53,-85.08,11171)
              ,(259,'1059 Marion St',29240,'COLUMBIA','South Carolina',34,-81.03,17738)
              ,(59,'299 E Grand Ave',45459,'WASHINGTO TWP','Ohio',39.77,-84.19,34364)
              ,(279,'16799 187th Ave Nebraska',98072,'COTTAGE LAKE','Washington',47.75,-122.09,22897)
              ,(363,'1994 Ayers Rd',94521,'CONCORD','California',37.97,-121.96,12550)
              ,(336,'791 Myers Chapel Rd',28904,'HAYESVILLE','North Carolina',35.04,-83.81,28838)
              ,(368,'5753 Colonial Dr',34655,'SEVEN SPRINGS','Florida',28.24,-82.71,15718)
              ,(227,'1172 10th Ave E',98102,'SEATTLE','Washington',47.63,-122.32,19472)
              ,(199,'1259 W 200 S',84015,'CLINTON','Utah',41.11,-112.05,29630)
              ,(329,'612 Orchard St',18509,'SCRANTON','Pennsylvania',41.4,-75.66,27764)
              ,(3,'234 Depot Hill Rd',13833,'SANITARIA SPG','New York',42.16,-75.83,39701)
              ,(330,'299 E Grand Ave',45415,'DAYTON','Ohio',39.77,-84.19,20077)
              ,(353,'1711 Bluebonnet Place Cir',77297,'CHASE BANK OF Texas','Texas',29.76,-95.38,26609)
              ,(373,'319 E Washington St',44022,'SOUTH RUSSELL','Ohio',41.43,-81.38,25743)
              ,(50,'98 Rutgers Slip',10028,'MANHATTAN','New York',40.71,-73.99,13328)
              ,(143,'80 McLean St',48203,'HIGHLAND PARK','Michigan',42.4,-83.09,22643)
              ,(221,'821 SE 13th St',56401,'BRAINERD','Minnesota',46.35,-94.19,26226)
              ,(104,'237 E Church St',28018,'SUNSHINE','North Carolina',35.36,-81.83,35546)
              ,(137,'1699 Center Ave',60411,'FORD HEIGHTS','Illinois',41.5,-87.63,19963)
              ,(272,'1528 John Fitch Blvd',6088,'WAREHOUSE POINT','Connecticut',41.85,-72.6,14944)
              ,(269,'146 Center Hill Rd',6063,'PLEASANT VALLEY','Connecticut',41.93,-72.97,20816)
              ,(274,'15 Henry St',1550,'SOUTHBRIDGE','Massachusetts',42.08,-72.03,10765)
              ,(351,'60 S Prospect St',44818,'BLOOMVILLE','Ohio',41.05,-83.01,32979)
              ,(36,'429 Adams St',60150,'MALTA','Illinois',41.93,-88.86,36927)
              ,(62,'474 N Market St',21701,'HOOD COLLEGE','Maryland',39.42,-77.41,37785)
              ,(364,'1101 Vermont Ave',83725,'BOISE STATE UNIVERSITY','Idaho',43.6,-116.2,35177)
              ,(390,'75 Orchard Dr',3049,'HOLLIS','New Hampshire',42.73,-71.58,38135)
              ,(108,'5753 Colonial Dr',34656,'NEW PT RICHEY','Florida',28.24,-82.71,16722)
              ,(291,'77 Robanette Connecticut',41074,'DAYTON','Kentucky',39.11,-84.46,17184)
              ,(16,'23898 Head of Creek Rd',21856,'WHITEHAVEN','Maryland',38.32,-75.79,35006)
              ,(196,'650 Travis St',71291,'DEAN CHAPEL','Louisiana',32.51,-92.14,28086)
              ,(8,'301 9th St E',58854,'WATFORD CITY','North Dakota',47.8,-103.27,18677)
              ,(218,'532 Circle Dr',79061,'OLD MOBEETIE','Texas',35.53,-100.44,14171)
              ,(106,'122 W 3rd South St',61377,'LEEDS','Illinois',41.05,-89.05,21312)
              ,(145,'9881 Tamarack Ave',91331,'LOS ANGELES','California',34.25,-118.41,13766)
              ,(18,'404 State Hwy 32',6254,'FRANKLIN','Connecticut',41.61,-72.14,36352)
              ,(390,'37 E 17th St',8006,'BARNEGAT LIGHT','New Jersey',39.75,-74.11,29332)
              ,(90,'75 Mandon Dr',7470,'PACKANACK LAKE','New Jersey',40.94,-74.24,28235)
              ,(129,'6067 106th St Nebraska',58339,'HANSBORO','North Dakota',48.95,-99.38,13965)
              ,(137,'101 3rd Ave',58479,'LEAL','North Dakota',47.07,-98.2,16641)
              ,(268,'3948 Klein Ave',44224,'CUYAHOGA FALLS','Ohio',41.17,-81.43,18163)
              ,(16,'1689 N Belle St',92406,'SN BERNRDNO','California',34.13,-117.28,40477)
              ,(237,'700 Windsor St',19508,'ROBESON','Pennsylvania',40.26,-75.81,12833)
              ,(188,'281 S Spring Garden St',19002,'PROSPECTVILLE','Pennsylvania',40.15,-75.22,37109)
              ,(76,'1162 Forrest St',40224,'LOUISVILLE','Kentucky',38.22,-85.74,27538)
              ,(272,'575 S Walnut Ave',73117,'OKLAHOMA CITY','Oklahoma',35.46,-97.51,10558)
              ,(101,'805 S Main St',48380,'MILFORD','Michigan',42.58,-83.6,14761)
              ,(349,'1827 Main St',90407,'SANTA MONICA','California',34.01,-118.49,24553)
              ,(349,'19645 State Hwy 12F',13615,'PADDY HILL','New York',44,-75.98,35241)
              ,(269,'779 W Vernon Ave',28504,'KINSTON','North Carolina',35.27,-77.59,22334)
              ,(183,'128 Pinedale Rd',32713,'DEBARY','Florida',28.88,-81.32,39389)
              ,(257,'3511 S Leavitt St',60626,'CHICAGO','Illinois',41.83,-87.68,22151)
              ,(89,'870 Dows St',57030,'GARRETSON','South Dakota',43.71,-96.5,20143)
              ,(121,'488 Martin Blvd',48630,'HOUGHTON LAKE HEIGHTS','Michigan',44.27,-84.76,36699)
              ,(294,'1650 Minnesota Ave',54492,'STEVENS POINT','Wisconsin',44.52,-89.56,26010)
              ,(399,'12976 Colorado Rd 43',35176,'VANDIVER','Alabama',33.48,-86.5,28792)
              ,(372,'766 Kellogg St SE',49518,'KENTWOOD','Michigan',42.96,-85.65,33110)
              ,(41,'9 Park Ln Pl',11758,'NORTH MASSAPEQUA','New York',40.66,-73.47,25536)
              ,(351,'698 Monroe Ave',82935,'GREEN RIVER','Wyoming',41.51,-109.46,24520)
              ,(39,'1 Casablanca Connecticut',12065,'HALFMOON','New York',42.85,-73.8,21068)
              ,(347,'84 Stapleton Rd',1111,'MASS MUTUAL LIFE INS Colorado','Massachusetts',42.11,-72.53,12440)
              ,(228,'1533 Trace Creek-Marion Ridge Rd',45696,'WILLOW WOOD','Ohio',38.59,-82.45,13982)
              ,(328,'4897 State Hwy 401',40145,'HUDSON','Kentucky',37.65,-86.28,12488)
              ,(30,'747 N Park Ave',31793,'TIFTON','Georgia',31.46,-83.51,36734)
              ,(320,'1834 Kennedy Dr',29020,'DUSTY BEND','South Carolina',34.26,-80.61,27246)
              ,(273,'109 S 12th St',19188,'HOSIERY CORP OF AMERICA','Pennsylvania',39.95,-75.16,32191)
              ,(155,'698 Saint Clair Ave',43279,'COLUMBUS','Ohio',39.98,-82.98,32861)
              ,(259,'56 Cypress Ln',11967,'SMITH POINT','New York',40.79,-72.87,22337)
              ,(32,'666 Greenbrier Dr',22407,'FREDERICKSBURG','Virginia',38.29,-77.48,15677)
              ,(72,'512 E Hanna St',46725,'TRI LAKES','Indiana',41.15,-85.48,18303)
              ,(156,'566 S Jefferson Ave',38506,'COOKEVL','Tennessee',36.15,-85.5,17307)
              ,(121,'1697 Cofrin Dr',54302,'PREBLE','Wisconsin',44.52,-87.98,11874)
              ,(374,'312 E Wapakoneta St',45896,'WAYNESFIELD','Ohio',40.6,-83.97,27054)
              ,(280,'298 Van Buren Ave',32746,'HEATHROW','Florida',28.75,-81.33,14093)
              ,(200,'84 Oak St',44076,'ORWELL','Ohio',41.53,-80.85,19202)
              ,(16,'14561 Cam del Norte',92199,'SAN DIEGO','California',32.99,-117.07,22323)
              ,(392,'2699 Taylor Rd',92413,'DEL ROSA','California',34.14,-117.25,13071)
              ,(234,'2738 Saint Marys St',27634,'N C DEPT REVENUE','North Carolina',35.82,-78.65,37999)
              ,(243,'297 N Alabama Rd',77488,'BURR','Texas',29.31,-96.09,19054)
              ,(211,'359 Fire Island Ave',11702,'BABYLON','New York',40.69,-73.32,16555)
              ,(169,'5468 Yolanda Ave',91357,'TARZANA','California',34.17,-118.54,16663)
              ,(344,'401 Truman Pkwy',2136,'HYDE PARK','Massachusetts',42.26,-71.11,13800)
              ,(386,'780 Caswell St',2718,'TAUNTON','Massachusetts',41.87,-71.01,30279)
              ,(380,'1672 N St',47421,'BEDFORD HEIGHTS','Indiana',38.86,-86.49,22168)
              ,(290,'476 Mortimer St',28657,'SPEAR','North Carolina',36.08,-81.92,37672)
              ,(125,'1697 Cofrin Dr',54311,'BELLEVUE','Wisconsin',44.52,-87.98,39898)
              ,(54,'1218 Mahoning Mountain Rd',18212,'ASHFIELD','Pennsylvania',40.81,-75.72,29748)
              ,(83,'656 E Catherine St',17201,'RED BRIDGE','Pennsylvania',39.93,-77.65,32864)
              ,(100,'3 Foothill Rd',89430,'SMITH','Nevada',38.8,-119.32,15891)
              ,(86,'1807 Mill Connecticut',52732,'CLINTON','Iowa',41.84,-90.23,28346)
              ,(371,'399 S Holloway St',47882,'LAKE SULLIVAN','Indiana',39.09,-87.4,19546)
              ,(31,'118 W Brooklyn Ave',37096,'FLATWOODS','Tennessee',35.61,-87.84,20856)
              ,(361,'30270 Fooks Ln',21890,'EASTERN CORRECTIONAL INST','Maryland',38.12,-75.7,26966)
              ,(393,'50 Linden Ln',11968,'SOUTHAMPTON','New York',40.88,-72.39,12765)
              ,(370,'4414 Old Hamilton Mill Rd',30515,'BUFORD','Georgia',34.11,-83.99,25050)
              ,(236,'532 E 9th St',57580,'WEAVER','South Dakota',43.37,-99.85,31861)
              ,(10,'201 SW Mission Rd',64064,'LEES SUMMIT','Missouri',38.91,-94.38,20122)
              ,(127,'4617 E 106th St',90002,'AUGUST F. HAW','California',33.94,-118.24,14200)
              ,(207,'378 W 17th St',72198,'NORTH LITTLE ROCK','Arkansas',34.77,-92.27,12564)
              ,(148,'2302 10th Ave S',55411,'MINNEAPOLIS','Minnesota',44.96,-93.26,11527)
              ,(100,'435 Mount Pleasant Ave',7983,'WHIPPANY','New Jersey',40.82,-74.41,12463)
              ,(263,'98 Rutgers Slip',10001,'GREELEY SQUARE','New York',40.71,-73.99,38556)
              ,(301,'1923 McGee St',64188,'Kansas CITY','Missouri',39.09,-94.58,39864)
              ,(8,'5099 Leota Connecticut',89150,'LAS VEGAS','Nevada',36.12,-115.21,11859)
              ,(4,'699 Washington St',80743,'OTIS','Colorado',40.14,-102.96,23811)
              ,(274,'1788 Wall St',90015,'DOWTOWN CARRIER ANNEX','California',34.03,-118.26,36945)
              ,(186,'98 Rutgers Slip',10107,'MANHATTAN','New York',40.71,-73.99,32363)
              ,(159,'4345 N Wyss Ln',61614,'PEORIA','Illinois',40.74,-89.6,18399)
              ,(170,'1198 New St',62274,'PINCKNEYVILLE','Illinois',38.07,-89.38,34904)
              ,(350,'938 Washington Heights Ter NW',30388,'ATL','Georgia',33.76,-84.42,17757)
              ,(217,'3101 1st Ave S',35231,'BIRMINGHAM','Alabama',33.52,-86.79,25647)
              ,(18,'298 Boone St N',57256,'ORTLEY','South Dakota',45.33,-97.2,28479)
              ,(387,'653 Leewood Dr',72512,'FRANKLIN','Arkansas',36.22,-91.74,23204)
              ,(383,'30555 29th Ave S',98580,'ROY','Washington',46.98,-122.47,31324)
              ,(109,'5830 Hawkins Corners Rd',13363,'STOKES','New York',43.3,-75.51,39703)
              ,(1,'5119 Schatulga Rd',31997,'AT&T UNIVERSAL CARD SERVICE','Georgia',32.51,-84.87,20698)
              ,(146,'2501 Wharton St',15216,'PGH','Pennsylvania',40.43,-79.97,17654)
              ,(316,'3190 Independence Rd',44112,'CLEVELAND','Ohio',41.47,-81.67,38490)
              ,(173,'217-1 94th Ave',11429,'QUEENS VILLAGE','New York',40.72,-73.74,10794)
              ,(97,'53 Slate Rd',1021,'CHICOPEE','Massachusetts',42.17,-72.57,20292)
              ,(151,'327 Hoyle Ave',36507,'BROMLEY','Alabama',30.88,-87.77,37037)
              ,(188,'18731 Hwy T14',52574,'GARFIELD','Iowa',40.77,-92.94,10392)
              ,(24,'211 Dickson St',46218,'INDIANAPOLIS','Indiana',39.77,-86.14,18731)
              ,(56,'273 E 2nd St',8016,'BURLINGTON CITY','New Jersey',40.07,-74.85,28107)
              ,(384,'540 Woodland Way',29622,'ANDERSON','South Carolina',34.51,-82.64,26722)
              ,(297,'698 Saint Clair Ave',43204,'VALLEYVIEW','Ohio',39.98,-82.98,38709)
              ,(187,'411 Holland St',29169,'WESTOVER ACRES','South Carolina',33.99,-81.08,14226)
              ,(334,'8600 W Benview Dr',89164,'LAS VEGAS','Nevada',36.12,-115.28,39700)
              ,(200,'4435 Delaware Rd',66732,'ELSMORE','Kansas',37.79,-95.14,39217)
              ,(392,'731 S Spring Ave',63133,'GREENDALE','Missouri',38.63,-90.24,30665)
              ,(266,'4616 Bluff Dr',28459,'SHALLOTTE','North Carolina',33.97,-78.38,25336)
              ,(125,'2255 N 37th St',53214,'W MILWAUKEE','Wisconsin',43.06,-87.96,38208)
              ,(342,'6046 Hemlock Dr',13367,'HARRISBURG','New York',43.78,-75.48,28627)
              ,(306,'352 Texas St',52620,'BONAPARTE','Iowa',40.7,-91.8,11979)
              ,(270,'2 Red River St',78733,'BEE CAVE','Texas',30.26,-97.74,25062)
              ,(322,'28 S Stockton St',8691,'TRENTON','New Jersey',40.22,-74.76,16571)
              ,(253,'529 S Liberty St',47304,'MUNCIE','Indiana',40.19,-85.39,13868)
              ,(171,'33 Baxter Rd',12571,'MILAN','New York',41.99,-73.87,22437)
              ,(175,'12990 Palisade St',96161,'GLENSHIRE','California',39.33,-120.24,25087)
              ,(264,'24290 Vista Ridge Dr',91385,'SANTA CLARITA','California',34.38,-118.56,31705)
              ,(193,'3101 1st Ave S',35285,'S S PAYMENT CTR','Alabama',33.52,-86.79,13088)
              ,(229,'1898 Queens Rd',28212,'CHARLOTTE','North Carolina',35.19,-80.83,32309)
              ,(79,'473 E Patten St',54726,'BOYD','Wisconsin',44.95,-91.04,37067)
              ,(323,'594 Winding Rd',11804,'OLD BETHPAGE','New York',40.75,-73.45,28664)
              ,(104,'2425 Van Buren St',76305,'DEAN','Texas',33.89,-98.51,23003)
              ,(238,'4785 Meldrum Rd',48064,'CASCO TOWNSHIP','Michigan',42.76,-82.67,20107)
              ,(88,'469 Shawneehaw Ave',28604,'FOSCOE','North Carolina',36.16,-81.87,39060)
              ,(130,'57 McKim Dr',41051,'WHITE TOWER','Kentucky',38.95,-84.54,10974)
              ,(281,'21970 Moscow Rd',95486,'SHERIDAN','California',38.47,-123.03,31377)
              ,(198,'570 S 10th St',17512,'COLUMBIA','Pennsylvania',40.03,-76.49,17984)
              ,(63,'14296 Tahoe View Dr',95945,'UNION HILL','California',39.18,-120.98,33307)
              ,(190,'186 S Church St',29391,'DUNCAN','South Carolina',34.93,-82.14,22946)
              ,(327,'899 Bridge St',53962,'UNION CENTER','Wisconsin',43.68,-90.26,33989)
              ,(45,'551 E Hopkins St',61326,'GRANVILLE','Illinois',41.26,-89.22,24546)
              ,(46,'11044 SE Stephens St',97216,'PORTLAND','Oregon',45.51,-122.55,19272)
              ,(351,'760 S Cedar St Exd',28383,'RAYNHAM','North Carolina',34.53,-79.29,39351)
              ,(393,'1037 Gap Run Rd',20130,'PARIS','Virginia',39,-77.95,12613)
              ,(377,'3187 E Wren Rd',62420,'CASEY','Illinois',39.3,-87.98,22496)
              ,(230,'2652 Louisiana Presa Ave',91772,'SO CAL EDISON Colorado','California',34.06,-118.08,25315)
              ,(88,'166 Saint Paul St',14651,'EASTMAN KODAK','New York',43.16,-77.61,11208)
              ,(165,'60 Salerno Rd',23801,'FORT LEE','Virginia',37.23,-77.33,29375)
              ,(17,'109 S 12th St',19173,'PHILA','Pennsylvania',39.95,-75.16,40084)
              ,(322,'3128 Janice Cir',30366,'ATLANTA','Georgia',33.88,-84.29,14817)
              ,(339,'300 SW 4th St',33135,'MIAMI','Florida',25.77,-80.2,18837)
              ,(102,'3321 Rita Ln',76117,'FORT WORTH','Texas',32.81,-97.27,23434)
              ,(31,'358 Hartford Ave',50304,'DES MOINES','Iowa',41.57,-93.61,11013)
              ,(314,'13279 Tammy Marie Ln',45389,'CHRISTIANSBG','Ohio',40.05,-84.02,12605)
              ,(133,'1162 Forrest St',40219,'SOUTH PARK VIEW','Kentucky',38.22,-85.74,40723)
              ,(244,'932 S Van Buren St',70434,'COVINGTON','Louisiana',30.47,-90.11,29694)
              ,(108,'90 Camp Rd',12815,'HORICON','New York',43.71,-73.69,34964)
              ,(277,'200 Collins Aly',71263,'OAK GROVE','Louisiana',32.86,-91.39,28542)
              ,(261,'6297 S Meridian Rd',46781,'PONETO','Indiana',40.65,-85.22,20423)
              ,(79,'196 Indian Kettle Rd',27947,'JARVISBURG','North Carolina',36.2,-75.86,20483)
              ,(157,'3364 Louberta St',71209,'MONROE','Louisiana',32.51,-92.08,13620)
              ,(305,'260 Deese Rd',28137,'RICHFIELD','North Carolina',35.47,-80.25,12620)
              ,(366,'15127 W Wilynwood Ln',99026,'NINE MILE FLS','Washington',47.8,-117.62,14713)
              ,(213,'1456 Walnut St',66508,'HERKIMER','Kansas',39.84,-96.64,20947)
              ,(252,'2599 Timber Ridge Rd',24570,'LOWRY','Virginia',37.34,-79.45,29365)
              ,(199,'4997 Cumberland Ave',20810,'GEICO','Maryland',38.97,-77.1,36610)
              ,(270,'221 Pineview Dr',30043,'LAWRENCEVILLE','Georgia',33.94,-83.99,33162)
              ,(370,'6091 Slater Dr',44142,'BROOKPARK','Ohio',41.4,-81.82,20155)
              ,(255,'4858 Garland Ave',75372,'DALLAS','Texas',32.79,-96.76,15044)
              ,(168,'769 S Main St',48118,'LIMA TWP','Michigan',42.31,-84.02,30518)
              ,(381,'159 Moccasin Dr',2886,'WARWICK','Rhode Island',41.7,-71.42,19599)
              ,(101,'156 S Main St',62691,'VIRGINIA','Illinois',39.95,-90.21,36246)
              ,(364,'13201 Blue Water Connecticut',34669,'PORT RICHEY','Florida',28.35,-82.69,29286)
              ,(393,'575 S Walnut Ave',73115,'OKC','Oklahoma',35.46,-97.51,27992)
              ,(218,'167 W Mulberry St',62454,'HARDINVILLE','Illinois',39,-87.74,36248)
              ,(391,'439 Jericho Tpke',11791,'MUTTONTOWN','New York',40.81,-73.5,16616)
              ,(75,'10 Lewisburg Rd',7461,'WALLKILL LAKE','New Jersey',41.2,-74.6,10460)
              ,(133,'2735 SW 89th Ave',97298,'PORTLAND','Oregon',45.5,-122.77,38160)
              ,(65,'43 Oliver Rd',10506,'BEDFORD','New York',41.19,-73.64,10614)
              ,(248,'1326 Butler Chapel Rd',38393,'CHEWALLA','Tennessee',35.02,-88.67,12096)
              ,(123,'573 Lane St',65793,'WILLOW SPGS','Missouri',36.99,-91.96,24170)
              ,(208,'2 Josiah Foster Path',11942,'EAST QUOGUE','New York',40.85,-72.57,29232)
              ,(385,'4166 W 3800 S',84120,'W VALLEY CITY','Utah',40.69,-111.99,34965)
              ,(118,'1 Mallory St',1863,'N CHELMSFORD','Massachusetts',42.63,-71.39,24663)
              ,(151,'2513 E Marion St',98122,'SEATTLE','Washington',47.61,-122.3,11946)
              ,(134,'487 E Ebony Ln',78539,'SAN CARLOS','Texas',26.29,-98.16,24039)
              ,(214,'13542 NW 10th Ter',33182,'WEST MIAMI','Florida',25.78,-80.41,36124)
              ,(264,'15 Courthouse Sq',38549,'BYRDSTOWN','Tennessee',36.57,-85.13,15845)
              ,(130,'10806 Louisiana Terraza Ave',92708,'FOUNTAIN VALLEY','California',33.71,-117.94,23072)
              ,(115,'19110 Timothy''s Manor Connecticut',21120,'PARKTON','Maryland',39.65,-76.67,33255)
              ,(286,'2718 Summerfield Dr',95209,'STKN','California',38.04,-121.35,29532)
              ,(102,'341 US Hwy 64 E',27962,'PLYMOUTH','North Carolina',35.86,-76.74,10126)
              ,(176,'284 S Minnequa Ave',17724,'WARD','Pennsylvania',41.65,-76.85,12820)
              ,(287,'2081 W Overland Rd',83642,'MERIDIAN','Idaho',43.59,-116.42,40112)
              ,(296,'256 E Beaver Tale Rd',17813,'BEAVERTOWN','Pennsylvania',40.75,-77.16,23295)
              ,(292,'36 India St',4103,'PORTLAND','Maine',43.66,-70.25,26801)
              ,(243,'1864 McKinley St',33761,'CLEARWATER','Florida',27.97,-82.76,22271)
              ,(255,'624 Union Ave',38142,'MEMPHIS','Tennessee',35.14,-90.04,37873)
              ,(264,'205 E State Rd 100',32187,'SAN MATEO','Florida',29.6,-81.58,21918)
              ,(377,'199 Fairview Ln',25607,'AMHERSTDALE','West Virginia',37.8,-81.75,38379)
              ,(239,'115 Horseshoe Dr',40977,'CLEAR CREEK','Kentucky',36.76,-83.7,29662)
              ,(10,'32186 Sherman Rd',92584,'MENIFEE','California',33.65,-117.18,26274)
              ,(360,'230 S Cedar St',68970,'RED CLOUD','Nebraska',40.08,-98.52,16592)
              ,(236,'812 Chopped Oak Rd',30522,'CHERRY LOG','Georgia',34.78,-84.45,11722)
              ,(244,'1711 Bluebonnet Place Cir',77280,'HOUSTON','Texas',29.76,-95.38,22832)
              ,(298,'39 Belle Ave',6859,'NORWALK','Connecticut',41.09,-73.42,37902)
              ,(58,'398 5th Ave',57532,'ORTON','South Dakota',44.36,-100.37,10450)
              ,(67,'2078 S Main St',31144,'N AMERICAN MEMBERSHIP GRP','Georgia',34.02,-84.61,39883)
              ,(302,'119 Magnolia St',40906,'KAYJAY','Kentucky',36.86,-83.88,36569)
              ,(399,'3481 Colorado Rd 11',58654,'SENTINEL BUTTE','North Dakota',46.91,-103.84,32634)
              ,(224,'670 Bryant St',18360,'STROUDSBURG','Pennsylvania',40.98,-75.19,37893)
              ,(204,'3687 Delaney St',32811,'ORLANDO','Florida',28.5,-81.37,19903)
              ,(75,'1630 Shrader St',94143,'UCSF','California',37.76,-122.45,36446)
              ,(138,'140 Tower Dr',45845,'FT LORAMIE','Ohio',40.34,-84.37,23287)
              ,(350,'812 Chopped Oak Rd',30522,'CHERRY LOG','Georgia',34.78,-84.45,14900)
              ,(379,'1111 Throckmorton St',76116,'FT WORTH','Texas',32.75,-97.33,36276)
              ,(98,'3099 Heron Ridge Dr',23454,'VIRGINIA BEACH','Virginia',36.73,-76.04,14552)
              ,(190,'1160 E Oak St',62721,'SPRINGFIELD','Illinois',39.78,-89.64,35937)
              ,(28,'1385 Starfield Rd',72199,'CAMP ROBINSON','Arkansas',34.78,-92.25,13882)
              ,(311,'3016 Fisher Rd',95547,'HYDESVILLE','California',40.56,-124.07,37256)
              ,(266,'152 W 3rd Ave N',55705,'WHITE','Minnesota',47.53,-92.24,13860)
              ,(228,'49 5th Ave S',58075,'DWIGHT','North Dakota',46.26,-96.6,21608)
              ,(379,'303 S Park Ave',74464,'THLEQUAH','Oklahoma',35.91,-94.97,37383)
              ,(12,'900 Traders Ave',67047,'FALL RIVER','Kansas',37.6,-96.02,23695)
              ,(278,'2587 S Business Park Rd',20602,'SAINT CHARLES','Maryland',38.64,-76.9,29728)
              ,(3,'378 E 2nd St',15834,'EMPORIUM','Pennsylvania',41.51,-78.23,33640)
              ,(339,'5998 S Meadow Dr',77502,'PASADENA','Texas',29.66,-95.15,26860)
              ,(212,'66 Boston-Providence Tpke',2071,'SOUTH WALPOLE','Massachusetts',42.09,-71.27,11957)
              ,(163,'2992 South St',33965,'FT MYERS','Florida',26.63,-81.85,35903)
              ,(127,'353 E 25th St',98417,'TACOMA','Washington',47.24,-122.43,26082)
              ,(98,'92 Grove St',1748,'HOPKINTON','Massachusetts',42.22,-71.52,31005)
              ,(232,'101 Roundhouse Rd',17872,'SHAMOKIN','Pennsylvania',40.78,-76.55,34636)
              ,(282,'15275 Deer Isle Dr',34740,'OAKLAND','Florida',28.54,-81.65,40195)
              ,(285,'200 School St',1354,'MOUNT HERMON','Massachusetts',42.7,-72.43,35171)
              ,(340,'320 N Post Office Rd',34739,'KENANSVILLE','Florida',27.88,-80.99,16931)
              ,(357,'398 W 3rd St',47371,'BRICE','Indiana',40.43,-84.98,25206)
              ,(356,'2381 Henderer Rd',97436,'ELKTON','Oregon',43.64,-123.61,32414)
              ,(84,'242 13th St Nebraska',44706,'DUEBER','Ohio',40.81,-81.37,26431)
              ,(193,'24951 Prospect Ave',92350,'LOMA LINDA','California',34.05,-117.26,34687)
              ,(71,'1573 Womrath Rd',29841,'BELVEDERE','South Carolina',33.51,-81.95,32843)
              ,(28,'2 A St',60539,'BATAVIA','Illinois',41.82,-88.33,39466)
              ,(34,'63 Tofani Ln',16154,'TRANSFER','Pennsylvania',41.32,-80.42,31401)
              ,(372,'533 Dalton Rd',5904,'GILMAN','Vermont',44.41,-71.71,27636)
              ,(91,'1837 S Farmstead Ave',91716,'CITY INDUSTRY','California',34,-117.97,13147)
              ,(400,'260 E Elm St',43160,'WSHNGTN Connecticut HS','Ohio',39.53,-83.43,30645)
              ,(196,'1898 Queens Rd',28269,'CHARLOTTE','North Carolina',35.19,-80.83,26138)
              ,(171,'777 College St',30153,'BRASWELL','Georgia',34,-85.04,36720)
              ,(123,'4 E Grand St',13428,'PALATINE BRIDGE','New York',42.91,-74.57,34142)
              ,(352,'480 Courtney Estates Dr',63026,'MURPHY','Missouri',38.53,-90.45,24270)
              ,(106,'58 Wilson Cir',19017,'CHESTER HTS','Pennsylvania',39.89,-75.46,29830)
              ,(2,'2507 N Grant St',78585,'SALINENO','Texas',26.5,-99.07,22127)
              ,(229,'11508 Campo Rico Ln',89441,'SPARKS','Nevada',39.68,-119.68,36449)
              ,(167,'1887 E Person Ave',38106,'MEMPHIS','Tennessee',35.1,-90,21589)
              ,(35,'86 Vail St',11768,'NORTHPORT','New York',40.9,-73.34,36945)
              ,(103,'300 SW 4th St',33174,'WEST MIAMI','Florida',25.77,-80.2,31476)
              ,(281,'3660 Otto Rd',77383,'SPRING','Texas',30.06,-95.38,17998)
              ,(179,'358 Draper St',31088,'CENTERVILLE','Georgia',32.61,-83.63,31392)
              ,(6,'11857 Martin St',60142,'HUNTLEY','Illinois',42.16,-88.42,39806)
              ,(124,'3190 Independence Rd',44198,'CLEVELAND','Ohio',41.47,-81.67,29370)
              ,(6,'469 Georgetown Ln',70341,'BRULY SAINT MARTIN','Louisiana',30.03,-91.04,31941)
              ,(333,'1 Elmsleigh Ln',48230,'GROSSE POINTE PARK','Michigan',42.38,-82.91,40152)
              ,(43,'298 S Swain St',56283,'REDWOOD FALLS','Minnesota',44.54,-95.11,37525)
              ,(227,'473 Erie Ave',56672,'THUNDER LAKE','Minnesota',47.05,-93.91,28497)
              ,(368,'31 Bellington St',2475,'ARLINGTON','Massachusetts',42.41,-71.18,37627)
              ,(163,'88 6th Ave N',58421,'MELVILLE','North Dakota',47.45,-99.12,23477)
              ,(107,'165 Lake Roxanne Rd',12935,'ELLENBURG DEP','New York',44.9,-73.8,37427)
              ,(23,'98 Terrace Ln',4015,'CASCO','Maine',44,-70.52,17310)
              ,(306,'471 Temple St',25801,'EAST BECKLEY','West Virginia',37.78,-81.18,30855)
              ,(197,'30800 N Talian Pl',85142,'CHANDLER HEIGHTS','Arizona',33.16,-111.59,13591)
              ,(166,'673 2nd Ave N',37236,'NASHVILLE','Tennessee',36.17,-86.78,12876)
              ,(315,'1501 Angelina Cir',77843,'Texas A & M UNIVERSITY','Texas',30.6,-96.31,33508)
              ,(222,'778 22nd Ave W',34203,'BRADEN RIVER','Florida',27.48,-82.57,24848)
              ,(16,'1620 W Bellevue Ave',90026,'ECHO PARK','California',34.07,-118.26,21148)
              ,(188,'107 Husted Ln',6830,'BELLE HAVEN','Connecticut',41.06,-73.63,23658)
              ,(33,'1655 Bennett St',77801,'TABOR','Texas',30.66,-96.36,38426)
              ,(204,'8055 Colorado Rd 48',34797,'HOWEY Indiana HLS','Florida',28.74,-81.82,39694)
              ,(366,'3623 Valley Meadow Dr',19020,'EDDINGTON','Pennsylvania',40.1,-74.93,26502)
              ,(277,'300 SW 4th St',33156,'RICHMOND HEIGHTS','Florida',25.77,-80.2,26407)
              ,(174,'10355 Southern Maryland Blvd',20754,'DUNKIRK','Maryland',38.72,-76.66,18026)
              ,(91,'1927 Berkshire Ln',80928,'SECURITY','Colorado',38.86,-104.76,30784)
              ,(232,'421 Vine St',72167,'TRASKWOOD','Arkansas',34.45,-92.66,25590)
              ,(206,'2004 Hawthorne St',43617,'SYLVANIA TWP','Ohio',41.66,-83.58,14815)
              ,(203,'74 E Craig St',24430,'CRAIGSVILLE','Virginia',38.08,-79.38,15651)
              ,(220,'109 S 12th St',19134,'PHILADELPHIA','Pennsylvania',39.95,-75.16,33506)
              ,(131,'2668 W Park Dr',21207,'GWYNN OAK','Maryland',39.32,-76.72,22294)
              ,(23,'214 2nd Ave N',29582,'CHERRY GROVE','South Carolina',33.82,-78.67,28973)
              ,(98,'4220 S Bannock St',80110,'GREENWOOD VILLAGE','Colorado',39.64,-104.99,26233)
              ,(308,'225 Funny Farm Rd',16667,'SAINT CLAIRSVILLE','Pennsylvania',40.18,-78.53,28983)
              ,(362,'542 Blossom Loop',72031,'WALNUT GROVE','Arkansas',35.58,-92.45,18465)
              ,(193,'3803 Arnold Rd',17329,'BRODBECKS','Pennsylvania',39.76,-76.85,40591)
              ,(59,'144 2nd St S',56243,'GROVE CITY','Minnesota',45.15,-94.68,26866)
              ,(387,'198 River Center Blvd',45258,'CINCINNATI','Ohio',39.09,-84.51,17145)
              ,(396,'522 Presidential Dr',43302,'MARION','Ohio',40.58,-83.12,23233)
              ,(62,'276 Osche Rd',16039,'HERMAN','Pennsylvania',40.83,-79.79,31060)
              ,(160,'799 Pine St',55587,'MONTICELLO','Minnesota',45.3,-93.8,39102)
              ,(275,'2500 Colorado Rd 3000 N',60912,'BEAVERVILLE','Illinois',40.95,-87.65,12183)
              ,(346,'4858 Garland Ave',75284,'DALLAS','Texas',32.79,-96.76,15386)
              ,(235,'382 Lakeside Dr',2648,'MARSTONS MLS','Massachusetts',41.67,-70.4,17374)
              ,(367,'663 Elk Ave',81225,'CRESTED BUTTE SO','Colorado',38.87,-106.98,12903)
              ,(258,'823 Azalia St',88310,'ALAMOGORDO','New Mexico',32.88,-105.95,35249)
              ,(3,'61 Tower Hill Rd',3451,'HINSDALE','New Hampshire',42.78,-72.48,17607)
              ,(158,'1154 Runyons Branch',41543,'MC ANDREWS','Kentucky',37.54,-82.28,39149)
              ,(197,'967 12th St',78570,'MERCEDES','Texas',26.14,-97.92,15314)
              ,(186,'1111 Throckmorton St',76150,'FORT WORTH','Texas',32.75,-97.33,24640)
              ,(104,'6700 State Hwy 210',55798,'WRIGHT','Minnesota',46.67,-93,13505)
              ,(65,'996 Jackson Hill Rd',13778,'GENEGANTSLET','New York',42.32,-75.77,26404)
              ,(378,'760 S Cedar St Exd',28383,'RAYNHAM','North Carolina',34.53,-79.29,33848)
              ,(389,'322 Logan St',42718,'FINLEY','Kentucky',37.34,-85.34,29258)
              ,(47,'358 Hartford Ave',50980,'DES MOINES','Iowa',41.57,-93.61,22071)
              ,(244,'7000 137th St N',55038,'CENTERVILLE','Minnesota',45.15,-92.96,36830)
              ,(183,'778 SE 8th St',34471,'MARICAMP','Florida',29.18,-82.13,17520)
              ,(84,'870 S 24th St',46036,'LEISURE','Indiana',40.27,-85.83,13056)
              ,(88,'7710 Old Linton Hall Rd',20156,'GAINESVILLE','Virginia',38.79,-77.61,40048)
              ,(381,'4345 N Wyss Ln',61613,'PEORIA','Illinois',40.74,-89.6,11821)
              ,(197,'1027 6th Ave',30912,'AUGUSTA','Georgia',33.45,-81.99,20486)
              ,(148,'2100 W Menefee Ave',88210,'ATOKA','New Mexico',32.84,-104.43,21306)
              ,(324,'669 N Broadway',90051,'LOS ANGELES','California',34.06,-118.24,23003)
              ,(96,'960 Madison Ave',53172,'S MILWAUKEE','Wisconsin',42.91,-87.86,30197)
              ,(171,'927 James City Rd',22725,'LEON','Virginia',38.45,-78.15,34905)
              ,(107,'1002 SE Fairway Dr',81413,'GRAND MESA','Colorado',38.89,-107.92,16488)
              ,(249,'81 Mill St',57433,'COLUMBIA','South Dakota',45.61,-98.31,24802)
              ,(313,'28149 Par View Connecticut',92026,'ESCONDIDO','California',33.22,-117.1,33592)
              ,(112,'276 W Dewey St',67213,'WICHITA','Kansas',37.68,-97.34,10030)
              ,(345,'192 Railroad St',29010,'STOKES BRIDGE','South Carolina',34.21,-80.24,11242)
              ,(98,'40 Elm St',4463,'MILO','Maine',45.25,-68.98,20306)
              ,(392,'1174 S Main St',62650,'ARCADIA','Illinois',39.72,-90.23,27042)
              ,(151,'290 Kensington Rd',27405,'MOUNT ZION','North Carolina',36.07,-79.82,16050)
              ,(6,'285 Ute St',87325,'TOHATCHI','New Mexico',35.85,-108.75,16033)
              ,(110,'523 17th St',97477,'SPFD','Oregon',44.05,-123,23595)
              ,(265,'64 Paddock Connecticut',7938,'LIBERTY COR','New Jersey',40.68,-74.56,17775)
              ,(227,'289 Main St',58575,'TURTLE LK','North Dakota',47.52,-100.89,11008)
              ,(381,'299 Weber St',28585,'TRENTON','North Carolina',35.06,-77.35,20232)
              ,(85,'164 1st St N',32240,'JAX','Florida',30.29,-81.39,32373)
              ,(66,'2699 Taylor Rd',92413,'DEL ROSA','California',34.14,-117.25,28971)
              ,(284,'801 Warren St',68980,'TRUMBULL','Nebraska',40.68,-98.27,31446)
              ,(14,'828 W 95th St',90044,'AUGUST F. HAW','California',33.95,-118.29,19941)
              ,(268,'303 E Ave D',79832,'ALPINE','Texas',30.36,-103.66,13272)
              ,(350,'400 E Golfers Ln',27856,'MOMEYER','North Carolina',35.96,-77.95,30466)
              ,(384,'2148 E Cedar Ave',89155,'CLARK Colorado COURTHOUSE','Nevada',36.17,-115.12,37277)
              ,(315,'632 N 1st St',64784,'SHELDON','Missouri',37.65,-94.29,34849)
              ,(334,'561 Ave D',77984,'GLAZE CITY','Texas',29.43,-97.17,35263)
              ,(267,'503 Highridge Connecticut',82732,'GILLETTE','Wyoming',43.75,-105.49,39945)
              ,(89,'204 Happy Valley Rd',98382,'GARDINER','Washington',48.06,-123.06,27100)
              ,(50,'200 Russell St',47469,'WEST BADEN SPRINGS','Indiana',38.56,-86.61,29463)
              ,(107,'3400 Dixie Hwy',48330,'DRAYTON PLAINS','Michigan',42.68,-83.37,14534)
              ,(153,'1776 S Monroe St',46816,'SOUTHTOWN MALL','Indiana',41.07,-85.13,25539)
              ,(15,'499 Koerner Dr',60481,'CUSTER PARK','Illinois',41.29,-88.15,40016)
              ,(149,'752 Mill Ave SE',44663,'NEW PHILA','Ohio',40.48,-81.44,34085)
              ,(119,'731 S Spring Ave',63131,'TOWN AND COUNTRY','Missouri',38.63,-90.24,28492)
              ,(85,'10154 Martin Luther King Blvd',80236,'FT LOGAN','Colorado',39.76,-104.87,12822)
              ,(129,'1923 McGee St',64150,'KANSAS CITY','Missouri',39.09,-94.58,33655)
              ,(215,'198 E Karen Ln',70041,'PILOTTOWN','Louisiana',29.34,-89.49,13270)
              ,(179,'3801 Pheasant Dr',60008,'ROLLING MDWS','Illinois',42.07,-88.02,19712)
              ,(267,'1898 Queens Rd',28219,'CHARLOTTE','North Carolina',35.19,-80.83,18417)
              ,(299,'706 S Prairie St',63825,'BLOOMFIELD','Missouri',36.88,-89.93,21531)
              ,(152,'698 S Seventh St',46701,'MERRIAM','Indiana',41.39,-85.41,40491)
              ,(185,'203 River Rd',17051,'ATKINSONS MLS','Pennsylvania',40.49,-77.74,20705)
              ,(354,'242 E Frazier St',88202,'ROSWELL','New Mexico',33.37,-104.52,28416)
              ,(254,'399 H St',92662,'NEWPORT BEACH','California',33.6,-117.89,40767)
              ,(53,'140 Main St',57744,'HERMOSA','South Dakota',43.84,-103.19,13657)
              ,(91,'7056 Efland-Cedar Grove Rd',27231,'CEDAR GROVE','North Carolina',36.2,-79.17,35613)
              ,(385,'6125 Belvidere Rd',61073,'ROSCOE','Illinois',42.41,-89,40269)
              ,(177,'1711 Bluebonnet Place Cir',77005,'WEST UNIVERSITY PLACE','Texas',29.76,-95.38,12195)
              ,(235,'889 Ward Ave',96848,'HON','Hawaii',21.3,-157.85,11924)
              ,(124,'2510 Cedar Dr',54467,'CODDINGTON','Wisconsin',44.46,-89.54,35063)
              ,(179,'79892 27th St',79464,'LUBBOCK','Texas',33.57,-101.87,11972)
              ,(249,'388 Clayton St',30530,'COMMERCE','Georgia',34.2,-83.46,25134)
              ,(247,'7357 Union St',16131,'HARTSTOWN','Pennsylvania',41.55,-80.38,32378)
              ,(252,'353 Alabama St',30112,'CARROLLTON','Georgia',33.58,-85.08,29695)
              ,(19,'2004 Hawthorne St',43652,'TOLEDO','Ohio',41.66,-83.58,15355)
              ,(375,'2943 N Division St',52806,'DAVENPORT','Iowa',41.55,-90.6,21993)
              ,(11,'2501 Wharton St',15239,'PITTSBURGH','Pennsylvania',40.43,-79.97,16633)
              ,(153,'3099 Heron Ridge Dr',23457,'VIRGINIA BCH','Virginia',36.73,-76.04,28086)
              ,(356,'18727 S Central Ave',90747,'LONG BEACH','California',33.86,-118.25,20766)
              ,(94,'1100 S Calumet Rd',46304,'BURNS HARBOR','Indiana',41.6,-87.05,40054)
              ,(370,'98 Oak Leaf Dr',76554,'LTL RVR ACAD','Texas',30.97,-97.37,10273)
              ,(104,'619 9th St',73728,'LAMBERT','Oklahoma',36.75,-98.35,17795)
              ,(310,'50 Thaxton Connecticut',22463,'GARRISONVILLE','Virginia',38.48,-77.42,25827)
              ,(74,'2145 State Hwy 113',72070,'OAKGROVE','Arkansas',35.03,-92.69,40727)
              ,(94,'1419 E 3300 S',84106,'SALT LAKE CITY','Utah',40.7,-111.85,39357)
              ,(227,'109 S 12th St',19102,'PHILADELPHIA','Pennsylvania',39.95,-75.16,21866)
              ,(179,'77 Martin Ave',11550,'HEMPSTEAD','New York',40.7,-73.61,11330)
              ,(178,'228 Daniel Ave',34610,'SPRING HILL','Florida',28.55,-82.39,13216)
              ,(253,'5312 S 300 E',46920,'CUTLER','Indiana',40.47,-86.47,23514)
              ,(240,'98 Mendel Connecticut',92697,'UNIV OF CALIFORNIA IRVINE','California',33.64,-117.84,20878)
              ,(387,'1931 Harrils Mill Ave',91913,'CHULA VISTA','California',32.64,-116.98,10076)
              ,(144,'1727 W Chicago Blvd',48215,'GROSSE POINTE','Michigan',42.38,-83.1,25268)
              ,(352,'922 State Hwy 25 Bus',72543,'EDEN ISLE','Arkansas',35.5,-92.03,29384)
              ,(95,'105 Hurd Rd',4417,'BURLINGTON','Maine',45.2,-68.42,16448)
              ,(43,'265 Maple Lodge Rd',12812,'BLUE MOUNTAIN LAKE','New York',43.87,-74.44,22083)
              ,(194,'62648 Elk Trail Way E',98022,'OSCEOLA','Washington',47.1,-121.6,17833)
              ,(146,'2074 Mango Glen',92084,'VISTA','California',33.21,-117.2,11695)
              ,(106,'731 Herr St',17126,'HBG','Pennsylvania',40.27,-76.88,34007)
              ,(310,'2398 W Rowland Ave',92704,'DIAMOND','California',33.71,-117.9,32969)
              ,(131,'461 E Hamilton St',60460,'ODELL','Illinois',41,-88.52,17330)
              ,(360,'3070 King St',22311,'ALEXANDRIA','Virginia',38.82,-77.08,39929)
              ,(373,'26351 Ferry Connecticut',91382,'SANTA CLARITA','California',34.41,-118.51,40703)
              ,(7,'298 Ross Graves Dr',75975,'CALEDONIA','Texas',31.9,-94.39,29625)
              ,(123,'700 Hester Rd',24330,'FRIES','Virginia',36.71,-80.97,13849)
              ,(232,'850 N Front St',83124,'OPAL','Wyoming',41.77,-110.32,14596)
              ,(204,'107 Strawridge Rd',12589,'WALLKILL','New York',41.6,-74.16,34606)
              ,(19,'4 St Agatha Ave',4745,'UPPER FRNCHVL','Maine',47.28,-68.38,38494)
              ,(328,'370 W 42nd St',33013,'HIALEAH','Florida',25.86,-80.29,12474)
              ,(42,'4525 26th St SW',33973,'LEHIGH ACRES','Florida',26.59,-81.72,26994)
              ,(368,'290 Kensington Rd',27415,'GREENSBORO','North Carolina',36.07,-79.82,22950)
              ,(324,'194 Stanton Corners Rd',12783,'SWAN LAKE','New York',41.75,-74.77,23139)
              ,(107,'7416 Horseshoe Rd',80924,'COLO SPGS','Colorado',38.94,-104.7,36619)
              ,(312,'1065 Shafter St',92166,'SAN DIEGO','California',32.72,-117.23,10764)
              ,(167,'452 1st Ave S',58467,'CRYSTAL SPRINGS','North Dakota',46.89,-99.3,31917)
              ,(60,'1446 Kosciusko Blvd',46324,'SOUTH CALUMET AVENUE','Indiana',41.62,-87.49,38289)
              ,(88,'1802 Schuylerville Rd',12831,'WILTON','New York',43.19,-73.64,19907)
              ,(2,'2408 Hazlette Fork Rd',25564,'SOD','West Virginia',38.26,-81.88,35107)
              ,(71,'662 4th St SE',56345,'SOBIESKI','Minnesota',45.97,-94.36,30926)
              ,(7,'813 S 10th St',36863,'LANETT','Alabama',32.86,-85.2,31245)
              ,(7,'101 Washington St',71913,'HOT SPRINGS NATIONAL PARK','Arkansas',34.5,-93.05,33178)
              ,(344,'92717 Deadwood Creek Rd',97430,'DEADWOOD','Oregon',44.16,-123.7,23007)
              ,(374,'731 S Spring Ave',63135,'DELLWOOD','Missouri',38.63,-90.24,11364)
              ,(263,'2501 Wharton St',15203,'CARSON','Pennsylvania',40.43,-79.97,21079)
              ,(383,'3017 260th Ave',52639,'MONTROSE','Iowa',40.52,-91.41,25496)
              ,(194,'7 Harbor Dr',60061,'VERNON HILLS','Illinois',42.23,-87.96,33032)
              ,(390,'415 Jones St',75968,'PINELAND','Texas',31.24,-93.97,28629)
              ,(317,'222 2nd St',63344,'PRAIRIEVILLE','Missouri',39.23,-91.01,39771)
              ,(210,'50 Swannanoa River Rd',28816,'W ASHEVILLE','North Carolina',35.57,-82.54,11105)
              ,(320,'6 Andre Ave',10983,'TAPPAN','New York',41.02,-73.95,38851)
              ,(10,'2501 Wharton St',15279,'PITTSBURGH','Pennsylvania',40.43,-79.97,21465)
              ,(348,'683 N Spruce St',69153,'OGALLALA','Nebraska',41.13,-101.72,27494)
              ,(343,'521 E 12th St',88102,'CLOVIS','New Mexico',34.41,-103.2,20996)
              ,(14,'21 Parker St',14450,'FAIRPORT','New York',43.1,-77.44,13020)
              ,(389,'326 6th St Nebraska',56093,'WASECA','Minnesota',44.08,-93.5,24412)
              ,(241,'4108 W Airline Park Dr',70729,'BUECHE','Louisiana',30.53,-91.4,29049)
              ,(342,'1851 Madison St',70004,'METAIRIE','Louisiana',29.99,-90.17,17468)
              ,(322,'355 S Clyde Morris Blvd',32125,'HOLLY HILL','Florida',29.19,-81.05,34618)
              ,(10,'836 Alameda Dr',75766,'REESE','Texas',31.96,-95.26,29021)
              ,(316,'61 Walnut St',1815,'WOBURN','Massachusetts',42.48,-71.15,10603)
              ,(378,'687 N Washington St',32227,'MAYPORT','Florida',30.33,-81.65,32448)
              ,(331,'81 Beach Pond Rd',6349,'SUB BASE NEW LONDON','Connecticut',41.32,-72.07,21711)
              ,(396,'300 SW 4th St',33180,'AVENTURA','Florida',25.77,-80.2,32635)
              ,(375,'376 SW 1st Connecticut',33093,'MARGATE','Florida',26.23,-80.13,31195)
              ,(271,'339 Flag St',43619,'NORTHWOOD','Ohio',41.61,-83.48,30152)
              ,(206,'467 Jefferson St',43343,'QUINCY','Ohio',40.29,-83.96,12691)
              ,(86,'341 Orange St',6532,'NEW HAVEN','Connecticut',41.31,-72.92,22926)
              ,(243,'1456 Walnut St',66508,'MARYSVILLE','Kansas',39.84,-96.64,17763)
              ,(64,'74-23 64th Ln',11386,'FLUSHING','New York',40.7,-73.89,14236)
              ,(181,'565 E State St',65025,'CLARKSBURG','Missouri',38.66,-92.66,39403)
              ,(366,'2013 W Cass St',33623,'TAMPA','Florida',27.95,-82.48,15078)
              ,(159,'300 SW 4th St',33175,'OLYMPIA HGTS','Florida',25.77,-80.2,25913)
              ,(181,'5198 SE Ina Ave',97267,'JENNINGS LODGE','Oregon',45.4,-122.61,12041)
              ,(56,'3848 Jean St',47920,'BATTLE GROUND','Indiana',40.51,-86.83,23244)
              ,(23,'1927 Berkshire Ln',80914,'Colorado SPGS','Colorado',38.86,-104.76,31505)
              ,(320,'109 S 12th St',19179,'PHILA','Pennsylvania',39.95,-75.16,38131)
              ,(225,'98 Pleasant St',1223,'SHERWOOD FOREST','Massachusetts',42.33,-73.07,33660)
              ,(128,'6 Peyster St',12228,'N Y DEPT OF MOTOR VEHICLES','New York',42.66,-73.79,24126)
              ,(129,'398 NW 4th St',70084,'BELLE POINT','Louisiana',30.07,-90.56,21819)
              ,(296,'176 Maple Dr',13421,'ONEIDA CASTLE','New York',43.08,-75.65,28552)
              ,(293,'14778 Millersburg Rd',43014,'DANVILLE','Ohio',40.44,-82.26,26548)
              ,(105,'383 Manchester St',3111,'MANCHESTER','New Hampshire',42.99,-71.45,40684)
              ,(211,'2959 Louisiana Ave',89802,'ELKO','Nevada',40.85,-115.71,38250)
              ,(71,'74 Arnold St',14701,'WEST ELLICOTT','New York',42.09,-79.23,28098)
              ,(78,'79 Hillcrest Dr',13676,'EBEN','New York',44.66,-74.98,40059)
              ,(354,'28 S Stockton St',8628,'EWING TOWNSHIP','New Jersey',40.22,-74.76,32129)
              ,(322,'2338 Aster St',70612,'LAKE CHARLES','Louisiana',30.21,-93.2,30822)
              ,(70,'2302 10th Ave S',55421,'SAINT ANTHONY','Minnesota',44.96,-93.26,36569)
              ,(93,'166 Saint Paul St',14609,'ROCHESTER','New York',43.16,-77.61,11017)
              ,(86,'48 Chenango St',13905,'BROADACRES','New York',42.1,-75.91,36310)
              ,(278,'3691 S 3600 E',83237,'FRANKLIN','Idaho',42.03,-111.79,33852)
              ,(123,'137 4th St',16933,'RUTLAND','Pennsylvania',41.8,-77.07,31338)
              ,(243,'1068 Campbell Pkwy',64801,'GRAND FALLS','Missouri',37.08,-94.5,32135)
              ,(137,'159 W San Carlos St',95196,'SAN JOSE WATER COMPANY','California',37.33,-121.89,25312)
              ,(347,'699 Milwee St',29649,'GREENWOOD','South Carolina',34.19,-82.15,31313)
              ,(282,'598 Bellview Ests',24938,'FRANKFORD','West Virginia',37.91,-80.38,38819)
              ,(82,'16 Nokomis Ave',7436,'OAKLAND','New Jersey',41.03,-74.24,37782)
              ,(366,'2131 US Hwy 9',12151,'ROUND LAKE','New York',42.93,-73.79,40353)
              ,(309,'4076 S Oak St',48455,'METAMORA','Michigan',42.94,-83.29,18153)
              ,(152,'1630 Grove Ave',23228,'HENRICO','Virginia',37.55,-77.46,25567)
              ,(279,'1179 18th Ave',68939,'ASH GROVE','Nebraska',40.09,-98.95,37246)
              ,(230,'12304 Claude Connecticut',80614,'EASTLAKE','Colorado',39.92,-104.96,36128)
              ,(165,'173 Earl Wayman Dr',37015,'ASHLAND CITY','Tennessee',36.27,-87.05,29647)
              ,(29,'205 S Main St',44312,'AKRON','Ohio',41.08,-81.52,40078)
              ,(240,'499 S Broadway St',76577,'SAN GABRIEL','Texas',30.61,-97.2,33667)
              ,(257,'98 Rutgers Slip',10019,'NEW YORK','New York',40.71,-73.99,35223)
              ,(279,'98 Rutgers Slip',10001,'GREELEY SQUARE','New York',40.71,-73.99,31471)
              ,(114,'300 SW 4th St',33146,'UNIVERSITY OF MIAMI','Florida',25.77,-80.2,18612)
              ,(393,'1385 Starfield Rd',72117,'BAUCUM','Arkansas',34.78,-92.25,15908)
              ,(387,'614 Broadway',37245,'Tennessee DEPT OF EMPLOYMENT SEC','Tennessee',36.16,-86.78,29530)
              ,(391,'2079 Smithdale Rd',15083,'SUTERSVILLE','Pennsylvania',40.23,-79.8,26833)
              ,(218,'143 Mechanic St',13032,'SOUTH BAY','New York',43.08,-75.75,37062)
              ,(24,'298 Florence St SW',35640,'HARTSELLE','Alabama',34.43,-86.93,35782)
              ,(85,'7519 Bradwell Ave',90660,'PICO RIVERA','California',33.98,-118.08,38574)
              ,(141,'162 Main St',14591,'WYOMING','New York',42.82,-78.08,38209)
              ,(365,'97 N Water St',17870,'VERDILLA','Pennsylvania',40.8,-76.86,38024)
              ,(58,'2255 N 37th St',53267,'CHASE BANK','Wisconsin',43.06,-87.96,10364)
              ,(331,'164 Railroad St',63764,'MARBLE HILL','Missouri',37.3,-89.98,13217)
              ,(257,'1851 Madison St',70033,'METAIRIE','Louisiana',29.99,-90.17,18537)
              ,(140,'575 S Walnut Ave',73155,'OKLAHOMA CITY','Oklahoma',35.46,-97.51,24524)
              ,(303,'311 S High St',65767,'URBANA','Missouri',37.84,-93.16,35172)
              ,(296,'1066 South St',71454,'SHELL POINT','Louisiana',31.66,-92.88,37033)
              ,(365,'104 Main St',73450,'MILBURN','Oklahoma',34.24,-96.55,26222)
              ,(240,'668 Sullivan Ln',60484,'UNIVERSITY PARK','Illinois',41.44,-87.68,15591)
              ,(355,'75 E Main St',15757,'MCGEES MILLS','Pennsylvania',40.87,-78.72,35049)
              ,(236,'758 N Calhoun St',32313,'FLORIDA STATE','Florida',30.45,-84.28,31411)
              ,(143,'427 3rd St',58216,'BATHGATE','North Dakota',48.88,-97.47,31134)
              ,(214,'140 E 7th St',79329,'IDALOU','Texas',33.66,-101.68,40043)
              ,(30,'280 E Elm St',71857,'READER','Arkansas',33.8,-93.38,26230)
              ,(136,'1899 Estelle St',71019,'MARTIN','Louisiana',32.02,-93.34,32785)
              ,(82,'6033 Morella Ave',91606,'NORTH HOLLYWOOD','California',34.18,-118.39,34125)
              ,(382,'430 Evergreen Dr',53050,'MAYVILLE','Wisconsin',43.49,-88.54,32563)
              ,(207,'1632 Martin Blvd',21220,'BALTIMORE','Maryland',39.33,-76.43,33918)
              ,(368,'52 Marshall Ave',13690,'STAR LAKE','New York',44.16,-75.03,22882)
              ,(310,'1927 Berkshire Ln',80931,'SECURITY','Colorado',38.86,-104.76,21727)
              ,(155,'1851 Madison St',70010,'METAIRIE','Louisiana',29.99,-90.17,39977)
              ,(295,'174 Dubois St',12758,'LIVINGSTON MANOR','New York',41.89,-74.82,39993)
              ,(218,'7122 Barranca Pkwy',92619,'IRVINE','California',33.66,-117.76,27240)
              ,(327,'13111 FM 2701',79529,'KNOX CITY','Texas',33.41,-99.81,19989)
              ,(97,'23 Sutton Rd',7830,'TEWKSBURY TWP','New Jersey',40.71,-74.83,13676)
              ,(147,'299 Factory St SE',44681,'RAGERSVILLE','Ohio',40.5,-81.64,24155)
              ,(276,'6 Peyster St',12211,'SIENA','New York',42.66,-73.79,26037)
              ,(394,'358 E Torrance St',64468,'MARYVILLE','Missouri',40.34,-94.87,33345)
              ,(177,'351 E Walnut St',18201,'HAZLETON','Pennsylvania',40.95,-75.97,16707)
              ,(140,'744 Main St',30087,'STONE MTN','Georgia',33.8,-84.17,26566)
              ,(179,'201 Washington St',58765,'NOONAN','North Dakota',48.89,-103.01,19195)
              ,(281,'13783 US Hwy 77',73095,'WAYNE','Oklahoma',34.91,-97.31,12102)
              ,(222,'247 N Doheny Dr',90209,'BEVERLY HILLS','California',34.07,-118.39,33742)
              ,(234,'194 Jeff St',72650,'DONGOLA','Arkansas',35.9,-92.63,31056)
              ,(4,'378 W 47th Pl',90037,'GREEN','California',34,-118.28,23756)
              ,(362,'2255 N 37th St',53207,'BAYVIEW','Wisconsin',43.06,-87.96,32973)
              ,(10,'1355 Commerce St',75388,'DALLAS','Texas',32.78,-96.8,27899)
              ,(207,'66 Pleasant Ave',14075,'HAMBURG','New York',42.72,-78.83,35786)
              ,(39,'2419 Watertank Rd',96103,'GRAEAGLE','California',39.78,-120.65,39197)
              ,(389,'573 McKaig Rd',45373,'TROY','Ohio',40.04,-84.21,20529)
              ,(38,'199 Bear Mountain Rd',98356,'LINDBERG','Washington',46.57,-122.33,32306)
              ,(302,'184 Wayne St',40962,'GRACE','Kentucky',37.15,-83.76,28366)
              ,(345,'178 Kiwassa Rd',12983,'HARRIETSTOWN','New York',44.32,-74.13,27965)
              ,(105,'648 E 1st St',62214,'ADDIEVILLE','Illinois',38.39,-89.48,25004)
              ,(51,'2535 Oak Dr',77414,'SARGENT','Texas',28.97,-95.96,31931)
              ,(179,'28141 N Bay Rd',92352,'LK ARROWHEAD','California',34.27,-117.19,15301)
              ,(18,'299 E Mississippi Ave',42045,'IUKA','Kentucky',37,-88.23,31435)
              ,(67,'156 S Main St',62691,'VIRGINIA','Illinois',39.95,-90.21,13917)
              ,(279,'7803 S 100 W',46931,'FULTON','Indiana',40.94,-86.26,14200)
              ,(386,'3080 S Irvington Ave',74149,'TULSA','Oklahoma',36.12,-95.91,21226)
              ,(78,'1630 Grove Ave',23232,'RICHMOND','Virginia',37.55,-77.46,29073)
              ,(31,'1800 S Oak St',65560,'SLIGO','Missouri',37.63,-91.53,19018)
              ,(304,'98 Rutgers Slip',10007,'NEW YORK','New York',40.71,-73.99,17261)
              ,(64,'2298 Championship Dr',47727,'EVANSVILLE','Indiana',38.08,-87.52,36940)
              ,(252,'529 S Liberty St',47304,'MUNCIE','Indiana',40.19,-85.39,11774)
              ,(215,'15366 US Hwy 80',36759,'MARION JCT','Alabama',32.44,-87.28,22207)
              ,(94,'83 State St',14470,'HOLLEY','New York',43.22,-78.02,20139)
              ,(167,'1021 Audubon Ave',70826,'GMF','Louisiana',30.44,-91.12,32548)
              ,(251,'760 W 26th St',92424,'SN BERNRDNO','California',34.14,-117.3,13652)
              ,(164,'531 Glenco Dr',63301,'BLACK WALNUT','Missouri',38.79,-90.51,12364)
              ,(190,'98 99th Ave SE',98004,'CLYDE HILL','Washington',47.61,-122.21,39378)
              ,(137,'1280 Sprucewood Ln',81601,'GLENWOOD SPRINGS','Colorado',39.54,-107.33,12049)
              ,(302,'673 2nd Ave N',37224,'NASHVL','Tennessee',36.17,-86.78,32656)
              ,(295,'15930 Lexington Ave',60426,'DIXMOOR','Illinois',41.6,-87.65,37894)
              ,(376,'9539 Brewerton Rd',13029,'BREWERTON','New York',43.23,-76.14,36316)
              ,(212,'92 Bridge St',7602,'HACKENSACK','New Jersey',40.88,-74.04,31478)
              ,(303,'290 Kensington Rd',27407,'GREENSBORO','North Carolina',36.07,-79.82,23768)
              ,(48,'505 Washington St',52142,'ALBANY','Iowa',42.84,-91.8,20619)
              ,(360,'158 Strawberry St',72010,'BALD KNOB','Arkansas',35.3,-91.57,24867)
              ,(42,'55 Harker Ave',8091,'WEST BERLIN','New Jersey',39.8,-74.93,17423)
              ,(133,'279 Cemetery Hill',5761,'PAWLET','Vermont',43.35,-73.18,12533)
              ,(387,'901 Carolyn Connecticut',77345,'KINGWOOD','Texas',29.99,-95.26,21802)
              ,(346,'492 S Dobson St',76028,'BRIAROAKS','Texas',32.53,-97.32,32386);

              INSERT INTO Spaces(WarehouseID,SpaceSize,MonthlyPrice) VALUES
              (329,4581,0.87)
              ,(258,8728,0.71)
              ,(463,10192,1.08)
              ,(864,3303,1.31)
              ,(455,14515,1.25)
              ,(789,5760,0.99)
              ,(425,12304,1.01)
              ,(299,7296,1.43)
              ,(627,12908,0.93)
              ,(488,6041,1.03)
              ,(368,12033,0.76)
              ,(637,12879,0.93)
              ,(615,7338,1.01)
              ,(329,4586,1.02)
              ,(781,7228,1.76)
              ,(723,8775,1.05)
              ,(432,9853,0.54)
              ,(835,10101,0.83)
              ,(515,10931,0.65)
              ,(193,4750,0.82)
              ,(435,12290,0.87)
              ,(469,4412,0.8)
              ,(923,12182,0.53)
              ,(864,3316,1.2)
              ,(706,7402,1.46)
              ,(783,13519,0.75)
              ,(705,9977,0.93)
              ,(471,11422,0.8)
              ,(161,8687,1.18)
              ,(552,3252,0.92)
              ,(699,8312,1.31)
              ,(822,4692,0.61)
              ,(900,10522,0.96)
              ,(877,3552,1.19)
              ,(395,12340,1.43)
              ,(199,13626,0.97)
              ,(763,12978,1.18)
              ,(800,13297,0.83)
              ,(855,12064,1.24)
              ,(405,13374,1.09)
              ,(612,10750,0.93)
              ,(588,5239,0.67)
              ,(315,11668,0.64)
              ,(443,12785,1.14)
              ,(634,5528,0.73)
              ,(190,11834,1.1)
              ,(867,9063,0.83)
              ,(700,6653,0.8)
              ,(580,14410,1.25)
              ,(409,13210,0.71)
              ,(574,3232,0.57)
              ,(572,7704,0.69)
              ,(412,12682,1.12)
              ,(818,7662,1.11)
              ,(791,5209,0.84)
              ,(740,9389,1.19)
              ,(255,8473,1.34)
              ,(636,9137,0.97)
              ,(467,11258,1.34)
              ,(668,10605,0.97)
              ,(926,7189,0.81)
              ,(792,5625,1.12)
              ,(441,5000,0.82)
              ,(795,11524,1.41)
              ,(248,13153,1.15)
              ,(530,12760,1.12)
              ,(778,5813,1.3)
              ,(731,5925,1.2)
              ,(849,7981,1.37)
              ,(283,13428,0.99)
              ,(406,10938,0.9)
              ,(620,10764,0.69)
              ,(552,6990,1.02)
              ,(534,6177,1.01)
              ,(607,5985,1.07)
              ,(311,11343,1.13)
              ,(572,4157,0.86)
              ,(767,10058,0.82)
              ,(781,13975,0.95)
              ,(584,13308,1.29)
              ,(582,13382,1.59)
              ,(262,13636,0.87)
              ,(497,10525,1.06)
              ,(328,9268,1.06)
              ,(296,3519,1.13)
              ,(863,12281,0.76)
              ,(357,5197,0.95)
              ,(368,8955,0.98)
              ,(660,5360,0.83)
              ,(734,10361,1.84)
              ,(841,13267,0.93)
              ,(329,12550,0.94)
              ,(235,12108,1.27)
              ,(439,8639,0.85)
              ,(849,12807,0.85)
              ,(820,13865,1.07)
              ,(785,5238,1.02)
              ,(219,11906,0.9)
              ,(477,6553,1.3)
              ,(584,4904,0.67)
              ,(161,13902,1.21)
              ,(743,4916,0.7)
              ,(245,6493,0.75)
              ,(182,9655,1.03)
              ,(654,11131,0.98)
              ,(388,13636,0.88)
              ,(291,11328,0.62)
              ,(397,11536,1.09)
              ,(835,8707,0.9)
              ,(731,3171,1.19)
              ,(654,10550,1.15)
              ,(796,14602,1)
              ,(205,3979,0.81)
              ,(362,13674,1.02)
              ,(351,13940,0.85)
              ,(272,9596,0.69)
              ,(763,8700,1.63)
              ,(389,9368,0.88)
              ,(816,13726,0.96)
              ,(835,11945,0.7)
              ,(576,13933,1.35)
              ,(739,4085,1.06)
              ,(718,4485,1.53)
              ,(416,4007,0.99)
              ,(698,8842,0.83)
              ,(240,12622,1.22)
              ,(407,12803,0.84)
              ,(198,14093,1.84)
              ,(381,12319,0.72)
              ,(867,11627,0.91)
              ,(273,10491,1)
              ,(248,14056,1.09)
              ,(911,12789,0.8)
              ,(387,4703,1.24)
              ,(771,7482,0.83)
              ,(854,7718,1.21)
              ,(215,11828,0.93)
              ,(443,12867,0.62)
              ,(667,12085,1.51)
              ,(182,3092,1.06)
              ,(177,3632,1.51)
              ,(564,13690,1.09)
              ,(928,7189,1.31)
              ,(567,4843,1.06)
              ,(910,4089,1.27)
              ,(486,12832,1.12)
              ,(829,8482,0.93)
              ,(165,5518,0.82)
              ,(269,9714,0.65)
              ,(920,8926,1.16)
              ,(930,9290,1.12)
              ,(571,14500,0.72)
              ,(196,10648,1.36)
              ,(217,7913,1.17)
              ,(210,3866,1.57)
              ,(804,4353,0.58)
              ,(358,13497,0.93)
              ,(442,4381,1.01)
              ,(291,10650,0.59)
              ,(337,13902,0.69)
              ,(655,6149,1)
              ,(206,12587,0.92)
              ,(484,7205,0.76)
              ,(822,10016,0.88)
              ,(927,4090,1.15)
              ,(535,13936,1.47)
              ,(462,14600,1.23)
              ,(419,9473,0.74)
              ,(840,5679,0.91)
              ,(913,12044,1.08)
              ,(159,8178,1.26)
              ,(364,12637,0.69)
              ,(587,6980,1.43)
              ,(201,13885,0.78)
              ,(327,5576,0.75)
              ,(452,7921,1.87)
              ,(380,12873,0.68)
              ,(489,12371,0.92)
              ,(384,10896,1.49)
              ,(514,12495,0.81)
              ,(207,3466,0.74)
              ,(354,13128,1.5)
              ,(462,9653,1.96)
              ,(256,13596,0.84)
              ,(702,3185,1.06)
              ,(159,14257,1.58)
              ,(771,7383,1.04)
              ,(331,8295,0.67)
              ,(606,9929,1.06)
              ,(337,9625,0.92)
              ,(489,11970,0.78)
              ,(278,12819,0.71)
              ,(414,4629,0.61)
              ,(396,12066,0.89)
              ,(655,8431,0.76)
              ,(336,10500,1)
              ,(413,3955,0.98)
              ,(762,14076,0.82)
              ,(384,11172,1.31)
              ,(614,11105,1.17)
              ,(243,11556,0.57)
              ,(671,5202,1.29)
              ,(355,6047,1.53)
              ,(483,10798,0.84)
              ,(621,9309,1)
              ,(753,7179,0.78)
              ,(738,9141,1.52)
              ,(448,8641,0.99)
              ,(581,5451,1.04)
              ,(905,9327,1.33)
              ,(922,11503,1.11)
              ,(731,11843,0.81)
              ,(727,6240,0.57)
              ,(766,5514,1.45)
              ,(908,11900,0.96)
              ,(742,12023,1.36)
              ,(399,12511,1.18)
              ,(705,14090,1.13)
              ,(859,6197,1.29)
              ,(890,11717,0.75)
              ,(612,4200,0.8)
              ,(259,10566,1.69)
              ,(873,8329,0.75)
              ,(212,4862,0.88)
              ,(209,12215,0.97)
              ,(465,9547,0.88)
              ,(714,11031,1.08)
              ,(435,5079,1.65)
              ,(376,4149,0.82)
              ,(491,9703,0.79)
              ,(524,10325,0.88)
              ,(393,5452,1.26)
              ,(317,11121,0.93)
              ,(740,8468,0.91)
              ,(197,3766,0.61)
              ,(777,11805,1.04)
              ,(909,8991,1.13)
              ,(372,7714,0.89)
              ,(560,14269,0.97)
              ,(873,8960,1.28)
              ,(914,7395,0.81)
              ,(456,12075,0.77)
              ,(556,12638,1.36)
              ,(504,8574,1.08)
              ,(298,4983,1.1)
              ,(554,8577,1.22)
              ,(192,4610,1.3)
              ,(630,13243,1.62)
              ,(362,10596,0.67)
              ,(484,10977,0.65)
              ,(323,6782,1.35)
              ,(438,10611,1.17)
              ,(619,11603,0.64)
              ,(196,14425,1.07)
              ,(847,8976,0.89)
              ,(819,11953,1.28)
              ,(671,11329,1.27)
              ,(516,6952,1.64)
              ,(673,5133,0.68)
              ,(698,9768,0.97)
              ,(788,4477,1.84)
              ,(633,7304,0.63)
              ,(304,12291,1.05)
              ,(788,7734,1.46)
              ,(521,14295,1.44)
              ,(526,9284,0.75)
              ,(563,8852,0.94)
              ,(663,11179,1.09)
              ,(468,9997,1.19)
              ,(875,8619,0.95)
              ,(230,13430,1.2)
              ,(336,6162,0.63)
              ,(783,11863,1.1)
              ,(707,9897,1.03)
              ,(437,13198,1.28)
              ,(559,5442,1.19)
              ,(772,3827,1.03)
              ,(620,4693,0.86)
              ,(246,6782,1.01)
              ,(605,5093,0.93)
              ,(797,12659,0.97)
              ,(425,10657,0.78)
              ,(347,5340,1.08)
              ,(497,10307,1.33)
              ,(181,3089,0.75)
              ,(803,9646,1.18)
              ,(528,10390,0.85)
              ,(932,11847,1.55)
              ,(359,12846,1.31)
              ,(696,13388,1)
              ,(784,12183,0.58)
              ,(617,4087,1.34)
              ,(876,11001,0.89)
              ,(383,5871,1.18)
              ,(756,12030,1.11)
              ,(670,3391,1.19)
              ,(822,3037,1.3)
              ,(712,10480,0.59)
              ,(238,12323,0.86)
              ,(617,4838,1.51)
              ,(288,7095,0.92)
              ,(750,11276,0.93)
              ,(931,5072,1.05)
              ,(532,11800,1.53)
              ,(436,12807,0.57)
              ,(381,5414,1.03)
              ,(342,5733,0.99)
              ,(373,13664,0.96)
              ,(421,5507,1.29)
              ,(508,8268,1.14)
              ,(372,13964,0.82)
              ,(781,13989,0.7)
              ,(325,12499,0.92)
              ,(650,3472,0.98)
              ,(159,4965,1.68)
              ,(680,4912,0.59)
              ,(573,12769,0.77)
              ,(327,7964,0.93)
              ,(663,10063,0.52)
              ,(214,8299,0.78)
              ,(327,4926,0.62)
              ,(238,11340,1.14)
              ,(749,8435,1.11)
              ,(196,4172,0.78)
              ,(824,9438,0.85)
              ,(524,12859,1.44)
              ,(256,8455,0.76)
              ,(476,11586,1)
              ,(540,5898,0.69)
              ,(283,5297,0.69)
              ,(294,11850,1.1)
              ,(661,12298,0.94)
              ,(810,8714,0.73)
              ,(179,6841,0.55)
              ,(876,12389,1.06)
              ,(201,13774,0.89)
              ,(414,10642,1.04)
              ,(415,7206,0.75)
              ,(887,12953,1.2)
              ,(395,12632,1.07)
              ,(320,7087,1.31)
              ,(845,8495,0.94)
              ,(588,6841,1.16)
              ,(645,13308,0.71)
              ,(734,12821,1.2)
              ,(554,12619,1.04)
              ,(874,8430,0.87)
              ,(672,12914,1.02)
              ,(400,6745,0.74)
              ,(557,3489,0.76)
              ,(382,9978,1.41)
              ,(928,7132,0.99)
              ,(763,6518,1.1)
              ,(397,11265,0.93)
              ,(259,3670,0.85)
              ,(881,8559,0.95)
              ,(708,7622,1.03)
              ,(649,3518,1.1)
              ,(192,13927,0.69)
              ,(321,9905,1.07)
              ,(158,4869,1.07)
              ,(188,11355,1.16)
              ,(594,8924,0.9)
              ,(413,4918,1.49)
              ,(218,7986,0.83)
              ,(328,10354,0.66)
              ,(832,7716,1.43)
              ,(826,11752,1.2)
              ,(530,5052,0.82)
              ,(626,4659,0.87)
              ,(467,3942,0.72)
              ,(195,6898,1.38)
              ,(287,7251,1.5)
              ,(388,4191,0.86)
              ,(747,4838,1.16)
              ,(863,5221,0.67)
              ,(854,7550,1.06)
              ,(654,10171,0.69)
              ,(631,8885,0.54)
              ,(475,5864,1.19)
              ,(688,13296,0.81)
              ,(627,4023,1.03)
              ,(541,3850,1.06)
              ,(408,6928,1.06)
              ,(646,11908,0.81)
              ,(305,4678,0.72)
              ,(254,9774,0.93)
              ,(519,11342,1.17)
              ,(666,10963,0.86)
              ,(468,11669,1.07)
              ,(803,7977,0.56)
              ,(746,11793,1.24)
              ,(916,7816,0.92)
              ,(457,11558,1.12)
              ,(348,7099,1.15)
              ,(779,11932,0.93)
              ,(217,11342,0.75)
              ,(748,8079,0.74)
              ,(374,12748,0.98)
              ,(382,14408,1.06)
              ,(779,14530,0.72)
              ,(888,3399,0.78)
              ,(266,10962,0.87)
              ,(738,9777,1.06)
              ,(799,3055,0.97)
              ,(261,12995,1.11)
              ,(203,14518,0.85)
              ,(721,6940,0.75)
              ,(473,3912,1.15)
              ,(180,13356,0.99)
              ,(286,9463,1.09)
              ,(191,14278,1.3)
              ,(568,5656,0.92)
              ,(560,8437,1.27)
              ,(438,6579,1.19)
              ,(493,11133,0.74)
              ,(311,5485,1.17)
              ,(807,11819,1.12)
              ,(521,10561,0.96)
              ,(681,14130,0.89)
              ,(803,9227,1.03)
              ,(508,7751,1.35)
              ,(740,10051,0.87)
              ,(199,5477,1.18)
              ,(804,12775,1.55)
              ,(304,4384,1.34)
              ,(886,7012,1.24)
              ,(677,8476,0.62)
              ,(517,12121,1.03)
              ,(750,3664,0.89)
              ,(583,6528,1.47)
              ,(473,8936,0.85)
              ,(835,4297,0.64)
              ,(852,4637,1)
              ,(283,4657,0.88)
              ,(272,8013,1.04)
              ,(536,10475,1.3)
              ,(306,9658,1.31)
              ,(602,10438,1.06)
              ,(268,7743,0.77)
              ,(779,11611,1.56)
              ,(297,3458,0.73)
              ,(345,7233,0.64)
              ,(383,6236,1.37)
              ,(196,3722,0.77)
              ,(337,4304,0.62)
              ,(772,5730,1.22)
              ,(410,9397,0.94)
              ,(432,5328,0.83)
              ,(268,6423,0.9)
              ,(837,8405,1)
              ,(239,9898,1.06)
              ,(284,14132,1.27)
              ,(729,14596,1.79)
              ,(262,7099,0.7)
              ,(401,5429,0.76)
              ,(699,4776,0.88)
              ,(769,7155,1.38)
              ,(547,13539,0.94)
              ,(772,3363,1.1)
              ,(277,9298,1.13)
              ,(697,4280,1.42)
              ,(336,5793,0.78)
              ,(801,3383,0.87)
              ,(618,9826,0.78)
              ,(746,14522,1.19)
              ,(527,9660,1.02)
              ,(914,5485,0.71)
              ,(336,4900,1)
              ,(284,9455,1.69)
              ,(282,5235,0.79)
              ,(905,7952,0.88)
              ,(494,8226,0.75)
              ,(724,6117,1.45)
              ,(575,8417,1.37)
              ,(726,6172,0.82)
              ,(192,5469,0.8)
              ,(912,9407,1.09)
              ,(502,6084,0.98)
              ,(475,7661,1.51)
              ,(834,6970,0.74)
              ,(640,12326,0.87)
              ,(417,5135,0.69)
              ,(438,5290,1)
              ,(569,13347,0.85)
              ,(451,12360,0.93)
              ,(616,10845,1.17)
              ,(405,8253,1.02)
              ,(510,7130,1.03)
              ,(697,6474,0.91)
              ,(164,6181,0.91)
              ,(827,11670,0.98)
              ,(289,7934,0.55)
              ,(162,13636,1.08)
              ,(920,13531,1.73)
              ,(333,10128,1.12)
              ,(476,10462,0.78)
              ,(831,12796,1.07)
              ,(894,3978,1.45)
              ,(411,10528,0.77)
              ,(184,12502,0.74)
              ,(915,8684,0.59)
              ,(234,6089,0.87)
              ,(354,6686,0.92)
              ,(797,9956,0.71)
              ,(824,11140,0.92)
              ,(591,9118,1.05)
              ,(902,6803,0.69)
              ,(684,5140,1.39)
              ,(729,6511,0.85)
              ,(832,12371,0.95)
              ,(392,11966,1.03)
              ,(787,3226,0.81)
              ,(359,6081,0.85)
              ,(345,12958,0.85)
              ,(354,5856,0.61)
              ,(746,10859,0.61)
              ,(921,11632,1.26)
              ,(886,13249,0.88)
              ,(400,6054,1.27)
              ,(414,4088,0.84)
              ,(717,9030,1.1)
              ,(227,10980,1.03)
              ,(451,7900,1.27)
              ,(610,9670,0.98)
              ,(779,3854,1)
              ,(276,14461,0.84)
              ,(417,6237,0.91)
              ,(731,9279,0.66)
              ,(185,8372,1.49)
              ,(797,3260,1.44)
              ,(551,9602,1.48)
              ,(798,9444,0.87)
              ,(721,10349,1.43)
              ,(375,5428,1.25)
              ,(585,9173,0.55)
              ,(410,3614,0.97)
              ,(747,12177,1.16)
              ,(181,8774,1.17)
              ,(674,10663,1.48)
              ,(649,6428,1)
              ,(472,13880,1.01)
              ,(179,13065,0.93)
              ,(926,6445,0.87)
              ,(825,3370,1.29)
              ,(620,8846,1)
              ,(229,8850,0.95)
              ,(812,13420,1.06)
              ,(722,13074,1.31)
              ,(475,9586,0.91)
              ,(415,8693,1.01)
              ,(459,4398,0.97)
              ,(530,3098,1.18)
              ,(736,11326,0.81)
              ,(803,9735,0.81)
              ,(765,3485,0.57)
              ,(672,13383,0.63)
              ,(872,13583,1.53)
              ,(393,14020,1.01)
              ,(255,10994,0.99)
              ,(910,10941,0.84)
              ,(851,5425,0.95)
              ,(462,3675,0.61)
              ,(871,7940,1.31)
              ,(275,9761,1.31)
              ,(359,6277,0.77)
              ,(293,7221,1.25)
              ,(693,9425,0.97)
              ,(787,7693,0.93)
              ,(617,13627,1.28)
              ,(481,8962,1.06)
              ,(407,13274,1.15)
              ,(215,5265,1.07)
              ,(825,9891,1.19)
              ,(275,3202,0.79)
              ,(801,5534,0.76)
              ,(767,3306,1.64)
              ,(744,7626,1.06)
              ,(615,6725,0.64)
              ,(348,4823,0.62)
              ,(784,4898,0.67)
              ,(493,6308,0.59)
              ,(676,4536,1.02)
              ,(758,10191,1)
              ,(302,7426,0.73)
              ,(291,14258,0.99)
              ,(643,5693,1.31)
              ,(356,12700,0.85)
              ,(344,11651,0.93)
              ,(344,11816,0.94)
              ,(768,7242,0.82)
              ,(825,10965,0.83)
              ,(528,12625,0.61)
              ,(538,10633,0.89)
              ,(815,13953,1.03)
              ,(890,7417,0.9)
              ,(592,4129,0.8)
              ,(645,7026,1.25)
              ,(337,5541,0.73)
              ,(347,12230,1.1)
              ,(307,3655,0.77)
              ,(730,11074,0.63)
              ,(761,7363,0.76)
              ,(385,8656,0.91)
              ,(617,7302,1.82)
              ,(650,13760,1.19)
              ,(793,7157,1.35)
              ,(159,7786,1.05)
              ,(429,9867,0.78)
              ,(480,8829,0.6)
              ,(274,8131,1.14)
              ,(358,14191,0.91)
              ,(483,3540,0.74)
              ,(554,9434,1.1)
              ,(485,13282,0.78)
              ,(701,5981,1.01)
              ,(330,6403,1.62)
              ,(694,8920,0.64)
              ,(193,6494,0.99)
              ,(393,4651,0.99)
              ,(882,12042,1.13)
              ,(514,6897,1.22)
              ,(407,11282,1.11)
              ,(907,14061,0.71)
              ,(723,4613,0.63)
              ,(763,9448,1.01)
              ,(679,9544,1.07)
              ,(767,11866,1.11)
              ,(341,3860,0.85)
              ,(414,5020,1.36)
              ,(754,9113,1.04)
              ,(496,3984,1)
              ,(187,4770,0.75)
              ,(707,11942,1.42)
              ,(255,13012,0.85)
              ,(680,3089,1.33)
              ,(807,12266,0.74)
              ,(832,7356,0.82)
              ,(164,9667,1.3)
              ,(672,12980,1)
              ,(315,3729,0.73)
              ,(452,9514,1.16)
              ,(606,14147,1.21)
              ,(287,8266,0.91)
              ,(726,11871,0.67)
              ,(844,13198,1.74)
              ,(316,6419,0.73)
              ,(426,3914,1.07)
              ,(232,4429,1)
              ,(483,10221,1.44)
              ,(545,12672,0.7)
              ,(849,6903,1.26)
              ,(760,5540,0.73)
              ,(799,6889,2.04)
              ,(744,11737,1.12)
              ,(648,10875,0.74)
              ,(575,12452,0.71)
              ,(318,13507,1.11)
              ,(916,13509,0.79)
              ,(792,9641,0.99)
              ,(862,7405,0.67)
              ,(723,11424,0.88)
              ,(389,7851,0.98)
              ,(482,6196,1.27)
              ,(627,6721,0.94)
              ,(927,4217,0.89)
              ,(648,6102,0.81)
              ,(711,11838,0.98)
              ,(669,5833,0.95)
              ,(446,11089,1.1)
              ,(311,11085,0.91)
              ,(599,6120,1.1)
              ,(209,3991,0.7)
              ,(811,6746,0.84)
              ,(313,13356,1.23)
              ,(847,9565,0.94)
              ,(469,5064,0.91)
              ,(234,12175,1.33)
              ,(386,11208,0.71)
              ,(178,10089,0.61)
              ,(872,7946,0.57)
              ,(640,14478,0.78)
              ,(303,6563,1.26)
              ,(316,8285,0.87)
              ,(688,10473,0.92)
              ,(901,5151,1.13)
              ,(782,12806,1.42)
              ,(667,12322,1.29)
              ,(370,7042,1.01)
              ,(928,12762,0.81)
              ,(457,10725,1.11)
              ,(179,7579,1.22)
              ,(458,9081,0.98)
              ,(747,13822,1)
              ,(805,13296,1.05)
              ,(915,5525,0.7)
              ,(316,11286,1.04)
              ,(252,6640,0.85)
              ,(784,13852,0.74)
              ,(268,6649,0.82)
              ,(837,3258,0.95)
              ,(200,11516,1.07)
              ,(650,11690,0.67)
              ,(364,13287,0.91)
              ,(741,12344,1.01)
              ,(791,6716,0.68)
              ,(272,3501,0.88)
              ,(581,13659,0.87)
              ,(272,10181,1.04)
              ,(353,12200,1.49)
              ,(363,13240,1.48)
              ,(763,7969,0.7)
              ,(414,5929,0.87)
              ,(567,6640,1.13)
              ,(421,11902,0.75)
              ,(754,14104,1.07)
              ,(416,7326,0.98)
              ,(824,9471,0.63)
              ,(813,6659,1.94)
              ,(766,13948,1.23)
              ,(299,14330,1.32)
              ,(572,12676,1.52)
              ,(631,5024,0.72)
              ,(363,8543,0.74)
              ,(906,14086,1.17)
              ,(913,14233,1.09)
              ,(714,12646,0.72)
              ,(807,13702,0.96)
              ,(548,7378,0.68)
              ,(408,3164,1.1)
              ,(926,12310,0.89)
              ,(905,10880,1.08)
              ,(877,9784,0.97)
              ,(549,4972,0.89)
              ,(548,6522,0.85)
              ,(593,4210,0.69)
              ,(727,14077,0.98)
              ,(534,6343,0.56)
              ,(277,14177,1.4)
              ,(665,11553,1.11)
              ,(718,12394,1.1)
              ,(927,4285,0.87)
              ,(271,14480,1.06)
              ,(501,7748,1.05)
              ,(442,3596,1.43)
              ,(541,6583,1.22)
              ,(182,11803,0.63)
              ,(918,12780,1.34)
              ,(924,7009,0.76)
              ,(768,9071,0.93)
              ,(864,14185,0.77)
              ,(307,10986,1.05)
              ,(396,8686,0.75)
              ,(253,8540,1.18)
              ,(526,10972,0.72)
              ,(191,9521,1.27)
              ,(534,4563,1.36)
              ,(832,5551,0.99)
              ,(501,13656,1.09)
              ,(896,9209,1.32)
              ,(769,11841,1.88)
              ,(768,3799,0.98)
              ,(879,8555,0.98)
              ,(283,5769,1.19)
              ,(575,10589,0.93)
              ,(708,4640,0.68)
              ,(425,5563,1.01)
              ,(260,13579,1.23)
              ,(739,11269,0.81)
              ,(271,11279,0.97)
              ,(354,12288,1.33)
              ,(581,4893,1.19)
              ,(690,5629,1.28)
              ,(880,12643,1.08)
              ,(906,8671,0.89)
              ,(300,9455,0.63)
              ,(895,10979,0.82)
              ,(222,11667,1.37)
              ,(428,8792,1.64)
              ,(340,7016,0.91)
              ,(373,9657,1.36)
              ,(831,6331,0.68)
              ,(718,9289,1.31)
              ,(889,3682,1.03)
              ,(905,10067,1.87)
              ,(920,4671,1.45)
              ,(325,6941,1.08)
              ,(897,8507,0.95)
              ,(797,9786,1.54)
              ,(299,13568,1.38)
              ,(605,13049,1.28)
              ,(779,11348,0.89)
              ,(912,3494,1.01)
              ,(459,12064,0.57)
              ,(773,9410,1.12)
              ,(410,14388,0.84)
              ,(379,12643,0.89)
              ,(669,13756,0.88)
              ,(763,8822,0.74)
              ,(817,5812,0.92)
              ,(651,12789,1.08)
              ,(594,11697,1.51)
              ,(551,9196,1.68)
              ,(303,14017,1.12)
              ,(915,13433,0.96)
              ,(473,9993,1.05)
              ,(317,6269,1.02)
              ,(201,4583,1.26)
              ,(352,7334,0.82)
              ,(305,11161,0.9)
              ,(898,6054,1)
              ,(326,6226,0.92)
              ,(919,10393,0.99)
              ,(650,6726,0.89)
              ,(889,14373,0.7)
              ,(364,4637,0.79)
              ,(833,9570,1.74)
              ,(889,12203,0.85)
              ,(445,9995,0.61)
              ,(355,8345,1.08)
              ,(203,8690,0.9)
              ,(551,3075,1.42)
              ,(726,6632,0.84)
              ,(309,7751,0.99)
              ,(788,11417,1.04)
              ,(295,6069,1.25)
              ,(335,8391,0.97)
              ,(224,4260,1.19)
              ,(230,13850,1.22)
              ,(477,6132,1.2)
              ,(388,10592,1.36)
              ,(193,14358,1.17)
              ,(817,7595,0.81)
              ,(673,10985,0.79)
              ,(379,13663,1.37)
              ,(276,3079,1.07)
              ,(568,11957,1.35)
              ,(546,8813,1)
              ,(815,6884,1.26)
              ,(315,4077,1.8)
              ,(633,12022,1.13)
              ,(530,4493,1.03)
              ,(540,6760,1.51)
              ,(265,6420,1.11)
              ,(903,12178,0.93)
              ,(509,3097,0.91)
              ,(906,6422,0.77)
              ,(533,12470,1)
              ,(355,11157,0.89)
              ,(897,14367,0.78)
              ,(549,3315,1.35)
              ,(190,6576,0.99)
              ,(688,11749,0.91)
              ,(888,14330,0.93)
              ,(451,7507,1.58)
              ,(922,5153,0.84)
              ,(364,14587,1.1)
              ,(348,8931,1.11)
              ,(417,14066,1.32)
              ,(189,5657,0.74)
              ,(632,9508,0.86)
              ,(272,11734,0.6)
              ,(563,9098,0.97)
              ,(405,12496,1.37)
              ,(841,10820,1.76)
              ,(816,12530,0.94)
              ,(822,4143,0.56)
              ,(556,8671,1.42)
              ,(647,9901,1.55)
              ,(179,4491,1.16)
              ,(475,3542,0.9)
              ,(629,8198,1.04)
              ,(874,14447,1.15)
              ,(883,7673,1.1)
              ,(924,6516,0.93)
              ,(373,4393,0.91)
              ,(367,14579,0.99)
              ,(174,8805,1.08)
              ,(322,14009,0.97)
              ,(299,13364,1.41)
              ,(865,6142,0.88)
              ,(773,13187,1.29)
              ,(605,12521,0.83)
              ,(554,5237,0.68)
              ,(903,4844,0.94)
              ,(248,3245,1.48)
              ,(806,8835,0.87)
              ,(323,7707,1.26)
              ,(493,8113,0.71)
              ,(498,12689,1.15)
              ,(792,3699,0.77)
              ,(368,6600,0.87)
              ,(762,9574,0.95)
              ,(650,3097,1.62)
              ,(428,10521,0.81)
              ,(649,13106,1.05)
              ,(327,9492,1.19)
              ,(338,3742,0.73)
              ,(789,12221,0.72)
              ,(581,6569,1.09)
              ,(629,10376,1.07)
              ,(686,14402,1.43)
              ,(489,13083,1.52)
              ,(391,3341,0.77)
              ,(236,9117,0.84)
              ,(735,13591,0.78)
              ,(416,13689,0.88)
              ,(339,14506,0.87)
              ,(335,10289,1.28)
              ,(201,6424,1.31)
              ,(427,11653,1.05)
              ,(531,10045,1.52)
              ,(210,7719,1.16)
              ,(376,3167,1.18)
              ,(886,10004,0.85)
              ,(342,9983,0.73)
              ,(624,12828,1.26)
              ,(457,7203,1.06)
              ,(469,8258,0.87)
              ,(193,5854,1.95)
              ,(382,4191,1.38)
              ,(485,6964,0.96)
              ,(608,6882,1.09)
              ,(413,3875,0.68)
              ,(255,5232,0.86)
              ,(220,4601,1.15)
              ,(872,9912,0.58)
              ,(243,10789,1.03)
              ,(305,12294,1.02)
              ,(931,14288,1.09)
              ,(705,9471,1.1)
              ,(478,13253,1)
              ,(643,6339,0.69)
              ,(386,6091,1.43)
              ,(666,5040,1.06)
              ,(832,5876,1.58)
              ,(714,12677,0.52)
              ,(820,12594,0.86)
              ,(239,4638,1.25)
              ,(257,11194,1.05)
              ,(330,5998,1.39)
              ,(523,7632,0.59)
              ,(514,11176,0.82)
              ,(221,4578,0.89)
              ,(642,5141,0.84)
              ,(610,5324,1.25)
              ,(835,6292,1.15)
              ,(280,7723,1.26)
              ,(170,4377,1.09)
              ,(699,6179,0.73)
              ,(904,3568,1.37)
              ,(847,5111,0.82)
              ,(332,8444,0.98)
              ,(310,9342,1.1)
              ,(755,7021,0.86)
              ,(662,12555,0.69)
              ,(299,13340,1.23)
              ,(232,11913,1.23)
              ,(557,11021,1.42)
              ,(892,7404,1.4)
              ,(879,11090,0.7)
              ,(641,11874,1.21)
              ,(438,5452,0.96)
              ,(252,9890,0.89)
              ,(828,3454,1)
              ,(292,10233,1.35)
              ,(196,14126,0.88)
              ,(545,8147,0.53)
              ,(276,14246,0.84)
              ,(568,5616,1.12)
              ,(326,11510,1.53)
              ,(698,12293,0.96)
              ,(768,3044,1.31)
              ,(850,11675,0.57)
              ,(543,11371,0.82)
              ,(883,13275,0.87)
              ,(545,11383,0.96)
              ,(932,8165,0.8)
              ,(495,9646,1.07)
              ,(411,6551,0.89)
              ,(656,9572,0.62)
              ,(671,8529,1.85)
              ,(695,4354,1.14)
              ,(507,5172,0.87)
              ,(231,10582,0.93)
              ,(281,10883,1.32)
              ,(682,5146,1.02)
              ,(565,14337,1.28)
              ,(452,8661,1.95)
              ,(490,14594,0.86)
              ,(526,5083,1.44)
              ,(863,12391,0.85)
              ,(490,13970,0.85)
              ,(352,7185,0.84)
              ,(741,12418,0.77)
              ,(368,12476,0.53)
              ,(794,6705,0.57)
              ,(787,12065,1.14)
              ,(719,3044,0.54)
              ,(859,5954,0.61)
              ,(687,3547,1.09)
              ,(653,11486,1.22)
              ,(540,10321,1.01)
              ,(653,6469,1.02)
              ,(306,12428,1.29)
              ,(167,12086,0.98)
              ,(733,4620,1.2)
              ,(405,11773,0.99)
              ,(460,10711,0.95)
              ,(521,7033,0.7)
              ,(849,11441,0.78)
              ,(434,11450,0.97)
              ,(516,13509,1.21)
              ,(375,9122,0.81)
              ,(427,4646,1.11)
              ,(533,12575,0.99)
              ,(730,11855,1.36)
              ,(532,11489,1.03)
              ,(644,7620,0.81)
              ,(411,7774,1.16)
              ,(900,5180,1.12)
              ,(769,5133,1.28)
              ,(861,12995,0.82)
              ,(509,9354,0.68)
              ,(277,11305,0.84)
              ,(706,7811,0.69)
              ,(272,9008,0.93)
              ,(301,11282,0.89)
              ,(372,10423,1.18)
              ,(423,6732,0.76)
              ,(733,5222,1.42)
              ,(816,10949,1.63)
              ,(740,7525,1.11)
              ,(577,12500,0.74)
              ,(625,8697,1.04)
              ,(368,8834,0.99)
              ,(565,13310,1.02)
              ,(793,5418,0.67)
              ,(281,7190,1.13)
              ,(336,5329,1.07)
              ,(349,5651,1.08)
              ,(198,10514,1.17)
              ,(220,12783,1.31)
              ,(455,10826,1.14)
              ,(363,11735,0.79)
              ,(660,14532,1.15)
              ,(671,8726,1.28)
              ,(877,8992,1.3)
              ,(166,5122,0.52)
              ,(498,6287,0.84)
              ,(361,3261,0.72)
              ,(319,10327,0.82)
              ,(785,12526,0.8)
              ,(766,7586,1.02)
              ,(362,14240,1.17)
              ,(384,11332,1.1)
              ,(736,12254,0.71)
              ,(677,7718,0.56)
              ,(797,4374,1.11)
              ,(308,7543,0.64)
              ,(537,4364,0.74)
              ,(843,4068,1)
              ,(653,5223,0.9)
              ,(515,4920,1.02)
              ,(205,7967,0.77)
              ,(480,12107,1.19)
              ,(784,11278,0.96)
              ,(231,11449,1.42)
              ,(294,11300,0.58)
              ,(434,7386,1.29)
              ,(362,8236,0.97)
              ,(932,11709,0.92)
              ,(926,13423,1.41)
              ,(919,14256,0.93)
              ,(521,3132,0.74)
              ,(668,3667,0.99)
              ,(466,7305,1.07)
              ,(528,10064,1.19)
              ,(640,9441,0.93)
              ,(610,3037,0.73)
              ,(678,9191,0.87)
              ,(769,3123,0.97)
              ,(409,11270,0.55)
              ,(199,3056,1.5)
              ,(368,9350,1.49)
              ,(321,4957,0.78)
              ,(531,8554,0.76)
              ,(644,9352,1.26)
              ,(678,8747,0.6)
              ,(708,4315,1)
              ,(598,12980,0.81)
              ,(570,5648,0.55)
              ,(431,7895,0.95)
              ,(898,8671,1.18)
              ,(882,12104,1.03)
              ,(764,4607,1.34)
              ,(644,13099,0.99)
              ,(475,7734,0.78)
              ,(829,10633,1.82)
              ,(347,6677,1.18)
              ,(490,5688,1.17)
              ,(445,8418,1.59)
              ,(597,9741,1.26)
              ,(302,6515,0.96)
              ,(653,13426,1.13)
              ,(636,6012,0.96)
              ,(578,12965,0.58)
              ,(662,10319,0.71)
              ,(734,9474,1.34)
              ,(432,4488,0.8)
              ,(310,14006,0.96)
              ,(326,14568,1.75)
              ,(290,11152,0.65)
              ,(452,13494,1.21)
              ,(708,8313,1.24)
              ,(417,6190,0.94)
              ,(345,10946,2.01)
              ,(878,3814,0.92)
              ,(837,14310,0.88)
              ,(757,7706,0.73)
              ,(486,10618,1)
              ,(309,8815,0.79)
              ,(871,7181,0.66)
              ,(756,11665,1.22)
              ,(244,10063,1.2)
              ,(476,5217,0.81)
              ,(787,12616,0.99)
              ,(558,9427,1.06)
              ,(874,11447,0.6)
              ,(341,10462,0.67)
              ,(257,12367,0.66)
              ,(169,14515,0.89)
              ,(882,7311,0.85)
              ,(904,12864,0.87)
              ,(243,10199,0.9)
              ,(339,13890,1.43)
              ,(248,5248,0.77)
              ,(728,13306,1.21)
              ,(769,13831,1.68)
              ,(640,5716,0.7)
              ,(537,11106,0.69)
              ,(706,12319,0.77)
              ,(540,11713,1.18)
              ,(451,5897,0.89)
              ,(503,9248,0.83)
              ,(362,7093,0.72)
              ,(375,10181,1.12)
              ,(831,9848,0.93)
              ,(420,8313,0.76)
              ,(319,9074,1.31)
              ,(256,5167,0.7)
              ,(627,6081,0.83)
              ,(924,7092,0.7)
              ,(804,12647,0.99)
              ,(451,5581,1.02)
              ,(596,5675,0.76)
              ,(773,10113,1.3)
              ,(581,5493,1.4)
              ,(322,10501,0.85)
              ,(888,9427,0.67)
              ,(361,4237,1.76)
              ,(485,12967,0.95)
              ,(270,4447,0.91)
              ,(780,8081,0.97)
              ,(610,8300,0.91)
              ,(706,13753,1.26)
              ,(719,12202,0.84)
              ,(213,3512,0.62)
              ,(262,6803,1.27)
              ,(204,5723,0.6)
              ,(347,12836,1.09)
              ,(186,8680,0.92)
              ,(806,11450,0.7)
              ,(494,9701,1.72)
              ,(908,13827,0.78)
              ,(439,10930,0.97)
              ,(407,8619,0.53)
              ,(335,8045,0.78)
              ,(294,4530,1.44)
              ,(691,7718,0.91)
              ,(500,14017,1.27)
              ,(848,10412,0.86)
              ,(614,9842,1.69)
              ,(854,5794,0.67)
              ,(218,13274,1.18)
              ,(235,7335,1.2)
              ,(623,6378,0.75)
              ,(883,8615,0.91)
              ,(578,10012,0.61)
              ,(723,6344,0.82)
              ,(250,11820,1.06)
              ,(566,8527,1.27)
              ,(295,12118,0.62)
              ,(849,5879,0.78)
              ,(303,3592,1.02)
              ,(262,11790,1.07)
              ,(905,5699,1.23)
              ,(601,9969,0.65)
              ,(829,5274,1.55)
              ,(332,9256,0.99)
              ,(600,5202,1.55)
              ,(922,11305,1.54)
              ,(812,10098,0.9)
              ,(173,11791,1.25)
              ,(708,12273,0.58)
              ,(236,9614,1.19)
              ,(433,3419,1.14)
              ,(576,9213,1.65)
              ,(226,10656,1.21)
              ,(374,11246,1.09)
              ,(316,10695,0.91)
              ,(905,4327,1.29)
              ,(929,4330,0.85)
              ,(746,4166,1.03)
              ,(761,9309,1.36)
              ,(367,10667,0.96)
              ,(318,7230,0.78)
              ,(682,8200,1)
              ,(824,13221,1.04)
              ,(295,4340,0.77)
              ,(828,12357,1.46)
              ,(279,6433,1.4)
              ,(816,4164,0.59)
              ,(539,3030,0.62)
              ,(368,7949,1.08)
              ,(743,11729,0.92)
              ,(873,12658,1.42)
              ,(553,6387,1.74)
              ,(752,5007,1.03)
              ,(865,11286,1.09)
              ,(900,4644,0.81)
              ,(686,10073,0.87)
              ,(929,14030,1.1)
              ,(370,5300,0.71)
              ,(318,11227,1.11)
              ,(223,8892,1.81)
              ,(167,7033,0.71)
              ,(830,6046,1.2)
              ,(793,5451,1.2)
              ,(570,10589,1.14)
              ,(395,9518,0.67)
              ,(227,13614,0.78)
              ,(632,10063,1.08)
              ,(475,12866,1.45)
              ,(581,4610,1.15)
              ,(297,5887,0.72)
              ,(364,9913,0.89)
              ,(837,10658,0.85)
              ,(874,11026,0.89)
              ,(761,11701,1.17)
              ,(926,10828,0.86)
              ,(912,7362,0.76)
              ,(576,4850,0.86)
              ,(197,7245,1.46)
              ,(683,5851,1.29)
              ,(785,9851,0.93)
              ,(519,13293,1.22)
              ,(442,3367,0.91)
              ,(764,9878,0.95)
              ,(856,11380,0.81)
              ,(287,3360,0.63)
              ,(364,9673,0.73)
              ,(482,9369,1.58)
              ,(268,5306,1.6)
              ,(633,13243,0.98)
              ,(722,7615,0.61)
              ,(873,3994,1.03)
              ,(852,5427,1.26)
              ,(734,7905,1.36)
              ,(523,5693,1.18)
              ,(257,6775,1)
              ,(706,4175,0.88)
              ,(498,6932,0.94)
              ,(619,5653,1.25)
              ,(183,8921,0.95)
              ,(377,9281,1)
              ,(394,12324,1.14)
              ,(762,4627,1.34)
              ,(557,5486,1.16)
              ,(545,12020,0.62)
              ,(218,6558,0.81)
              ,(825,12293,1.39)
              ,(637,11722,0.95)
              ,(670,3135,0.79)
              ,(193,6104,1.26)
              ,(638,5258,1.05)
              ,(539,11423,1.05)
              ,(361,10008,1.35)
              ,(598,3226,1.37)
              ,(416,14467,0.96)
              ,(670,4869,1.06)
              ,(262,4218,1.77)
              ,(656,10563,0.88)
              ,(620,10887,1.12)
              ,(745,4785,1.16)
              ,(915,11157,0.85)
              ,(533,12219,0.98)
              ,(575,6232,1.65)
              ,(431,11140,1.07)
              ,(229,12867,1.02)
              ,(598,14425,0.96)
              ,(703,5297,0.64)
              ,(412,9622,0.83)
              ,(486,12454,1.49)
              ,(443,12787,1.01)
              ,(388,3029,0.6)
              ,(319,4798,0.96)
              ,(529,9384,0.52)
              ,(412,4378,1.17)
              ,(693,6600,0.67)
              ,(299,6610,0.65)
              ,(294,5123,1.55)
              ,(394,13892,0.99)
              ,(206,7092,0.99)
              ,(407,6269,1.45)
              ,(198,7300,1.52)
              ,(671,7556,1.42)
              ,(656,7026,1.82)
              ,(435,12601,0.77)
              ,(707,3222,1.05)
              ,(192,12480,1.69)
              ,(786,12935,0.99)
              ,(325,14049,1.18)
              ,(790,6173,1.06)
              ,(808,13853,0.64)
              ,(552,14068,1.11)
              ,(687,3766,1.05)
              ,(632,9473,0.72)
              ,(632,5379,1.53)
              ,(538,9463,0.91)
              ,(395,6823,0.85)
              ,(570,4629,1.07)
              ,(475,14114,1.16)
              ,(202,10617,1.49)
              ,(297,12416,1.27)
              ,(490,13446,1.11)
              ,(831,7491,0.74)
              ,(647,8320,0.88)
              ,(262,14136,0.71)
              ,(568,8220,0.87)
              ,(182,11400,1.28)
              ,(418,8812,0.99)
              ,(701,4254,1.08)
              ,(439,14470,1.07)
              ,(241,12382,1.05)
              ,(577,5201,1.02)
              ,(299,10803,0.64)
              ,(309,11946,0.67)
              ,(524,5185,1.02)
              ,(907,6111,1.08)
              ,(431,8967,0.88)
              ,(609,14295,1.54)
              ,(728,14002,0.96)
              ,(585,11294,0.87)
              ,(350,10565,1.67)
              ,(907,6286,0.7)
              ,(829,9807,0.92)
              ,(494,7425,0.99)
              ,(421,11354,0.71)
              ,(774,8559,0.72)
              ,(347,7838,0.81)
              ,(324,7557,1)
              ,(454,3793,1.01)
              ,(591,4333,0.95)
              ,(473,3554,0.99)
              ,(790,9013,1.17)
              ,(691,9099,0.86)
              ,(792,8054,0.68)
              ,(378,13112,1.2)
              ,(730,7963,1.09)
              ,(205,4055,0.87)
              ,(769,10674,0.93)
              ,(381,3499,1.13)
              ,(615,3327,0.98)
              ,(365,5681,1.37)
              ,(605,5563,0.63)
              ,(874,14044,0.7)
              ,(192,13820,1.14)
              ,(609,3394,1.24)
              ,(616,5711,0.56)
              ,(706,9837,1.27)
              ,(419,8203,0.78)
              ,(202,3654,1.19)
              ,(837,5931,0.8)
              ,(472,12704,0.59)
              ,(349,5914,0.83)
              ,(440,3991,1.4)
              ,(318,9116,1.2)
              ,(826,3743,1.49)
              ,(413,11177,0.77)
              ,(282,9944,1.26)
              ,(454,8225,0.74)
              ,(913,7007,0.78)
              ,(768,13585,1.27)
              ,(351,14303,1.61)
              ,(678,13821,0.51)
              ,(427,4132,1)
              ,(342,8660,1.17)
              ,(813,14441,1.07)
              ,(309,4979,0.87);


              INSERT INTO Contracts(SpaceID,LesseeID,StartDate,EndDate,AmountCharged,ContractInformation) VALUES
              (1,763,'2018-10-27','2019-4-20',23623.55202,'trade fair and exhibition exhibits')
              ,(2,832,'2014-11-6','2015-12-3',82278.57445,'trade fair and exhibition exhibits')
              ,(3,927,'2017-9-16','2018-9-12',134591.6067,'forklifts')
              ,(3,847,'2019-1-30','2019-3-27',20878.47639,'personal items')
              ,(4,989,'2015-3-25','2016-12-22',93503.56152,'packaged foods and chocolate items')
              ,(4,516,'2017-1-17','2017-5-9',16414.41832,'electronics')
              ,(5,381,'2016-2-14','2017-1-7',201571.2097,'personal items')
              ,(5,464,'2017-10-23','2018-6-3',137043.8407,'glass')
              ,(5,510,'2018-9-21','2019-8-10',198498.4778,'chickens')
              ,(5,804,'2019-9-13','2019-12-18',58996.45161,'textiles')
              ,(5,982,'2020-6-21','2020-10-25',77432.84274,'trucks')
              ,(6,641,'2017-12-12','2018-9-14',53308.24258,'dry and liquid goods')
              ,(7,851,'2013-7-20','2015-7-17',306005.8382,'textiles')
              ,(8,903,'2017-6-7','2017-11-18',57955.18761,'chickens')
              ,(8,416,'2018-1-22','2018-7-16',61842.42581,'chickens')
              ,(8,761,'2018-9-26','2019-5-24',84812.46968,'household and industrial appliances')
              ,(9,780,'2016-2-12','2017-10-30',254532.852,'personal items')
              ,(9,515,'2018-2-22','2019-2-13',144750.312,'trade fair and exhibition exhibits')
              ,(10,733,'2016-4-26','2018-3-13',144576.5248,'bulk and packaged goods')
              ,(11,522,'2016-12-31','2018-2-12',126379.1055,'equipment')
              ,(11,419,'2018-5-9','2019-1-8',75579.66116,'bulk and packaged goods')
              ,(11,868,'2019-1-25','2019-8-21',64428.56361,'dangerous')
              ,(11,354,'2019-11-27','2020-2-13',24160.71135,'medical supplies')
              ,(12,513,'2018-11-14','2020-6-24',238544.838,'vehicle parts')
              ,(13,465,'2014-9-3','2015-4-20',57486.01035,'printed materials')
              ,(15,519,'2014-7-17','2015-8-24',173645.472,'electronics')
              ,(15,867,'2015-10-1','2015-12-29',38348.50374,'telecommunication equipment')
              ,(16,434,'2015-2-7','2016-10-12',191304.1996,'medical supplies')
              ,(16,575,'2017-3-7','2017-9-2',55862.0746,'spare parts')
              ,(17,598,'2013-2-9','2014-9-12',104524.4381,'dry and liquid goods')
              ,(18,435,'2013-3-22','2014-6-6',125230.08,'machine parts')
              ,(20,970,'2015-6-21','2016-12-5',70317.31452,'personal items')
              ,(20,431,'2017-1-24','2017-3-27',8179.5,'trucks')
              ,(21,833,'2016-2-2','2017-10-8',222365.3487,'medical supplies')
              ,(21,727,'2017-12-30','2018-9-24',97058.49097,'medical supplies')
              ,(22,457,'2016-11-30','2017-10-5',36941.24903,'dangerous')
              ,(22,736,'2018-4-6','2019-1-28',35506.63742,'dry and liquid goods')
              ,(23,397,'2017-11-13','2018-12-28',89661.48484,'goods under customs control')
              ,(24,625,'2017-8-7','2019-4-2',81271.95097,'medical supplies')
              ,(24,803,'2019-12-28','2020-5-9',17925.65419,'personal items')
              ,(25,669,'2017-7-6','2018-7-14',136533.2328,'machine parts')
              ,(25,823,'2018-9-10','2019-1-15',46487.18652,'telecommunication equipment')
              ,(26,519,'2015-7-14','2016-1-10',61816.71774,'personal items')
              ,(26,638,'2016-5-6','2017-5-4',124663.7141,'dry and liquid goods')
              ,(26,378,'2018-1-5','2018-8-28',80705.15927,'chickens')
              ,(27,825,'2017-10-6','2018-4-27',63797.9265,'vehicle parts')
              ,(28,373,'2014-9-10','2016-5-22',191889.6,'printed materials')
              ,(29,374,'2014-5-17','2014-10-26',56246.36342,'personal items')
              ,(29,512,'2014-11-6','2015-2-24',38191.97516,'household and industrial appliances')
              ,(29,736,'2015-9-26','2015-12-29',32636.77877,'machine parts')
              ,(30,977,'2017-3-26','2018-2-25',34049.06942,'equipment')
              ,(31,769,'2017-7-14','2019-1-30',208378.4884,'equipment')
              ,(31,593,'2019-3-1','2019-3-22',7745.041161,'forklifts')
              ,(31,921,'2020-1-21','2020-3-17',20653.4431,'trucks')
              ,(34,673,'2013-6-17','2013-11-24',22906.96258,'goods under customs control')
              ,(35,617,'2014-9-10','2016-1-10',291076.9152,'dry and liquid goods')
              ,(35,966,'2016-1-17','2016-9-16',145239.6106,'bulk and packaged goods')
              ,(36,569,'2018-4-20','2019-5-17',175490.5726,'personal items')
              ,(37,453,'2016-10-6','2017-10-29',201256.1257,'dangerous')
              ,(38,961,'2014-2-18','2015-8-28',207842.4045,'dangerous')
              ,(39,610,'2017-7-20','2018-8-21',201155.136,'trade fair and exhibition exhibits')
              ,(40,588,'2018-8-12','2019-3-20',108627.0794,'trucks')
              ,(40,538,'2019-5-30','2020-5-14',172815.8081,'personal items')
              ,(40,638,'2020-7-6','2021-1-12',93814.29581,'glass')
              ,(40,791,'2021-1-19','2021-8-13',101714.447,'containers')
              ,(43,629,'2017-4-1','2017-10-6',47551.24026,'equipment')
              ,(44,855,'2017-10-12','2017-11-26',22214.96855,'household and industrial appliances')
              ,(47,498,'2017-6-4','2019-1-10',149050.5365,'electronics')
              ,(48,741,'2015-12-24','2016-2-28',11898.13935,'containers')
              ,(48,615,'2016-8-12','2017-5-20',50657.22968,'trade fair and exhibition exhibits')
              ,(48,354,'2017-12-28','2018-2-14',8653.192258,'dangerous')
              ,(49,616,'2014-5-10','2014-11-29',123850.4637,'trade fair and exhibition exhibits')
              ,(49,534,'2015-2-17','2015-9-6',122630.2621,'medical supplies')
              ,(49,561,'2015-9-22','2015-12-7',46367.66129,'telecommunication equipment')
              ,(50,780,'2015-9-27','2017-1-6',148356.1834,'household and industrial appliances')
              ,(51,589,'2016-12-9','2017-1-25',2932.727226,'goods under customs control')
              ,(51,479,'2017-6-26','2017-12-7',10233.34606,'electronics')
              ,(52,562,'2014-2-5','2014-5-13',17464.84374,'containers')
              ,(52,537,'2014-12-17','2015-6-2',30068.33923,'packaged foods and chocolate items')
              ,(52,775,'2015-11-21','2016-1-6',8282.297032,'dry and liquid goods')
              ,(53,971,'2017-9-13','2019-2-7',246322.0769,'trucks')
              ,(53,991,'2019-2-9','2019-6-8',57250.63897,'dangerous')
              ,(53,503,'2019-12-8','2020-10-22',153470.2003,'household and industrial appliances')
              ,(53,860,'2021-2-24','2021-3-29',15876.22761,'bulk and packaged goods')
              ,(54,838,'2016-7-31','2017-2-27',60782.0281,'cosmetics and personal hygiene products')
              ,(55,972,'2018-9-15','2019-4-28',33346.00161,'equipment')
              ,(56,485,'2016-11-27','2018-1-23',159700.5297,'machine parts')
              ,(57,588,'2015-10-17','2016-2-1',41148.44119,'trucks')
              ,(57,481,'2016-10-1','2017-4-18',76528.40932,'machine parts')
              ,(57,709,'2017-4-26','2017-7-17',31534.31942,'personal items')
              ,(57,980,'2017-11-15','2018-8-15',104986.2098,'containers')
              ,(58,475,'2014-11-14','2015-12-6',116175.3339,'stationery')
              ,(58,812,'2016-1-2','2016-2-5',10206.61848,'printed materials')
              ,(59,408,'2016-9-18','2018-6-4',318843.9917,'equipment')
              ,(59,568,'2018-6-4','2018-7-21',24015.49297,'goods under customs control')
              ,(60,353,'2016-6-25','2017-1-12',70033.53847,'electronics')
              ,(61,895,'2018-6-15','2019-2-5',46349.91798,'personal items')
              ,(62,922,'2016-8-10','2017-8-21',80233.54839,'textiles')
              ,(63,933,'2017-3-15','2018-8-16',72074.03226,'personal items')
              ,(63,974,'2018-8-21','2018-9-23',4582.741935,'stationery')
              ,(63,888,'2018-9-29','2018-12-4',9165.483871,'dangerous')
              ,(64,985,'2018-4-24','2019-11-5',308203.8039,'equipment')
              ,(64,464,'2020-1-23','2020-8-19',115026.0625,'electronics')
              ,(66,679,'2017-12-4','2018-2-13',34368.03097,'goods under customs control')
              ,(66,832,'2018-11-15','2019-11-11',174744.4955,'chickens')
              ,(67,429,'2014-6-20','2015-6-25',94705.02097,'household and industrial appliances')
              ,(69,970,'2013-6-9','2015-1-29',221836.143,'stationery')
              ,(70,751,'2015-7-7','2016-6-19',156694.3641,'printed materials')
              ,(72,478,'2015-8-24','2016-2-3',41005.11077,'household and industrial appliances')
              ,(72,848,'2016-3-20','2016-11-15',60375.62323,'bulk and packaged goods')
              ,(73,436,'2013-1-7','2014-2-12',96838.78355,'personal items')
              ,(73,457,'2014-4-17','2014-9-16',36706.97032,'machine parts')
              ,(74,789,'2014-11-29','2016-8-27',134606.494,'printed materials')
              ,(76,719,'2018-5-20','2019-1-25',108536.0444,'containers')
              ,(76,381,'2019-1-28','2019-8-3',81184.96118,'forklifts')
              ,(78,621,'2018-2-16','2020-2-8',201692.7495,'forklifts')
              ,(78,607,'2020-6-2','2020-12-18',55591.2149,'containers')
              ,(78,379,'2021-8-20','2022-8-5',97773.49355,'containers')
              ,(79,785,'2016-7-20','2017-8-5',171327.8649,'containers')
              ,(79,623,'2017-8-26','2018-1-5',59357.68548,'packaged foods and chocolate items')
              ,(80,713,'2015-11-3','2017-3-24',294807.1872,'stationery')
              ,(81,638,'2015-4-2','2016-8-3',352415.1858,'personal items')
              ,(82,743,'2018-5-15','2018-9-19',51031.41039,'machine parts')
              ,(82,680,'2019-1-20','2019-12-26',136619.5239,'textiles')
              ,(83,671,'2017-11-27','2019-7-14',224461.5823,'packaged foods and chocolate items')
              ,(83,593,'2020-1-19','2020-8-16',79355.10484,'electronics')
              ,(86,462,'2013-3-27','2014-4-25',124557.8636,'bulk and packaged goods')
              ,(88,861,'2013-6-1','2014-3-8',83229.50323,'packaged foods and chocolate items')
              ,(89,647,'2013-3-28','2014-11-22',91013.83742,'medical supplies')
              ,(91,428,'2013-5-17','2014-9-7',199761.219,'vehicle parts')
              ,(91,705,'2014-12-18','2015-5-15',61850.754,'containers')
              ,(91,748,'2015-5-19','2015-6-5',7104.4785,'forklifts')
              ,(92,568,'2014-6-20','2016-2-10',239745.4839,'household and industrial appliances')
              ,(93,380,'2016-3-9','2016-7-2',59896.51839,'spare parts')
              ,(93,673,'2016-8-23','2017-4-27',128647.3047,'goods under customs control')
              ,(93,958,'2017-5-25','2017-10-20',77084.21497,'vehicle parts')
              ,(93,876,'2018-3-23','2018-11-12',121876.3939,'personal items')
              ,(94,699,'2014-11-11','2015-8-16',69144.0479,'dangerous')
              ,(95,816,'2014-11-6','2015-2-8',34659.46016,'medical supplies')
              ,(95,975,'2015-8-27','2016-1-28',56782.51984,'personal items')
              ,(95,704,'2016-2-12','2016-7-1',51620.47258,'containers')
              ,(96,994,'2015-6-1','2017-3-17',329133.8552,'dry and liquid goods')
              ,(100,379,'2014-11-19','2015-7-21',27154.55535,'machine parts')
              ,(104,744,'2013-4-8','2014-11-1',192669.5739,'bulk and packaged goods')
              ,(104,460,'2014-11-3','2015-10-14',116208.0472,'printed materials')
              ,(105,368,'2013-7-19','2015-3-18',224272.774,'chickens')
              ,(105,433,'2015-4-19','2016-2-21',113799.0352,'packaged foods and chocolate items')
              ,(105,463,'2016-9-15','2017-3-23',69831.22616,'equipment')
              ,(106,373,'2018-3-8','2018-6-8',37392.55123,'bulk and packaged goods')
              ,(106,501,'2018-10-31','2019-3-13',54056.62297,'packaged foods and chocolate items')
              ,(107,508,'2015-8-14','2015-10-19',15700.608,'stationery')
              ,(108,393,'2017-5-21','2017-10-2',57070.82477,'goods under customs control')
              ,(108,986,'2017-11-19','2018-2-4',32794.42916,'medical supplies')
              ,(108,627,'2018-8-14','2018-8-28',5962.623484,'personal items')
              ,(111,859,'2014-12-6','2016-6-18',230126.129,'containers')
              ,(112,383,'2013-2-2','2014-4-3',210198.1452,'packaged foods and chocolate items')
              ,(113,1000,'2013-8-21','2014-8-21',39845.51347,'containers')
              ,(113,857,'2014-9-20','2015-2-1',14628.2159,'chickens')
              ,(114,385,'2018-3-6','2019-9-2',257465.9816,'spare parts')
              ,(114,791,'2019-9-24','2019-11-7',20786.24439,'bulk and packaged goods')
              ,(114,433,'2019-12-8','2020-11-7',158258.9061,'household and industrial appliances')
              ,(114,547,'2021-1-26','2021-12-13',151645.1011,'medical supplies')
              ,(115,884,'2014-2-20','2014-10-30',101136.9484,'machine parts')
              ,(115,795,'2015-3-23','2015-9-10',68628.64355,'vehicle parts')
              ,(117,392,'2014-1-26','2015-9-6',282430.6258,'telecommunication equipment')
              ,(118,913,'2018-8-11','2019-7-1',90469.49574,'goods under customs control')
              ,(119,629,'2014-11-21','2015-3-11',49094.80258,'equipment')
              ,(121,571,'2015-10-7','2016-12-5',270766.506,'trucks')
              ,(122,919,'2017-1-25','2017-5-25',17599.76129,'stationery')
              ,(122,655,'2017-7-13','2018-3-12',35492.85194,'glass')
              ,(122,609,'2018-11-4','2019-2-5',13639.815,'personal items')
              ,(123,412,'2013-9-23','2015-7-18',154097.2938,'household and industrial appliances')
              ,(124,771,'2017-12-3','2018-11-10',45952.40526,'packaged foods and chocolate items')
              ,(124,394,'2018-11-15','2019-3-2',14376.92211,'spare parts')
              ,(125,728,'2018-9-24','2020-9-14',179222.0633,'printed materials')
              ,(125,810,'2020-10-6','2021-1-16',25354.57761,'containers')
              ,(128,367,'2018-5-3','2019-1-1',213429.8474,'bulk and packaged goods')
              ,(128,996,'2019-1-14','2019-10-1',228361.1535,'textiles')
              ,(128,686,'2019-11-6','2020-6-13',193228.6684,'chickens')
              ,(129,420,'2013-10-23','2015-7-12',188366.2525,'dry and liquid goods')
              ,(130,377,'2018-11-23','2020-7-20',216816.3578,'personal items')
              ,(132,986,'2013-12-14','2014-9-8',139075.505,'electronics')
              ,(133,778,'2016-2-9','2016-4-16',23218.22323,'containers')
              ,(133,625,'2016-7-4','2017-6-20',121635.7665,'equipment')
              ,(133,655,'2017-10-6','2018-2-22',48169.14968,'dry and liquid goods')
              ,(133,427,'2018-7-9','2019-3-2',81783.59226,'chickens')
              ,(135,773,'2016-2-1','2017-9-21',125783.7637,'electronics')
              ,(136,950,'2014-9-20','2015-5-3',71170.54113,'electronics')
              ,(137,581,'2015-12-13','2016-1-30',17883.936,'spare parts')
              ,(138,366,'2013-5-11','2014-2-17',76198.374,'machine parts')
              ,(138,970,'2014-5-30','2015-2-12',69713.406,'stationery')
              ,(138,438,'2015-3-1','2015-4-10',10808.28,'electronics')
              ,(139,650,'2013-5-8','2015-4-23',441933.831,'packaged foods and chocolate items')
              ,(139,993,'2015-5-1','2015-12-31',150813.7829,'chickens')
              ,(141,849,'2013-7-12','2014-12-30',99566.94503,'personal items')
              ,(141,562,'2015-5-24','2015-10-5',24891.73626,'glass')
              ,(142,786,'2015-3-27','2015-11-6',113215.4168,'chickens')
              ,(144,854,'2013-10-9','2014-9-30',61901.03884,'chickens')
              ,(145,909,'2015-6-23','2017-3-12',110460.7736,'spare parts')
              ,(145,617,'2017-9-27','2018-7-2',48898.24055,'personal items')
              ,(146,844,'2015-12-27','2016-9-8',124617.761,'telecommunication equipment')
              ,(147,692,'2013-11-9','2015-5-28',150958.395,'telecommunication equipment')
              ,(147,368,'2015-7-16','2015-11-12',31794.777,'stationery')
              ,(151,977,'2017-1-19','2017-11-21',107840.7174,'chickens')
              ,(151,546,'2018-5-6','2019-2-22',102906.8284,'spare parts')
              ,(152,645,'2017-11-27','2018-5-22',62235.87097,'spare parts')
              ,(152,485,'2018-6-3','2019-3-10',99011.6129,'dangerous')
              ,(153,379,'2013-6-1','2014-6-20',188350.0676,'forklifts')
              ,(154,977,'2016-12-25','2018-2-14',130451.1654,'dry and liquid goods')
              ,(155,449,'2016-11-15','2017-10-11',67842.68806,'vehicle parts')
              ,(155,677,'2017-11-24','2018-1-18',11307.11468,'dangerous')
              ,(156,842,'2016-7-27','2018-3-22',51565.77842,'containers')
              ,(157,398,'2013-8-21','2014-11-25',195996.6855,'containers')
              ,(158,717,'2016-11-21','2018-1-13',62646.74545,'trucks')
              ,(158,467,'2018-5-8','2019-3-10',45861.01461,'vehicle parts')
              ,(159,851,'2014-1-27','2014-3-28',12769.69355,'trade fair and exhibition exhibits')
              ,(159,733,'2014-7-15','2015-6-6',69382.00161,'telecommunication equipment')
              ,(160,507,'2016-1-11','2016-7-13',59782.18761,'textiles')
              ,(161,610,'2013-5-12','2013-12-9',43945.51452,'packaged foods and chocolate items')
              ,(161,899,'2014-8-9','2015-2-23',41237.97097,'packaged foods and chocolate items')
              ,(162,905,'2016-6-4','2017-2-5',96487.88168,'containers')
              ,(162,639,'2017-3-1','2017-7-5',49420.62232,'equipment')
              ,(163,833,'2017-6-6','2018-9-19',87171.20323,'forklifts')
              ,(165,496,'2015-10-2','2016-4-13',30906.54677,'bulk and packaged goods')
              ,(165,704,'2016-5-8','2016-11-19',31065.85887,'chickens')
              ,(165,833,'2017-3-27','2017-8-10',21666.44516,'packaged foods and chocolate items')
              ,(166,453,'2013-4-13','2014-6-19',299755.2681,'goods under customs control')
              ,(166,521,'2015-1-10','2015-10-28',201918.4792,'telecommunication equipment')
              ,(167,505,'2016-9-19','2018-8-12',420912.3484,'printed materials')
              ,(169,957,'2018-8-22','2019-2-25',32732.74844,'dry and liquid goods')
              ,(169,989,'2019-10-10','2020-1-27',19079.51647,'vehicle parts')
              ,(169,608,'2020-2-2','2020-9-19',40259.53016,'cosmetics and personal hygiene products')
              ,(172,622,'2013-11-21','2015-10-25',207623.2603,'printed materials')
              ,(174,564,'2017-7-19','2018-2-25',81070.03597,'glass')
              ,(175,602,'2014-7-13','2015-1-2',24505.17097,'household and industrial appliances')
              ,(175,826,'2015-2-21','2015-5-28',13598.24516,'bulk and packaged goods')
              ,(176,943,'2016-6-7','2016-10-30',72747.35831,'household and industrial appliances')
              ,(176,869,'2017-6-23','2018-6-9',176098.7777,'telecommunication equipment')
              ,(176,413,'2018-6-30','2018-9-20',41139.88539,'bulk and packaged goods')
              ,(176,736,'2018-11-22','2019-10-2',157535.6587,'bulk and packaged goods')
              ,(177,957,'2018-11-20','2019-6-28',65228.73677,'equipment')
              ,(179,446,'2014-2-5','2014-4-23',42342.03174,'telecommunication equipment')
              ,(179,617,'2015-1-29','2015-9-4',119877.4405,'cosmetics and personal hygiene products')
              ,(179,594,'2015-9-29','2016-4-26',115478.2684,'bulk and packaged goods')
              ,(180,559,'2015-5-10','2016-11-18',191285.955,'medical supplies')
              ,(180,550,'2017-4-23','2017-10-5',56563.05121,'printed materials')
              ,(180,827,'2017-10-26','2018-2-28',42850.79637,'equipment')
              ,(181,405,'2018-3-25','2020-1-27',58465.94148,'medical supplies')
              ,(181,437,'2020-3-21','2020-11-18',21023.41432,'containers')
              ,(182,893,'2016-7-10','2018-3-4',401526.2323,'equipment')
              ,(182,399,'2018-7-7','2019-2-17',150072.0968,'textiles')
              ,(183,720,'2017-2-13','2018-11-10',406929.9997,'trucks')
              ,(185,860,'2014-1-13','2015-2-14',45397.65435,'forklifts')
              ,(185,991,'2015-2-16','2015-4-26',7890.272419,'containers')
              ,(185,615,'2015-10-28','2016-6-14',26300.90806,'cosmetics and personal hygiene products')
              ,(185,988,'2016-12-7','2017-1-28',5946.292258,'stationery')
              ,(186,500,'2013-5-14','2014-1-17',189218.904,'dry and liquid goods')
              ,(186,434,'2014-5-19','2015-4-11',249494.2807,'telecommunication equipment')
              ,(186,791,'2015-7-29','2016-1-13',128180.5479,'trade fair and exhibition exhibits')
              ,(187,614,'2016-11-25','2018-1-30',112091.0876,'personal items')
              ,(187,570,'2018-5-26','2018-6-17',5721.586839,'cosmetics and personal hygiene products')
              ,(190,371,'2014-10-26','2016-10-11',214748.0323,'printed materials')
              ,(190,388,'2017-3-7','2017-6-28',33891.79839,'personal items')
              ,(190,887,'2018-4-16','2019-4-11',107973.871,'medical supplies')
              ,(191,505,'2015-10-31','2016-4-8',50598.34839,'equipment')
              ,(192,932,'2013-7-11','2013-7-28',5240.696661,'containers')
              ,(193,874,'2017-9-18','2019-2-17',49446.45537,'machine parts')
              ,(193,797,'2019-5-23','2019-10-15',13867.96137,'chickens')
              ,(194,575,'2014-1-2','2015-7-17',204053.3805,'telecommunication equipment')
              ,(194,643,'2015-10-13','2016-3-13',55287.19045,'dry and liquid goods')
              ,(195,648,'2015-7-26','2017-5-17',143457.0006,'personal items')
              ,(195,911,'2017-7-20','2017-9-29',15409.14832,'glass')
              ,(196,788,'2018-7-11','2019-1-11',65438.70968,'vehicle parts')
              ,(198,951,'2014-7-7','2015-6-18',135268.5437,'medical supplies')
              ,(198,869,'2015-11-22','2016-7-30',98128.33665,'packaged foods and chocolate items')
              ,(198,848,'2016-8-13','2017-5-6',103992.5799,'printed materials')
              ,(198,866,'2017-8-13','2018-6-3',114939.1672,'personal items')
              ,(198,901,'2018-7-6','2019-6-24',138005.1906,'glass')
              ,(199,776,'2017-5-25','2019-4-16',342537.3041,'personal items')
              ,(199,718,'2019-6-13','2020-3-12',135329.4993,'vehicle parts')
              ,(200,964,'2015-11-10','2016-9-25',140825.729,'bulk and packaged goods')
              ,(200,853,'2016-10-27','2017-9-7',138625.327,'dangerous')
              ,(201,435,'2014-1-4','2015-9-26',140556.3735,'stationery')
              ,(202,850,'2014-3-10','2016-2-19',161605.9193,'machine parts')
              ,(203,678,'2015-5-23','2015-12-15',64554.4559,'cosmetics and personal hygiene products')
              ,(203,930,'2016-3-25','2017-1-23',95264.82813,'machine parts')
              ,(204,846,'2013-6-11','2013-8-22',22119.87716,'bulk and packaged goods')
              ,(206,991,'2014-2-14','2014-7-29',31294.65048,'containers')
              ,(207,522,'2016-1-5','2017-4-21',222129.8385,'vehicle parts')
              ,(207,437,'2017-6-3','2017-10-11',61179.82839,'electronics')
              ,(207,379,'2017-11-7','2018-3-14',59767.98619,'personal items')
              ,(208,974,'2013-4-8','2014-2-5',87794.92931,'stationery')
              ,(208,764,'2014-2-14','2014-11-18',80261.37102,'forklifts')
              ,(210,902,'2015-2-9','2016-9-10',243276.2914,'equipment')
              ,(210,740,'2017-2-10','2017-11-12',115545.7343,'spare parts')
              ,(211,388,'2014-4-29','2016-2-13',283271.5793,'electronics')
              ,(211,793,'2016-3-17','2016-4-14',12109.31942,'printed materials')
              ,(212,884,'2015-8-28','2016-4-12',74081.40329,'glass')
              ,(214,826,'2017-3-10','2017-9-5',48474.73016,'packaged foods and chocolate items')
              ,(214,775,'2017-11-2','2017-12-23',13811.23597,'equipment')
              ,(215,884,'2015-9-8','2016-12-7',176445.5226,'containers')
              ,(215,792,'2017-1-8','2017-12-21',134268.8516,'equipment')
              ,(215,593,'2018-3-28','2018-7-21',44498.32258,'printed materials')
              ,(216,524,'2013-8-22','2014-4-12',129043.2468,'dangerous')
              ,(216,534,'2014-5-30','2015-1-28',134581.5836,'machine parts')
              ,(216,817,'2015-4-18','2016-2-9',164488.6022,'goods under customs control')
              ,(217,469,'2014-6-15','2015-2-6',118008.595,'containers')
              ,(218,616,'2013-9-25','2014-2-13',76038.95758,'packaged foods and chocolate items')
              ,(218,445,'2014-7-14','2015-5-26',170413.5503,'equipment')
              ,(219,383,'2018-11-13','2020-10-3',186830.5544,'vehicle parts')
              ,(219,842,'2020-11-30','2021-1-17',12996.90813,'trucks')
              ,(222,875,'2015-3-11','2015-9-7',108867.2923,'spare parts')
              ,(223,714,'2016-11-19','2017-1-22',13541.34194,'packaged foods and chocolate items')
              ,(223,773,'2017-2-27','2017-6-23',24543.68226,'textiles')
              ,(223,607,'2017-8-5','2017-9-29',11637.09073,'telecommunication equipment')
              ,(223,960,'2017-10-12','2018-3-21',33853.35484,'stationery')
              ,(225,841,'2017-7-29','2018-11-5',186213.3406,'equipment')
              ,(226,421,'2016-1-21','2017-9-17',172160.1271,'glass')
              ,(227,571,'2014-4-23','2016-1-28',260271.1074,'chickens')
              ,(228,622,'2015-10-13','2017-4-12',155266.2588,'dry and liquid goods')
              ,(229,631,'2016-10-11','2017-7-22',32726.77665,'printed materials')
              ,(230,987,'2015-8-7','2016-9-27',108267.1695,'trucks')
              ,(230,630,'2016-12-27','2017-11-12',83082.72,'printed materials')
              ,(230,631,'2017-12-17','2018-6-19',47772.564,'trade fair and exhibition exhibits')
              ,(231,931,'2016-12-12','2017-11-2',100019.2742,'equipment')
              ,(232,447,'2016-2-4','2017-6-21',117036.677,'textiles')
              ,(232,365,'2017-12-3','2018-5-5',35599.62542,'textiles')
              ,(233,936,'2013-7-1','2014-5-30',116653.7295,'machine parts')
              ,(233,627,'2014-9-12','2014-12-25',36432.396,'cosmetics and personal hygiene products')
              ,(234,985,'2014-5-31','2014-10-31',39933.85877,'printed materials')
              ,(234,985,'2015-2-1','2015-6-24',37323.80265,'electronics')
              ,(234,993,'2015-7-30','2016-7-26',94484.03187,'electronics')
              ,(237,816,'2016-9-20','2017-9-3',119754.8994,'trucks')
              ,(238,746,'2013-7-13','2014-4-27',66971.45497,'cosmetics and personal hygiene products')
              ,(238,677,'2014-6-5','2015-2-16',59530.18219,'electronics')
              ,(239,995,'2013-7-9','2013-11-9',57663.10031,'cosmetics and personal hygiene products')
              ,(239,752,'2013-11-15','2014-10-15',156581.1016,'spare parts')
              ,(239,579,'2014-12-2','2015-1-29',27190.73023,'textiles')
              ,(239,499,'2015-5-11','2015-6-22',19689.83913,'packaged foods and chocolate items')
              ,(239,727,'2016-3-5','2017-2-3',157049.9073,'packaged foods and chocolate items')
              ,(241,496,'2017-11-16','2019-4-28',107123.4929,'medical supplies')
              ,(242,797,'2014-9-6','2016-1-28',160296.2093,'personal items')
              ,(243,623,'2016-8-23','2018-2-11',312621.7215,'stationery')
              ,(243,421,'2018-3-30','2018-11-12',132151.0815,'stationery')
              ,(244,549,'2015-2-22','2016-8-6',166544.1418,'personal items')
              ,(244,921,'2017-6-4','2017-12-30',65551.27239,'chickens')
              ,(244,474,'2018-4-14','2018-6-17',20073.1169,'containers')
              ,(244,675,'2019-4-26','2019-6-19',16936.69239,'trucks')
              ,(247,449,'2016-9-9','2017-6-30',59678.68065,'machine parts')
              ,(249,467,'2017-4-14','2018-4-7',86084.98026,'equipment')
              ,(249,654,'2018-10-28','2019-10-9',83199.45019,'cosmetics and personal hygiene products')
              ,(249,543,'2020-2-18','2020-6-26',31019.44819,'glass')
              ,(249,752,'2020-12-16','2021-7-4',48092.16774,'bulk and packaged goods')
              ,(251,413,'2018-1-31','2019-12-23',214287.6818,'cosmetics and personal hygiene products')
              ,(251,996,'2020-3-10','2021-3-5',111640.471,'trade fair and exhibition exhibits')
              ,(252,984,'2018-9-2','2019-6-30',126571.602,'cosmetics and personal hygiene products')
              ,(252,733,'2020-1-4','2020-3-8',26912.23432,'containers')
              ,(253,631,'2015-10-11','2016-12-15',108406.4547,'equipment')
              ,(253,516,'2017-6-8','2018-1-16',55838.12748,'containers')
              ,(253,368,'2018-5-17','2018-9-7',28422.10994,'personal items')
              ,(254,670,'2013-5-30','2014-4-14',166769.9843,'dangerous')
              ,(254,759,'2014-5-7','2014-7-16',36595.29435,'spare parts')
              ,(254,378,'2014-8-8','2015-6-15',162587.6649,'goods under customs control')
              ,(255,442,'2016-9-12','2018-3-24',150985.296,'dangerous')
              ,(255,877,'2018-4-16','2018-7-21',25975.9649,'goods under customs control')
              ,(256,459,'2016-7-7','2016-11-7',63741.10761,'household and industrial appliances')
              ,(256,549,'2016-11-15','2017-7-10',122818.2317,'telecommunication equipment')
              ,(256,681,'2017-7-23','2017-11-23',63741.10761,'trade fair and exhibition exhibits')
              ,(256,810,'2018-3-15','2018-5-7',27465.68052,'medical supplies')
              ,(258,417,'2018-12-5','2020-5-13',202740.5032,'personal items')
              ,(259,965,'2014-11-17','2015-3-16',14068.7251,'spare parts')
              ,(259,767,'2015-10-18','2016-2-3',12768.25471,'bulk and packaged goods')
              ,(261,680,'2017-6-20','2018-12-26',154576.0792,'goods under customs control')
              ,(262,999,'2018-8-18','2019-2-3',26339.9911,'household and industrial appliances')
              ,(263,477,'2016-4-17','2016-6-10',23604.66726,'printed materials')
              ,(263,953,'2016-9-2','2016-10-17',19670.55605,'containers')
              ,(265,759,'2017-5-21','2017-9-27',89942.29548,'machine parts')
              ,(266,534,'2014-11-23','2016-3-16',112969.0597,'telecommunication equipment')
              ,(266,482,'2016-4-2','2016-7-25',26886.16452,'chickens')
              ,(269,888,'2014-9-1','2016-8-9',285284.0665,'forklifts')
              ,(269,581,'2016-10-4','2016-11-26',21356.01063,'packaged foods and chocolate items')
              ,(270,796,'2016-11-14','2018-10-20',195522.7101,'containers')
              ,(270,615,'2018-12-5','2019-5-2',41045.90226,'equipment')
              ,(270,989,'2019-11-5','2020-6-24',64342.22516,'telecommunication equipment')
              ,(270,712,'2020-12-19','2021-9-1',70998.31742,'stationery')
              ,(270,538,'2021-12-30','2022-8-30',67392.93411,'dangerous')
              ,(270,496,'2022-9-9','2023-9-5',100118.721,'glass')
              ,(271,641,'2015-3-6','2015-12-1',147383.4194,'textiles')
              ,(272,579,'2013-12-18','2015-1-17',51938.20597,'packaged foods and chocolate items')
              ,(273,841,'2016-8-17','2018-3-26',259007.5577,'chickens')
              ,(273,974,'2018-4-20','2018-8-18',53039.09032,'glass')
              ,(276,698,'2018-8-9','2019-6-28',70849.31023,'textiles')
              ,(277,529,'2016-6-26','2017-10-5',62217.02042,'spare parts')
              ,(278,930,'2017-3-21','2019-2-7',94051.35329,'equipment')
              ,(278,414,'2019-5-2','2020-1-8',34312.33965,'spare parts')
              ,(278,509,'2020-1-28','2021-1-1',46342.1639,'trade fair and exhibition exhibits')
              ,(280,769,'2016-11-9','2018-7-11',97701.5655,'packaged foods and chocolate items')
              ,(281,600,'2013-9-20','2014-7-1',118118.2705,'trade fair and exhibition exhibits')
              ,(281,662,'2014-12-19','2015-11-22',140577.3783,'glass')
              ,(281,807,'2016-1-14','2016-4-26',42838.66853,'machine parts')
              ,(283,878,'2013-3-13','2014-4-5',75792.17032,'forklifts')
              ,(284,761,'2017-12-4','2019-1-10',186654.1178,'chickens')
              ,(284,939,'2019-1-17','2019-10-13',124900.3922,'textiles')
              ,(285,451,'2018-3-21','2019-10-16',45042.10403,'goods under customs control')
              ,(287,646,'2017-9-8','2018-8-17',102602.0879,'printed materials')
              ,(287,783,'2019-1-7','2019-12-9',100508.1677,'cosmetics and personal hygiene products')
              ,(287,400,'2019-12-22','2020-4-3',30810.53952,'containers')
              ,(288,626,'2013-11-6','2014-10-30',222664.365,'vehicle parts')
              ,(289,942,'2013-12-2','2015-2-11',248515.4009,'spare parts')
              ,(291,941,'2018-6-23','2018-11-7',32789.169,'trade fair and exhibition exhibits')
              ,(292,544,'2015-6-4','2015-10-29',27268.06848,'stationery')
              ,(292,800,'2015-11-26','2016-3-25',22259.64774,'chickens')
              ,(293,871,'2013-12-31','2015-6-18',177088.7749,'medical supplies')
              ,(293,484,'2015-10-23','2016-3-4',44106.38027,'trucks')
              ,(293,822,'2016-11-20','2017-2-10',27193.40739,'vehicle parts')
              ,(295,734,'2018-2-21','2018-12-15',134329.8905,'personal items')
              ,(296,573,'2017-4-6','2018-7-25',64922.60927,'dangerous')
              ,(296,633,'2019-2-18','2019-12-28',42780.58253,'vehicle parts')
              ,(299,395,'2015-7-6','2016-1-10',67483.92813,'electronics')
              ,(299,726,'2016-2-6','2016-11-28',106251.2911,'trucks')
              ,(300,526,'2014-4-29','2016-1-18',155639.9426,'vehicle parts')
              ,(301,752,'2015-12-18','2017-9-10',139728.4723,'vehicle parts')
              ,(302,507,'2013-9-30','2014-2-3',44754.444,'textiles')
              ,(302,442,'2014-3-5','2014-8-18',58962.204,'goods under customs control')
              ,(303,358,'2014-2-8','2015-4-12',77204.02065,'equipment')
              ,(303,746,'2015-6-8','2015-8-3',10101.46065,'stationery')
              ,(304,386,'2017-5-16','2018-11-13',333882.5226,'goods under customs control')
              ,(308,766,'2018-9-12','2018-10-27',19993.51742,'printed materials')
              ,(308,995,'2019-5-25','2020-5-14',157726.6374,'containers')
              ,(309,466,'2016-10-17','2017-9-8',78442.24094,'textiles')
              ,(309,415,'2018-1-8','2018-1-26',4331.166677,'bulk and packaged goods')
              ,(309,678,'2018-2-8','2018-5-26',25746.37969,'dry and liquid goods')
              ,(310,843,'2016-6-28','2018-4-1',204959.4526,'packaged foods and chocolate items')
              ,(311,945,'2018-4-23','2018-10-24',71362.34632,'personal items')
              ,(312,612,'2015-10-13','2015-12-8',18573.78194,'medical supplies')
              ,(312,756,'2016-2-1','2016-11-2',91210.53629,'dangerous')
              ,(313,810,'2014-12-28','2015-11-3',120740.34,'textiles')
              ,(315,617,'2018-6-21','2020-3-8',176860.3471,'packaged foods and chocolate items')
              ,(315,386,'2020-5-14','2020-9-26',38140.80968,'trade fair and exhibition exhibits')
              ,(316,487,'2013-10-29','2015-2-6',45644.76,'chickens')
              ,(316,534,'2015-9-13','2016-5-19',24442.03277,'trucks')
              ,(316,367,'2016-5-19','2016-6-3',1472.411613,'bulk and packaged goods')
              ,(320,522,'2016-10-11','2017-7-17',61171.929,'forklifts')
              ,(320,927,'2017-7-24','2017-10-6',16224.81271,'chickens')
              ,(320,673,'2017-11-12','2018-4-16',33984.405,'household and industrial appliances')
              ,(322,602,'2013-3-21','2015-1-1',285053.58,'equipment')
              ,(323,568,'2016-7-3','2016-11-19',44080.90185,'cosmetics and personal hygiene products')
              ,(324,974,'2018-9-1','2018-9-17',1763.544774,'textiles')
              ,(325,675,'2016-1-25','2017-7-3',142654.6089,'textiles')
              ,(326,477,'2015-9-6','2016-12-17',293523.6821,'stationery')
              ,(326,906,'2016-12-20','2017-8-6',143625.9043,'dry and liquid goods')
              ,(327,720,'2014-9-19','2015-12-24',100335.7577,'equipment')
              ,(327,855,'2016-1-10','2016-3-29',17194.1971,'dangerous')
              ,(328,831,'2014-4-29','2014-8-11',40812.61935,'electronics')
              ,(328,557,'2014-8-23','2015-1-31',63181.07419,'glass')
              ,(328,380,'2015-6-25','2015-9-11',30609.46452,'vehicle parts')
              ,(329,837,'2015-1-23','2016-2-26',54998.94513,'bulk and packaged goods')
              ,(329,823,'2016-2-28','2016-6-28',16678.8781,'equipment')
              ,(329,884,'2016-7-14','2016-12-12',20814.13713,'personal items')
              ,(330,762,'2014-12-24','2015-7-1',23397.44705,'goods under customs control')
              ,(330,907,'2015-11-15','2016-7-15',30082.43192,'trade fair and exhibition exhibits')
              ,(330,636,'2016-10-9','2017-3-9',18693.19844,'electronics')
              ,(331,951,'2017-4-6','2017-6-3',25607.46774,'medical supplies')
              ,(332,680,'2013-5-30','2014-2-13',101412.085,'bulk and packaged goods')
              ,(333,878,'2017-5-26','2019-3-6',139833.9796,'machine parts')
              ,(335,604,'2017-5-1','2017-8-27',52486.99761,'printed materials')
              ,(335,773,'2017-9-12','2018-3-16',82288.93694,'vehicle parts')
              ,(336,431,'2017-12-16','2018-11-9',136191.9801,'bulk and packaged goods')
              ,(336,359,'2019-3-7','2019-10-30',98407.01003,'glass')
              ,(336,404,'2020-4-19','2020-7-1',30311.01997,'machine parts')
              ,(337,643,'2014-11-23','2016-11-4',266909.599,'equipment')
              ,(337,944,'2017-1-3','2017-11-13',117710.1321,'trucks')
              ,(337,365,'2018-4-21','2018-6-12',19493.39768,'cosmetics and personal hygiene products')
              ,(339,777,'2013-1-5','2013-9-18',134778.0542,'containers')
              ,(341,789,'2015-10-4','2016-12-17',138361.1013,'stationery')
              ,(342,469,'2016-11-25','2017-7-4',59773.83435,'bulk and packaged goods')
              ,(343,794,'2014-8-3','2016-2-6',148369.3734,'textiles')
              ,(343,930,'2016-4-9','2016-5-4',6719.627419,'cosmetics and personal hygiene products')
              ,(344,952,'2014-3-6','2014-5-20',24002.69516,'personal items')
              ,(344,794,'2014-8-13','2015-3-9',66567.47458,'goods under customs control')
              ,(345,525,'2018-3-10','2019-2-1',170924.609,'trade fair and exhibition exhibits')
              ,(345,619,'2019-5-28','2019-12-8',101095.6529,'spare parts')
              ,(346,883,'2014-1-15','2015-11-4',292490.5092,'vehicle parts')
              ,(347,907,'2015-6-18','2015-12-7',42727.0471,'household and industrial appliances')
              ,(348,506,'2017-12-15','2019-9-27',290448.774,'trucks')
              ,(348,551,'2019-9-28','2020-9-6',153478.3076,'printed materials')
              ,(349,506,'2018-4-15','2019-9-18',88080.34403,'equipment')
              ,(349,685,'2019-9-26','2019-12-24',15046.35435,'vehicle parts')
              ,(350,503,'2017-7-22','2019-4-8',56133.50806,'containers')
              ,(351,765,'2015-11-23','2017-4-7',238741.5138,'equipment')
              ,(352,758,'2013-7-1','2014-3-20',62657.8409,'dry and liquid goods')
              ,(354,903,'2014-5-30','2015-6-11',133777.5075,'dry and liquid goods')
              ,(354,637,'2016-1-20','2016-5-27',45420.48,'textiles')
              ,(355,899,'2018-6-25','2018-7-23',2958.493548,'packaged foods and chocolate items')
              ,(356,855,'2017-9-1','2018-9-11',103277.4496,'machine parts')
              ,(357,537,'2014-12-9','2016-3-9',121254.7099,'personal items')
              ,(357,749,'2016-7-2','2017-4-20',77645.55987,'personal items')
              ,(358,798,'2016-4-29','2016-7-7',9044.097097,'chickens')
              ,(358,482,'2016-12-4','2017-7-14',29098.39935,'machine parts')
              ,(359,824,'2014-10-3','2015-3-9',51101.53244,'containers')
              ,(359,449,'2015-10-6','2016-6-12',81371.86694,'bulk and packaged goods')
              ,(361,768,'2013-3-26','2015-2-5',120170.611,'cosmetics and personal hygiene products')
              ,(363,523,'2018-8-28','2019-3-11',53047.42258,'trucks')
              ,(363,394,'2020-2-2','2021-1-26',97661.66516,'household and industrial appliances')
              ,(363,551,'2021-3-15','2021-6-25',27747.88258,'machine parts')
              ,(363,405,'2022-6-3','2022-10-6',34004.75806,'vehicle parts')
              ,(364,519,'2014-1-16','2015-10-21',159592.8282,'forklifts')
              ,(365,880,'2018-7-12','2019-12-5',114724.4287,'trade fair and exhibition exhibits')
              ,(367,925,'2018-5-18','2019-7-21',160329.395,'glass')
              ,(367,898,'2019-8-26','2020-6-28',114734.5554,'trade fair and exhibition exhibits')
              ,(369,405,'2017-10-30','2018-5-31',29887.1431,'telecommunication equipment')
              ,(369,508,'2018-6-8','2018-10-2',16276.56619,'dry and liquid goods')
              ,(371,568,'2014-12-24','2016-6-26',52873.66452,'equipment')
              ,(372,655,'2013-4-5','2014-9-20',171852.9892,'forklifts')
              ,(372,922,'2014-12-6','2015-6-22',63840.32245,'equipment')
              ,(373,908,'2015-11-6','2016-7-26',96888.56371,'trade fair and exhibition exhibits')
              ,(374,576,'2013-9-13','2015-5-9',73614.10384,'telecommunication equipment')
              ,(375,547,'2014-8-7','2015-4-21',48852.25123,'machine parts')
              ,(376,665,'2014-3-3','2014-6-15',12322.23368,'vehicle parts')
              ,(376,779,'2014-6-29','2015-6-21',42298.43676,'stationery')
              ,(376,669,'2015-8-18','2015-10-1',5213.25271,'machine parts')
              ,(376,710,'2016-3-3','2016-6-23',13270.09781,'cosmetics and personal hygiene products')
              ,(376,879,'2016-7-28','2017-1-8',19431.21465,'trade fair and exhibition exhibits')
              ,(376,809,'2017-4-1','2017-11-1',25355.36545,'containers')
              ,(377,666,'2014-5-15','2015-4-13',90266.09516,'spare parts')
              ,(379,797,'2013-7-28','2015-6-12',111156.509,'spare parts')
              ,(379,662,'2015-10-15','2016-3-13',24376.42742,'bulk and packaged goods')
              ,(379,751,'2016-9-12','2017-3-14',29739.24145,'vehicle parts')
              ,(379,498,'2017-6-25','2017-10-1',15925.93258,'personal items')
              ,(381,496,'2014-9-23','2015-11-20',154302.8679,'equipment')
              ,(381,550,'2015-12-1','2016-10-12',115271.1732,'equipment')
              ,(381,740,'2017-1-21','2017-10-27',101774.232,'printed materials')
              ,(381,501,'2018-1-24','2018-6-25',55446.89342,'textiles')
              ,(383,366,'2018-8-11','2020-7-27',98970.83226,'electronics')
              ,(383,974,'2020-9-21','2021-9-17',49900.09839,'machine parts')
              ,(383,634,'2022-2-5','2022-5-13',13408.05968,'chickens')
              ,(384,398,'2014-9-29','2016-5-1',144267.7781,'forklifts')
              ,(385,445,'2018-4-13','2019-8-29',164330.9762,'bulk and packaged goods')
              ,(386,578,'2016-9-23','2017-6-10',29661.53806,'stationery')
              ,(386,908,'2017-6-16','2018-4-15',34567.10013,'trade fair and exhibition exhibits')
              ,(387,740,'2015-10-22','2016-6-6',70196.868,'forklifts')
              ,(387,557,'2016-7-2','2017-5-3',93903.705,'printed materials')
              ,(388,656,'2015-3-31','2016-6-11',196868.9479,'forklifts')
              ,(389,791,'2013-2-14','2013-5-22',30976.13332,'telecommunication equipment')
              ,(390,777,'2017-8-18','2019-2-22',233867.6513,'dangerous')
              ,(390,981,'2019-3-24','2019-6-29',41021.99308,'trucks')
              ,(391,801,'2017-12-20','2018-12-24',55831.79497,'forklifts')
              ,(392,887,'2017-7-6','2018-7-23',189206.892,'textiles')
              ,(392,480,'2018-7-23','2019-5-26',152058.942,'dangerous')
              ,(392,432,'2019-7-30','2020-1-14',83211.408,'packaged foods and chocolate items')
              ,(395,515,'2013-8-8','2014-9-10',110053.965,'dangerous')
              ,(396,860,'2015-9-4','2017-1-23',190560.006,'packaged foods and chocolate items')
              ,(396,997,'2017-10-20','2018-6-24',92836.926,'equipment')
              ,(397,480,'2018-3-21','2019-2-7',93063.85403,'trade fair and exhibition exhibits')
              ,(397,617,'2019-8-10','2020-2-15',54455.32016,'electronics')
              ,(397,557,'2020-10-26','2021-3-20',41777.89113,'packaged foods and chocolate items')
              ,(397,469,'2021-3-25','2022-2-21',95945.0879,'vehicle parts')
              ,(398,447,'2013-7-12','2014-9-15',87073.3771,'stationery')
              ,(398,804,'2014-10-11','2014-12-23',14782.22448,'dry and liquid goods')
              ,(398,358,'2015-4-14','2016-2-28',64798.79226,'trucks')
              ,(399,539,'2013-10-20','2013-12-7',20311.26503,'equipment')
              ,(399,713,'2014-8-26','2014-11-22',37237.31923,'equipment')
              ,(400,899,'2013-5-6','2015-3-6',346069.4702,'dangerous')
              ,(400,961,'2015-5-26','2015-9-26',63627.12232,'dangerous')
              ,(400,969,'2016-2-11','2016-10-19',129840.713,'spare parts')
              ,(401,686,'2015-4-22','2015-6-2',14528.12516,'personal items')
              ,(401,627,'2016-2-5','2016-11-22',103114.2542,'cosmetics and personal hygiene products')
              ,(402,525,'2014-12-25','2015-6-11',15086.29703,'forklifts')
              ,(403,714,'2016-3-27','2016-8-2',41347.24955,'dry and liquid goods')
              ,(404,803,'2015-5-24','2015-8-27',33347.45468,'equipment')
              ,(404,715,'2015-9-17','2016-5-26',88458.51135,'medical supplies')
              ,(405,377,'2016-7-26','2017-10-14',44665.33185,'machine parts')
              ,(406,460,'2014-11-16','2015-5-24',92339.74524,'dry and liquid goods')
              ,(406,847,'2015-6-2','2016-3-26',145593.884,'medical supplies')
              ,(406,871,'2016-5-2','2016-5-18',7817.12129,'forklifts')
              ,(407,896,'2015-12-21','2016-1-25',14629.22661,'forklifts')
              ,(407,630,'2016-6-20','2016-12-31',81087.71323,'electronics')
              ,(407,986,'2017-1-21','2017-5-7',44305.65774,'dry and liquid goods')
              ,(408,998,'2014-11-25','2015-2-8',13222.37903,'dangerous')
              ,(411,459,'2015-2-24','2015-9-5',67427.99598,'printed materials')
              ,(411,782,'2015-11-15','2016-1-10',19564.59987,'printed materials')
              ,(412,555,'2014-10-18','2015-7-2',161573.9932,'containers')
              ,(413,775,'2013-6-17','2013-11-7',25203.5009,'goods under customs control')
              ,(413,905,'2014-6-22','2014-12-16',31195.94168,'electronics')
              ,(414,820,'2016-4-6','2016-7-28',41010.76011,'trade fair and exhibition exhibits')
              ,(414,869,'2016-9-2','2017-7-29',119765.9366,'trucks')
              ,(416,409,'2015-1-31','2016-3-23',116361.0386,'stationery')
              ,(416,717,'2016-9-8','2017-4-21',62784.73306,'chickens')
              ,(416,449,'2017-5-21','2018-1-12',65854.2089,'forklifts')
              ,(417,697,'2016-2-3','2018-1-3',152155.6694,'personal items')
              ,(417,903,'2018-1-5','2018-5-3',25649.09855,'vehicle parts')
              ,(417,762,'2018-6-12','2019-4-19',67600.59024,'telecommunication equipment')
              ,(419,468,'2017-9-22','2019-3-22',187497.9499,'chickens')
              ,(421,594,'2013-2-13','2013-11-13',87879.58505,'containers')
              ,(423,954,'2014-10-21','2016-7-10',186001.2122,'bulk and packaged goods')
              ,(425,788,'2017-12-2','2019-3-2',305162.8125,'textiles')
              ,(426,507,'2015-10-19','2016-4-23',37208.70503,'textiles')
              ,(426,474,'2016-6-6','2017-4-26',64468.55845,'trucks')
              ,(427,429,'2017-8-4','2019-3-28',176996.904,'stationery')
              ,(427,388,'2019-7-18','2020-4-17',80694.096,'stationery')
              ,(427,595,'2020-7-17','2020-8-2',4712.064,'household and industrial appliances')
              ,(429,860,'2017-3-20','2017-6-5',32560.7205,'stationery')
              ,(429,612,'2017-11-19','2018-3-4',44400.9825,'trucks')
              ,(431,531,'2018-7-3','2019-7-19',123836.897,'machine parts')
              ,(432,640,'2015-1-11','2015-8-27',58657.63355,'equipment')
              ,(432,390,'2015-12-31','2016-4-23',29328.81677,'equipment')
              ,(432,635,'2016-5-23','2016-11-22',47080.46903,'personal items')
              ,(433,801,'2013-5-25','2014-9-28',45735.60465,'household and industrial appliances')
              ,(433,480,'2014-12-22','2015-4-3',9501.082839,'chickens')
              ,(433,793,'2015-5-4','2016-3-11',29062.13574,'dry and liquid goods')
              ,(434,970,'2014-9-7','2015-11-16',68320.95968,'machine parts')
              ,(434,654,'2016-6-2','2016-8-9',10680.05806,'trade fair and exhibition exhibits')
              ,(435,897,'2017-12-19','2018-6-4',23181.04374,'bulk and packaged goods')
              ,(435,908,'2018-6-26','2018-11-10',19016.78439,'machine parts')
              ,(435,989,'2019-5-1','2019-9-29',20960.10542,'textiles')
              ,(437,730,'2018-1-7','2018-8-21',104239.7661,'glass')
              ,(437,450,'2018-10-3','2019-5-7',99627.3871,'forklifts')
              ,(438,569,'2018-2-3','2019-1-8',145273.2994,'goods under customs control')
              ,(438,959,'2019-4-14','2019-7-1',33425.7149,'goods under customs control')
              ,(442,572,'2015-7-5','2017-6-14',60706.30548,'chickens')
              ,(442,761,'2017-7-8','2018-1-17',16501.85487,'goods under customs control')
              ,(443,454,'2013-2-6','2013-8-4',28065.90658,'printed materials')
              ,(443,378,'2013-8-13','2014-1-13',23989.29445,'dry and liquid goods')
              ,(444,984,'2013-1-1','2013-12-30',105041.4974,'bulk and packaged goods')
              ,(445,876,'2016-3-20','2016-9-2',16113.97877,'forklifts')
              ,(445,419,'2017-1-9','2017-2-26',4659.463742,'textiles')
              ,(446,622,'2013-6-25','2013-11-16',13015.296,'dangerous')
              ,(446,398,'2013-11-27','2014-5-1',14009.52,'medical supplies')
              ,(447,879,'2016-12-9','2017-5-31',40962.66097,'stationery')
              ,(447,997,'2017-7-1','2017-12-23',41436.21774,'medical supplies')
              ,(447,354,'2018-4-14','2019-2-3',69849.62419,'spare parts')
              ,(448,407,'2018-2-24','2018-6-25',36201.79094,'equipment')
              ,(448,907,'2018-10-12','2019-5-17',64923.873,'goods under customs control')
              ,(451,376,'2013-12-23','2015-4-11',134940.9194,'equipment')
              ,(451,950,'2016-1-19','2016-12-10',92807.46774,'dry and liquid goods')
              ,(451,600,'2017-7-2','2017-9-15',21351.41129,'trucks')
              ,(452,417,'2013-2-10','2013-12-15',109453.9997,'stationery')
              ,(452,624,'2013-12-24','2014-3-6',25586.64929,'stationery')
              ,(452,418,'2014-8-19','2014-9-20',11371.84413,'goods under customs control')
              ,(454,631,'2014-1-22','2015-12-27',622998.7138,'personal items')
              ,(455,962,'2013-5-11','2013-9-25',23059.155,'personal items')
              ,(456,358,'2014-12-25','2015-4-3',13835.54381,'printed materials')
              ,(457,381,'2016-5-19','2017-4-9',46265.57419,'containers')
              ,(457,946,'2017-5-13','2017-11-13',26193.43277,'telecommunication equipment')
              ,(457,556,'2018-6-13','2019-3-10',38436.01548,'glass')
              ,(458,350,'2015-7-25','2017-6-27',235110.2995,'stationery')
              ,(458,352,'2017-8-3','2017-12-3',40801.5029,'printed materials')
              ,(460,560,'2017-4-7','2018-8-6',60895.25129,'personal items')
              ,(460,381,'2018-8-29','2019-8-27',45483.49016,'dry and liquid goods')
              ,(462,530,'2016-6-17','2017-7-5',78842.15613,'equipment')
              ,(462,667,'2017-10-30','2018-8-25',61550.40387,'trade fair and exhibition exhibits')
              ,(463,358,'2013-5-15','2014-8-9',69024.34248,'trucks')
              ,(464,729,'2018-9-5','2018-12-16',10168.31584,'equipment')
              ,(465,653,'2018-11-4','2020-5-18',145633.6817,'packaged foods and chocolate items')
              ,(465,473,'2020-7-8','2020-8-26',12720.23245,'trucks')
              ,(466,503,'2015-1-21','2017-1-15',424364.4605,'telecommunication equipment')
              ,(466,848,'2017-1-29','2017-9-5',128187.3336,'household and industrial appliances')
              ,(467,843,'2016-7-3','2016-10-14',34374.95419,'cosmetics and personal hygiene products')
              ,(467,376,'2017-4-2','2017-6-20',26365.25613,'printed materials')
              ,(468,498,'2015-3-6','2016-7-5',64237.93137,'dangerous')
              ,(469,422,'2018-5-13','2018-7-25',12115.64516,'containers')
              ,(470,517,'2013-8-22','2013-12-1',54663.4725,'chickens')
              ,(470,995,'2014-7-12','2015-5-15',166155.3075,'goods under customs control')
              ,(470,376,'2015-8-13','2015-11-20',53581.0275,'spare parts')
              ,(470,620,'2016-3-17','2016-5-22',35720.685,'personal items')
              ,(471,522,'2015-1-19','2015-8-6',27875.61508,'cosmetics and personal hygiene products')
              ,(471,771,'2015-11-4','2016-8-6',38661.6571,'textiles')
              ,(471,660,'2016-9-8','2017-5-20',35579.93081,'personal items')
              ,(472,458,'2016-2-20','2016-11-30',67313.93652,'cosmetics and personal hygiene products')
              ,(473,627,'2016-3-4','2016-10-28',49734.13065,'chickens')
              ,(473,860,'2016-12-11','2017-3-5',17553.22258,'medical supplies')
              ,(474,495,'2014-6-30','2016-2-3',175146.9757,'stationery')
              ,(475,459,'2018-5-1','2019-4-16',136701.5831,'telecommunication equipment')
              ,(476,625,'2015-2-16','2017-1-15',119824.2035,'chickens')
              ,(476,377,'2017-12-15','2018-7-4',34455.88684,'equipment')
              ,(479,510,'2014-3-9','2015-10-5',116120.9903,'forklifts')
              ,(482,569,'2017-7-3','2018-7-1',131848.6375,'spare parts')
              ,(482,981,'2019-3-21','2019-7-3',37774.81626,'dry and liquid goods')
              ,(482,440,'2019-9-28','2020-3-7',58478.32132,'dry and liquid goods')
              ,(483,938,'2013-9-28','2014-7-21',35522.93613,'medical supplies')
              ,(484,726,'2016-5-14','2017-2-4',47661.19355,'telecommunication equipment')
              ,(484,840,'2017-10-23','2018-5-4',34581.24194,'telecommunication equipment')
              ,(485,903,'2017-2-12','2018-8-8',208271.324,'equipment')
              ,(485,549,'2018-11-16','2019-4-8',54949.81427,'trade fair and exhibition exhibits')
              ,(486,867,'2015-4-20','2016-8-14',187661.88,'cosmetics and personal hygiene products')
              ,(488,417,'2016-1-28','2016-11-2',79550.667,'telecommunication equipment')
              ,(490,451,'2013-12-28','2014-8-4',43700.43977,'telecommunication equipment')
              ,(490,521,'2014-9-26','2014-11-7',8380.906258,'personal items')
              ,(492,474,'2018-5-31','2018-8-3',24791.59742,'chickens')
              ,(493,425,'2014-7-18','2014-8-10',3399.463065,'telecommunication equipment')
              ,(495,834,'2017-9-24','2018-5-23',191082.3813,'household and industrial appliances')
              ,(496,492,'2016-7-29','2016-9-10',16521.05497,'chickens')
              ,(496,802,'2016-10-11','2016-12-18',26126.31948,'machine parts')
              ,(496,765,'2017-4-28','2017-10-12',64163.16697,'packaged foods and chocolate items')
              ,(497,508,'2018-8-4','2019-6-16',87342.17574,'trucks')
              ,(498,725,'2017-8-17','2018-6-28',146081.819,'medical supplies')
              ,(500,636,'2018-10-11','2019-9-6',90610.42065,'machine parts')
              ,(500,909,'2019-11-8','2019-12-13',9610.196129,'machine parts')
              ,(501,908,'2014-11-6','2015-5-27',63298.02929,'household and industrial appliances')
              ,(502,470,'2016-1-17','2017-9-24',106900.6003,'trade fair and exhibition exhibits')
              ,(502,363,'2018-6-11','2018-10-22',23080.81142,'equipment')
              ,(503,939,'2017-11-30','2019-11-27',130444.9416,'telecommunication equipment')
              ,(503,517,'2020-7-4','2020-10-5',16686.9045,'personal items')
              ,(504,514,'2016-4-8','2017-9-18',110005.8364,'equipment')
              ,(505,445,'2018-7-31','2019-10-1',102234.7918,'equipment')
              ,(505,919,'2019-12-27','2020-12-7',82841.30671,'bulk and packaged goods')
              ,(506,731,'2017-5-9','2017-12-22',78800.04774,'equipment')
              ,(507,860,'2015-12-17','2016-8-17',79123.65097,'dangerous')
              ,(507,685,'2017-1-27','2017-9-22',77177.98742,'bulk and packaged goods')
              ,(508,691,'2017-6-23','2019-4-6',103663.2362,'medical supplies')
              ,(508,475,'2019-4-17','2019-9-19',24643.8675,'trade fair and exhibition exhibits')
              ,(508,890,'2019-9-23','2020-2-10',22258.9771,'equipment')
              ,(509,627,'2017-8-15','2019-7-4',166492.2271,'goods under customs control')
              ,(509,382,'2020-1-14','2020-3-12',14035.68194,'machine parts')
              ,(512,895,'2015-11-5','2016-4-14',67210.899,'bulk and packaged goods')
              ,(512,580,'2016-11-21','2017-7-24',102277.455,'trucks')
              ,(512,781,'2017-10-5','2018-3-22',70133.112,'medical supplies')
              ,(512,743,'2018-3-29','2018-8-9',55522.047,'packaged foods and chocolate items')
              ,(512,551,'2018-9-13','2019-4-14',88918.767,'chickens')
              ,(514,787,'2016-2-12','2016-9-23',39216.56516,'personal items')
              ,(514,478,'2016-10-13','2017-10-13',63901.99234,'household and industrial appliances')
              ,(516,770,'2015-11-25','2016-2-2',8348.483613,'vehicle parts')
              ,(516,763,'2016-4-19','2017-2-5',35329.81471,'dry and liquid goods')
              ,(519,375,'2013-11-18','2013-12-11',9082.830581,'household and industrial appliances')
              ,(521,728,'2016-8-11','2016-12-15',14655.08439,'cosmetics and personal hygiene products')
              ,(523,715,'2018-2-24','2018-5-31',36773.79097,'equipment')
              ,(524,415,'2017-9-3','2018-6-1',92093.23065,'glass')
              ,(524,602,'2018-7-5','2018-10-9',32623.43226,'personal items')
              ,(525,940,'2015-5-9','2016-3-21',101751.1713,'cosmetics and personal hygiene products')
              ,(525,534,'2016-12-13','2017-1-12',9629.448387,'cosmetics and personal hygiene products')
              ,(526,362,'2015-11-18','2016-11-7',46341.24194,'printed materials')
              ,(527,403,'2017-1-3','2017-1-23',8228.775484,'telecommunication equipment')
              ,(527,873,'2017-7-16','2017-10-14',37029.48968,'vehicle parts')
              ,(528,483,'2016-4-17','2017-11-11',110153.7695,'trucks')
              ,(528,380,'2018-1-29','2018-4-5',12687.86874,'medical supplies')
              ,(528,863,'2018-7-20','2019-4-10',50751.47497,'telecommunication equipment')
              ,(529,648,'2018-7-26','2019-10-3',90024.858,'electronics')
              ,(530,424,'2018-7-24','2019-6-20',139852.7746,'trucks')
              ,(531,685,'2014-1-19','2014-11-30',50086.21935,'household and industrial appliances')
              ,(532,978,'2016-6-5','2017-12-28',274844.5506,'medical supplies')
              ,(534,729,'2013-5-2','2014-2-21',147871.3527,'dry and liquid goods')
              ,(534,788,'2014-6-3','2015-1-27',119299.5998,'glass')
              ,(534,987,'2015-3-27','2016-3-5',172433.035,'forklifts')
              ,(534,798,'2016-9-9','2017-6-29',146868.835,'containers')
              ,(534,858,'2017-7-5','2018-6-23',176944.3644,'containers')
              ,(534,553,'2018-7-24','2018-11-24',61654.83518,'bulk and packaged goods')
              ,(536,500,'2018-2-12','2018-9-8',35543.89548,'medical supplies')
              ,(537,532,'2017-6-27','2018-1-27',25409.80084,'household and industrial appliances')
              ,(537,815,'2018-4-3','2019-2-28',39302.07513,'personal items')
              ,(537,951,'2019-4-27','2020-1-30',33008.99361,'dry and liquid goods')
              ,(538,689,'2016-1-3','2017-1-27',186590.9206,'spare parts')
              ,(538,573,'2017-7-4','2018-1-31',100950.4725,'personal items')
              ,(538,543,'2018-5-1','2018-9-3',59804.78226,'trade fair and exhibition exhibits')
              ,(540,660,'2018-3-15','2018-10-5',109043.2777,'chickens')
              ,(540,506,'2019-8-20','2020-3-7',106905.1742,'trucks')
              ,(541,584,'2014-2-27','2016-1-30',152841.2516,'dangerous')
              ,(541,843,'2016-3-3','2016-7-29',32222.94194,'household and industrial appliances')
              ,(541,607,'2016-8-22','2017-5-15',57914.20645,'trucks')
              ,(542,807,'2016-8-19','2017-5-16',128204.1871,'stationery')
              ,(542,391,'2017-8-18','2018-7-11',155269.5155,'textiles')
              ,(542,372,'2019-4-23','2019-11-7',94016.40387,'personal items')
              ,(543,354,'2017-1-19','2017-10-27',115644.8475,'trade fair and exhibition exhibits')
              ,(543,918,'2017-11-13','2018-8-12',111940.92,'dry and liquid goods')
              ,(544,927,'2016-2-20','2017-8-24',104645.6978,'containers')
              ,(546,877,'2016-2-14','2017-4-22',129736.5774,'trucks')
              ,(548,689,'2016-3-4','2016-9-21',96846.07935,'glass')
              ,(548,771,'2016-10-14','2017-1-23',48663.95032,'goods under customs control')
              ,(551,720,'2015-10-7','2017-3-9',154342.6727,'bulk and packaged goods')
              ,(552,397,'2016-5-26','2017-12-4',80484.03842,'stationery')
              ,(552,723,'2018-10-9','2019-4-30',29332.60287,'textiles')
              ,(553,541,'2015-8-30','2015-9-24',3095.501613,'forklifts')
              ,(553,954,'2016-2-6','2016-9-7',26497.49381,'containers')
              ,(554,908,'2017-3-23','2018-6-28',143559.2421,'telecommunication equipment')
              ,(555,395,'2013-9-14','2014-9-13',97218.73452,'stationery')
              ,(555,387,'2014-10-8','2015-7-23',76920.31742,'trade fair and exhibition exhibits')
              ,(555,695,'2015-10-15','2016-9-11',88672.03258,'cosmetics and personal hygiene products')
              ,(556,550,'2015-9-3','2016-8-18',23549.04435,'bulk and packaged goods')
              ,(557,859,'2013-7-26','2015-3-5',167633.0836,'trucks')
              ,(560,546,'2016-3-16','2017-2-8',121287.0493,'containers')
              ,(560,705,'2017-2-15','2017-4-9',19538.64319,'printed materials')
              ,(561,756,'2013-9-30','2014-4-21',63191.68665,'personal items')
              ,(561,423,'2014-6-3','2015-1-23',72841.64865,'vehicle parts')
              ,(563,685,'2014-11-9','2016-10-26',54441.98347,'dry and liquid goods')
              ,(564,356,'2013-4-13','2013-5-4',7398.415161,'equipment')
              ,(566,881,'2017-3-28','2018-10-20',93477.38773,'trucks')
              ,(568,443,'2014-4-2','2016-2-5',208708.7202,'equipment')
              ,(569,720,'2014-12-24','2016-4-14',115591.1715,'packaged foods and chocolate items')
              ,(569,501,'2016-11-21','2017-9-26',74879.8155,'household and industrial appliances')
              ,(569,505,'2018-3-12','2019-3-2',86026.9725,'personal items')
              ,(570,932,'2016-1-20','2016-2-13',14179.11329,'electronics')
              ,(571,766,'2014-10-9','2015-2-8',39255.29458,'dangerous')
              ,(572,827,'2017-3-12','2018-11-13',315913.7066,'printed materials')
              ,(572,363,'2019-4-2','2019-8-28',76522.46903,'personal items')
              ,(573,704,'2017-3-30','2018-9-4',99795.61234,'chickens')
              ,(573,751,'2018-10-11','2019-10-2',67929.70935,'spare parts')
              ,(573,491,'2019-10-18','2020-3-4',26332.30306,'personal items')
              ,(574,735,'2018-7-6','2020-3-4',241993.3655,'stationery')
              ,(574,384,'2020-4-4','2021-1-5',110033.2272,'trade fair and exhibition exhibits')
              ,(574,800,'2021-6-17','2021-8-13',22724.25344,'dry and liquid goods')
              ,(574,582,'2021-11-25','2022-8-8',102059.8049,'printed materials')
              ,(575,568,'2017-10-24','2018-2-6',8996.328871,'containers')
              ,(576,840,'2016-7-18','2018-4-21',91456.66916,'glass')
              ,(577,534,'2014-7-9','2015-11-30',93474.27058,'dangerous')
              ,(579,528,'2014-10-13','2016-1-30',69100.02581,'goods under customs control')
              ,(579,389,'2016-4-20','2017-1-30',41547.48387,'personal items')
              ,(580,488,'2016-4-16','2017-3-27',34942.635,'personal items')
              ,(580,884,'2017-6-5','2018-5-13',34638.786,'equipment')
              ,(581,394,'2017-6-4','2018-11-19',59244.549,'dangerous')
              ,(581,562,'2018-12-3','2019-11-5',37458.561,'chickens')
              ,(581,994,'2020-4-17','2021-4-9',39681.621,'bulk and packaged goods')
              ,(583,911,'2018-3-4','2019-10-9',91519.50658,'telecommunication equipment')
              ,(584,536,'2016-7-5','2016-9-9',22781.81613,'personal items')
              ,(584,596,'2016-10-1','2017-8-11',108386.2161,'electronics')
              ,(585,773,'2015-8-20','2016-3-17',38558.90613,'trucks')
              ,(585,900,'2016-6-3','2017-2-4',45169.00432,'trade fair and exhibition exhibits')
              ,(586,780,'2017-7-14','2017-8-27',21036.52916,'containers')
              ,(586,672,'2017-9-1','2017-12-16',50678.91116,'vehicle parts')
              ,(586,418,'2018-5-25','2018-9-13',53069.42584,'medical supplies')
              ,(587,587,'2014-1-25','2015-6-4',125038.9401,'printed materials')
              ,(587,886,'2015-8-12','2015-10-1',12630.19597,'telecommunication equipment')
              ,(588,777,'2016-11-10','2018-2-15',168924.3387,'packaged foods and chocolate items')
              ,(589,969,'2014-2-17','2014-10-4',84044.4885,'chickens')
              ,(589,612,'2014-10-5','2015-6-8',90283.599,'spare parts')
              ,(590,734,'2014-7-11','2015-7-17',139572.4978,'telecommunication equipment')
              ,(590,359,'2016-2-19','2016-10-5',86151.21832,'medical supplies')
              ,(591,393,'2017-10-13','2018-3-14',30573.38787,'equipment')
              ,(592,617,'2016-12-27','2018-8-27',187420.8542,'containers')
              ,(593,515,'2016-6-18','2017-1-9',53474.00202,'printed materials')
              ,(594,646,'2017-10-23','2019-9-6',218924.3805,'equipment')
              ,(594,578,'2019-11-21','2020-8-13',85261.911,'goods under customs control')
              ,(594,359,'2020-12-25','2021-8-11',73402.1715,'stationery')
              ,(595,655,'2015-7-27','2016-7-3',166478.6442,'bulk and packaged goods')
              ,(595,949,'2017-3-15','2017-11-18',120721.356,'bulk and packaged goods')
              ,(595,647,'2018-6-1','2019-1-14',110498.9831,'telecommunication equipment')
              ,(595,854,'2019-4-9','2019-8-13',61334.23732,'electronics')
              ,(596,891,'2015-9-19','2016-2-24',35723.62161,'vehicle parts')
              ,(597,442,'2016-3-24','2016-7-21',13314.0271,'containers')
              ,(597,387,'2016-9-6','2017-1-20',15216.03097,'cosmetics and personal hygiene products')
              ,(597,984,'2017-2-9','2017-4-28',8726.84129,'household and industrial appliances')
              ,(598,809,'2018-2-9','2018-10-20',75260.35887,'textiles')
              ,(600,911,'2017-8-20','2017-9-13',10935.9871,'equipment')
              ,(600,741,'2017-9-14','2017-12-18',43288.28226,'household and industrial appliances')
              ,(601,781,'2014-10-4','2016-3-2',49092.2504,'spare parts')
              ,(603,922,'2017-1-24','2018-2-2',70887.16374,'forklifts')
              ,(603,906,'2018-9-28','2019-5-13',43025.09671,'spare parts')
              ,(603,820,'2019-7-21','2020-1-1',31084.21084,'electronics')
              ,(603,763,'2020-1-10','2020-3-3',10045.50716,'machine parts')
              ,(603,925,'2020-3-12','2020-6-18',18574.71135,'chickens')
              ,(604,861,'2018-3-8','2019-10-19',157412.1523,'trade fair and exhibition exhibits')
              ,(604,445,'2020-1-15','2020-8-17',57362.05548,'personal items')
              ,(606,391,'2015-3-14','2017-1-19',375475.5561,'chickens')
              ,(606,881,'2017-9-7','2018-6-25',161393.4813,'containers')
              ,(608,642,'2017-9-10','2019-7-31',190787.7673,'glass')
              ,(608,969,'2019-10-15','2020-10-2',97747.57887,'personal items')
              ,(608,685,'2020-12-24','2021-10-9',80025.63823,'medical supplies')
              ,(609,699,'2018-4-14','2019-8-30',131121.9264,'telecommunication equipment')
              ,(609,567,'2019-11-23','2020-10-5',82635.48842,'machine parts')
              ,(609,518,'2021-4-11','2021-10-1',45097.60094,'goods under customs control')
              ,(611,468,'2015-7-25','2017-5-13',206586.6776,'dry and liquid goods')
              ,(611,858,'2017-9-9','2017-10-9',9418.845484,'dangerous')
              ,(612,858,'2015-11-18','2017-1-15',185458.9746,'cosmetics and personal hygiene products')
              ,(613,847,'2017-11-17','2018-3-13',10292.4929,'dry and liquid goods')
              ,(614,584,'2015-4-13','2015-5-25',14762.68839,'spare parts')
              ,(614,875,'2015-8-12','2016-3-8',73461.94935,'personal items')
              ,(614,912,'2016-5-12','2016-8-20',35149.25806,'personal items')
              ,(615,978,'2017-7-20','2018-4-21',96498.01452,'spare parts')
              ,(615,854,'2018-5-17','2018-10-8',50529.86942,'glass')
              ,(616,962,'2017-11-14','2019-6-15',118263.4706,'printed materials')
              ,(618,874,'2017-7-25','2017-12-14',27457.48645,'trucks')
              ,(619,714,'2015-4-17','2016-5-14',85579.08416,'packaged foods and chocolate items')
              ,(619,763,'2016-7-24','2016-8-10',3701.894226,'stationery')
              ,(620,765,'2018-5-17','2018-12-4',31347.66498,'spare parts')
              ,(621,562,'2016-8-5','2018-3-24',274695.1119,'forklifts')
              ,(621,417,'2018-7-9','2018-9-1',24888.48329,'cosmetics and personal hygiene products')
              ,(621,920,'2018-10-20','2019-9-12',150713.5933,'chickens')
              ,(623,532,'2013-1-31','2014-8-9',235412.5776,'packaged foods and chocolate items')
              ,(623,418,'2014-9-5','2014-10-1',11028.33697,'vehicle parts')
              ,(623,824,'2014-10-18','2015-9-10',138702.5457,'personal items')
              ,(624,989,'2015-2-22','2015-5-24',30771.13776,'packaged foods and chocolate items')
              ,(625,680,'2017-9-15','2017-11-7',5217.07979,'glass')
              ,(625,855,'2018-1-6','2018-10-1',26380.70535,'vehicle parts')
              ,(625,900,'2019-1-25','2019-7-23',17619.94873,'textiles')
              ,(625,649,'2019-9-3','2020-3-2',17816.81966,'packaged foods and chocolate items')
              ,(625,606,'2020-11-21','2021-5-10',16734.02952,'spare parts')
              ,(625,776,'2021-8-6','2021-11-4',8859.192097,'glass')
              ,(626,489,'2015-10-22','2017-1-14',145445.8645,'household and industrial appliances')
              ,(626,488,'2017-4-9','2017-5-18',12605.30826,'medical supplies')
              ,(629,778,'2018-9-14','2019-2-1',15558.29032,'household and industrial appliances')
              ,(630,751,'2015-1-13','2015-8-13',49023.70065,'cosmetics and personal hygiene products')
              ,(631,471,'2018-5-4','2019-7-10',138677.5185,'stationery')
              ,(632,840,'2013-2-21','2014-4-28',58159.97419,'packaged foods and chocolate items')
              ,(632,637,'2014-5-4','2015-2-22',39672.92903,'forklifts')
              ,(634,692,'2013-9-19','2015-9-18',418716.9528,'dry and liquid goods')
              ,(634,866,'2016-4-9','2017-1-27',168290.9015,'bulk and packaged goods')
              ,(636,432,'2018-9-25','2020-4-10',78343.96534,'stationery')
              ,(640,757,'2018-9-17','2019-8-4',141126.0968,'goods under customs control')
              ,(640,501,'2019-10-21','2020-8-2',125738.5161,'dry and liquid goods')
              ,(641,959,'2013-8-19','2013-9-19',2858.2785,'cosmetics and personal hygiene products')
              ,(642,669,'2017-8-15','2019-5-12',237368.1619,'trucks')
              ,(643,533,'2017-10-4','2018-3-16',94507.20808,'vehicle parts')
              ,(644,579,'2013-7-22','2014-4-4',65223.53961,'bulk and packaged goods')
              ,(644,747,'2014-5-10','2014-12-3',52739.34648,'glass')
              ,(646,446,'2015-8-21','2016-1-16',115118.9164,'equipment')
              ,(646,566,'2016-2-22','2016-10-18',185901.4934,'textiles')
              ,(646,857,'2017-1-14','2017-4-18',73116.06852,'printed materials')
              ,(649,788,'2013-5-11','2013-11-7',27002.6129,'spare parts')
              ,(650,681,'2018-11-4','2020-4-13',262222.063,'trucks')
              ,(651,687,'2013-2-1','2014-10-25',189583.3394,'household and industrial appliances')
              ,(652,925,'2018-7-20','2018-10-16',25924.99587,'chickens')
              ,(652,371,'2019-5-20','2019-7-10',15024.71352,'personal items')
              ,(653,407,'2013-9-14','2014-11-14',58353.89226,'trucks')
              ,(653,397,'2015-6-16','2015-12-29',26848.26968,'medical supplies')
              ,(653,369,'2016-7-30','2017-7-29',49861.07226,'personal items')
              ,(653,972,'2018-1-16','2018-3-20',8629.800968,'personal items')
              ,(655,612,'2013-11-5','2015-6-24',265368.2694,'medical supplies')
              ,(657,899,'2016-7-2','2017-3-3',73065.92594,'stationery')
              ,(658,929,'2015-10-5','2017-2-4',247815.979,'electronics')
              ,(658,428,'2017-2-17','2017-3-5',8125.114065,'personal items')
              ,(658,806,'2017-5-30','2018-3-23',150822.4298,'goods under customs control')
              ,(659,841,'2015-4-20','2017-3-18',252309.3361,'personal items')
              ,(661,490,'2015-3-25','2015-11-24',41003.1571,'vehicle parts')
              ,(661,383,'2016-6-22','2017-5-28',57135.54677,'goods under customs control')
              ,(662,927,'2017-3-23','2017-6-20',30305.29239,'personal items')
              ,(663,629,'2014-10-13','2016-2-4',124828.6207,'packaged foods and chocolate items')
              ,(664,734,'2017-3-3','2018-3-19',101547.1434,'chickens')
              ,(664,968,'2018-4-21','2018-12-23',65565.87213,'equipment')
              ,(665,515,'2018-1-7','2019-11-27',147437.7098,'dangerous')
              ,(665,677,'2020-3-11','2020-5-1',10913.38635,'equipment')
              ,(665,575,'2020-5-6','2021-2-17',61414.54674,'cosmetics and personal hygiene products')
              ,(666,450,'2018-8-23','2020-6-25',85426.08155,'personal items')
              ,(667,613,'2014-3-14','2015-7-21',82701.19335,'vehicle parts')
              ,(667,829,'2015-10-23','2016-3-10',23270.17384,'forklifts')
              ,(668,931,'2016-1-11','2018-1-7',285671.1792,'household and industrial appliances')
              ,(669,957,'2014-10-21','2016-2-20',91405.46202,'electronics')
              ,(669,389,'2016-6-4','2016-7-6',6006.108387,'medical supplies')
              ,(670,537,'2018-7-11','2020-5-6',274747.8605,'vehicle parts')
              ,(670,556,'2020-6-22','2020-12-31',79325.69806,'dry and liquid goods')
              ,(670,759,'2021-5-5','2021-12-6',88828.25565,'packaged foods and chocolate items')
              ,(671,888,'2013-6-20','2013-11-9',48516.89952,'machine parts')
              ,(672,527,'2018-12-2','2020-4-24',116061.8516,'trade fair and exhibition exhibits')
              ,(673,754,'2017-4-21','2018-7-25',43527.64839,'machine parts')
              ,(675,376,'2013-3-30','2013-11-10',125196.3435,'vehicle parts')
              ,(676,875,'2013-8-22','2014-7-15',99583.68339,'telecommunication equipment')
              ,(676,916,'2014-12-19','2015-3-29',30453.72581,'medical supplies')
              ,(677,495,'2014-5-5','2014-6-7',5150.823097,'electronics')
              ,(677,557,'2014-6-18','2015-3-27',44016.12465,'vehicle parts')
              ,(680,467,'2013-5-18','2013-9-14',24805.75921,'electronics')
              ,(681,928,'2017-8-3','2017-10-6',9818.180129,'chickens')
              ,(681,753,'2018-4-26','2018-11-25',32676.13074,'packaged foods and chocolate items')
              ,(682,804,'2017-6-3','2017-9-25',43604.93381,'personal items')
              ,(682,647,'2018-2-19','2019-2-17',138847.2892,'dangerous')
              ,(682,474,'2019-4-3','2020-1-6',106334.8386,'forklifts')
              ,(683,961,'2017-9-27','2018-8-22',92150.23616,'electronics')
              ,(685,571,'2016-7-22','2017-1-10',56132.57729,'equipment')
              ,(685,375,'2017-4-17','2017-11-13',68533.96065,'bulk and packaged goods')
              ,(688,413,'2015-9-28','2017-6-6',332187.8043,'personal items')
              ,(688,559,'2017-7-28','2018-2-1',101217.6778,'textiles')
              ,(688,504,'2018-3-24','2018-8-29',85065.92071,'machine parts')
              ,(689,644,'2018-10-23','2019-12-6',98529.96029,'dry and liquid goods')
              ,(690,408,'2014-9-22','2015-10-3',131649.4986,'printed materials')
              ,(690,811,'2015-10-18','2015-12-5',16806.31897,'packaged foods and chocolate items')
              ,(691,672,'2014-11-1','2015-10-11',138709.5387,'chickens')
              ,(691,808,'2015-12-2','2016-6-16',79435.40444,'containers')
              ,(693,440,'2016-3-30','2016-8-15',41597.42458,'spare parts')
              ,(694,884,'2016-10-30','2018-1-18',208333.2097,'household and industrial appliances')
              ,(694,635,'2018-6-26','2019-5-9',148408.1516,'household and industrial appliances')
              ,(694,582,'2019-5-21','2020-4-12',153089.7968,'telecommunication equipment')
              ,(695,965,'2013-8-15','2014-6-21',146588.4,'bulk and packaged goods')
              ,(696,725,'2017-6-16','2018-10-22',64581.0121,'containers')
              ,(696,805,'2018-12-29','2019-11-14',41918.70968,'equipment')
              ,(696,956,'2019-11-17','2020-9-24',40870.74194,'telecommunication equipment')
              ,(698,608,'2018-3-24','2019-1-9',55629.8129,'electronics')
              ,(699,528,'2018-11-23','2018-12-29',12498.97239,'trade fair and exhibition exhibits')
              ,(699,838,'2019-1-1','2019-2-18',16665.29652,'telecommunication equipment')
              ,(699,842,'2019-2-21','2019-6-11',38191.30452,'telecommunication equipment')
              ,(701,884,'2017-6-20','2018-2-8',24426.32952,'packaged foods and chocolate items')
              ,(701,635,'2018-9-15','2018-10-11',2725.684839,'forklifts')
              ,(702,801,'2017-2-20','2017-10-4',94323.84116,'spare parts')
              ,(702,903,'2018-5-3','2019-2-18',121452.3795,'medical supplies')
              ,(702,719,'2019-4-9','2019-9-27',71368.92406,'machine parts')
              ,(702,419,'2019-10-4','2020-1-5',38814.678,'personal items')
              ,(702,682,'2020-4-22','2020-8-10',45909.83419,'containers')
              ,(704,844,'2013-1-11','2013-10-5',109347.081,'trade fair and exhibition exhibits')
              ,(705,877,'2018-4-19','2020-1-25',272795.6307,'electronics')
              ,(705,807,'2020-6-16','2021-2-17',103881.9275,'equipment')
              ,(706,466,'2014-7-18','2015-5-12',46096.02426,'goods under customs control')
              ,(707,390,'2014-3-25','2016-1-23',69811.74697,'telecommunication equipment')
              ,(708,832,'2018-2-22','2019-1-17',132422.4629,'dry and liquid goods')
              ,(709,680,'2018-8-6','2020-5-1',227373.9151,'machine parts')
              ,(710,915,'2013-10-1','2014-9-27',222270.029,'goods under customs control')
              ,(712,621,'2016-8-29','2018-3-20',107319.2942,'forklifts')
              ,(714,559,'2013-11-28','2014-2-20',21347.81419,'bulk and packaged goods')
              ,(714,760,'2014-3-6','2014-4-7',8132.500645,'glass')
              ,(715,844,'2016-6-4','2018-4-11',204388.0548,'forklifts')
              ,(716,630,'2017-4-19','2017-6-26',34758.62555,'chickens')
              ,(716,920,'2017-9-25','2018-9-2',174815.4403,'textiles')
              ,(717,784,'2013-8-22','2015-1-2',121101.6159,'personal items')
              ,(718,762,'2017-9-16','2019-4-4',114185.8894,'forklifts')
              ,(720,817,'2016-8-1','2017-12-13',289964.747,'equipment')
              ,(722,473,'2013-1-28','2014-9-3',380471.3667,'electronics')
              ,(722,766,'2014-10-11','2015-5-17',142268.8815,'vehicle parts')
              ,(725,654,'2014-10-28','2016-10-6',395774.1148,'containers')
              ,(726,987,'2017-3-13','2017-4-5',12085.88308,'forklifts')
              ,(726,445,'2017-4-8','2017-6-6',31002.91747,'trucks')
              ,(727,638,'2014-1-16','2015-11-25',209094.6751,'medical supplies')
              ,(728,667,'2016-8-13','2016-10-28',33860.736,'vehicle parts')
              ,(728,613,'2017-2-12','2017-12-30',143017.056,'bulk and packaged goods')
              ,(729,567,'2018-11-1','2019-5-13',32796.876,'stationery')
              ,(729,842,'2019-5-20','2020-5-16',61515.384,'packaged foods and chocolate items')
              ,(729,880,'2020-9-11','2021-9-9',61685.316,'textiles')
              ,(729,897,'2021-12-12','2022-10-18',52678.92,'goods under customs control')
              ,(731,694,'2014-11-15','2015-3-22',47128.04081,'medical supplies')
              ,(732,476,'2016-7-20','2018-4-25',256310.3381,'trade fair and exhibition exhibits')
              ,(732,796,'2018-11-19','2019-8-26',111439.2774,'personal items')
              ,(733,508,'2016-4-30','2017-1-31',88720.68077,'textiles')
              ,(733,415,'2017-11-15','2018-9-6',94828.26387,'dangerous')
              ,(734,755,'2017-9-10','2018-11-7',63399.97684,'vehicle parts')
              ,(735,938,'2014-1-24','2014-2-27',6384.196452,'medical supplies')
              ,(735,700,'2014-12-10','2015-5-26',31357.67081,'trucks')
              ,(736,589,'2016-7-27','2017-2-24',20859.05613,'packaged foods and chocolate items')
              ,(736,452,'2017-2-28','2017-10-5',21547.79855,'printed materials')
              ,(737,372,'2016-12-19','2017-4-26',59809.99432,'trade fair and exhibition exhibits')
              ,(737,490,'2017-8-14','2017-12-15',57473.66642,'machine parts')
              ,(737,384,'2018-1-30','2018-5-9',46259.29248,'containers')
              ,(739,994,'2018-7-6','2019-3-28',178150.0113,'machine parts')
              ,(740,541,'2018-8-19','2020-7-25',306655.0058,'equipment')
              ,(740,539,'2020-9-3','2021-4-29',103376.6167,'electronics')
              ,(742,600,'2015-8-31','2016-5-18',32956.28056,'personal items')
              ,(743,877,'2016-3-13','2017-6-26',244342.9935,'equipment')
              ,(743,977,'2017-9-2','2018-4-27',123211.2542,'containers')
              ,(745,514,'2017-5-4','2019-2-12',113038.926,'dangerous')
              ,(745,701,'2019-8-26','2019-9-29',5921.916,'machine parts')
              ,(746,715,'2017-11-8','2018-5-6',48692.75216,'vehicle parts')
              ,(747,710,'2013-2-6','2014-5-20',117870.8499,'containers')
              ,(747,518,'2014-10-29','2015-2-7',25437.93982,'textiles')
              ,(748,482,'2014-5-4','2016-1-14',359629.2,'forklifts')
              ,(748,772,'2016-6-28','2017-1-6',111369.0426,'spare parts')
              ,(750,500,'2018-8-17','2020-5-24',184585.779,'bulk and packaged goods')
              ,(750,508,'2020-6-1','2020-8-2',17715.663,'dangerous')
              ,(751,979,'2015-6-8','2016-4-27',119865.0803,'cosmetics and personal hygiene products')
              ,(752,836,'2017-12-6','2018-5-12',61341.74855,'trucks')
              ,(753,834,'2014-11-25','2015-5-9',36407.64919,'household and industrial appliances')
              ,(753,707,'2015-8-1','2016-2-28',46557.66048,'packaged foods and chocolate items')
              ,(754,468,'2015-8-20','2017-1-21',177488.7484,'vehicle parts')
              ,(756,683,'2017-10-2','2018-7-9',114675.8381,'forklifts')
              ,(757,395,'2013-5-20','2014-3-25',64949.44761,'stationery')
              ,(759,371,'2016-5-21','2017-9-11',240993.5992,'personal items')
              ,(759,789,'2018-1-4','2018-5-16',66550.53368,'personal items')
              ,(761,458,'2018-10-26','2018-11-14',14326.08213,'personal items')
              ,(762,728,'2016-7-29','2017-2-14',25220.45806,'trucks')
              ,(762,387,'2017-2-25','2017-8-20',22194.0031,'trucks')
              ,(762,694,'2017-11-10','2018-6-8',26481.48097,'goods under customs control')
              ,(763,421,'2016-12-7','2018-4-15',140281.5784,'dry and liquid goods')
              ,(764,641,'2013-10-14','2015-8-9',154398.5385,'cosmetics and personal hygiene products')
              ,(764,423,'2015-10-28','2016-2-20',26740.71073,'machine parts')
              ,(765,540,'2018-4-1','2018-7-19',36357.3315,'equipment')
              ,(765,638,'2018-11-5','2019-3-22',45696.8295,'trade fair and exhibition exhibits')
              ,(766,699,'2015-10-17','2016-9-18',36015.08129,'dry and liquid goods')
              ,(766,809,'2017-2-23','2017-8-27',19770.89032,'vehicle parts')
              ,(766,479,'2018-6-8','2019-2-7',26076.20129,'trade fair and exhibition exhibits')
              ,(766,625,'2019-6-27','2020-3-17',28213.59484,'bulk and packaged goods')
              ,(767,776,'2014-12-7','2016-1-28',79358.6176,'vehicle parts')
              ,(768,668,'2018-9-25','2020-1-4',263624.8962,'bulk and packaged goods')
              ,(769,671,'2017-10-16','2018-7-15',84094.36723,'stationery')
              ,(769,676,'2018-9-28','2019-9-28',112847.2207,'machine parts')
              ,(770,519,'2017-1-30','2018-9-24',223082.9749,'bulk and packaged goods')
              ,(770,795,'2018-11-19','2019-6-8',74484.51489,'household and industrial appliances')
              ,(770,389,'2019-6-12','2019-10-20',48174.06435,'personal items')
              ,(771,954,'2014-5-18','2015-4-15',183780.1208,'dry and liquid goods')
              ,(771,878,'2015-9-26','2016-4-15',111818.0253,'trade fair and exhibition exhibits')
              ,(772,713,'2013-11-7','2015-4-28',105906.8542,'medical supplies')
              ,(772,647,'2015-6-13','2015-8-12',11833.16806,'bulk and packaged goods')
              ,(773,444,'2015-12-19','2016-7-27',53933.80955,'glass')
              ,(774,431,'2018-8-23','2020-8-17',335304.5952,'goods under customs control')
              ,(775,535,'2018-2-13','2019-12-24',177482.9229,'containers')
              ,(776,781,'2018-3-30','2018-10-23',41763.8025,'goods under customs control')
              ,(777,386,'2016-4-3','2017-8-28',156125.6299,'forklifts')
              ,(777,818,'2017-10-4','2018-3-25',52448.45381,'equipment')
              ,(778,382,'2016-4-24','2018-1-2',334576.8171,'machine parts')
              ,(779,989,'2013-4-5','2014-1-27',145049.2815,'trucks')
              ,(780,426,'2013-1-12','2014-2-20',87365.49523,'dangerous')
              ,(781,959,'2018-5-23','2019-12-14',253561.6684,'trucks')
              ,(781,812,'2020-5-8','2020-10-25',75623.65548,'vehicle parts')
              ,(783,652,'2018-1-16','2019-2-20',164864.7677,'equipment')
              ,(785,915,'2017-10-14','2018-10-29',242299.7003,'trade fair and exhibition exhibits')
              ,(786,940,'2017-12-11','2018-2-5',12846.75677,'glass')
              ,(787,704,'2017-12-6','2019-7-1',145234.3796,'trucks')
              ,(787,997,'2020-2-18','2020-7-18',38339.84497,'forklifts')
              ,(787,942,'2021-4-16','2021-12-19',62714.84574,'trucks')
              ,(788,918,'2013-4-23','2015-3-7',186959.8483,'telecommunication equipment')
              ,(788,399,'2015-5-27','2015-8-5',19161.33145,'cosmetics and personal hygiene products')
              ,(788,550,'2016-1-1','2016-6-10',44071.06234,'telecommunication equipment')
              ,(789,861,'2016-2-22','2017-10-8',303207.5299,'forklifts')
              ,(790,723,'2017-7-11','2019-2-14',369735.4405,'personal items')
              ,(791,942,'2017-4-29','2017-11-6',108055.8225,'equipment')
              ,(791,671,'2018-3-17','2018-8-8',81466.16981,'bulk and packaged goods')
              ,(791,853,'2018-8-8','2019-3-15',123896.4666,'trade fair and exhibition exhibits')
              ,(792,916,'2014-5-8','2014-5-24',5473.396645,'trade fair and exhibition exhibits')
              ,(792,927,'2014-7-18','2015-3-4',78337.98948,'printed materials')
              ,(792,833,'2015-12-20','2016-1-28',13341.40432,'forklifts')
              ,(793,948,'2014-8-1','2016-1-31',65501.67987,'packaged foods and chocolate items')
              ,(793,761,'2016-9-23','2017-6-19',32153.19687,'trade fair and exhibition exhibits')
              ,(793,592,'2017-7-22','2018-5-19',35978.11248,'telecommunication equipment')
              ,(794,664,'2016-5-4','2016-8-10',22825.47716,'textiles')
              ,(794,950,'2016-9-25','2017-1-28',29114.12903,'goods under customs control')
              ,(795,463,'2015-8-23','2017-6-25',239885.791,'glass')
              ,(795,982,'2017-7-1','2018-6-7',121727.76,'goods under customs control')
              ,(795,721,'2018-8-9','2018-9-22',15706.80774,'dry and liquid goods')
              ,(796,397,'2018-4-22','2019-10-19',223102.1845,'electronics')
              ,(796,628,'2020-6-20','2020-10-27',52807.67303,'spare parts')
              ,(797,464,'2014-12-4','2015-2-25',31633.39776,'goods under customs control')
              ,(798,793,'2017-4-7','2017-10-23',81593.49213,'equipment')
              ,(799,405,'2018-7-24','2018-8-30',8181.408968,'glass')
              ,(799,460,'2019-5-12','2019-5-31',4201.264065,'dry and liquid goods')
              ,(800,957,'2014-8-30','2015-5-22',47993.99613,'dry and liquid goods')
              ,(800,531,'2015-12-1','2016-6-27',37851.86865,'machine parts')
              ,(801,859,'2013-1-21','2014-9-25',286311.881,'spare parts')
              ,(802,991,'2014-10-4','2015-3-4',90334.98769,'trucks')
              ,(803,640,'2017-5-25','2018-4-14',169543.3889,'equipment')
              ,(803,702,'2018-10-26','2019-9-13',168496.8248,'medical supplies')
              ,(804,598,'2017-6-22','2017-8-24',33499.72568,'equipment')
              ,(805,715,'2018-2-9','2019-8-6',237176.5146,'textiles')
              ,(806,526,'2014-7-26','2015-3-21',84584.2979,'packaged foods and chocolate items')
              ,(807,907,'2015-6-11','2015-10-30',30538.32126,'vehicle parts')
              ,(808,535,'2014-8-24','2015-7-17',63958.13042,'personal items')
              ,(809,800,'2015-1-27','2015-4-18',16499.37077,'personal items')
              ,(809,856,'2015-6-11','2015-11-30',35035.7009,'printed materials')
              ,(810,708,'2016-8-23','2016-11-15',28579.36065,'printed materials')
              ,(811,694,'2014-4-2','2014-10-13',39780.63871,'dry and liquid goods')
              ,(813,860,'2016-1-25','2016-9-27',85731.18648,'trucks')
              ,(814,952,'2016-8-15','2018-4-28',125911.6964,'glass')
              ,(814,504,'2018-5-13','2019-3-21',63259.98271,'medical supplies')
              ,(815,919,'2016-3-31','2016-8-4',42938.17839,'electronics')
              ,(816,526,'2018-2-25','2019-7-20',63279.34403,'bulk and packaged goods')
              ,(817,587,'2013-3-25','2014-4-29',225605.0323,'goods under customs control')
              ,(818,377,'2014-4-8','2014-8-5',41808.06847,'bulk and packaged goods')
              ,(822,788,'2017-2-24','2019-2-4',105007.2823,'household and industrial appliances')
              ,(822,372,'2019-4-14','2019-10-25',28692.13065,'dry and liquid goods')
              ,(822,796,'2020-6-16','2021-4-30',47031.43065,'goods under customs control')
              ,(825,896,'2017-3-15','2018-1-28',128293.1973,'household and industrial appliances')
              ,(825,971,'2018-4-11','2019-1-9',109793.2378,'household and industrial appliances')
              ,(826,972,'2015-10-21','2016-7-2',65523.1754,'packaged foods and chocolate items')
              ,(826,596,'2016-7-2','2017-2-17',59099.33468,'goods under customs control')
              ,(826,530,'2017-11-25','2017-12-13',4625.165323,'trade fair and exhibition exhibits')
              ,(827,479,'2017-6-19','2019-4-12',182503.438,'equipment')
              ,(827,937,'2019-9-11','2020-3-29',55136.99032,'containers')
              ,(828,527,'2013-2-24','2014-9-10',96670.18742,'telecommunication equipment')
              ,(828,715,'2015-1-2','2015-10-6',47562.41903,'printed materials')
              ,(829,822,'2016-6-19','2017-7-17',224920.8726,'household and industrial appliances')
              ,(829,761,'2017-12-8','2018-2-20',42351.5129,'medical supplies')
              ,(831,408,'2018-6-25','2020-4-2',315681.2346,'equipment')
              ,(831,646,'2020-5-7','2020-9-6',59525.67329,'dangerous')
              ,(833,891,'2015-3-17','2016-10-1',117522.09,'bulk and packaged goods')
              ,(834,709,'2015-8-28','2017-1-11',147556.544,'equipment')
              ,(834,582,'2017-2-20','2017-9-2',57023.84371,'personal items')
              ,(834,795,'2017-9-20','2018-5-2',65841.96387,'electronics')
              ,(835,421,'2017-11-14','2018-10-6',206686.3714,'telecommunication equipment')
              ,(835,813,'2018-10-23','2019-4-5',103977.193,'spare parts')
              ,(836,965,'2018-10-17','2020-7-4',69854.66352,'printed materials')
              ,(836,800,'2020-10-23','2020-12-7',5021.501371,'printed materials')
              ,(836,444,'2021-9-6','2022-8-31',40060.42205,'chickens')
              ,(836,666,'2023-1-15','2023-3-13',6360.568403,'packaged foods and chocolate items')
              ,(836,648,'2023-8-19','2024-5-24',31133.3085,'trucks')
              ,(837,635,'2013-10-24','2014-2-3',55767.83371,'equipment')
              ,(837,367,'2014-4-23','2014-8-24',67249.44653,'machine parts')
              ,(838,466,'2014-2-21','2015-12-13',197013.1935,'spare parts')
              ,(839,654,'2017-3-6','2017-9-3',53176.23523,'forklifts')
              ,(840,749,'2017-9-26','2018-5-28',60649.97806,'trucks')
              ,(840,674,'2018-6-30','2019-5-16',79540.95484,'goods under customs control')
              ,(840,593,'2019-6-30','2020-5-17',80038.08581,'machine parts')
              ,(840,493,'2020-6-21','2020-12-8',42256.13226,'stationery')
              ,(840,896,'2020-12-24','2021-5-29',38776.21548,'bulk and packaged goods')
              ,(841,389,'2018-7-18','2019-8-29',187273.8684,'telecommunication equipment')
              ,(842,489,'2014-7-16','2015-9-6',65363.80166,'vehicle parts')
              ,(842,787,'2016-7-24','2017-4-2',39500.4269,'spare parts')
              ,(842,953,'2017-5-2','2017-6-7',5642.918129,'printed materials')
              ,(843,464,'2017-11-2','2018-5-16',67419.55161,'trade fair and exhibition exhibits')
              ,(843,686,'2018-11-19','2019-10-3',109945.7303,'containers')
              ,(846,584,'2015-10-25','2016-7-8',24532.58579,'chickens')
              ,(846,883,'2016-8-1','2016-10-13',6968.399855,'equipment')
              ,(846,436,'2016-11-9','2017-3-29',13364.05452,'electronics')
              ,(847,357,'2018-3-16','2019-6-6',74867.98674,'spare parts')
              ,(847,517,'2019-8-30','2020-8-10',57951.50652,'vehicle parts')
              ,(847,586,'2021-3-13','2021-4-30',8039.515355,'goods under customs control')
              ,(848,625,'2018-8-7','2020-2-28',240751.4516,'stationery')
              ,(849,459,'2014-3-30','2015-8-11',167828.4527,'personal items')
              ,(851,893,'2013-6-4','2014-1-1',31983.60121,'spare parts')
              ,(852,806,'2018-8-15','2018-9-6',4851.178839,'equipment')
              ,(852,759,'2018-9-8','2018-11-21',16317.60155,'goods under customs control')
              ,(853,436,'2015-2-3','2016-5-23',172013.8875,'telecommunication equipment')
              ,(853,629,'2016-7-30','2017-3-17',83290.935,'chickens')
              ,(854,535,'2016-3-22','2016-9-5',75382.965,'packaged foods and chocolate items')
              ,(854,679,'2016-11-9','2017-11-6',163404.99,'bulk and packaged goods')
              ,(855,922,'2014-11-22','2016-3-9',190025.6596,'spare parts')
              ,(856,953,'2018-7-31','2019-8-6',54392.74084,'bulk and packaged goods')
              ,(856,744,'2020-6-10','2021-3-16',40904.514,'trucks')
              ,(856,512,'2021-12-12','2022-2-7',8356.836194,'personal items')
              ,(856,768,'2022-4-11','2022-10-9',26536.62019,'personal items')
              ,(858,400,'2014-11-2','2015-3-27',48687.6346,'cosmetics and personal hygiene products')
              ,(859,356,'2013-8-11','2014-7-25',218852.4403,'trade fair and exhibition exhibits')
              ,(860,437,'2017-4-30','2019-3-2',95141.06835,'printed materials')
              ,(861,618,'2016-6-4','2016-10-15',36835.52555,'containers')
              ,(861,804,'2016-12-22','2017-2-28',18833.20103,'glass')
              ,(861,879,'2017-4-29','2017-12-1',59823.10916,'packaged foods and chocolate items')
              ,(862,864,'2013-5-18','2013-11-5',40777.54258,'machine parts')
              ,(863,892,'2016-5-19','2016-7-26',20326.10594,'chickens')
              ,(864,433,'2017-6-10','2019-1-18',340374.7146,'medical supplies')
              ,(864,429,'2019-2-23','2019-4-27',36530.84671,'trucks')
              ,(867,922,'2016-3-18','2017-11-14',47621.51303,'telecommunication equipment')
              ,(868,995,'2017-3-15','2017-4-7',9592.083968,'glass')
              ,(868,818,'2017-5-7','2018-1-24',109266.3478,'printed materials')
              ,(868,355,'2018-3-9','2018-5-31',34614.91171,'equipment')
              ,(869,745,'2018-7-28','2019-5-10',148663.515,'goods under customs control')
              ,(870,452,'2013-6-12','2015-1-27',104812.9862,'packaged foods and chocolate items')
              ,(870,435,'2015-1-29','2015-6-17',24526.94458,'textiles')
              ,(870,657,'2015-11-12','2016-1-19',11998.79303,'telecommunication equipment')
              ,(870,594,'2016-6-11','2016-9-26',18880.45374,'forklifts')
              ,(871,570,'2013-6-10','2014-12-4',58521.83806,'vehicle parts')
              ,(871,416,'2015-3-6','2016-1-9',33363.92613,'trucks')
              ,(872,939,'2015-5-7','2016-4-12',98474.376,'packaged foods and chocolate items')
              ,(873,469,'2016-10-11','2018-3-24',297686.2604,'glass')
              ,(875,610,'2016-7-20','2017-12-23',106937.334,'medical supplies')
              ,(876,530,'2013-1-12','2014-2-5',52671.99915,'dry and liquid goods')
              ,(876,525,'2014-8-9','2015-1-9',20716.75031,'glass')
              ,(877,717,'2014-1-21','2014-2-15',12221.66976,'chickens')
              ,(878,516,'2014-11-4','2016-2-20',152349.7906,'trucks')
              ,(879,935,'2013-7-3','2014-8-15',187787.4817,'chickens')
              ,(879,642,'2014-12-3','2015-5-17',75943.46685,'textiles')
              ,(879,457,'2015-11-24','2016-7-30',114605.5954,'glass')
              ,(879,548,'2016-11-3','2017-1-7',29917.12331,'cosmetics and personal hygiene products')
              ,(879,408,'2017-1-9','2017-12-13',155569.0412,'cosmetics and personal hygiene products')
              ,(880,611,'2017-8-19','2018-3-2',124456.561,'trucks')
              ,(880,878,'2018-4-26','2018-12-3',141050.7691,'personal items')
              ,(881,756,'2017-5-11','2019-4-30',131628.2114,'equipment')
              ,(881,824,'2019-6-8','2020-5-29',65173.35639,'trade fair and exhibition exhibits')
              ,(881,625,'2020-6-9','2020-8-8',10984.27355,'stationery')
              ,(882,762,'2014-11-11','2015-9-7',172856.0468,'vehicle parts')
              ,(883,878,'2014-9-3','2016-2-6',183392.8655,'spare parts')
              ,(883,418,'2016-3-30','2016-10-1',65120.30734,'vehicle parts')
              ,(883,492,'2016-10-23','2017-8-24',107360.5067,'bulk and packaged goods')
              ,(885,722,'2017-4-28','2018-3-21',50432.13406,'printed materials')
              ,(885,995,'2018-6-5','2019-4-29',50586.36077,'equipment')
              ,(886,372,'2014-1-7','2014-5-21',21797.6071,'textiles')
              ,(886,647,'2014-8-19','2015-5-25',45384.57,'textiles')
              ,(886,975,'2015-6-2','2015-12-26',33672.4229,'chickens')
              ,(888,713,'2015-3-26','2015-11-25',80255.22852,'bulk and packaged goods')
              ,(889,728,'2016-10-11','2017-7-5',52092.91873,'household and industrial appliances')
              ,(889,509,'2017-9-3','2018-4-12',43118.10876,'electronics')
              ,(890,864,'2017-6-9','2019-4-7',329669.4298,'chickens')
              ,(891,915,'2015-2-8','2017-1-28',69460.06065,'telecommunication equipment')
              ,(892,935,'2018-3-20','2018-4-10',4084.229032,'spare parts')
              ,(893,478,'2013-11-25','2015-8-2',189460.9669,'telecommunication equipment')
              ,(894,938,'2014-3-7','2014-6-2',14784.37868,'personal items')
              ,(895,362,'2016-7-7','2016-12-26',49647.58084,'textiles')
              ,(895,822,'2017-4-19','2018-3-20',96697.32315,'spare parts')
              ,(895,824,'2018-6-21','2019-1-10',58595.69134,'textiles')
              ,(895,783,'2019-5-14','2020-4-9',95542.72824,'glass')
              ,(896,676,'2016-1-13','2017-11-3',307631.6419,'personal items')
              ,(898,399,'2018-1-24','2018-7-31',17394.50594,'printed materials')
              ,(898,763,'2018-9-21','2019-1-1',9437.44471,'equipment')
              ,(898,637,'2019-3-24','2019-11-23',22575.84813,'spare parts')
              ,(899,390,'2014-1-13','2014-6-24',48281.62297,'containers')
              ,(899,704,'2014-6-29','2014-10-13',31591.67923,'containers')
              ,(899,868,'2014-11-3','2015-6-22',68846.01794,'chickens')
              ,(899,858,'2015-10-5','2016-7-18',85535.96168,'household and industrial appliances')
              ,(900,797,'2014-8-26','2015-11-8',106467.7032,'spare parts')
              ,(900,509,'2016-2-3','2016-10-25',64268.65911,'dry and liquid goods')
              ,(902,692,'2018-11-19','2019-5-17',124864.6431,'telecommunication equipment')
              ,(902,959,'2019-7-22','2019-12-7',96264.36174,'vehicle parts')
              ,(902,744,'2020-3-28','2020-11-12',159743.0351,'machine parts')
              ,(903,449,'2013-4-7','2014-1-14',189944.9025,'chickens')
              ,(904,719,'2014-10-4','2015-10-8',32152.97569,'bulk and packaged goods')
              ,(904,475,'2015-10-23','2016-2-20',10456.25226,'textiles')
              ,(907,982,'2018-3-1','2018-10-15',93028.67768,'chickens')
              ,(909,621,'2014-11-12','2016-7-10',270323.2289,'goods under customs control')
              ,(910,998,'2018-5-12','2018-10-10',43040.90361,'electronics')
              ,(910,951,'2018-11-15','2019-9-17',87221.96361,'goods under customs control')
              ,(911,459,'2016-2-24','2016-11-6',106094.9265,'medical supplies')
              ,(911,796,'2017-8-30','2018-1-10',55119.62976,'equipment')
              ,(911,929,'2018-2-17','2018-4-24',27352.59823,'dangerous')
              ,(912,359,'2014-8-25','2016-2-10',276161.0284,'containers')
              ,(912,872,'2016-12-29','2017-4-3',49129.77097,'trucks')
              ,(913,968,'2017-12-25','2019-9-8',188641.404,'glass')
              ,(913,552,'2020-6-9','2020-12-1',53074.35,'forklifts')
              ,(914,720,'2013-12-27','2015-7-31',73541.72429,'stationery')
              ,(914,650,'2015-10-22','2016-3-24',19492.98716,'vehicle parts')
              ,(915,850,'2015-2-1','2016-10-15',179147.4368,'equipment')
              ,(915,417,'2017-2-23','2018-2-8',100806.4355,'equipment')
              ,(915,478,'2018-2-24','2018-11-30',80357.13,'household and industrial appliances')
              ,(916,590,'2015-5-26','2015-12-5',47639.68108,'vehicle parts')
              ,(916,450,'2016-5-24','2016-6-22',7158.294048,'equipment')
              ,(916,418,'2016-8-19','2017-5-1',62943.62008,'cosmetics and personal hygiene products')
              ,(916,837,'2017-11-11','2018-3-12',29867.36482,'personal items')
              ,(917,844,'2017-7-29','2018-1-3',86499.61781,'equipment')
              ,(919,354,'2017-8-23','2018-2-13',42341.96265,'vehicle parts')
              ,(920,810,'2017-1-4','2018-11-14',262533.4882,'glass')
              ,(921,896,'2014-8-26','2016-5-16',123218.2391,'medical supplies')
              ,(921,368,'2016-10-20','2017-3-6',26837.67687,'chickens')
              ,(922,784,'2016-11-5','2018-8-2',143790.8748,'spare parts')
              ,(922,859,'2018-11-25','2019-7-15',52534.61884,'spare parts')
              ,(923,926,'2015-12-13','2016-12-9',91976.598,'equipment')
              ,(923,630,'2017-7-13','2018-5-10',76477.779,'household and industrial appliances')
              ,(924,548,'2013-3-15','2013-9-2',15261.75,'dangerous')
              ,(924,421,'2014-3-3','2014-5-3',5444.25,'medical supplies')
              ,(925,354,'2013-12-15','2014-9-20',42520.464,'forklifts')
              ,(926,581,'2016-12-19','2017-3-3',13262.01145,'electronics')
              ,(928,810,'2017-2-13','2017-10-26',95981.20621,'chickens')
              ,(928,813,'2018-5-27','2018-9-28',46673.214,'glass')
              ,(929,621,'2016-1-19','2017-5-4',200051.5372,'personal items')
              ,(930,433,'2013-4-21','2013-6-27',35342.75071,'trade fair and exhibition exhibits')
              ,(930,432,'2013-8-14','2014-3-6',107610.7634,'containers')
              ,(931,524,'2013-9-3','2015-2-12',185963.085,'chickens')
              ,(932,502,'2013-10-5','2014-8-17',141849.8516,'cosmetics and personal hygiene products')
              ,(932,395,'2014-8-26','2015-8-16',159356.6371,'goods under customs control')
              ,(933,878,'2014-6-19','2016-4-25',100148.4296,'trade fair and exhibition exhibits')
              ,(933,763,'2016-8-17','2017-1-9',21481.54185,'spare parts')
              ,(934,371,'2014-11-16','2016-8-27',191763.346,'electronics')
              ,(935,905,'2015-2-7','2016-6-26',91380.89032,'household and industrial appliances')
              ,(936,393,'2018-5-22','2019-12-7',177355.8766,'stationery')
              ,(936,355,'2019-12-28','2020-2-28',19496.568,'goods under customs control')
              ,(937,471,'2016-12-6','2016-12-28',4912.133032,'electronics')
              ,(938,812,'2017-4-15','2018-11-10',210572.4925,'dangerous')
              ,(939,750,'2013-3-10','2013-8-10',30044.14113,'electronics')
              ,(939,647,'2013-10-18','2014-2-6',21796.72984,'printed materials')
              ,(940,650,'2016-5-12','2017-12-13',230903.3323,'textiles')
              ,(940,939,'2018-5-13','2019-1-29',103906.4995,'spare parts')
              ,(940,401,'2019-2-13','2019-12-9',119034.6489,'chickens')
              ,(940,488,'2019-12-29','2020-5-24',58522.05145,'packaged foods and chocolate items')
              ,(942,633,'2018-5-7','2020-2-17',99288.504,'medical supplies')
              ,(943,654,'2015-9-8','2016-1-27',43767.01858,'medical supplies')
              ,(943,840,'2016-12-8','2017-4-2',35696.50452,'trucks')
              ,(944,986,'2016-10-31','2018-8-11',89564.9519,'equipment')
              ,(944,685,'2018-12-26','2019-6-10',22908.75503,'trucks')
              ,(944,720,'2019-7-14','2019-12-16',21390.705,'machine parts')
              ,(945,989,'2018-4-14','2019-10-17',80594.62781,'equipment')
              ,(945,765,'2019-11-11','2020-7-14',35982.35652,'telecommunication equipment')
              ,(946,751,'2015-1-29','2017-1-10',160492.8387,'glass')
              ,(946,532,'2017-3-28','2018-3-7',77541.48387,'printed materials')
              ,(952,991,'2017-9-1','2019-1-1',69131.55087,'forklifts')
              ,(952,552,'2019-1-31','2020-1-29',51529.26687,'vehicle parts')
              ,(953,899,'2015-8-3','2016-8-22',107910.2342,'dangerous')
              ,(955,440,'2016-9-2','2017-4-5',43970.71113,'equipment')
              ,(955,629,'2017-10-5','2018-6-4',49492.61439,'containers')
              ,(955,407,'2019-2-14','2019-6-25',26791.45655,'dry and liquid goods')
              ,(956,914,'2015-9-7','2016-9-27',113261.085,'containers')
              ,(957,681,'2014-6-12','2014-9-1',45016.69065,'personal items')
              ,(958,523,'2017-1-3','2018-7-14',276445.2,'telecommunication equipment')
              ,(958,858,'2018-7-19','2018-12-22',77424.50845,'packaged foods and chocolate items')
              ,(958,362,'2019-1-4','2019-2-3',14889.32855,'electronics')
              ,(959,789,'2015-12-18','2017-3-22',243834.2923,'chickens')
              ,(960,985,'2017-4-18','2018-4-17',127797.8168,'electronics')
              ,(961,735,'2013-11-26','2014-10-20',86244.42581,'household and industrial appliances')
              ,(962,681,'2014-12-17','2015-3-7',38931.39871,'packaged foods and chocolate items')
              ,(964,498,'2013-4-23','2014-3-10',95701.5421,'spare parts')
              ,(965,485,'2015-3-8','2015-12-22',33810.20323,'containers')
              ,(965,549,'2016-3-14','2017-2-7',38606.80645,'personal items')
              ,(965,992,'2017-7-7','2017-12-8',18016.50968,'dry and liquid goods')
              ,(966,457,'2018-9-25','2020-5-29',286362.2526,'stationery')
              ,(967,508,'2014-5-10','2014-11-20',81682.91148,'electronics')
              ,(967,380,'2015-4-29','2016-3-25',139366.2046,'stationery')
              ,(967,614,'2016-6-17','2017-2-19',103998.3461,'bulk and packaged goods')
              ,(967,930,'2017-3-5','2017-11-1',101472.0705,'dry and liquid goods')
              ,(968,495,'2017-9-18','2018-1-3',15648.94156,'cosmetics and personal hygiene products')
              ,(968,730,'2018-3-21','2018-8-12',21060.25781,'dry and liquid goods')
              ,(968,781,'2019-3-9','2019-6-13',14040.17187,'trade fair and exhibition exhibits')
              ,(968,698,'2019-7-15','2020-1-19',27495.33658,'vehicle parts')
              ,(969,491,'2015-2-28','2016-5-30',185232.0066,'equipment')
              ,(970,545,'2014-6-5','2015-5-19',74139.89574,'trade fair and exhibition exhibits')
              ,(970,724,'2015-6-27','2015-7-12',3195.685161,'personal items')
              ,(970,610,'2015-8-16','2016-6-10',63700.65755,'personal items')
              ,(970,639,'2016-7-20','2017-4-3',54752.7391,'dry and liquid goods')
              ,(971,418,'2014-3-5','2014-9-17',116909.669,'medical supplies')
              ,(971,669,'2015-2-28','2015-8-14',99611.80984,'medical supplies')
              ,(971,492,'2015-8-18','2016-1-6',84103.38435,'dry and liquid goods')
              ,(972,982,'2014-6-9','2014-7-6',10792.4609,'goods under customs control')
              ,(973,673,'2013-5-12','2013-12-23',30389.67581,'textiles')
              ,(973,457,'2014-7-10','2014-10-17',13371.45735,'telecommunication equipment')
              ,(973,750,'2014-10-18','2015-4-19',24716.93632,'trade fair and exhibition exhibits')
              ,(973,584,'2015-8-19','2015-12-8',14992.24006,'trade fair and exhibition exhibits')
              ,(973,843,'2016-6-12','2017-6-5',48353.35084,'equipment')
              ,(973,991,'2017-10-2','2018-9-8',46057.242,'bulk and packaged goods')
              ,(974,962,'2015-3-6','2015-6-12',22089.47661,'electronics')
              ,(975,957,'2014-1-17','2015-11-12',209704.7156,'spare parts')
              ,(976,373,'2018-1-14','2018-4-21',37944.8746,'forklifts')
              ,(976,433,'2018-5-20','2019-2-17',106793.3069,'equipment')
              ,(976,678,'2019-8-23','2020-2-23',71977.90645,'equipment')
              ,(976,776,'2020-10-15','2021-5-9',80583.96048,'equipment')
              ,(977,992,'2015-6-16','2017-3-6',232812.4599,'vehicle parts')
              ,(977,931,'2017-9-9','2017-11-3',20357.21032,'vehicle parts')
              ,(978,752,'2014-3-26','2015-10-14',125446.0065,'stationery')
              ,(979,572,'2017-10-29','2018-12-3',139835.8839,'forklifts')
              ,(980,734,'2018-5-30','2018-6-28',5726.947597,'equipment')
              ,(980,437,'2019-3-20','2019-7-29',25870.00466,'cosmetics and personal hygiene products')
              ,(981,609,'2017-4-13','2017-8-6',23116.38,'chickens')
              ,(981,624,'2017-9-30','2018-9-18',70957.236,'goods under customs control')
              ,(981,522,'2018-11-10','2019-9-14',61911.696,'dangerous')
              ,(982,702,'2013-6-20','2013-8-15',29928.53613,'telecommunication equipment')
              ,(984,361,'2018-6-1','2019-1-17',35053.6471,'glass')
              ,(985,563,'2014-8-29','2015-12-2',153333.18,'machine parts')
              ,(986,823,'2014-2-11','2015-2-20',181979.2068,'printed materials')
              ,(987,958,'2014-9-24','2016-6-9',110938.464,'medical supplies')
              ,(987,547,'2016-10-7','2017-6-2',42313.068,'equipment')
              ,(988,700,'2017-8-17','2017-9-16',18647.34968,'packaged foods and chocolate items')
              ,(988,566,'2017-11-3','2018-1-27',52834.15742,'equipment')
              ,(988,814,'2018-8-8','2019-4-19',157880.8939,'dry and liquid goods')
              ,(988,498,'2019-4-24','2019-6-13',31078.91613,'dry and liquid goods')
              ,(989,974,'2014-11-11','2015-7-9',137290.8194,'equipment')
              ,(989,927,'2015-10-25','2016-7-16',151591.9464,'equipment')
              ,(989,881,'2016-10-14','2017-4-29',112692.8809,'trucks')
              ,(989,706,'2017-6-10','2017-12-30',116125.1514,'trade fair and exhibition exhibits')
              ,(990,766,'2016-5-24','2017-10-28',221906.9485,'chickens')
              ,(991,395,'2018-5-26','2018-12-10',49088.00671,'spare parts')
              ,(991,531,'2019-3-14','2019-10-7',51319.27974,'textiles')
              ,(991,445,'2020-5-7','2020-11-23',49583.84516,'trucks')
              ,(993,675,'2017-2-17','2017-5-12',33784.86774,'trade fair and exhibition exhibits')
              ,(994,506,'2016-7-28','2018-5-27',136555.7923,'vehicle parts')
              ,(995,709,'2018-10-10','2019-12-30',144445.7754,'equipment')
              ,(996,520,'2013-1-27','2013-6-18',31802.93381,'household and industrial appliances')
              ,(996,404,'2013-6-26','2014-5-3',69652.90432,'machine parts')
              ,(997,856,'2014-9-17','2015-11-29',56698.99403,'personal items')
              ,(997,923,'2016-6-30','2016-7-22',2847.894677,'household and industrial appliances')
              ,(997,644,'2016-8-2','2017-3-18',29514.54484,'containers')
              ,(998,635,'2016-3-24','2017-10-7',261815.9487,'dry and liquid goods')
              ,(998,595,'2018-6-5','2018-12-12',88514.28871,'household and industrial appliances')
              ,(998,973,'2019-2-14','2019-12-8',138361.8092,'medical supplies')
              ,(999,862,'2017-8-31','2018-2-17',9464.876129,'stationery')
              ,(999,895,'2018-4-28','2018-6-22',3062.165806,'goods under customs control')
              ,(999,398,'2018-9-9','2019-3-29',11190.82413,'containers')
              ,(1001,453,'2016-2-12','2017-8-26',73464.60585,'personal items')
              ,(1001,797,'2017-10-21','2018-2-13',15059.58944,'machine parts')
              ,(1002,593,'2016-10-30','2017-1-26',41767.54219,'equipment')
              ,(1003,656,'2013-4-13','2015-4-13',257746.9989,'textiles')
              ,(1003,954,'2015-9-29','2016-3-6',56139.41482,'stationery')
              ,(1004,624,'2013-7-19','2015-3-31',138565.98,'containers')
              ,(1005,600,'2018-12-5','2019-7-25',125981.4333,'equipment')
              ,(1006,912,'2018-7-11','2020-1-27',226665.1326,'chickens')
              ,(1006,396,'2020-8-14','2020-9-22',15645.91181,'dry and liquid goods')
              ,(1008,483,'2016-12-12','2018-1-8',154751.9075,'cosmetics and personal hygiene products')
              ,(1008,723,'2018-1-27','2018-7-21',69085.67298,'personal items')
              ,(1009,423,'2016-6-23','2016-10-13',38601.06194,'forklifts')
              ,(1009,436,'2016-10-13','2017-5-26',77546.77621,'bulk and packaged goods')
              ,(1010,542,'2017-9-11','2018-12-16',76871.82435,'containers')
              ,(1011,466,'2017-3-10','2019-2-20',215211.8532,'packaged foods and chocolate items')
              ,(1011,616,'2019-3-1','2019-6-7',29621.85619,'personal items')
              ,(1012,714,'2015-8-10','2016-1-1',54171.05806,'trucks')
              ,(1012,878,'2016-4-5','2016-9-11',59813.87661,'dangerous')
              ,(1012,647,'2016-10-9','2016-11-2',9028.509677,'goods under customs control')
              ,(1012,550,'2017-7-10','2018-6-30',133546.7056,'containers')
              ,(1013,739,'2018-11-1','2020-7-1',336619.8766,'packaged foods and chocolate items')
              ,(1013,638,'2020-7-29','2020-8-22',13287.62671,'trucks')
              ,(1014,419,'2018-6-13','2019-4-17',77082.07703,'packaged foods and chocolate items')
              ,(1014,800,'2019-7-26','2020-2-28',54307.827,'electronics')
              ,(1015,597,'2015-12-16','2017-8-28',108472.9346,'containers')
              ,(1016,819,'2017-11-17','2018-6-22',91501.9875,'goods under customs control')
              ,(1018,865,'2016-2-1','2016-8-14',78159.48169,'personal items')
              ,(1018,397,'2017-2-22','2017-5-3',28057.24984,'equipment')
              ,(1019,771,'2014-11-22','2015-8-14',55400.47258,'telecommunication equipment')
              ,(1020,879,'2017-10-25','2018-1-6',22297.33665,'equipment')
              ,(1020,834,'2018-3-17','2018-8-10',44594.67329,'chickens')
              ,(1020,514,'2018-8-18','2018-10-9',15883.03432,'textiles')
              ,(1020,543,'2018-11-8','2019-8-7',83080.48723,'bulk and packaged goods')
              ,(1021,837,'2017-5-18','2018-6-12',76637.26452,'packaged foods and chocolate items')
              ,(1021,893,'2019-1-17','2019-12-3',62881.85806,'spare parts')
              ,(1021,619,'2019-12-6','2020-10-31',64846.91613,'chickens')
              ,(1022,542,'2013-4-4','2014-3-24',78779.29703,'dangerous')
              ,(1024,388,'2015-4-19','2016-3-31',74758.97845,'trade fair and exhibition exhibits')
              ,(1025,859,'2017-6-30','2019-1-21',183337.9258,'printed materials')
              ,(1026,713,'2018-4-26','2018-7-29',17159.75913,'electronics')
              ,(1026,809,'2018-9-22','2018-12-29',17889.96165,'printed materials')
              ,(1026,615,'2019-8-15','2019-12-13',21906.07548,'trucks')
              ,(1027,957,'2015-6-22','2016-12-19',154928.592,'equipment')
              ,(1027,432,'2017-1-6','2017-1-20',3972.528,'medical supplies')
              ,(1027,650,'2017-4-14','2018-2-17',87679.368,'textiles')
              ,(1027,678,'2018-5-23','2018-12-29',62425.44,'equipment')
              ,(1028,567,'2013-10-1','2015-6-10',209840.2869,'trucks')
              ,(1029,891,'2017-1-19','2017-6-5',57071.97706,'trade fair and exhibition exhibits')
              ,(1030,677,'2016-7-19','2017-5-10',51121.93935,'household and industrial appliances')
              ,(1030,484,'2017-6-11','2017-7-25',7624.967226,'personal items')
              ,(1031,542,'2013-5-6','2014-7-15',109255.1894,'equipment')
              ,(1031,420,'2014-11-2','2015-6-12',55757.82077,'dry and liquid goods')
              ,(1031,543,'2015-9-7','2016-8-5',83636.73116,'equipment')
              ,(1032,489,'2014-5-7','2015-1-17',154145.1433,'medical supplies')
              ,(1032,391,'2015-2-3','2015-9-18',137219.4021,'household and industrial appliances')
              ,(1036,894,'2013-9-19','2014-8-16',98050.13332,'dangerous')
              ,(1036,914,'2014-9-27','2015-1-4',29326.17281,'equipment')
              ,(1039,953,'2018-6-27','2019-11-17',139797.2574,'packaged foods and chocolate items')
              ,(1039,360,'2020-4-9','2020-5-13',9356.509355,'goods under customs control')
              ,(1039,717,'2020-11-13','2021-10-7',90262.79613,'dry and liquid goods')
              ,(1040,546,'2016-3-23','2017-2-6',61802.64774,'goods under customs control')
              ,(1041,652,'2013-10-19','2014-5-17',43410.61742,'glass')
              ,(1042,505,'2014-8-3','2015-1-24',72498.77826,'trucks')
              ,(1042,640,'2015-6-26','2016-3-17',110414.806,'medical supplies')
              ,(1043,665,'2018-7-24','2020-1-17',307419.1917,'telecommunication equipment')
              ,(1044,495,'2017-8-18','2019-3-29',245797.6947,'household and industrial appliances')
              ,(1044,480,'2019-12-16','2020-7-6',84858.72794,'equipment')
              ,(1044,740,'2020-12-15','2021-4-29',56433.14419,'cosmetics and personal hygiene products')
              ,(1045,639,'2013-7-19','2015-2-6',178041.338,'goods under customs control')
              ,(1045,512,'2015-4-1','2016-2-26',103935.9486,'printed materials')
              ,(1045,691,'2016-4-24','2017-1-27',87293.63661,'packaged foods and chocolate items')
              ,(1045,550,'2017-5-26','2017-10-13',43960.82419,'personal items')
              ,(1046,930,'2013-7-5','2014-8-7',225285.8458,'equipment')
              ,(1046,406,'2014-9-3','2014-12-3',51510.08032,'medical supplies')
              ,(1046,510,'2015-8-2','2016-2-24',116605.2368,'equipment')
              ,(1047,863,'2017-2-24','2017-12-19',112737.6681,'equipment')
              ,(1049,540,'2016-4-23','2016-12-25',22192.46942,'household and industrial appliances')
              ,(1049,478,'2017-3-17','2018-1-9',26883.56052,'goods under customs control')
              ,(1050,716,'2017-12-10','2018-8-8',43108.94497,'trucks')
              ,(1052,400,'2016-12-23','2017-5-14',40729.02174,'packaged foods and chocolate items')
              ,(1053,979,'2018-11-9','2020-5-8',185320.1497,'packaged foods and chocolate items')
              ,(1053,817,'2020-5-13','2021-2-13',93678.31742,'machine parts')
              ,(1053,476,'2021-7-19','2021-12-6',47517.9871,'spare parts')
              ,(1053,464,'2021-12-21','2022-8-19',81798.82065,'cosmetics and personal hygiene products')
              ,(1054,430,'2015-12-27','2016-9-17',69452.2771,'glass')
              ,(1055,951,'2014-11-10','2016-3-30',285544.6142,'printed materials')
              ,(1056,376,'2013-9-8','2015-5-28',264724.6587,'electronics')
              ,(1057,790,'2013-1-28','2013-11-18',86638.54703,'equipment')
              ,(1057,967,'2014-3-13','2015-1-21',92532.32574,'electronics')
              ,(1058,606,'2014-11-30','2015-10-29',48748.87974,'printed materials')
              ,(1059,580,'2018-7-22','2019-12-15',84033.07635,'trade fair and exhibition exhibits')
              ,(1063,577,'2015-1-9','2016-10-7',101421.3934,'personal items')
              ,(1063,386,'2016-10-28','2017-4-24',28340.67194,'electronics')
              ,(1063,671,'2017-6-17','2017-7-1',2229.041613,'dangerous')
              ,(1065,590,'2015-8-28','2016-10-17',86438.352,'printed materials')
              ,(1066,701,'2017-9-12','2017-11-26',36599.26573,'glass')
              ,(1066,796,'2018-7-31','2019-4-14',125413.4839,'forklifts')
              ,(1066,817,'2019-4-26','2019-9-29',76126.47271,'stationery')
              ,(1067,382,'2018-10-10','2019-12-21',160255.2867,'printed materials')
              ,(1069,478,'2014-1-5','2014-9-10',55053.6,'goods under customs control')
              ,(1069,452,'2014-10-30','2015-1-1',13985.39032,'dangerous')
              ,(1070,761,'2017-3-7','2017-8-28',56153.37542,'cosmetics and personal hygiene products')
              ,(1070,456,'2017-9-19','2018-5-20',78421.09326,'bulk and packaged goods')
              ,(1074,690,'2017-9-21','2019-5-18',271234.656,'equipment')
              ,(1074,765,'2019-10-30','2019-12-9',17962.56,'electronics')
              ,(1077,711,'2018-8-30','2018-12-11',27268.97589,'dry and liquid goods')
              ,(1077,973,'2018-12-26','2019-6-20',46595.53161,'packaged foods and chocolate items')
              ,(1078,910,'2017-9-5','2018-12-7',185785.0111,'medical supplies')
              ,(1079,979,'2013-3-31','2014-10-30',171892.287,'forklifts')
              ,(1079,531,'2014-12-5','2015-12-4',108250.506,'medical supplies')
              ,(1080,927,'2014-10-20','2015-5-10',15168.63939,'personal items')
              ,(1080,660,'2016-1-12','2016-5-1',8260.150161,'textiles')
              ,(1080,813,'2016-5-22','2016-11-6',12615.50206,'trade fair and exhibition exhibits')
              ,(1082,458,'2015-9-9','2015-12-4',8824.086871,'textiles')
              ,(1082,985,'2016-1-8','2016-5-26',14262.18692,'textiles')
              ,(1083,802,'2016-2-22','2017-9-8',118411.3452,'household and industrial appliances')
              ,(1083,748,'2017-9-18','2018-6-19',57526.07903,'packaged foods and chocolate items')
              ,(1083,404,'2019-5-31','2020-5-6',71592.675,'equipment')
              ,(1084,942,'2017-9-28','2019-7-10',100921.9355,'containers')
              ,(1085,495,'2017-3-24','2019-1-2',306245.8282,'chickens')
              ,(1085,992,'2019-1-9','2019-11-5',141562.0161,'goods under customs control')
              ,(1085,516,'2020-6-17','2021-6-5',166571.3056,'machine parts')
              ,(1086,388,'2018-10-31','2020-9-28',91410.59787,'medical supplies')
              ,(1092,536,'2014-1-23','2014-9-27',25988.54323,'equipment')
              ,(1096,609,'2013-1-7','2014-4-30',99949.01361,'stationery')
              ,(1096,875,'2014-5-17','2014-11-16',38264.99894,'personal items')
              ,(1096,399,'2015-2-5','2015-7-5',31364.75323,'personal items')
              ,(1096,696,'2016-5-23','2017-3-3',59383.93277,'machine parts')
              ,(1097,471,'2014-2-25','2015-9-8',245973.8671,'cosmetics and personal hygiene products')
              ,(1097,994,'2016-2-14','2016-10-7',103660.4154,'telecommunication equipment')
              ,(1097,597,'2016-10-30','2016-12-17',21083.47432,'printed materials')
              ,(1098,941,'2017-7-4','2019-5-11',138125.2483,'cosmetics and personal hygiene products')
              ,(1101,876,'2015-2-8','2016-1-23',78668.06748,'household and industrial appliances')
              ,(1101,719,'2016-2-8','2016-5-29',25020.50284,'medical supplies')
              ,(1102,996,'2015-8-8','2015-9-3',11787.10084,'dry and liquid goods')
              ,(1102,786,'2015-9-10','2016-5-18',113790.8581,'glass')
              ,(1102,529,'2017-1-6','2017-3-3',25387.60181,'machine parts')
              ,(1103,854,'2014-1-4','2014-3-13',28269.01045,'machine parts')
              ,(1104,942,'2014-5-31','2015-8-13',92998.8929,'spare parts')
              ,(1105,829,'2016-8-25','2017-3-31',112023.5123,'equipment')
              ,(1105,782,'2017-6-4','2018-2-19',133606.0239,'equipment')
              ,(1105,413,'2018-3-20','2018-8-29',83246.83026,'equipment')
              ,(1107,484,'2017-10-22','2018-3-10',35403.23274,'stationery')
              ,(1108,783,'2013-3-25','2013-10-25',53105.23558,'goods under customs control')
              ,(1109,417,'2015-10-21','2017-2-19',209408.7118,'trucks')
              ,(1112,653,'2016-12-10','2018-1-8',340221.5419,'goods under customs control')
              ,(1114,704,'2018-4-29','2018-11-8',106736.0165,'cosmetics and personal hygiene products')
              ,(1114,638,'2019-1-16','2019-8-28',123880.1435,'packaged foods and chocolate items')
              ,(1115,741,'2013-2-17','2013-3-17',9776.088,'equipment')
              ,(1116,357,'2014-12-6','2015-1-4',5715.366774,'trucks')
              ,(1117,718,'2017-9-26','2018-6-28',204932.954,'containers')
              ,(1118,747,'2015-2-22','2015-3-19',2971.229032,'personal items')
              ,(1118,998,'2015-10-29','2016-8-12',34228.55845,'bulk and packaged goods')
              ,(1118,758,'2016-11-10','2017-10-6',39220.22323,'dangerous')
              ,(1119,676,'2018-5-28','2019-1-25',103220.3381,'goods under customs control')
              ,(1119,927,'2019-1-26','2019-8-17',86585.65548,'electronics')
              ,(1119,774,'2019-9-23','2020-9-2',147152.9613,'personal items')
              ,(1120,995,'2013-2-3','2013-8-14',36583.11639,'medical supplies')
              ,(1121,950,'2013-3-24','2013-12-17',96384.03871,'trucks')
              ,(1122,634,'2015-4-26','2015-12-1',51656.04218,'cosmetics and personal hygiene products')
              ,(1122,374,'2016-1-1','2016-7-8',44579.87202,'electronics')
              ,(1122,786,'2016-10-5','2017-1-9',22643.74452,'dry and liquid goods')
              ,(1123,450,'2017-6-3','2019-2-27',101776.0814,'trucks')
              ,(1123,998,'2019-3-20','2019-4-21',5136.963097,'chickens')
              ,(1124,669,'2016-7-5','2018-2-27',290180.7977,'telecommunication equipment')
              ,(1124,376,'2018-8-7','2019-7-29',171601.9335,'household and industrial appliances')
              ,(1125,846,'2015-11-10','2016-7-14',101026.0277,'trade fair and exhibition exhibits')
              ,(1125,958,'2017-2-17','2017-6-13',47445.42194,'trade fair and exhibition exhibits')
              ,(1125,921,'2017-7-10','2018-6-14',138655.1555,'containers')
              ,(1126,479,'2014-5-1','2015-1-10',36355.25352,'textiles')
              ,(1126,585,'2015-7-19','2016-1-24',27051.74376,'dangerous')
              ,(1127,628,'2013-6-16','2014-9-6',189100.2066,'electronics')
              ,(1128,654,'2014-4-10','2014-6-16',22676.80055,'dangerous')
              ,(1128,541,'2014-9-28','2015-1-9',34861.3501,'dangerous')
              ,(1128,444,'2015-2-18','2015-12-13',100860.9935,'medical supplies')
              ,(1129,639,'2016-12-25','2017-12-23',84445.62677,'electronics')
              ,(1129,409,'2018-6-9','2019-2-12',57692.88,'containers')
              ,(1129,889,'2020-1-24','2020-11-24',70952.9371,'glass')
              ,(1131,826,'2014-7-4','2015-9-16',121366.9455,'machine parts')
              ,(1131,554,'2015-11-4','2015-11-19',4146.934355,'chickens')
              ,(1131,976,'2016-5-1','2017-4-24',98973.49994,'cosmetics and personal hygiene products')
              ,(1131,466,'2017-5-7','2018-2-12',77685.90358,'stationery')
              ,(1133,407,'2014-8-23','2016-6-20',140394.1943,'household and industrial appliances')
              ,(1133,833,'2016-11-10','2017-10-7',69670.88202,'printed materials')
              ,(1134,677,'2014-12-1','2015-12-8',141015.168,'medical supplies')
              ,(1135,455,'2017-5-25','2017-8-5',22385.16,'containers')
              ,(1135,973,'2017-8-9','2017-10-16',21141.54,'vehicle parts')
              ,(1136,653,'2014-5-2','2014-6-3',21528.60387,'trade fair and exhibition exhibits')
              ,(1136,595,'2014-9-10','2015-7-1',197794.0481,'machine parts')
              ,(1137,410,'2018-5-10','2019-12-26',81438.37935,'electronics')
              ,(1139,452,'2016-5-8','2018-2-2',499763.1077,'cosmetics and personal hygiene products')
              ,(1139,401,'2018-3-3','2018-4-30',45647.65394,'textiles')
              ,(1139,481,'2018-5-11','2018-12-27',181016.5587,'goods under customs control')
              ,(1141,772,'2015-3-22','2015-4-26',9084.528871,'machine parts')
              ,(1141,560,'2015-11-4','2016-2-11',25696.23881,'household and industrial appliances')
              ,(1142,397,'2015-9-7','2016-11-6',136868.4613,'goods under customs control')
              ,(1143,597,'2015-11-29','2016-12-9',176021.4526,'household and industrial appliances')
              ,(1143,905,'2017-4-5','2017-10-22',93628.43226,'equipment')
              ,(1144,820,'2016-7-27','2016-9-14',8710.53479,'cosmetics and personal hygiene products')
              ,(1144,954,'2017-2-10','2017-6-19',22931.81608,'personal items')
              ,(1144,482,'2017-7-13','2018-6-7',58485.01931,'goods under customs control')
              ,(1145,684,'2017-5-10','2017-10-27',44197.98194,'bulk and packaged goods')
              ,(1145,766,'2017-11-12','2018-6-13',55377.47148,'dangerous')
              ,(1148,973,'2014-6-12','2016-2-14',189849.744,'household and industrial appliances')
              ,(1148,911,'2016-2-23','2016-10-30',77553,'textiles')
              ,(1150,452,'2016-9-21','2016-11-16',22546.84103,'goods under customs control')
              ,(1150,864,'2017-3-22','2017-11-14',95421.45223,'equipment')
              ,(1150,519,'2017-12-12','2018-7-7',83342.78739,'telecommunication equipment')
              ,(1151,906,'2017-6-12','2018-7-1',47043.03484,'printed materials')
              ,(1151,947,'2018-11-7','2019-5-2',21561.39097,'bulk and packaged goods')
              ,(1152,933,'2016-1-21','2016-8-13',35045.68573,'cosmetics and personal hygiene products')
              ,(1153,749,'2016-4-30','2018-3-29',117368.0245,'forklifts')
              ,(1154,714,'2015-10-2','2017-2-2',207376.3267,'glass')
              ,(1155,553,'2014-7-15','2015-2-28',43961.71703,'textiles')
              ,(1155,801,'2015-5-13','2015-11-24',37598.83694,'packaged foods and chocolate items')
              ,(1155,832,'2015-12-22','2016-2-7',9062.283774,'medical supplies')
              ,(1156,695,'2014-6-14','2014-11-18',22935.42097,'electronics')
              ,(1156,846,'2015-3-26','2015-4-10',2191.282258,'equipment')
              ,(1158,803,'2013-4-30','2014-8-23',125027.7677,'spare parts')
              ,(1158,553,'2015-1-27','2015-7-31',48187.78548,'containers')
              ,(1160,536,'2014-8-24','2016-2-23',117234.7802,'trucks')
              ,(1163,467,'2014-11-10','2014-12-25',6168.060726,'packaged foods and chocolate items')
              ,(1164,544,'2014-5-29','2014-8-1',16991.9969,'equipment')
              ,(1165,628,'2015-1-3','2016-11-21',176009.2645,'equipment')
              ,(1166,985,'2015-6-27','2017-4-3',379164.8863,'vehicle parts')
              ,(1166,730,'2017-4-11','2018-4-1',208364.6047,'dangerous')
              ,(1166,756,'2018-5-30','2018-10-12',79237.24403,'equipment')
              ,(1167,550,'2013-6-5','2013-7-9',11803.66374,'bulk and packaged goods')
              ,(1167,993,'2013-7-18','2013-11-19',43048.656,'stationery')
              ,(1167,760,'2014-4-16','2014-8-13',41312.8231,'equipment')
              ,(1169,555,'2016-1-27','2016-4-24',25752.20787,'bulk and packaged goods')
              ,(1169,495,'2016-7-24','2017-2-7',57942.46771,'electronics')
              ,(1171,631,'2015-10-22','2016-11-30',191928.2197,'equipment')
              ,(1172,665,'2013-10-6','2014-9-21',94668,'spare parts')
              ,(1172,952,'2014-10-7','2015-8-8',82496.4,'cosmetics and personal hygiene products')
              ,(1173,702,'2017-3-8','2018-12-11',174558.9435,'electronics')
              ,(1174,739,'2016-10-25','2017-9-16',184242.6437,'telecommunication equipment')
              ,(1174,627,'2017-9-27','2018-4-25',118683.9116,'glass')
              ,(1174,445,'2018-7-3','2018-8-26',30518.72013,'personal items')
              ,(1174,456,'2019-5-11','2019-5-28',9607.745226,'electronics')
              ,(1175,422,'2017-3-11','2017-12-6',98631.11323,'chickens')
              ,(1178,414,'2016-10-9','2017-10-20',79916.43484,'dry and liquid goods')
              ,(1178,622,'2017-11-27','2018-10-13',68013.9871,'personal items')
              ,(1180,758,'2018-1-9','2019-8-7',136785.9895,'equipment')
              ,(1181,669,'2016-5-26','2016-12-10',119385.502,'vehicle parts')
              ,(1182,682,'2016-1-23','2016-9-4',68240.58387,'glass')
              ,(1182,733,'2016-10-13','2016-11-14',9705.327484,'stationery')
              ,(1183,675,'2015-11-10','2017-8-17',363940.3334,'dangerous')
              ,(1184,615,'2013-7-1','2014-6-4',44442.40974,'packaged foods and chocolate items')
              ,(1185,932,'2015-11-20','2017-8-9',333173.9745,'telecommunication equipment')
              ,(1185,676,'2018-5-8','2018-10-10',82232.43,'goods under customs control')
              ,(1186,981,'2017-12-17','2018-10-3',86458.35484,'printed materials')
              ,(1186,629,'2019-1-24','2019-7-3',47701.16129,'containers')
              ,(1188,880,'2014-10-11','2016-1-1',118694.8299,'cosmetics and personal hygiene products')
              ,(1189,600,'2014-1-2','2014-7-11',39303.55935,'forklifts')
              ,(1190,783,'2015-3-2','2016-11-7',108538.8821,'glass')
              ,(1190,614,'2016-12-5','2017-7-29',41583.07819,'bulk and packaged goods')
              ,(1191,913,'2018-9-3','2019-10-12',171447.9561,'dry and liquid goods')
              ,(1192,502,'2016-3-9','2017-5-27',162858.5483,'medical supplies')
              ,(1192,685,'2017-10-5','2018-9-8',123977.9039,'telecommunication equipment')
              ,(1192,840,'2018-11-9','2019-3-8',43649.02534,'vehicle parts')
              ,(1192,378,'2019-3-10','2020-1-20',115908.3362,'medical supplies')
              ,(1192,884,'2020-2-21','2020-10-8',84363.66242,'dry and liquid goods')
              ,(1193,679,'2014-5-12','2015-7-21',110697.93,'personal items')
              ,(1194,411,'2014-8-23','2015-11-3',67874.57216,'chickens')
              ,(1194,818,'2015-11-29','2016-4-15',21434.07542,'textiles')
              ,(1194,734,'2016-5-19','2016-11-3',26093.65703,'vehicle parts')
              ,(1195,533,'2018-6-11','2020-2-19',76692.44439,'bulk and packaged goods')
              ,(1195,697,'2020-3-5','2020-12-6',34250.99458,'dry and liquid goods')
              ,(1198,728,'2015-7-16','2016-9-8',92181.09194,'machine parts')
              ,(1198,958,'2017-8-6','2018-3-8',46968.46113,'textiles')
              ,(1198,389,'2018-8-27','2018-12-24',26117.97605,'containers')
              ,(1198,650,'2019-1-4','2019-11-13',68696.86137,'vehicle parts')
              ,(1199,965,'2013-10-23','2015-5-26',160593.3,'dry and liquid goods')
              ,(1199,515,'2015-8-29','2016-3-6',52608.15,'electronics')
              ,(1200,922,'2013-7-5','2015-6-4',216951.8319,'personal items')
              ,(1200,620,'2015-6-6','2016-3-15',87836.00632,'personal items')
              ,(1201,457,'2016-4-18','2017-8-18',133002.135,'chickens')
              ,(1201,368,'2017-8-28','2018-2-3',43423.695,'personal items')
              ,(1202,895,'2015-4-20','2016-9-18',304866.3111,'household and industrial appliances')
              ,(1202,361,'2016-9-20','2017-1-6',63685.80581,'cosmetics and personal hygiene products')
              ,(1203,684,'2015-5-30','2015-8-13',23086.95968,'spare parts')
              ,(1204,359,'2016-8-24','2018-1-13',253102.373,'machine parts')
              ,(1205,393,'2017-7-20','2019-4-3',149967.3501,'dangerous')
              ,(1206,453,'2016-5-19','2016-9-19',47663.26577,'trucks')
              ,(1206,453,'2016-10-1','2017-5-14',87188.90081,'trade fair and exhibition exhibits')
              ,(1208,440,'2017-9-27','2018-9-7',177636.2988,'bulk and packaged goods')
              ,(1208,780,'2018-10-11','2019-7-27',148802.5807,'equipment')
              ,(1209,636,'2016-11-4','2018-7-9',267275.167,'personal items')
              ,(1209,595,'2018-11-12','2019-3-11',51970.17135,'stationery')
              ,(1209,661,'2019-8-1','2019-8-30',12664.99974,'telecommunication equipment')
              ,(1211,809,'2015-12-1','2017-4-3',161197.6275,'goods under customs control')
              ,(1211,946,'2017-6-30','2017-9-29',29997.9225,'dangerous')
              ,(1212,810,'2018-11-28','2019-9-21',56151.40921,'vehicle parts')
              ,(1212,363,'2020-1-6','2020-12-25',66927.94229,'textiles')
              ,(1212,848,'2021-3-6','2021-10-10',41215.51248,'packaged foods and chocolate items')
              ,(1212,670,'2021-12-29','2022-11-19',61445.14476,'chickens')
              ,(1214,400,'2013-3-8','2013-7-20',19475.51245,'telecommunication equipment')
              ,(1217,696,'2013-9-19','2013-10-25',6876.429677,'personal items')
              ,(1217,815,'2013-11-18','2014-11-4',67045.18935,'dry and liquid goods')
              ,(1218,977,'2013-3-20','2014-2-24',94710,'glass')
              ,(1218,970,'2014-10-18','2015-8-26',86655.48387,'spare parts')
              ,(1218,537,'2016-1-2','2016-4-16',29162.90323,'packaged foods and chocolate items')
              ,(1219,973,'2015-3-25','2017-2-22',326004.271,'trucks')
              ,(1219,699,'2017-5-2','2018-3-3',142044.7181,'containers')
              ,(1220,942,'2018-3-30','2019-8-2',55463.1,'telecommunication equipment')
              ,(1220,803,'2019-10-24','2020-4-21',20374.2,'equipment')
              ,(1220,799,'2020-5-8','2020-10-29',19695.06,'forklifts')
              ,(1221,708,'2018-10-22','2020-1-1',266428.0812,'telecommunication equipment')
              ,(1221,823,'2020-1-23','2020-9-14',143602.2915,'packaged foods and chocolate items')
              ,(1221,746,'2021-4-14','2022-2-25',193710.3251,'stationery')
              ,(1221,508,'2022-3-7','2023-2-16',211431.4589,'equipment')
              ,(1221,896,'2023-4-4','2023-10-17',119770.4218,'equipment')
              ,(1221,875,'2023-11-9','2024-7-6',146657.6594,'packaged foods and chocolate items')
              ,(1221,998,'2025-4-27','2025-6-16',30553.67903,'trade fair and exhibition exhibits')
              ,(1222,617,'2016-4-22','2017-5-18',119274.0455,'personal items')
              ,(1223,985,'2016-12-5','2017-12-22',31787.30439,'trade fair and exhibition exhibits')
              ,(1224,678,'2018-4-30','2020-1-7',39259.71,'stationery')
              ,(1225,663,'2015-9-27','2015-11-1',10177.28419,'equipment')
              ,(1226,471,'2014-9-30','2015-9-30',133404.1326,'electronics')
              ,(1226,691,'2016-2-7','2016-5-2',31066.71581,'personal items')
              ,(1226,677,'2016-5-24','2016-12-19',76387.57181,'trade fair and exhibition exhibits')
              ,(1226,642,'2017-2-15','2017-3-30',15716.10329,'trucks')
              ,(1230,932,'2014-10-14','2015-9-2',134585.0039,'machine parts')
              ,(1231,662,'2014-6-20','2014-10-7',13887.73219,'equipment')
              ,(1231,485,'2015-3-6','2015-9-9',23825.74239,'packaged foods and chocolate items')
              ,(1231,863,'2015-10-21','2016-3-13',18347.09574,'vehicle parts')
              ,(1233,725,'2013-12-4','2015-2-28',235751.521,'medical supplies')
              ,(1233,690,'2015-3-2','2015-7-24',75273.2129,'household and industrial appliances')
              ,(1234,721,'2018-7-13','2018-11-6',14784.94839,'containers')
              ,(1234,991,'2019-2-17','2019-9-6',25618.74677,'machine parts')
              ,(1235,423,'2015-7-21','2017-3-8',251570.9944,'medical supplies')
              ,(1235,381,'2017-3-12','2017-8-15',65847.44148,'electronics')
              ,(1235,489,'2017-12-25','2018-6-22',75555.71811,'printed materials')
              ,(1236,500,'2016-6-5','2017-9-19',256759.5118,'equipment')
              ,(1236,861,'2018-3-25','2019-1-10',158634.8576,'equipment')
              ,(1237,730,'2016-1-27','2017-12-23',117716.0853,'medical supplies')
              ,(1238,510,'2016-11-4','2017-8-21',71264.7871,'trucks')
              ,(1238,388,'2017-9-29','2018-3-6',38827.02194,'spare parts')
              ,(1239,720,'2018-10-26','2019-3-10',29910.16452,'cosmetics and personal hygiene products')
              ,(1239,400,'2019-10-1','2020-9-24',79538.88194,'spare parts')
              ,(1240,936,'2014-3-6','2014-6-7',38025.099,'bulk and packaged goods')
              ,(1241,641,'2013-4-14','2013-9-13',32831.57342,'telecommunication equipment')
              ,(1243,786,'2018-8-15','2020-4-29',229333.1731,'electronics')
              ,(1243,603,'2020-7-23','2021-4-1',92763.98013,'bulk and packaged goods')
              ,(1244,401,'2016-11-23','2017-4-8',85936.57935,'stationery')
              ,(1244,725,'2017-5-11','2017-10-26',106156.951,'personal items')
              ,(1245,417,'2018-7-16','2019-3-7',42018.6629,'vehicle parts')
              ,(1246,698,'2013-6-3','2014-4-1',43357.18529,'bulk and packaged goods')
              ,(1247,788,'2013-4-19','2013-8-21',37054.794,'equipment')
              ,(1247,684,'2013-12-8','2014-7-7',63052.9156,'electronics')
              ,(1248,557,'2013-3-28','2015-2-1',207121.8992,'textiles')
              ,(1248,658,'2015-4-10','2016-2-28',99418.51161,'goods under customs control')
              ,(1250,377,'2017-6-5','2019-5-15',328762.8083,'trucks')
              ,(1250,673,'2019-5-17','2019-8-13',40805.53897,'bulk and packaged goods')
              ,(1251,930,'2018-10-29','2019-5-24',65289.69639,'dangerous')
              ,(1252,733,'2014-1-25','2015-1-16',67466.31794,'electronics')
              ,(1252,718,'2015-6-11','2015-7-20',7390.973032,'glass')
              ,(1253,461,'2014-6-17','2015-3-15',38285.74355,'trade fair and exhibition exhibits')
              ,(1253,542,'2015-9-27','2015-12-5',9748.030645,'vehicle parts')
              ,(1253,762,'2016-6-11','2017-1-24',32069.60806,'dry and liquid goods')
              ,(1255,887,'2016-5-27','2017-6-26',100982.1259,'spare parts')
              ,(1256,750,'2015-7-3','2015-10-6',29479.1175,'dangerous')
              ,(1257,787,'2013-2-10','2013-7-27',91733.27777,'dry and liquid goods')
              ,(1257,808,'2013-10-8','2014-5-23',124691.3416,'dangerous')
              ,(1258,706,'2015-6-6','2017-4-3',69221.01256,'vehicle parts')
              ,(1259,500,'2017-6-24','2017-11-8',43545.25113,'packaged foods and chocolate items')
              ,(1261,757,'2013-6-17','2015-2-9',43162.23484,'electronics')
              ,(1261,846,'2015-2-25','2016-2-20',25811.30323,'goods under customs control')
              ,(1261,702,'2016-2-23','2017-2-6',25022.62452,'telecommunication equipment')
              ,(1261,590,'2017-3-9','2018-3-8',26098.09548,'electronics')
              ,(1261,409,'2018-3-25','2018-8-27',11113.2,'vehicle parts')
              ,(1261,882,'2018-9-26','2019-7-28',21867.90968,'packaged foods and chocolate items')
              ,(1264,494,'2013-3-26','2014-7-18',137736.9135,'containers')
              ,(1264,635,'2014-12-15','2015-6-25',55209.78581,'stationery')
              ,(1265,929,'2018-5-13','2020-5-1',316059.574,'printed materials')
              ,(1266,507,'2015-12-2','2015-12-23',3304.050242,'trucks')
              ,(1266,900,'2016-2-18','2016-9-17',33355.17387,'electronics')
              ,(1266,504,'2016-11-9','2016-12-11',5034.743226,'stationery')
              ,(1266,867,'2017-4-19','2018-3-18',52392.79669,'electronics')
              ,(1269,585,'2016-12-15','2017-12-22',135460.08,'medical supplies')
              ,(1269,989,'2018-9-11','2019-4-21',80839.08,'cosmetics and personal hygiene products')
              ,(1270,415,'2015-11-13','2017-11-5',164508.7845,'trucks')
              ,(1270,412,'2017-12-21','2018-6-1',36860.88948,'printed materials')
              ,(1270,476,'2018-6-29','2018-11-3',28897.11706,'trade fair and exhibition exhibits')
              ,(1271,568,'2013-2-20','2013-4-18',13080.12097,'personal items')
              ,(1272,866,'2016-3-13','2017-3-28',47287.93548,'cosmetics and personal hygiene products')
              ,(1272,517,'2017-5-27','2017-6-14',2239.954839,'cosmetics and personal hygiene products')
              ,(1272,867,'2017-11-6','2018-4-10',19288.5,'bulk and packaged goods')
              ,(1273,865,'2015-11-6','2017-9-8',148314.3886,'vehicle parts')
              ,(1274,482,'2015-6-16','2016-4-4',70126.83266,'cosmetics and personal hygiene products')
              ,(1277,572,'2017-8-11','2018-10-16',205097.9957,'bulk and packaged goods')
              ,(1277,544,'2018-12-15','2019-10-11',142759.6258,'electronics')
              ,(1277,879,'2020-1-12','2020-5-21',61862.50452,'stationery')
              ,(1278,370,'2013-8-5','2015-3-23',124953.6276,'telecommunication equipment')
              ,(1279,771,'2013-8-31','2015-6-22',142260.8284,'stationery')
              ,(1279,588,'2015-9-16','2015-12-24',21339.12426,'equipment')
              ,(1280,819,'2016-3-20','2017-2-25',86327.64,'personal items')
              ,(1280,766,'2017-10-30','2018-4-26',44930.76,'personal items')
              ,(1280,728,'2019-1-17','2019-5-21',31300.08,'printed materials')
              ,(1281,528,'2018-9-18','2019-7-14',53796.64906,'cosmetics and personal hygiene products')
              ,(1281,801,'2019-10-20','2019-12-20',10975.2361,'containers')
              ,(1282,681,'2014-9-8','2015-1-29',82763.01905,'dangerous')
              ,(1283,977,'2016-2-13','2017-11-21',244037.8602,'containers')
              ,(1283,604,'2017-11-24','2018-6-25',80340.13016,'equipment')
              ,(1284,873,'2013-12-28','2014-6-20',14596.25661,'telecommunication equipment')
              ,(1285,495,'2016-10-1','2017-6-15',66949.26271,'trade fair and exhibition exhibits')
              ,(1286,700,'2013-10-13','2014-7-25',53294.49435,'stationery')
              ,(1286,617,'2014-11-6','2015-10-13',63766.395,'trucks')
              ,(1286,921,'2016-5-5','2016-11-14',36090.65758,'dangerous')
              ,(1288,785,'2018-7-11','2019-7-4',163829.3458,'trade fair and exhibition exhibits')
              ,(1289,873,'2018-1-13','2019-3-8',62722.9619,'cosmetics and personal hygiene products')
              ,(1289,812,'2019-9-9','2020-3-3',26346.63794,'trucks')
              ,(1290,812,'2014-5-15','2015-10-21',246495.2795,'electronics')
              ,(1291,474,'2014-11-12','2015-6-16',37759.56619,'packaged foods and chocolate items')
              ,(1292,953,'2017-3-29','2017-6-26',22505.95539,'dangerous')
              ,(1292,662,'2017-12-10','2018-10-22',79908.78542,'dry and liquid goods')
              ,(1293,539,'2017-3-3','2017-5-25',26132.18052,'forklifts')
              ,(1293,418,'2017-10-6','2018-7-24',91620.05458,'vehicle parts')
              ,(1293,878,'2018-10-4','2019-6-16',80285.61484,'stationery')
              ,(1294,675,'2017-6-19','2018-5-13',135465.185,'dry and liquid goods')
              ,(1295,641,'2018-8-18','2019-12-28',93438.08419,'equipment')
              ,(1296,356,'2018-4-3','2019-1-18',93151.95242,'cosmetics and personal hygiene products')
              ,(1296,412,'2019-4-1','2019-9-22',55891.17145,'textiles')
              ,(1297,937,'2015-8-12','2016-2-1',70167.41042,'forklifts')
              ,(1298,848,'2014-1-24','2014-4-3',24031.89871,'medical supplies')
              ,(1298,890,'2014-4-22','2014-9-3',46670.64387,'equipment')
              ,(1300,952,'2018-8-19','2018-9-23',15558.69339,'printed materials')
              ,(1301,359,'2016-1-25','2017-9-26',286117.5484,'glass')
              ,(1302,408,'2015-10-10','2017-7-9',73258.53523,'vehicle parts')
              ,(1303,660,'2017-4-18','2017-9-8',38681.83674,'personal items')
              ,(1303,475,'2017-9-10','2018-3-6',47878.91681,'equipment')
              ,(1305,683,'2015-2-28','2016-8-21',236217.1384,'forklifts')
              ,(1305,687,'2016-9-30','2017-5-20',101485.8817,'vehicle parts')
              ,(1305,716,'2017-6-24','2017-7-12',7873.904613,'containers')
              ,(1306,771,'2015-6-7','2016-6-7',22529.89742,'glass')
              ,(1306,392,'2016-9-12','2017-2-17',9726.02129,'bulk and packaged goods')
              ,(1306,987,'2017-9-27','2018-5-30',15081.48871,'stationery')
              ,(1307,472,'2017-10-21','2019-5-26',90799.20929,'household and industrial appliances')
              ,(1308,677,'2018-3-18','2020-3-2',118174.831,'textiles')
              ,(1308,967,'2020-3-8','2020-12-19',47269.93239,'dangerous')
              ,(1310,994,'2017-12-18','2019-9-14',95108.66129,'trade fair and exhibition exhibits')
              ,(1310,830,'2020-3-3','2021-1-29',49726.10323,'electronics')
              ,(1312,401,'2017-3-21','2018-6-25',123989.4075,'machine parts')
              ,(1313,946,'2014-9-16','2016-6-4',292075.4909,'chickens')
              ,(1313,489,'2016-9-9','2016-11-10',28881.468,'vehicle parts')
              ,(1313,604,'2017-2-20','2017-8-7',78259.46168,'packaged foods and chocolate items')
              ,(1313,836,'2017-10-8','2017-12-9',28881.468,'forklifts')
              ,(1313,781,'2017-12-19','2018-12-13',167233.0163,'vehicle parts')
              ,(1314,526,'2016-3-9','2018-1-23',162900.3803,'personal items')
              ,(1315,396,'2013-4-2','2013-12-17',79743.19669,'printed materials')
              ,(1315,617,'2014-3-25','2014-9-15',53572.64952,'equipment')
              ,(1318,637,'2015-4-6','2016-10-29',247744.0126,'spare parts')
              ,(1318,935,'2017-3-10','2017-8-30',74929.57026,'stationery')
              ,(1319,876,'2013-1-5','2014-4-27',156762.334,'trucks')
              ,(1320,355,'2013-12-25','2015-4-29',56148.54677,'telecommunication equipment')
              ,(1322,953,'2016-7-12','2016-11-22',57687.38782,'trade fair and exhibition exhibits')
              ,(1322,724,'2017-1-3','2017-4-16',44675.19508,'personal items')
              ,(1323,833,'2014-11-11','2015-12-25',229656.2838,'chickens')
              ,(1324,416,'2017-10-24','2018-8-9',64051.24713,'telecommunication equipment')
              ,(1325,813,'2018-4-27','2018-12-3',66065.40387,'chickens')
              ,(1325,911,'2019-1-20','2019-11-2',85885.02503,'household and industrial appliances')
              ,(1325,404,'2020-5-2','2020-11-21',60960.34994,'textiles')
              ,(1326,370,'2014-5-14','2016-1-18',324751.6115,'trade fair and exhibition exhibits')
              ,(1327,985,'2016-1-7','2017-9-28',84379.65968,'dry and liquid goods')
              ,(1327,963,'2017-10-1','2018-5-18',30671.33661,'cosmetics and personal hygiene products')
              ,(1327,807,'2018-8-7','2019-2-21',26519.32161,'electronics')
              ,(1328,534,'2017-5-24','2017-11-24',42507.49006,'packaged foods and chocolate items')
              ,(1328,520,'2017-12-23','2018-7-14',46896.85045,'vehicle parts')
              ,(1330,455,'2014-12-9','2015-6-19',56001.42348,'vehicle parts')
              ,(1330,465,'2015-9-15','2016-2-29',48709.57147,'containers')
              ,(1330,742,'2016-12-15','2017-6-10',51626.31227,'machine parts')
              ,(1333,693,'2014-6-29','2014-7-23',13309.04671,'telecommunication equipment')
              ,(1334,959,'2017-12-29','2018-5-26',79300.77039,'printed materials')
              ,(1334,750,'2018-12-19','2019-8-12',126452.5798,'dangerous')
              ,(1335,551,'2018-11-17','2019-9-8',157556.0361,'bulk and packaged goods')
              ,(1335,889,'2020-1-2','2020-4-25',60886.06142,'equipment')
              ,(1336,858,'2016-6-8','2016-11-24',85433.93216,'trucks')
              ,(1337,756,'2017-3-13','2017-4-27',8449.123065,'containers')
              ,(1337,672,'2017-5-17','2017-10-20',29290.29329,'glass')
              ,(1338,853,'2014-4-24','2015-11-6',139122.209,'trucks')
              ,(1338,838,'2016-2-19','2016-3-6',3967.834839,'chickens')
              ,(1340,410,'2014-8-2','2015-3-31',58376.18613,'forklifts')
              ,(1341,523,'2016-9-15','2017-6-12',133446.1935,'vehicle parts')
              ,(1341,467,'2017-7-3','2017-9-9',33608.67097,'cosmetics and personal hygiene products')
              ,(1341,712,'2017-9-12','2018-2-3',71171.30323,'equipment')
              ,(1341,465,'2018-5-8','2018-6-25',23723.76774,'equipment')
              ,(1341,738,'2018-9-22','2019-6-8',128009.4968,'packaged foods and chocolate items')
              ,(1343,505,'2016-10-21','2017-9-25',52753.16787,'forklifts')
              ,(1343,456,'2018-1-1','2018-10-10',43883.16619,'personal items')
              ,(1344,746,'2014-10-14','2016-1-9',237038.2045,'stationery')
              ,(1344,792,'2016-12-16','2017-4-1',55588.60548,'trucks')
              ,(1344,983,'2017-5-15','2017-8-27',54539.76387,'printed materials')
              ,(1344,602,'2017-9-17','2018-8-28',180925.1782,'trucks')
              ,(1345,959,'2017-2-1','2017-9-24',103484.5621,'printed materials')
              ,(1345,748,'2017-10-22','2018-5-28',95998.44484,'goods under customs control')
              ,(1346,850,'2016-2-6','2016-7-21',29827.90277,'spare parts')
              ,(1346,441,'2016-9-7','2016-10-31',9703.05271,'vehicle parts')
              ,(1348,876,'2014-7-11','2016-2-21',159947.3061,'household and industrial appliances')
              ,(1348,431,'2016-9-8','2017-4-22',61267.95116,'vehicle parts')
              ,(1349,491,'2016-10-12','2017-7-14',49261.68145,'trade fair and exhibition exhibits')
              ,(1349,626,'2017-10-14','2018-4-24',34393.61032,'machine parts')
              ,(1350,446,'2013-4-3','2013-5-22',10953.67181,'printed materials')
              ,(1351,877,'2015-8-5','2016-7-18',93011.50916,'dangerous')
              ,(1352,919,'2013-1-22','2014-3-18',313171.171,'cosmetics and personal hygiene products')
              ,(1353,846,'2014-5-21','2015-9-20',221726.6385,'packaged foods and chocolate items')
              ,(1355,928,'2015-1-11','2015-9-25',153584.257,'dangerous')
              ,(1357,813,'2015-8-24','2016-7-23',102069.9906,'equipment')
              ,(1357,690,'2016-9-27','2017-6-15',79761.28006,'printed materials')
              ,(1358,640,'2017-6-29','2019-4-18',163826.8766,'forklifts')
              ,(1358,945,'2019-6-26','2019-7-17',5228.517339,'dry and liquid goods')
              ,(1360,649,'2017-4-13','2018-2-22',65749.68581,'forklifts')
              ,(1361,729,'2013-1-15','2014-5-2',101498.5603,'dangerous')
              ,(1361,555,'2014-6-14','2014-10-22',27955.11194,'packaged foods and chocolate items')
              ,(1361,788,'2014-11-21','2015-8-26',59780.93168,'trucks')
              ,(1362,884,'2015-4-24','2015-7-20',22268.77258,'stationery')
              ,(1363,716,'2016-11-27','2018-3-18',61764.47787,'household and industrial appliances')
              ,(1363,630,'2018-7-3','2018-8-5',4281.991113,'machine parts')
              ,(1364,556,'2015-1-19','2017-1-3',99688.70202,'medical supplies')
              ,(1364,421,'2017-1-8','2017-2-10',4601.017016,'forklifts')
              ,(1365,514,'2015-11-5','2016-1-31',10368.10713,'telecommunication equipment')
              ,(1365,535,'2016-3-18','2016-5-31',8818.849742,'containers')
              ,(1365,680,'2016-6-28','2017-3-11',30508.45316,'personal items')
              ,(1368,643,'2018-10-23','2019-2-17',21703.71135,'electronics')
              ,(1368,381,'2019-8-27','2020-5-20',49528.98232,'equipment')
              ,(1369,437,'2018-10-10','2019-2-13',67150.35871,'machine parts')
              ,(1369,687,'2019-3-14','2019-4-23',21317.57419,'chickens')
              ,(1370,691,'2013-12-21','2014-10-17',88196.64677,'dry and liquid goods')
              ,(1371,501,'2015-2-8','2016-3-8',47079.72726,'electronics')
              ,(1372,994,'2017-1-3','2018-6-21',179547.354,'cosmetics and personal hygiene products')
              ,(1372,739,'2019-1-14','2019-10-3',88092.522,'medical supplies')
              ,(1373,770,'2015-3-2','2016-11-8',82629.50579,'cosmetics and personal hygiene products')
              ,(1373,910,'2017-3-12','2018-2-21',46336.80552,'equipment')
              ,(1373,955,'2018-7-20','2019-4-9',35221.32905,'electronics')
              ,(1374,540,'2017-11-21','2019-5-25',60739.21452,'medical supplies')
              ,(1374,729,'2019-6-23','2019-9-21',9939.144194,'printed materials')
              ,(1374,923,'2019-10-9','2020-2-9',13583.49706,'medical supplies')
              ,(1375,642,'2014-10-25','2015-10-22',95429.25474,'medical supplies')
              ,(1376,852,'2015-6-16','2016-12-16',65170.27582,'glass')
              ,(1377,946,'2015-7-18','2016-1-10',58604.2529,'equipment')
              ,(1377,564,'2016-2-16','2016-11-1',86241.48581,'personal items')
              ,(1377,873,'2016-12-27','2017-1-10',4661.701935,'trade fair and exhibition exhibits')
              ,(1378,604,'2014-10-14','2016-7-12',339922.5155,'personal items')
              ,(1378,806,'2017-4-3','2017-5-18',24013.36452,'dry and liquid goods')
              ,(1380,665,'2015-4-6','2017-2-11',73335.87213,'printed materials')
              ,(1380,528,'2017-3-25','2017-8-17',15707.09226,'telecommunication equipment')
              ,(1381,700,'2013-10-23','2015-10-14',305090.9058,'vehicle parts')
              ,(1383,556,'2018-11-16','2020-2-13',66865.01748,'personal items')
              ,(1383,942,'2020-7-30','2021-5-23',43742.09294,'spare parts')
              ,(1385,865,'2017-12-10','2019-2-21',111197.2924,'glass')
              ,(1386,356,'2014-8-15','2015-3-24',36743.39584,'forklifts')
              ,(1386,606,'2015-5-28','2015-8-29',15462.153,'machine parts')
              ,(1386,774,'2015-10-21','2016-9-16',55031.9639,'vehicle parts')
              ,(1386,403,'2017-1-25','2017-5-22',19452.38603,'personal items')
              ,(1388,449,'2017-6-17','2017-9-15',33346.91613,'forklifts')
              ,(1388,358,'2017-12-31','2018-3-7',24454.40516,'glass')
              ,(1389,608,'2017-8-10','2018-10-18',81982.929,'trade fair and exhibition exhibits')
              ,(1389,686,'2018-10-26','2019-10-10',65926.36456,'glass')
              ,(1389,398,'2019-11-17','2020-3-21',23612.59476,'dangerous')
              ,(1390,689,'2018-10-2','2019-7-6',80746.43376,'equipment')
              ,(1391,730,'2017-6-25','2018-1-13',85725.62013,'telecommunication equipment')
              ,(1392,431,'2013-3-20','2014-8-7',104108.6008,'forklifts')
              ,(1392,977,'2014-12-15','2015-2-3',10307.78226,'personal items')
              ,(1393,900,'2017-2-28','2017-12-13',53314.68077,'equipment')
              ,(1396,625,'2013-12-13','2014-2-24',17428.50392,'dangerous')
              ,(1396,986,'2014-5-22','2014-9-19',28649.59548,'cosmetics and personal hygiene products')
              ,(1396,668,'2014-10-25','2015-8-25',72578.97523,'equipment')
              ,(1397,725,'2014-7-16','2015-9-19',60180.58065,'equipment')
              ,(1397,642,'2015-12-30','2016-9-23',37507.89677,'personal items')
              ,(1397,648,'2016-10-10','2016-12-22',10216.70323,'personal items')
              ,(1397,611,'2017-1-18','2017-4-13',11896.16129,'trucks')
              ,(1398,378,'2016-6-7','2017-1-11',74814.85742,'vehicle parts');

              INSERT INTO Contract_Status(ContractID,StatusID) VALUES
              (568,4)
              ,(1362,2)
              ,(1549,2)
              ,(1805,3)
              ,(488,2)
              ,(1540,2)
              ,(1248,4)
              ,(919,2)
              ,(1983,3)
              ,(1941,3)
              ,(178,4)
              ,(1426,4)
              ,(1910,3)
              ,(1431,2)
              ,(730,3)
              ,(801,4)
              ,(1985,4)
              ,(1892,2)
              ,(1169,2)
              ,(1091,4)
              ,(554,3)
              ,(242,4)
              ,(1975,3)
              ,(191,4)
              ,(1566,3)
              ,(600,4)
              ,(224,2)
              ,(371,4)
              ,(1607,4)
              ,(1698,4)
              ,(1313,3)
              ,(307,3)
              ,(1832,4)
              ,(109,4)
              ,(915,2)
              ,(444,2)
              ,(1453,3)
              ,(620,2)
              ,(254,3)
              ,(710,3)
              ,(1455,4)
              ,(878,3)
              ,(1199,4)
              ,(1817,2)
              ,(1296,2)
              ,(882,4)
              ,(1450,2)
              ,(1218,4)
              ,(1106,4)
              ,(345,3)
              ,(895,3)
              ,(449,4)
              ,(1588,4)
              ,(1027,2)
              ,(902,3)
              ,(220,2)
              ,(1505,2)
              ,(1602,3)
              ,(623,4)
              ,(479,4)
              ,(844,4)
              ,(464,3)
              ,(699,4)
              ,(1952,3)
              ,(1132,2)
              ,(1888,3)
              ,(322,4)
              ,(1991,3)
              ,(980,3)
              ,(86,4)
              ,(12,3)
              ,(512,3)
              ,(753,2)
              ,(1202,4)
              ,(1241,3)
              ,(921,2)
              ,(552,2)
              ,(608,4)
              ,(596,3)
              ,(1751,4)
              ,(227,2)
              ,(1160,2)
              ,(1491,2)
              ,(1270,4)
              ,(828,2)
              ,(1217,4)
              ,(378,4)
              ,(598,3)
              ,(1371,4)
              ,(264,4)
              ,(1778,3)
              ,(587,2)
              ,(1104,4)
              ,(703,3)
              ,(64,2)
              ,(565,4)
              ,(1292,4)
              ,(1343,2)
              ,(1009,3)
              ,(549,4)
              ,(25,2)
              ,(1865,2)
              ,(1897,2)
              ,(1456,2)
              ,(389,2)
              ,(1657,3)
              ,(1407,2)
              ,(1555,2)
              ,(69,2)
              ,(750,3)
              ,(1209,3)
              ,(1754,4)
              ,(922,4)
              ,(198,3)
              ,(673,4)
              ,(1919,2)
              ,(1628,4)
              ,(514,4)
              ,(357,2)
              ,(1053,2)
              ,(1913,3)
              ,(1436,4)
              ,(1280,4)
              ,(943,2)
              ,(585,4)
              ,(1419,2)
              ,(1541,4)
              ,(995,3)
              ,(1119,2)
              ,(1382,2)
              ,(1003,2)
              ,(170,3)
              ,(1189,4)
              ,(1225,3)
              ,(509,2)
              ,(1289,3)
              ,(1740,4)
              ,(1062,2)
              ,(1634,4)
              ,(169,4)
              ,(206,2)
              ,(1574,4)
              ,(692,2)
              ,(1074,2)
              ,(1508,4)
              ,(1258,2)
              ,(1735,3)
              ,(1834,3)
              ,(595,2)
              ,(1163,3)
              ,(1390,4)
              ,(1828,4)
              ,(1775,4)
              ,(1472,2)
              ,(1089,2)
              ,(316,3)
              ,(1190,2)
              ,(1504,4)
              ,(1227,3)
              ,(312,4)
              ,(539,4)
              ,(1372,4)
              ,(559,4)
              ,(591,2)
              ,(1043,2)
              ,(1542,3)
              ,(331,3)
              ,(817,2)
              ,(725,3)
              ,(936,3)
              ,(196,2)
              ,(1207,2)
              ,(884,4)
              ,(262,3)
              ,(572,4)
              ,(1283,3)
              ,(1311,3)
              ,(1627,3)
              ,(437,2)
              ,(1239,4)
              ,(50,2)
              ,(1100,2)
              ,(94,4)
              ,(492,4)
              ,(618,2)
              ,(1610,2)
              ,(1312,4)
              ,(1479,3)
              ,(96,3)
              ,(979,3)
              ,(1008,3)
              ,(1595,2)
              ,(836,3)
              ,(1347,2)
              ,(805,2)
              ,(543,4)
              ,(398,4)
              ,(779,4)
              ,(288,4)
              ,(589,2)
              ,(91,2)
              ,(1451,4)
              ,(214,4)
              ,(1918,3)
              ,(763,3)
              ,(229,2)
              ,(1833,2)
              ,(524,4)
              ,(1959,3)
              ,(1608,4)
              ,(1680,3)
              ,(1191,3)
              ,(245,4)
              ,(249,3)
              ,(1889,3)
              ,(1247,4)
              ,(18,3)
              ,(402,4)
              ,(1535,2)
              ,(1023,4)
              ,(1078,3)
              ,(821,3)
              ,(996,4)
              ,(506,3)
              ,(1002,4)
              ,(1155,2)
              ,(1499,2)
              ,(1410,4)
              ,(142,2)
              ,(627,4)
              ,(298,4)
              ,(1586,3)
              ,(1756,3)
              ,(1759,2)
              ,(223,4)
              ,(1510,4)
              ,(1880,4)
              ,(342,2)
              ,(528,3)
              ,(946,4)
              ,(1112,3)
              ,(122,2)
              ,(1860,3)
              ,(1804,2)
              ,(289,2)
              ,(795,4)
              ,(671,2)
              ,(55,3)
              ,(1747,3)
              ,(1559,4)
              ,(1471,3)
              ,(1321,2)
              ,(741,2)
              ,(1396,4)
              ,(395,4)
              ,(1325,2)
              ,(1052,3)
              ,(1733,2)
              ,(1947,3)
              ,(1122,2)
              ,(540,3)
              ,(213,4)
              ,(797,3)
              ,(1929,4)
              ,(199,4)
              ,(1099,3)
              ,(941,3)
              ,(1926,2)
              ,(1986,2)
              ,(854,2)
              ,(733,3)
              ,(468,4)
              ,(1976,4)
              ,(1335,4)
              ,(1584,4)
              ,(865,2)
              ,(1417,2)
              ,(1026,4)
              ,(887,3)
              ,(120,2)
              ,(364,4)
              ,(1839,3)
              ,(1183,2)
              ,(1554,2)
              ,(1443,4)
              ,(508,2)
              ,(30,3)
              ,(1557,3)
              ,(1060,4)
              ,(135,2)
              ,(964,4)
              ,(1254,2)
              ,(1478,2)
              ,(1399,2)
              ,(569,2)
              ,(1192,4)
              ,(1301,3)
              ,(1000,2)
              ,(1385,4)
              ,(548,2)
              ,(1141,4)
              ,(453,4)
              ,(1786,3)
              ,(1375,3)
              ,(113,4)
              ,(1921,2)
              ,(462,4)
              ,(590,3)
              ,(804,2)
              ,(1668,2)
              ,(1550,2)
              ,(1261,2)
              ,(62,3)
              ,(718,3)
              ,(485,3)
              ,(1300,2)
              ,(1018,2)
              ,(1493,2)
              ,(1646,3)
              ,(1741,4)
              ,(147,4)
              ,(1293,3)
              ,(1898,4)
              ,(26,2)
              ,(1697,3)
              ,(116,4)
              ,(406,3)
              ,(315,3)
              ,(1532,3)
              ,(893,2)
              ,(1040,3)
              ,(1848,2)
              ,(1694,3)
              ,(1361,3)
              ,(1780,3)
              ,(1066,4)
              ,(794,3)
              ,(1468,4)
              ,(1090,2)
              ,(874,3)
              ,(1614,2)
              ,(1527,4)
              ,(1388,3)
              ,(363,2)
              ,(1690,4)
              ,(397,2)
              ,(1883,3)
              ,(1916,2)
              ,(1501,4)
              ,(1049,4)
              ,(347,3)
              ,(1492,2)
              ,(1257,2)
              ,(1377,2)
              ,(1231,3)
              ,(1115,4)
              ,(150,4)
              ,(955,3)
              ,(879,2)
              ,(1483,4)
              ,(1012,2)
              ,(1318,4)
              ,(1525,4)
              ,(777,3)
              ,(527,3)
              ,(575,4)
              ,(1609,4)
              ,(1577,4)
              ,(905,4)
              ,(1070,2)
              ,(13,4)
              ,(1351,2)
              ,(1068,4)
              ,(593,4)
              ,(1755,3)
              ,(1234,3)
              ,(1849,3)
              ,(291,4)
              ,(1815,4)
              ,(616,2)
              ,(1942,2)
              ,(845,4)
              ,(867,2)
              ,(1051,3)
              ,(1393,2)
              ,(580,4)
              ,(760,2)
              ,(1638,3)
              ,(1401,4)
              ,(835,3)
              ,(651,3)
              ,(775,3)
              ,(54,3)
              ,(724,3)
              ,(1546,4)
              ,(197,3)
              ,(1851,4)
              ,(1494,2)
              ,(1327,2)
              ,(1813,4)
              ,(666,3)
              ,(181,4)
              ,(1845,4)
              ,(477,4)
              ,(956,3)
              ,(1307,2)
              ,(1587,3)
              ,(1920,3)
              ,(1387,4)
              ,(1533,2)
              ,(90,4)
              ,(1895,3)
              ,(280,3)
              ,(705,2)
              ,(581,2)
              ,(1707,4)
              ,(903,2)
              ,(1302,3)
              ,(411,4)
              ,(636,4)
              ,(851,4)
              ,(578,4)
              ,(1273,3)
              ,(1424,2)
              ,(103,3)
              ,(556,2)
              ,(1519,2)
              ,(7,3)
              ,(1108,4)
              ,(221,3)
              ,(38,4)
              ,(1935,4)
              ,(268,2)
              ,(326,3)
              ,(1818,2)
              ,(1863,2)
              ,(954,4)
              ,(304,2)
              ,(1126,3)
              ,(1629,2)
              ,(1194,3)
              ,(1616,4)
              ,(1206,2)
              ,(419,3)
              ,(1428,4)
              ,(1693,3)
              ,(1129,2)
              ,(339,4)
              ,(266,4)
              ,(346,4)
              ,(1870,3)
              ,(625,3)
              ,(40,4)
              ,(639,3)
              ,(1200,3)
              ,(802,4)
              ,(1654,4)
              ,(1484,4)
              ,(823,3)
              ,(1001,4)
              ,(1392,3)
              ,(483,3)
              ,(1345,2)
              ,(783,2)
              ,(66,4)
              ,(655,4)
              ,(172,3)
              ,(1050,2)
              ,(969,2)
              ,(487,2)
              ,(87,4)
              ,(1765,2)
              ,(1084,2)
              ,(762,3)
              ,(658,3)
              ,(236,3)
              ,(986,3)
              ,(324,4)
              ,(1016,4)
              ,(335,3)
              ,(987,4)
              ,(544,4)
              ,(1379,4)
              ,(872,3)
              ,(205,3)
              ,(1743,4)
              ,(1944,3)
              ,(1096,2)
              ,(1539,2)
              ,(390,2)
              ,(292,2)
              ,(1137,4)
              ,(619,3)
              ,(359,2)
              ,(510,4)
              ,(1762,4)
              ,(1583,3)
              ,(295,2)
              ,(1368,2)
              ,(1553,3)
              ,(1858,4)
              ,(938,4)
              ,(665,2)
              ,(1442,2)
              ,(1752,2)
              ,(515,3)
              ,(1162,2)
              ,(71,3)
              ,(1544,3)
              ,(1726,2)
              ,(1937,2)
              ,(1511,2)
              ,(1287,3)
              ,(190,4)
              ,(317,3)
              ,(1934,3)
              ,(490,3)
              ,(1414,2)
              ,(447,3)
              ,(1641,2)
              ,(622,2)
              ,(927,3)
              ,(44,3)
              ,(1538,2)
              ,(1987,3)
              ,(286,2)
              ,(1788,3)
              ,(1705,3)
              ,(1397,2)
              ,(108,2)
              ,(1719,3)
              ,(1219,2)
              ,(1114,4)
              ,(1825,2)
              ,(1696,3)
              ,(1659,2)
              ,(290,3)
              ,(458,3)
              ,(542,2)
              ,(1850,3)
              ,(933,3)
              ,(1214,3)
              ,(1899,4)
              ,(667,2)
              ,(125,3)
              ,(1288,2)
              ,(1165,4)
              ,(1537,4)
              ,(1359,4)
              ,(1376,4)
              ,(1884,3)
              ,(739,3)
              ,(1859,3)
              ,(1172,3)
              ,(334,4)
              ,(857,4)
              ,(558,3)
              ,(1716,3)
              ,(1620,2)
              ,(550,2)
              ,(913,2)
              ,(511,3)
              ,(1170,3)
              ,(740,4)
              ,(523,4)
              ,(1330,2)
              ,(930,4)
              ,(1103,4)
              ,(1914,2)
              ,(146,2)
              ,(1543,3)
              ,(998,3)
              ,(1563,2)
              ,(1704,4)
              ,(407,3)
              ,(101,2)
              ,(1487,4)
              ,(1365,2)
              ,(1432,3)
              ,(999,3)
              ,(81,3)
              ,(1198,2)
              ,(1364,2)
              ,(499,3)
              ,(800,3)
              ,(128,3)
              ,(1329,3)
              ,(633,3)
              ,(713,4)
              ,(216,2)
              ,(261,4)
              ,(1006,3)
              ,(1236,3)
              ,(978,4)
              ,(793,3)
              ,(1742,4)
              ,(1575,4)
              ,(392,2)
              ,(1004,2)
              ,(1485,2)
              ,(338,2)
              ,(1506,4)
              ,(1606,2)
              ,(243,3)
              ,(152,3)
              ,(896,3)
              ,(78,2)
              ,(1044,3)
              ,(1857,4)
              ,(586,3)
              ,(698,4)
              ,(1380,3)
              ,(459,2)
              ,(1065,4)
              ,(1908,4)
              ,(1440,4)
              ,(154,3)
              ,(1148,4)
              ,(1900,4)
              ,(726,2)
              ,(770,3)
              ,(1480,2)
              ,(1567,4)
              ,(1656,4)
              ,(420,2)
              ,(659,2)
              ,(1346,4)
              ,(255,4)
              ,(1111,3)
              ,(84,2)
              ,(1960,2)
              ,(1613,2)
              ,(463,2)
              ,(272,4)
              ,(344,4)
              ,(1500,4)
              ,(1063,2)
              ,(489,3)
              ,(1949,2)
              ,(1019,2)
              ,(337,4)
              ,(409,4)
              ,(210,4)
              ,(1552,3)
              ,(405,2)
              ,(208,3)
              ,(111,3)
              ,(1783,2)
              ,(270,2)
              ,(1057,4)
              ,(14,4)
              ,(1159,3)
              ,(52,2)
              ,(1842,4)
              ,(563,3)
              ,(1807,3)
              ,(735,2)
              ,(1358,2)
              ,(717,4)
              ,(1514,2)
              ,(1470,3)
              ,(1798,2)
              ,(293,3)
              ,(701,4)
              ,(207,4)
              ,(963,2)
              ,(1946,4)
              ,(1518,2)
              ,(1182,2)
              ,(253,3)
              ,(1138,4)
              ,(235,4)
              ,(139,3)
              ,(1592,4)
              ,(323,3)
              ,(118,4)
              ,(1334,4)
              ,(92,2)
              ,(1999,4)
              ,(1691,2)
              ,(744,4)
              ,(140,3)
              ,(1871,3)
              ,(1175,2)
              ,(975,3)
              ,(1398,4)
              ,(1153,2)
              ,(1457,4)
              ,(890,2)
              ,(1210,4)
              ,(866,4)
              ,(430,2)
              ,(457,3)
              ,(176,2)
              ,(1421,3)
              ,(732,2)
              ,(469,2)
              ,(137,2)
              ,(669,3)
              ,(1713,4)
              ,(1877,3)
              ,(1675,3)
              ,(1134,2)
              ,(143,4)
              ,(99,3)
              ,(574,2)
              ,(1530,4)
              ,(1739,4)
              ,(28,3)
              ,(1489,3)
              ,(251,3)
              ,(1110,4)
              ,(1404,3)
              ,(640,4)
              ,(1054,2)
              ,(1310,3)
              ,(1970,2)
              ,(299,3)
              ,(1536,4)
              ,(1037,4)
              ,(164,3)
              ,(1632,4)
              ,(1452,3)
              ,(427,2)
              ,(1332,4)
              ,(361,3)
              ,(1158,3)
              ,(925,4)
              ,(1323,3)
              ,(370,2)
              ,(1623,3)
              ,(1357,3)
              ,(482,4)
              ,(1240,4)
              ,(265,4)
              ,(1619,3)
              ,(1221,2)
              ,(1712,3)
              ,(1816,3)
              ,(1029,3)
              ,(1262,3)
              ,(310,2)
              ,(48,2)
              ,(1185,4)
              ,(428,3)
              ,(114,4)
              ,(1722,4)
              ,(1551,4)
              ,(644,4)
              ,(626,4)
              ,(43,2)
              ,(1400,4)
              ,(319,2)
              ,(456,2)
              ,(1678,3)
              ,(1005,2)
              ,(354,4)
              ,(648,3)
              ,(1229,3)
              ,(1622,4)
              ,(29,2)
              ,(1193,4)
              ,(1903,3)
              ,(711,3)
              ,(1105,3)
              ,(1744,4)
              ,(720,3)
              ,(1571,3)
              ,(983,3)
              ,(362,2)
              ,(786,4)
              ,(1724,4)
              ,(646,3)
              ,(571,2)
              ,(798,3)
              ,(209,4)
              ,(1701,3)
              ,(228,4)
              ,(1560,4)
              ,(156,3)
              ,(678,4)
              ,(583,4)
              ,(320,3)
              ,(1305,4)
              ,(1268,3)
              ,(1308,4)
              ,(1250,3)
              ,(1034,4)
              ,(838,4)
              ,(1978,2)
              ,(65,4)
              ,(1806,3)
              ,(1822,2)
              ,(566,2)
              ,(1663,2)
              ,(1101,3)
              ,(1774,3)
              ,(1886,2)
              ,(751,4)
              ,(1709,4)
              ,(1439,2)
              ,(530,3)
              ,(1102,4)
              ,(1042,2)
              ,(766,3)
              ,(1846,4)
              ,(355,3)
              ,(145,2)
              ,(1695,2)
              ,(1626,4)
              ,(926,4)
              ,(1121,2)
              ,(162,3)
              ,(1425,4)
              ,(1356,3)
              ,(1787,4)
              ,(20,2)
              ,(803,2)
              ,(1513,4)
              ,(1072,2)
              ,(576,2)
              ,(984,2)
              ,(829,2)
              ,(1205,4)
              ,(1075,3)
              ,(1069,2)
              ,(466,3)
              ,(1930,4)
              ,(1226,3)
              ,(1252,4)
              ,(1974,3)
              ,(348,2)
              ,(441,4)
              ,(366,2)
              ,(1809,3)
              ,(134,3)
              ,(1151,4)
              ,(757,3)
              ,(1604,2)
              ,(450,2)
              ,(234,3)
              ,(756,4)
              ,(787,2)
              ,(1784,3)
              ,(1785,4)
              ,(722,2)
              ,(846,4)
              ,(790,2)
              ,(631,2)
              ,(1799,4)
              ,(1168,2)
              ,(960,2)
              ,(731,2)
              ,(1071,2)
              ,(1381,3)
              ,(1802,4)
              ,(422,3)
              ,(1041,2)
              ,(27,2)
              ,(377,2)
              ,(992,2)
              ,(1265,4)
              ,(1246,2)
              ,(1874,4)
              ,(1796,4)
              ,(759,2)
              ,(51,4)
              ,(981,2)
              ,(755,3)
              ,(1761,3)
              ,(781,4)
              ,(997,2)
              ,(1228,2)
              ,(1409,3)
              ,(1353,4)
              ,(1152,4)
              ,(1945,3)
              ,(1370,2)
              ,(356,3)
              ,(421,4)
              ,(1317,2)
              ,(974,4)
              ,(21,3)
              ,(1438,4)
              ,(24,3)
              ,(1617,4)
              ,(827,2)
              ,(1911,3)
              ,(1790,2)
              ,(818,2)
              ,(1720,4)
              ,(1556,2)
              ,(1867,3)
              ,(1402,2)
              ,(399,3)
              ,(538,3)
              ,(1444,2)
              ,(932,4)
              ,(1647,2)
              ,(638,3)
              ,(577,2)
              ,(110,3)
              ,(285,3)
              ,(1993,2)
              ,(1522,4)
              ,(1631,4)
              ,(1118,2)
              ,(132,3)
              ,(1648,4)
              ,(1413,4)
              ,(1852,4)
              ,(1373,3)
              ,(303,2)
              ,(1962,2)
              ,(686,4)
              ,(1936,4)
              ,(1692,2)
              ,(1080,2)
              ,(1086,3)
              ,(1905,2)
              ,(1621,3)
              ,(385,3)
              ,(1980,3)
              ,(1498,4)
              ,(15,3)
              ,(138,2)
              ,(117,4)
              ,(1391,4)
              ,(1215,2)
              ,(848,2)
              ,(1703,3)
              ,(1979,2)
              ,(881,3)
              ,(1630,2)
              ,(1819,4)
              ,(404,2)
              ,(935,2)
              ,(408,2)
              ,(888,4)
              ,(1565,4)
              ,(1749,3)
              ,(318,2)
              ,(1652,3)
              ,(1547,3)
              ,(1603,3)
              ,(1958,2)
              ,(212,3)
              ,(112,3)
              ,(1363,3)
              ,(594,4)
              ,(1477,4)
              ,(1187,2)
              ,(521,2)
              ,(541,2)
              ,(5,4)
              ,(1324,4)
              ,(1188,2)
              ,(546,4)
              ,(83,4)
              ,(282,2)
              ,(460,2)
              ,(1166,2)
              ,(1669,4)
              ,(1427,3)
              ,(1562,4)
              ,(561,2)
              ,(10,4)
              ,(1971,2)
              ,(1789,4)
              ,(182,4)
              ,(365,3)
              ,(1777,4)
              ,(807,2)
              ,(1625,4)
              ,(1010,2)
              ,(438,4)
              ,(547,2)
              ,(1235,3)
              ,(555,2)
              ,(1222,4)
              ,(1677,2)
              ,(914,2)
              ,(1319,4)
              ,(959,3)
              ,(1605,4)
              ,(613,2)
              ,(1030,4)
              ,(965,3)
              ,(690,3)
              ,(1447,4)
              ,(1017,2)
              ,(1142,3)
              ,(1651,3)
              ,(977,4)
              ,(73,2)
              ,(472,4)
              ,(19,3)
              ,(144,3)
              ,(1955,2)
              ,(858,4)
              ,(2000,4)
              ,(1031,2)
              ,(1211,3)
              ,(215,2)
              ,(34,2)
              ,(1840,2)
              ,(822,4)
              ,(910,2)
              ,(1681,3)
              ,(847,3)
              ,(1769,4)
              ,(1136,2)
              ,(1349,3)
              ,(900,2)
              ,(1836,3)
              ,(1876,3)
              ,(1140,4)
              ,(1095,3)
              ,(1067,2)
              ,(898,4)
              ,(767,4)
              ,(1128,3)
              ,(1284,4)
              ,(871,2)
              ,(962,3)
              ,(1794,2)
              ,(774,2)
              ,(203,4)
              ,(833,3)
              ,(1336,2)
              ,(413,4)
              ,(283,4)
              ,(1612,4)
              ,(971,3)
              ,(624,4)
              ,(88,4)
              ,(279,4)
              ,(1545,3)
              ,(82,4)
              ,(602,4)
              ,(944,4)
              ,(942,3)
              ,(1507,2)
              ,(1812,2)
              ,(765,2)
              ,(446,4)
              ,(859,3)
              ,(241,3)
              ,(325,3)
              ,(810,4)
              ,(1476,2)
              ,(1077,2)
              ,(876,2)
              ,(1326,3)
              ,(376,3)
              ,(716,2)
              ,(500,3)
              ,(1348,4)
              ,(1157,4)
              ,(123,3)
              ,(582,3)
              ,(332,4)
              ,(461,2)
              ,(17,3)
              ,(1497,2)
              ,(124,4)
              ,(517,4)
              ,(1998,3)
              ,(1020,2)
              ,(657,4)
              ,(497,2)
              ,(219,3)
              ,(1474,2)
              ,(452,3)
              ,(1953,3)
              ,(1904,4)
              ,(1328,4)
              ,(1279,2)
              ,(864,4)
              ,(758,2)
              ,(1670,2)
              ,(1967,2)
              ,(1660,4)
              ,(1933,2)
              ,(1056,2)
              ,(784,2)
              ,(1573,3)
              ,(329,4)
              ,(1435,2)
              ,(1598,3)
              ,(1594,4)
              ,(1342,4)
              ,(662,4)
              ,(1083,3)
              ,(1251,4)
              ,(920,2)
              ,(843,4)
              ,(1737,2)
              ,(1714,2)
              ,(260,4)
              ,(1264,2)
              ,(1896,3)
              ,(204,3)
              ,(1408,2)
              ,(1658,3)
              ,(278,4)
              ,(1384,3)
              ,(423,4)
              ,(736,4)
              ,(1339,3)
              ,(493,4)
              ,(668,4)
              ,(1611,4)
              ,(877,4)
              ,(1580,4)
              ,(1,2)
              ,(1174,4)
              ,(194,2)
              ,(1760,2)
              ,(417,2)
              ,(36,4)
              ,(520,3)
              ,(761,3)
              ,(1448,4)
              ,(308,3)
              ,(715,3)
              ,(76,2)
              ,(1725,3)
              ,(1286,3)
              ,(1516,2)
              ,(1827,3)
              ,(161,2)
              ,(211,2)
              ,(617,3)
              ,(59,4)
              ,(1682,3)
              ,(1272,2)
              ,(1233,3)
              ,(1890,2)
              ,(1201,4)
              ,(529,3)
              ,(697,3)
              ,(918,3)
              ,(1173,3)
              ,(1729,4)
              ,(306,4)
              ,(1753,2)
              ,(737,4)
              ,(742,2)
              ,(1256,4)
              ,(1033,4)
              ,(1893,2)
              ,(923,3)
              ,(1490,4)
              ,(908,2)
              ,(173,3)
              ,(1593,2)
              ,(1831,3)
              ,(1590,4)
              ,(1303,2)
              ,(193,4)
              ,(1294,2)
              ,(1144,3)
              ,(653,2)
              ,(1150,3)
              ,(192,2)
              ,(1931,3)
              ,(187,3)
              ,(1164,2)
              ,(1149,2)
              ,(433,4)
              ,(637,4)
              ,(1969,3)
              ,(1082,3)
              ,(186,3)
              ,(840,3)
              ,(1032,4)
              ,(780,2)
              ,(269,2)
              ,(1711,2)
              ,(98,4)
              ,(474,2)
              ,(687,3)
              ,(1021,3)
              ,(505,4)
              ,(1943,2)
              ,(929,4)
              ,(1276,4)
              ,(1295,2)
              ,(185,2)
              ,(1467,3)
              ,(1994,3)
              ,(131,3)
              ,(873,2)
              ,(160,3)
              ,(1912,4)
              ,(387,4)
              ,(1238,4)
              ,(188,3)
              ,(1868,2)
              ,(1702,2)
              ,(284,4)
              ,(1352,2)
              ,(1269,3)
              ,(276,4)
              ,(1820,2)
              ,(1824,3)
              ,(394,2)
              ,(349,2)
              ,(183,4)
              ,(745,2)
              ,(982,2)
              ,(1793,4)
              ,(218,2)
              ,(1220,3)
              ,(1995,2)
              ,(32,2)
              ,(37,2)
              ,(313,4)
              ,(654,4)
              ,(217,2)
              ,(1966,3)
              ,(259,2)
              ,(588,3)
              ,(832,2)
              ,(1446,2)
              ,(688,2)
              ,(1315,3)
              ,(1120,2)
              ,(1253,2)
              ,(1322,3)
              ,(677,4)
              ,(79,2)
              ,(614,2)
              ,(1271,4)
              ,(400,3)
              ,(1107,2)
              ,(841,4)
              ,(351,4)
              ,(97,3)
              ,(708,2)
              ,(175,4)
              ,(1823,3)
              ,(649,2)
              ,(252,3)
              ,(89,3)
              ,(1844,2)
              ,(1515,2)
              ,(1837,4)
              ,(820,3)
              ,(246,2)
              ,(1636,3)
              ,(1338,3)
              ,(1878,3)
              ,(1948,3)
              ,(1232,3)
              ,(1176,4)
              ,(1521,4)
              ,(1058,3)
              ,(80,3)
              ,(121,3)
              ,(1416,3)
              ,(728,4)
              ,(1732,4)
              ,(1879,3)
              ,(412,4)
              ,(1662,4)
              ,(1938,4)
              ,(155,2)
              ,(601,3)
              ,(130,3)
              ,(473,3)
              ,(1666,4)
              ,(368,4)
              ,(415,2)
              ,(240,3)
              ,(1014,3)
              ,(545,3)
              ,(632,2)
              ,(1866,3)
              ,(1186,3)
              ,(1776,4)
              ,(967,2)
              ,(126,2)
              ,(641,3)
              ,(647,3)
              ,(189,3)
              ,(1524,4)
              ,(863,2)
              ,(382,4)
              ,(1125,3)
              ,(1139,3)
              ,(1242,4)
              ,(727,2)
              ,(1415,2)
              ,(990,3)
              ,(1650,2)
              ,(41,3)
              ,(734,4)
              ,(77,3)
              ,(1098,3)
              ,(311,4)
              ,(852,4)
              ,(250,4)
              ,(1644,4)
              ,(1686,2)
              ,(484,4)
              ,(1131,3)
              ,(1117,2)
              ,(1113,2)
              ,(892,4)
              ,(1076,3)
              ,(1073,2)
              ,(537,4)
              ,(1771,2)
              ,(263,3)
              ,(1829,3)
              ,(1297,2)
              ,(353,2)
              ,(232,3)
              ,(976,3)
              ,(1429,2)
              ,(1263,2)
              ,(1181,4)
              ,(1772,4)
              ,(953,3)
              ,(9,2)
              ,(85,4)
              ,(1015,2)
              ,(274,3)
              ,(799,2)
              ,(1618,4)
              ,(700,2)
              ,(1025,3)
              ,(1841,3)
              ,(1683,2)
              ,(916,2)
              ,(442,2)
              ,(1223,3)
              ,(340,2)
              ,(1855,3)
              ,(46,4)
              ,(1059,2)
              ,(1721,4)
              ,(789,2)
              ,(373,4)
              ,(1460,2)
              ,(273,3)
              ,(1298,3)
              ,(238,2)
              ,(45,3)
              ,(746,2)
              ,(1360,4)
              ,(1633,2)
              ,(95,3)
              ,(849,2)
              ,(924,4)
              ,(1847,4)
              ,(557,2)
              ,(35,2)
              ,(635,4)
              ,(684,4)
              ,(1350,3)
              ,(157,2)
              ,(656,3)
              ,(1509,3)
              ,(1267,3)
              ,(1523,2)
              ,(1730,2)
              ,(670,2)
              ,(1706,4)
              ,(1902,4)
              ,(1266,4)
              ,(1746,4)
              ,(1437,3)
              ,(287,2)
              ,(721,2)
              ,(973,3)
              ,(1087,3)
              ,(1245,4)
              ,(281,3)
              ,(8,4)
              ,(1764,4)
              ,(1203,3)
              ,(1665,4)
              ,(1591,2)
              ,(1147,4)
              ,(525,2)
              ,(672,2)
              ,(1355,2)
              ,(1869,3)
              ,(1412,4)
              ,(3,4)
              ,(695,3)
              ,(67,4)
              ,(816,2)
              ,(1723,4)
              ,(1856,3)
              ,(811,4)
              ,(383,3)
              ,(1853,3)
              ,(1196,4)
              ,(184,2)
              ,(222,3)
              ,(993,3)
              ,(860,4)
              ,(1208,2)
              ,(749,4)
              ,(1795,2)
              ,(1024,2)
              ,(961,3)
              ,(1932,2)
              ,(1894,2)
              ,(275,3)
              ,(56,2)
              ,(1244,3)
              ,(448,2)
              ,(1727,4)
              ,(200,3)
              ,(1923,3)
              ,(663,4)
              ,(1341,2)
              ,(504,3)
              ,(597,4)
              ,(478,3)
              ,(1520,3)
              ,(149,2)
              ,(1973,2)
              ,(445,4)
              ,(336,2)
              ,(605,3)
              ,(1800,4)
              ,(949,2)
              ,(248,4)
              ,(1046,3)
              ,(195,3)
              ,(1464,3)
              ,(2,4)
              ,(68,3)
              ,(426,3)
              ,(1572,4)
              ,(451,2)
              ,(1449,3)
              ,(1961,3)
              ,(1750,2)
              ,(1891,3)
              ,(1055,4)
              ,(570,4)
              ,(1061,2)
              ,(1803,3)
              ,(560,2)
              ,(1482,4)
              ,(501,4)
              ,(1275,3)
              ,(503,4)
              ,(1038,2)
              ,(1811,4)
              ,(839,2)
              ,(1441,2)
              ,(776,3)
              ,(314,4)
              ,(70,2)
              ,(1314,2)
              ,(443,4)
              ,(681,3)
              ,(1964,2)
              ,(507,2)
              ,(1597,4)
              ,(1688,2)
              ,(1915,2)
              ,(1797,2)
              ,(301,3)
              ,(174,2)
              ,(812,2)
              ,(1531,3)
              ,(1643,3)
              ,(1274,3)
              ,(1956,4)
              ,(1534,3)
              ,(267,4)
              ,(1906,4)
              ,(159,4)
              ,(534,4)
              ,(381,2)
              ,(39,4)
              ,(940,2)
              ,(1710,2)
              ,(277,4)
              ,(1996,4)
              ,(403,4)
              ,(788,4)
              ,(855,4)
              ,(1389,4)
              ,(645,3)
              ,(1671,2)
              ,(1161,3)
              ,(333,2)
              ,(1146,3)
              ,(1171,2)
              ,(573,2)
              ,(609,2)
              ,(1653,3)
              ,(16,4)
              ,(1674,2)
              ,(384,4)
              ,(950,3)
              ,(105,2)
              ,(476,4)
              ,(1466,3)
              ,(1873,4)
              ,(153,2)
              ,(129,4)
              ,(1965,2)
              ,(628,2)
              ,(652,4)
              ,(1821,3)
              ,(106,3)
              ,(1637,4)
              ,(664,3)
              ,(536,2)
              ,(1685,4)
              ,(825,3)
              ,(1143,2)
              ,(513,3)
              ,(352,3)
              ,(870,3)
              ,(1502,3)
              ,(1092,4)
              ,(643,4)
              ,(1885,4)
              ,(886,2)
              ,(1320,3)
              ,(875,3)
              ,(1064,2)
              ,(1640,3)
              ,(244,4)
              ,(991,4)
              ,(1495,3)
              ,(1589,2)
              ,(1130,4)
              ,(885,3)
              ,(1864,3)
              ,(1814,2)
              ,(1854,3)
              ,(768,4)
              ,(1997,3)
              ,(968,4)
              ,(1465,4)
              ,(1528,4)
              ,(360,3)
              ,(1745,3)
              ,(1462,4)
              ,(778,2)
              ,(167,3)
              ,(1434,4)
              ,(685,2)
              ,(931,4)
              ,(693,3)
              ,(226,4)
              ,(691,4)
              ,(1576,3)
              ,(707,4)
              ,(621,2)
              ,(1503,2)
              ,(1748,4)
              ,(1655,3)
              ,(1925,2)
              ,(1569,2)
              ,(1600,2)
              ,(1564,4)
              ,(1403,3)
              ,(553,4)
              ,(1278,2)
              ,(1758,2)
              ,(1469,4)
              ,(861,2)
              ,(951,4)
              ,(532,2)
              ,(1094,4)
              ,(6,3)
              ,(1661,4)
              ,(785,4)
              ,(1022,4)
              ,(237,3)
              ,(894,2)
              ,(1216,3)
              ,(1195,2)
              ,(719,3)
              ,(502,3)
              ,(93,3)
              ,(1344,2)
              ,(660,2)
              ,(429,2)
              ,(1887,4)
              ,(1963,3)
              ,(869,2)
              ,(907,4)
              ,(689,4)
              ,(906,3)
              ,(1459,3)
              ,(599,2)
              ,(1135,4)
              ,(680,2)
              ,(842,2)
              ,(1779,2)
              ,(704,3)
              ,(350,2)
              ,(1277,2)
              ,(31,2)
              ,(1306,3)
              ,(1197,2)
              ,(1907,2)
              ,(434,3)
              ,(494,2)
              ,(714,2)
              ,(1039,4)
              ,(1395,3)
              ,(42,2)
              ,(897,2)
              ,(1940,2)
              ,(1331,2)
              ,(1354,4)
              ,(141,2)
              ,(937,3)
              ,(1420,4)
              ,(1635,3)
              ,(1687,2)
              ,(1738,4)
              ,(61,2)
              ,(533,3)
              ,(610,4)
              ,(1950,4)
              ,(748,3)
              ,(1097,3)
              ,(904,3)
              ,(257,4)
              ,(1045,2)
              ,(1433,3)
              ,(1224,3)
              ,(328,2)
              ,(1529,2)
              ,(1990,4)
              ,(401,2)
              ,(579,2)
              ,(791,3)
              ,(1340,3)
              ,(393,4)
              ,(947,2)
              ,(1981,2)
              ,(168,3)
              ,(302,3)
              ,(418,3)
              ,(1291,3)
              ,(1649,4)
              ,(771,3)
              ,(374,2)
              ,(819,4)
              ,(1488,2)
              ,(772,3)
              ,(1116,3)
              ,(826,3)
              ,(1826,4)
              ,(1127,3)
              ,(386,3)
              ,(831,2)
              ,(177,3)
              ,(486,3)
              ,(607,3)
              ,(148,3)
              ,(1667,3)
              ,(498,2)
              ,(47,2)
              ,(4,3)
              ,(1928,4)
              ,(1624,2)
              ,(1927,3)
              ,(1909,4)
              ,(1881,3)
              ,(1972,2)
              ,(1526,3)
              ,(1801,4)
              ,(1047,4)
              ,(1977,2)
              ,(1454,2)
              ,(939,3)
              ,(1835,3)
              ,(22,4)
              ,(305,4)
              ,(634,2)
              ,(1386,2)
              ,(1204,3)
              ,(1517,2)
              ,(1992,4)
              ,(74,3)
              ,(1579,3)
              ,(358,2)
              ,(1383,2)
              ,(911,4)
              ,(526,4)
              ,(115,2)
              ,(1792,2)
              ,(1676,2)
              ,(1309,3)
              ,(989,4)
              ,(1378,2)
              ,(294,4)
              ,(321,2)
              ,(1109,4)
              ,(934,2)
              ,(1882,3)
              ,(1423,4)
              ,(1924,2)
              ,(584,3)
              ,(985,4)
              ,(171,2)
              ,(1418,3)
              ,(1968,2)
              ,(1237,4)
              ,(764,4)
              ,(1791,3)
              ,(1734,4)
              ,(239,4)
              ,(519,4)
              ,(1430,4)
              ,(604,3)
              ,(158,2)
              ,(901,2)
              ,(1085,4)
              ,(615,4)
              ,(899,3)
              ,(1036,4)
              ,(1875,4)
              ,(856,2)
              ,(712,3)
              ,(1736,4)
              ,(1872,3)
              ,(1411,3)
              ,(1230,4)
              ,(808,4)
              ,(1830,4)
              ,(1548,3)
              ,(49,3)
              ,(675,2)
              ,(1178,3)
              ,(309,3)
              ,(1717,3)
              ,(1708,3)
              ,(1367,3)
              ,(391,4)
              ,(1461,3)
              ,(1177,2)
              ,(296,4)
              ,(1093,3)
              ,(1156,4)
              ,(966,3)
              ,(1290,4)
              ,(1767,2)
              ,(491,3)
              ,(380,2)
              ,(1982,4)
              ,(1285,2)
              ,(883,4)
              ,(432,3)
              ,(102,2)
              ,(1615,3)
              ,(1079,4)
              ,(1048,2)
              ,(1766,2)
              ,(1689,2)
              ,(994,3)
              ,(496,4)
              ,(1578,3)
              ,(769,2)
              ,(119,3)
              ,(1316,2)
              ,(1394,2)
              ,(297,4)
              ,(1718,4)
              ,(369,4)
              ,(367,2)
              ,(723,3)
              ,(300,4)
              ,(127,3)
              ,(1582,3)
              ,(1013,4)
              ,(1679,4)
              ,(471,4)
              ,(1700,3)
              ,(1445,4)
              ,(1561,2)
              ,(424,2)
              ,(1028,3)
              ,(1781,2)
              ,(379,2)
              ,(948,3)
              ,(889,4)
              ,(814,2)
              ,(454,2)
              ,(1184,3)
              ,(1255,3)
              ,(1715,3)
              ,(1699,2)
              ,(679,4)
              ,(809,3)
              ,(1808,2)
              ,(1304,2)
              ,(1639,3)
              ,(612,3)
              ,(53,3)
              ,(743,3)
              ,(1282,4)
              ,(1642,4)
              ,(1763,4)
              ,(522,2)
              ,(1672,3)
              ,(1585,3)
              ,(773,4)
              ,(1133,4)
              ,(754,4)
              ,(676,2)
              ,(104,2)
              ,(440,2)
              ,(792,3)
              ,(107,4)
              ,(1951,2)
              ,(729,2)
              ,(1475,3)
              ,(1299,3)
              ,(425,4)
              ,(642,4)
              ,(988,3)
              ,(231,2)
              ,(1731,3)
              ,(630,3)
              ,(1773,2)
              ,(1496,3)
              ,(830,3)
              ,(436,4)
              ,(396,2)
              ,(1581,2)
              ,(834,3)
              ,(163,2)
              ,(850,4)
              ,(372,4)
              ,(1939,2)
              ,(1081,3)
              ,(837,4)
              ,(225,3)
              ,(650,3)
              ,(1954,4)
              ,(606,2)
              ,(706,2)
              ,(1369,4)
              ,(179,4)
              ,(1568,4)
              ,(1007,3)
              ,(439,3)
              ,(1984,3)
              ,(562,2)
              ,(696,3)
              ,(880,4)
              ,(330,3)
              ,(815,2)
              ,(531,4)
              ,(165,2)
              ,(1154,3)
              ,(1757,2)
              ,(151,4)
              ,(868,4)
              ,(970,2)
              ,(1558,3)
              ,(1861,2)
              ,(1249,2)
              ,(72,3)
              ,(57,4)
              ,(271,3)
              ,(912,2)
              ,(1088,3)
              ,(694,3)
              ,(567,3)
              ,(891,4)
              ,(709,2)
              ,(738,3)
              ,(972,3)
              ,(1213,4)
              ,(1145,2)
              ,(1374,3)
              ,(343,4)
              ,(410,4)
              ,(958,2)
              ,(1599,2)
              ,(629,4)
              ,(256,4)
              ,(806,3)
              ,(1728,4)
              ,(133,4)
              ,(917,3)
              ,(75,2)
              ,(603,3)
              ,(683,3)
              ,(1243,3)
              ,(1917,2)
              ,(1782,2)
              ,(414,3)
              ,(202,3)
              ,(747,3)
              ,(416,3)
              ,(862,2)
              ,(1167,2)
              ,(952,3)
              ,(1901,2)
              ,(1011,3)
              ,(1684,3)
              ,(1180,2)
              ,(1259,2)
              ,(1463,4)
              ,(100,3)
              ,(1406,2)
              ,(1673,4)
              ,(470,4)
              ,(1035,4)
              ,(516,4)
              ,(60,4)
              ,(247,3)
              ,(1212,3)
              ,(1988,3)
              ,(201,2)
              ,(431,4)
              ,(475,2)
              ,(1333,2)
              ,(327,2)
              ,(1486,4)
              ,(945,2)
              ,(1601,2)
              ,(518,2)
              ,(1405,3)
              ,(233,4)
              ,(1124,4)
              ,(551,2)
              ,(388,4)
              ,(1645,4)
              ,(1596,3)
              ,(230,2)
              ,(1260,4)
              ,(1458,2)
              ,(1664,2)
              ,(1922,3)
              ,(33,4)
              ,(481,3)
              ,(824,4)
              ,(1366,2)
              ,(1123,2)
              ,(674,4)
              ,(1179,3)
              ,(957,4)
              ,(661,3)
              ,(1570,4)
              ,(853,3)
              ,(1481,2)
              ,(535,2)
              ,(1838,2)
              ,(1770,3)
              ,(435,4)
              ,(752,4)
              ,(611,2)
              ,(1422,3)
              ,(63,2)
              ,(928,2)
              ,(1512,3)
              ,(375,4)
              ,(782,3)
              ,(813,4)
              ,(1473,4)
              ,(564,3)
              ,(1281,4)
              ,(592,4)
              ,(796,2)
              ,(1810,4)
              ,(341,2)
              ,(455,4)
              ,(1768,3)
              ,(11,2)
              ,(495,4)
              ,(58,2)
              ,(909,3)
              ,(1843,2)
              ,(1862,4)
              ,(166,2)
              ,(180,4)
              ,(136,4)
              ,(1989,2)
              ,(480,2)
              ,(702,2)
              ,(467,3)
              ,(23,3)
              ,(1957,2)
              ,(682,4)
              ,(465,2)
              ,(258,2)
              ,(1337,2);

              CREATE TABLE IF NOT EXISTS Attributes (
                AttributeID int(11) NOT NULL auto_increment,
                AttributeName varchar(50),
                AttributeDescription varchar(200),
                AttributeType int(5),
                lft int(11) NOT NULL,
                rght int(11) NOT NULL,
                PRIMARY KEY(AttributeID));

                INSERT INTO Attributes (AttributeName, AttributeType, AttributeDescription, AttributeIcon) VALUES
                ('Retail/Industrial', 1, 'This location is ideal for retail use.', 'fas fa-store-alt'),
                ('Office/Industrial', 1, 'This location is ideal for office use.', 'fas fa-building'),
                ('Industrial', 1, 'This location is ideal for industrial use.', 'fa fa-industry'),
                ('Yard', 2, 'This location has an exterior yard.', 'fas fa-tree'),
                ('Fencing', 2, 'This location has an outdoor fenced area.', 'fa fa-chain'),
                ('Loading Dock', 2, 'This location has a loading dock and bay doors, perfect for moving Indiana and out.', 'fa fa-truck'),
                ('Floor Drains', 2, 'This location has indoor floor drains.', 'fas fa-shower'),
                ('Sprinkler', 2, '', 'fa fa-fire-extinguisher'),
                ('Bathroom', 2, '', 'fas fa-toilet-paper'),
                ('Customizable', 2, '', 'fas fa-cogs'),
                ('Power', 2, '', 'fas fa-battery-full'),
                ('Crane', 2, '', ''),
                ('Mezzanine', 2, '', ''),
                ('Kitchen', 2, '', 'fa fa-cutlery'),
                ('Air Conditioning', 2, '', 'fa fa-snowflake-o'),
                ('Security', 2, '', 'fa fa-lock'),
                ('Auto Service', 2, '', 'fas fa-wrench');


                INSERT INTO Space_Attributes(SpaceID,AttributeID) VALUES
                (1,2)
                ,(2,2)
                ,(3,2)
                ,(4,2)
                ,(5,3)
                ,(6,3)
                ,(7,2)
                ,(8,1)
                ,(9,3)
                ,(10,3)
                ,(11,3)
                ,(12,3)
                ,(13,2)
                ,(14,2)
                ,(15,2)
                ,(16,2)
                ,(17,1)
                ,(18,3)
                ,(19,2)
                ,(20,2)
                ,(21,2)
                ,(22,2)
                ,(23,3)
                ,(24,1)
                ,(25,1)
                ,(26,2)
                ,(27,3)
                ,(28,1)
                ,(29,3)
                ,(30,2)
                ,(31,1)
                ,(32,3)
                ,(33,2)
                ,(34,2)
                ,(35,1)
                ,(36,2)
                ,(37,2)
                ,(38,3)
                ,(39,2)
                ,(40,2)
                ,(41,2)
                ,(42,2)
                ,(43,2)
                ,(44,3)
                ,(45,3)
                ,(46,2)
                ,(47,2)
                ,(48,2)
                ,(49,2)
                ,(50,2)
                ,(51,2)
                ,(52,3)
                ,(53,3)
                ,(54,3)
                ,(55,3)
                ,(56,3)
                ,(57,1)
                ,(58,1)
                ,(59,2)
                ,(60,3)
                ,(61,3)
                ,(62,3)
                ,(63,1)
                ,(64,1)
                ,(65,2)
                ,(66,1)
                ,(67,2)
                ,(68,1)
                ,(69,1)
                ,(70,1)
                ,(71,3)
                ,(72,1)
                ,(73,1)
                ,(74,1)
                ,(75,2)
                ,(76,2)
                ,(77,2)
                ,(78,3)
                ,(79,1)
                ,(80,2)
                ,(81,3)
                ,(82,2)
                ,(83,1)
                ,(84,3)
                ,(85,1)
                ,(86,1)
                ,(87,1)
                ,(88,2)
                ,(89,1)
                ,(90,1)
                ,(91,1)
                ,(92,2)
                ,(93,3)
                ,(94,2)
                ,(95,3)
                ,(96,3)
                ,(97,3)
                ,(98,2)
                ,(99,1)
                ,(100,2)
                ,(101,1)
                ,(102,2)
                ,(103,2)
                ,(104,2)
                ,(105,2)
                ,(106,1)
                ,(107,2)
                ,(108,3)
                ,(109,1)
                ,(110,2)
                ,(111,2)
                ,(112,3)
                ,(113,2)
                ,(114,2)
                ,(115,2)
                ,(116,2)
                ,(117,2)
                ,(118,3)
                ,(119,1)
                ,(120,1)
                ,(121,3)
                ,(122,3)
                ,(123,2)
                ,(124,1)
                ,(125,2)
                ,(126,2)
                ,(127,3)
                ,(128,2)
                ,(129,2)
                ,(130,3)
                ,(131,1)
                ,(132,3)
                ,(133,2)
                ,(134,2)
                ,(135,3)
                ,(136,1)
                ,(137,2)
                ,(138,2)
                ,(139,1)
                ,(140,1)
                ,(141,2)
                ,(142,2)
                ,(143,3)
                ,(144,2)
                ,(145,1)
                ,(146,3)
                ,(147,1)
                ,(148,2)
                ,(149,1)
                ,(150,2)
                ,(151,2)
                ,(152,2)
                ,(153,1)
                ,(154,1)
                ,(155,1)
                ,(156,2)
                ,(157,3)
                ,(158,2)
                ,(159,3)
                ,(160,2)
                ,(161,2)
                ,(162,1)
                ,(163,1)
                ,(164,3)
                ,(165,2)
                ,(166,2)
                ,(167,1)
                ,(168,1)
                ,(169,2)
                ,(170,1)
                ,(171,1)
                ,(172,2)
                ,(173,3)
                ,(174,1)
                ,(175,2)
                ,(176,2)
                ,(177,1)
                ,(178,1)
                ,(179,3)
                ,(180,3)
                ,(181,3)
                ,(182,3)
                ,(183,1)
                ,(184,1)
                ,(185,1)
                ,(186,3)
                ,(187,2)
                ,(188,3)
                ,(189,3)
                ,(190,2)
                ,(191,2)
                ,(192,2)
                ,(193,3)
                ,(194,1)
                ,(195,2)
                ,(196,2)
                ,(197,3)
                ,(198,3)
                ,(199,2)
                ,(200,1)
                ,(201,1)
                ,(202,3)
                ,(203,2)
                ,(204,3)
                ,(205,2)
                ,(206,1)
                ,(207,3)
                ,(208,1)
                ,(209,2)
                ,(210,1)
                ,(211,2)
                ,(212,2)
                ,(213,3)
                ,(214,1)
                ,(215,2)
                ,(216,1)
                ,(217,1)
                ,(218,2)
                ,(219,1)
                ,(220,3)
                ,(221,3)
                ,(222,3)
                ,(223,2)
                ,(224,1)
                ,(225,1)
                ,(226,3)
                ,(227,1)
                ,(228,1)
                ,(229,3)
                ,(230,3)
                ,(231,2)
                ,(232,1)
                ,(233,2)
                ,(234,3)
                ,(235,3)
                ,(236,3)
                ,(237,3)
                ,(238,2)
                ,(239,3)
                ,(240,1)
                ,(241,2)
                ,(242,1)
                ,(243,2)
                ,(244,2)
                ,(245,1)
                ,(246,2)
                ,(247,2)
                ,(248,3)
                ,(249,1)
                ,(250,1)
                ,(251,3)
                ,(252,2)
                ,(253,3)
                ,(254,1)
                ,(255,3)
                ,(256,2)
                ,(257,2)
                ,(258,2)
                ,(259,3)
                ,(260,1)
                ,(261,1)
                ,(262,3)
                ,(263,3)
                ,(264,2)
                ,(265,2)
                ,(266,2)
                ,(267,3)
                ,(268,3)
                ,(269,3)
                ,(270,3)
                ,(271,3)
                ,(272,3)
                ,(273,2)
                ,(274,1)
                ,(275,3)
                ,(276,2)
                ,(277,3)
                ,(278,1)
                ,(279,1)
                ,(280,2)
                ,(281,2)
                ,(282,3)
                ,(283,2)
                ,(284,2)
                ,(285,3)
                ,(286,2)
                ,(287,2)
                ,(288,2)
                ,(289,3)
                ,(290,1)
                ,(291,2)
                ,(292,1)
                ,(293,3)
                ,(294,1)
                ,(295,3)
                ,(296,3)
                ,(297,1)
                ,(298,2)
                ,(299,3)
                ,(300,3)
                ,(301,3)
                ,(302,3)
                ,(303,3)
                ,(304,3)
                ,(305,1)
                ,(306,2)
                ,(307,3)
                ,(308,3)
                ,(309,3)
                ,(310,3)
                ,(311,2)
                ,(312,2)
                ,(313,3)
                ,(314,1)
                ,(315,3)
                ,(316,1)
                ,(317,3)
                ,(318,3)
                ,(319,2)
                ,(320,2)
                ,(321,2)
                ,(322,1)
                ,(323,3)
                ,(324,2)
                ,(325,2)
                ,(326,1)
                ,(327,3)
                ,(328,1)
                ,(329,2)
                ,(330,1)
                ,(331,1)
                ,(332,1)
                ,(333,2)
                ,(334,3)
                ,(335,2)
                ,(336,1)
                ,(337,1)
                ,(338,3)
                ,(339,1)
                ,(340,1)
                ,(341,1)
                ,(342,2)
                ,(343,1)
                ,(344,1)
                ,(345,3)
                ,(346,3)
                ,(347,1)
                ,(348,3)
                ,(349,3)
                ,(350,2)
                ,(351,2)
                ,(352,2)
                ,(353,1)
                ,(354,1)
                ,(355,1)
                ,(356,3)
                ,(357,2)
                ,(358,2)
                ,(359,1)
                ,(360,1)
                ,(361,2)
                ,(362,2)
                ,(363,1)
                ,(364,2)
                ,(365,2)
                ,(366,3)
                ,(367,1)
                ,(368,1)
                ,(369,3)
                ,(370,3)
                ,(371,2)
                ,(372,2)
                ,(373,2)
                ,(374,2)
                ,(375,3)
                ,(376,1)
                ,(377,3)
                ,(378,3)
                ,(379,2)
                ,(380,3)
                ,(381,2)
                ,(382,1)
                ,(383,3)
                ,(384,1)
                ,(385,3)
                ,(386,2)
                ,(387,1)
                ,(388,1)
                ,(389,3)
                ,(390,3)
                ,(391,3)
                ,(392,1)
                ,(393,2)
                ,(394,1)
                ,(395,1)
                ,(396,2)
                ,(397,1)
                ,(398,2)
                ,(399,3)
                ,(400,1)
                ,(401,1)
                ,(402,3)
                ,(403,1)
                ,(404,3)
                ,(405,1)
                ,(406,1)
                ,(407,1)
                ,(408,2)
                ,(409,3)
                ,(410,2)
                ,(411,2)
                ,(412,1)
                ,(413,3)
                ,(414,3)
                ,(415,1)
                ,(416,3)
                ,(417,3)
                ,(418,2)
                ,(419,3)
                ,(420,3)
                ,(421,3)
                ,(422,2)
                ,(423,3)
                ,(424,3)
                ,(425,1)
                ,(426,2)
                ,(427,2)
                ,(428,1)
                ,(429,2)
                ,(430,3)
                ,(431,1)
                ,(432,1)
                ,(433,2)
                ,(434,3)
                ,(435,2)
                ,(436,1)
                ,(437,1)
                ,(438,3)
                ,(439,3)
                ,(440,3)
                ,(441,1)
                ,(442,2)
                ,(443,3)
                ,(444,2)
                ,(445,1)
                ,(446,1)
                ,(447,2)
                ,(448,3)
                ,(449,2)
                ,(450,1)
                ,(451,3)
                ,(452,3)
                ,(453,3)
                ,(454,3)
                ,(455,3)
                ,(456,1)
                ,(457,2)
                ,(458,2)
                ,(459,2)
                ,(460,1)
                ,(461,3)
                ,(462,3)
                ,(463,3)
                ,(464,3)
                ,(465,2)
                ,(466,1)
                ,(467,2)
                ,(468,1)
                ,(469,2)
                ,(470,3)
                ,(471,3)
                ,(472,3)
                ,(473,1)
                ,(474,1)
                ,(475,1)
                ,(476,2)
                ,(477,3)
                ,(478,3)
                ,(479,2)
                ,(480,3)
                ,(481,1)
                ,(482,3)
                ,(483,1)
                ,(484,2)
                ,(485,2)
                ,(486,1)
                ,(487,3)
                ,(488,1)
                ,(489,3)
                ,(490,2)
                ,(491,3)
                ,(492,3)
                ,(493,3)
                ,(494,1)
                ,(495,2)
                ,(496,3)
                ,(497,3)
                ,(498,1)
                ,(499,3)
                ,(500,2)
                ,(501,3)
                ,(502,2)
                ,(503,3)
                ,(504,2)
                ,(505,1)
                ,(506,3)
                ,(507,3)
                ,(508,3)
                ,(509,1)
                ,(510,1)
                ,(511,1)
                ,(512,1)
                ,(513,1)
                ,(514,3)
                ,(515,1)
                ,(516,2)
                ,(517,2)
                ,(518,3)
                ,(519,2)
                ,(520,2)
                ,(521,1)
                ,(522,2)
                ,(523,2)
                ,(524,2)
                ,(525,1)
                ,(526,2)
                ,(527,1)
                ,(528,3)
                ,(529,2)
                ,(530,3)
                ,(531,1)
                ,(532,2)
                ,(533,2)
                ,(534,3)
                ,(535,2)
                ,(536,3)
                ,(537,3)
                ,(538,2)
                ,(539,3)
                ,(540,2)
                ,(541,2)
                ,(542,3)
                ,(543,1)
                ,(544,3)
                ,(545,3)
                ,(546,3)
                ,(547,1)
                ,(548,1)
                ,(549,2)
                ,(550,3)
                ,(551,2)
                ,(552,3)
                ,(553,3)
                ,(554,3)
                ,(555,3)
                ,(556,2)
                ,(557,3)
                ,(558,2)
                ,(559,1)
                ,(560,3)
                ,(561,1)
                ,(562,3)
                ,(563,3)
                ,(564,3)
                ,(565,2)
                ,(566,1)
                ,(567,1)
                ,(568,3)
                ,(569,3)
                ,(570,3)
                ,(571,3)
                ,(572,2)
                ,(573,3)
                ,(574,1)
                ,(575,2)
                ,(576,2)
                ,(577,3)
                ,(578,2)
                ,(579,1)
                ,(580,1)
                ,(581,3)
                ,(582,1)
                ,(583,1)
                ,(584,3)
                ,(585,1)
                ,(586,1)
                ,(587,1)
                ,(588,3)
                ,(589,1)
                ,(590,3)
                ,(591,1)
                ,(592,1)
                ,(593,3)
                ,(594,1)
                ,(595,3)
                ,(596,3)
                ,(597,1)
                ,(598,2)
                ,(599,3)
                ,(600,3)
                ,(601,2)
                ,(602,3)
                ,(603,3)
                ,(604,3)
                ,(605,3)
                ,(606,1)
                ,(607,2)
                ,(608,2)
                ,(609,3)
                ,(610,2)
                ,(611,3)
                ,(612,3)
                ,(613,3)
                ,(614,3)
                ,(615,2)
                ,(616,2)
                ,(617,1)
                ,(618,1)
                ,(619,1)
                ,(620,1)
                ,(621,2)
                ,(622,1)
                ,(623,1)
                ,(624,3)
                ,(625,2)
                ,(626,2)
                ,(627,2)
                ,(628,2)
                ,(629,1)
                ,(630,3)
                ,(631,2)
                ,(632,3)
                ,(633,2)
                ,(634,2)
                ,(635,3)
                ,(636,2)
                ,(637,2)
                ,(638,1)
                ,(639,2)
                ,(640,3)
                ,(641,3)
                ,(642,1)
                ,(643,2)
                ,(644,1)
                ,(645,1)
                ,(646,3)
                ,(647,1)
                ,(648,2)
                ,(649,1)
                ,(650,2)
                ,(651,3)
                ,(652,3)
                ,(653,2)
                ,(654,1)
                ,(655,1)
                ,(656,3)
                ,(657,1)
                ,(658,2)
                ,(659,1)
                ,(660,3)
                ,(661,1)
                ,(662,3)
                ,(663,1)
                ,(664,2)
                ,(665,1)
                ,(666,1)
                ,(667,2)
                ,(668,1)
                ,(669,1)
                ,(670,2)
                ,(671,2)
                ,(672,1)
                ,(673,2)
                ,(674,2)
                ,(675,3)
                ,(676,2)
                ,(677,1)
                ,(678,2)
                ,(679,3)
                ,(680,1)
                ,(681,3)
                ,(682,2)
                ,(683,3)
                ,(684,2)
                ,(685,2)
                ,(686,1)
                ,(687,1)
                ,(688,2)
                ,(689,1)
                ,(690,2)
                ,(691,2)
                ,(692,3)
                ,(693,3)
                ,(694,2)
                ,(695,3)
                ,(696,2)
                ,(697,1)
                ,(698,1)
                ,(699,2)
                ,(700,3)
                ,(701,3)
                ,(702,3)
                ,(703,2)
                ,(704,2)
                ,(705,3)
                ,(706,2)
                ,(707,3)
                ,(708,2)
                ,(709,1)
                ,(710,2)
                ,(711,2)
                ,(712,1)
                ,(713,2)
                ,(714,3)
                ,(715,3)
                ,(716,3)
                ,(717,1)
                ,(718,1)
                ,(719,2)
                ,(720,3)
                ,(721,2)
                ,(722,3)
                ,(723,1)
                ,(724,1)
                ,(725,1)
                ,(726,3)
                ,(727,1)
                ,(728,2)
                ,(729,3)
                ,(730,3)
                ,(731,1)
                ,(732,3)
                ,(733,1)
                ,(734,3)
                ,(735,2)
                ,(736,3)
                ,(737,3)
                ,(738,3)
                ,(739,2)
                ,(740,1)
                ,(741,2)
                ,(742,3)
                ,(743,3)
                ,(744,3)
                ,(745,1)
                ,(746,2)
                ,(747,3)
                ,(748,1)
                ,(749,2)
                ,(750,2)
                ,(751,1)
                ,(752,2)
                ,(753,2)
                ,(754,1)
                ,(755,3)
                ,(756,1)
                ,(757,2)
                ,(758,3)
                ,(759,2)
                ,(760,3)
                ,(761,1)
                ,(762,3)
                ,(763,2)
                ,(764,3)
                ,(765,1)
                ,(766,2)
                ,(767,3)
                ,(768,3)
                ,(769,2)
                ,(770,2)
                ,(771,2)
                ,(772,2)
                ,(773,3)
                ,(774,2)
                ,(775,1)
                ,(776,2)
                ,(777,1)
                ,(778,3)
                ,(779,3)
                ,(780,1)
                ,(781,2)
                ,(782,2)
                ,(783,3)
                ,(784,3)
                ,(785,1)
                ,(786,2)
                ,(787,2)
                ,(788,3)
                ,(789,2)
                ,(790,2)
                ,(791,2)
                ,(792,3)
                ,(793,3)
                ,(794,2)
                ,(795,2)
                ,(796,2)
                ,(797,1)
                ,(798,3)
                ,(799,2)
                ,(800,1)
                ,(801,3)
                ,(802,2)
                ,(803,1)
                ,(804,2)
                ,(805,2)
                ,(806,2)
                ,(807,1)
                ,(808,3)
                ,(809,2)
                ,(810,3)
                ,(811,2)
                ,(812,2)
                ,(813,1)
                ,(814,1)
                ,(815,1)
                ,(816,1)
                ,(817,2)
                ,(818,3)
                ,(819,3)
                ,(820,2)
                ,(821,3)
                ,(822,3)
                ,(823,1)
                ,(824,3)
                ,(825,3)
                ,(826,3)
                ,(827,2)
                ,(828,1)
                ,(829,3)
                ,(830,2)
                ,(831,1)
                ,(832,2)
                ,(833,3)
                ,(834,1)
                ,(835,3)
                ,(836,1)
                ,(837,2)
                ,(838,3)
                ,(839,3)
                ,(840,3)
                ,(841,1)
                ,(842,2)
                ,(843,3)
                ,(844,1)
                ,(845,1)
                ,(846,1)
                ,(847,2)
                ,(848,3)
                ,(849,2)
                ,(850,1)
                ,(851,2)
                ,(852,1)
                ,(853,2)
                ,(854,2)
                ,(855,1)
                ,(856,1)
                ,(857,2)
                ,(858,3)
                ,(859,3)
                ,(860,3)
                ,(861,3)
                ,(862,3)
                ,(863,3)
                ,(864,2)
                ,(865,2)
                ,(866,1)
                ,(867,3)
                ,(868,3)
                ,(869,1)
                ,(870,3)
                ,(871,1)
                ,(872,3)
                ,(873,1)
                ,(874,2)
                ,(875,2)
                ,(876,1)
                ,(877,1)
                ,(878,3)
                ,(879,3)
                ,(880,3)
                ,(881,3)
                ,(882,1)
                ,(883,3)
                ,(884,3)
                ,(885,1)
                ,(886,3)
                ,(887,3)
                ,(888,2)
                ,(889,2)
                ,(890,2)
                ,(891,2)
                ,(892,1)
                ,(893,1)
                ,(894,3)
                ,(895,2)
                ,(896,2)
                ,(897,1)
                ,(898,3)
                ,(899,1)
                ,(900,1)
                ,(901,3)
                ,(902,2)
                ,(903,2)
                ,(904,1)
                ,(905,2)
                ,(906,3)
                ,(907,3)
                ,(908,3)
                ,(909,1)
                ,(910,3)
                ,(911,3)
                ,(912,2)
                ,(913,2)
                ,(914,1)
                ,(915,3)
                ,(916,2)
                ,(917,2)
                ,(918,3)
                ,(919,3)
                ,(920,3)
                ,(921,2)
                ,(922,2)
                ,(923,1)
                ,(924,1)
                ,(925,2)
                ,(926,1)
                ,(927,2)
                ,(928,1)
                ,(929,2)
                ,(930,2)
                ,(931,3)
                ,(932,3)
                ,(933,1)
                ,(934,3)
                ,(935,2)
                ,(936,1)
                ,(937,1)
                ,(938,1)
                ,(939,1)
                ,(940,1)
                ,(941,3)
                ,(942,3)
                ,(943,2)
                ,(944,2)
                ,(945,2)
                ,(946,3)
                ,(947,3)
                ,(948,3)
                ,(949,2)
                ,(950,1)
                ,(951,1)
                ,(952,2)
                ,(953,1)
                ,(954,3)
                ,(955,3)
                ,(956,3)
                ,(957,3)
                ,(958,2)
                ,(959,3)
                ,(960,2)
                ,(961,1)
                ,(962,2)
                ,(963,2)
                ,(964,2)
                ,(965,1)
                ,(966,2)
                ,(967,3)
                ,(968,2)
                ,(969,1)
                ,(970,1)
                ,(971,3)
                ,(972,2)
                ,(973,3)
                ,(974,1)
                ,(975,1)
                ,(976,1)
                ,(977,2)
                ,(978,2)
                ,(979,3)
                ,(980,3)
                ,(981,3)
                ,(982,2)
                ,(983,1)
                ,(984,1)
                ,(985,2)
                ,(986,1)
                ,(987,2)
                ,(988,2)
                ,(989,2)
                ,(990,2)
                ,(991,1)
                ,(992,3)
                ,(993,2)
                ,(994,3)
                ,(995,2)
                ,(996,3)
                ,(997,2)
                ,(998,3)
                ,(999,2)
                ,(1000,3)
                ,(1001,3)
                ,(1002,3)
                ,(1003,1)
                ,(1004,3)
                ,(1005,1)
                ,(1006,1)
                ,(1007,2)
                ,(1008,3)
                ,(1009,3)
                ,(1010,3)
                ,(1011,2)
                ,(1012,1)
                ,(1013,1)
                ,(1014,3)
                ,(1015,1)
                ,(1016,3)
                ,(1017,2)
                ,(1018,1)
                ,(1019,1)
                ,(1020,2)
                ,(1021,3)
                ,(1022,1)
                ,(1023,1)
                ,(1024,3)
                ,(1025,2)
                ,(1026,1)
                ,(1027,3)
                ,(1028,1)
                ,(1029,1)
                ,(1030,3)
                ,(1031,2)
                ,(1032,3)
                ,(1033,1)
                ,(1034,1)
                ,(1035,3)
                ,(1036,3)
                ,(1037,1)
                ,(1038,2)
                ,(1039,2)
                ,(1040,3)
                ,(1041,2)
                ,(1042,1)
                ,(1043,3)
                ,(1044,2)
                ,(1045,1)
                ,(1046,3)
                ,(1047,2)
                ,(1048,2)
                ,(1049,2)
                ,(1050,1)
                ,(1051,3)
                ,(1052,1)
                ,(1053,1)
                ,(1054,1)
                ,(1055,3)
                ,(1056,2)
                ,(1057,3)
                ,(1058,3)
                ,(1059,2)
                ,(1060,3)
                ,(1061,1)
                ,(1062,1)
                ,(1063,3)
                ,(1064,3)
                ,(1065,3)
                ,(1066,2)
                ,(1067,2)
                ,(1068,1)
                ,(1069,2)
                ,(1070,3)
                ,(1071,1)
                ,(1072,1)
                ,(1073,2)
                ,(1074,1)
                ,(1075,2)
                ,(1076,1)
                ,(1077,3)
                ,(1078,1)
                ,(1079,2)
                ,(1080,3)
                ,(1081,1)
                ,(1082,2)
                ,(1083,3)
                ,(1084,2)
                ,(1085,2)
                ,(1086,3)
                ,(1087,1)
                ,(1088,3)
                ,(1089,3)
                ,(1090,1)
                ,(1091,1)
                ,(1092,3)
                ,(1093,1)
                ,(1094,3)
                ,(1095,3)
                ,(1096,2)
                ,(1097,1)
                ,(1098,1)
                ,(1099,1)
                ,(1100,3)
                ,(1101,2)
                ,(1102,2)
                ,(1103,1)
                ,(1104,2)
                ,(1105,2)
                ,(1106,1)
                ,(1107,3)
                ,(1108,2)
                ,(1109,1)
                ,(1110,1)
                ,(1111,1)
                ,(1112,1)
                ,(1113,1)
                ,(1114,1)
                ,(1115,1)
                ,(1116,3)
                ,(1117,1)
                ,(1118,3)
                ,(1119,2)
                ,(1120,1)
                ,(1121,3)
                ,(1122,2)
                ,(1123,1)
                ,(1124,3)
                ,(1125,3)
                ,(1126,1)
                ,(1127,2)
                ,(1128,2)
                ,(1129,2)
                ,(1130,1)
                ,(1131,1)
                ,(1132,1)
                ,(1133,2)
                ,(1134,3)
                ,(1135,1)
                ,(1136,1)
                ,(1137,3)
                ,(1138,2)
                ,(1139,2)
                ,(1140,1)
                ,(1141,2)
                ,(1142,3)
                ,(1143,3)
                ,(1144,3)
                ,(1145,3)
                ,(1146,2)
                ,(1147,2)
                ,(1148,3)
                ,(1149,1)
                ,(1150,1)
                ,(1151,2)
                ,(1152,3)
                ,(1153,3)
                ,(1154,3)
                ,(1155,3)
                ,(1156,2)
                ,(1157,2)
                ,(1158,3)
                ,(1159,3)
                ,(1160,1)
                ,(1161,3)
                ,(1162,1)
                ,(1163,3)
                ,(1164,3)
                ,(1165,3)
                ,(1166,2)
                ,(1167,3)
                ,(1168,1)
                ,(1169,1)
                ,(1170,3)
                ,(1171,2)
                ,(1172,1)
                ,(1173,2)
                ,(1174,3)
                ,(1175,3)
                ,(1176,1)
                ,(1177,1)
                ,(1178,1)
                ,(1179,2)
                ,(1180,2)
                ,(1181,2)
                ,(1182,1)
                ,(1183,2)
                ,(1184,2)
                ,(1185,3)
                ,(1186,2)
                ,(1187,1)
                ,(1188,1)
                ,(1189,2)
                ,(1190,1)
                ,(1191,3)
                ,(1192,1)
                ,(1193,3)
                ,(1194,1)
                ,(1195,1)
                ,(1196,3)
                ,(1197,2)
                ,(1198,2)
                ,(1199,1)
                ,(1200,3)
                ,(1201,3)
                ,(1202,1)
                ,(1203,3)
                ,(1204,2)
                ,(1205,2)
                ,(1206,1)
                ,(1207,1)
                ,(1208,2)
                ,(1209,2)
                ,(1210,2)
                ,(1211,1)
                ,(1212,3)
                ,(1213,1)
                ,(1214,1)
                ,(1215,2)
                ,(1216,2)
                ,(1217,1)
                ,(1218,1)
                ,(1219,3)
                ,(1220,1)
                ,(1221,1)
                ,(1222,1)
                ,(1223,2)
                ,(1224,1)
                ,(1225,1)
                ,(1226,1)
                ,(1227,2)
                ,(1228,2)
                ,(1229,3)
                ,(1230,1)
                ,(1231,2)
                ,(1232,2)
                ,(1233,1)
                ,(1234,2)
                ,(1235,3)
                ,(1236,3)
                ,(1237,2)
                ,(1238,3)
                ,(1239,3)
                ,(1240,2)
                ,(1241,1)
                ,(1242,3)
                ,(1243,1)
                ,(1244,2)
                ,(1245,1)
                ,(1246,3)
                ,(1247,2)
                ,(1248,1)
                ,(1249,3)
                ,(1250,2)
                ,(1251,3)
                ,(1252,2)
                ,(1253,2)
                ,(1254,2)
                ,(1255,2)
                ,(1256,3)
                ,(1257,3)
                ,(1258,2)
                ,(1259,1)
                ,(1260,3)
                ,(1261,1)
                ,(1262,1)
                ,(1263,1)
                ,(1264,2)
                ,(1265,1)
                ,(1266,2)
                ,(1267,3)
                ,(1268,1)
                ,(1269,2)
                ,(1270,1)
                ,(1271,2)
                ,(1272,2)
                ,(1273,3)
                ,(1274,2)
                ,(1275,2)
                ,(1276,1)
                ,(1277,3)
                ,(1278,3)
                ,(1279,2)
                ,(1280,3)
                ,(1281,2)
                ,(1282,1)
                ,(1283,2)
                ,(1284,1)
                ,(1285,2)
                ,(1286,3)
                ,(1287,2)
                ,(1288,1)
                ,(1289,1)
                ,(1290,1)
                ,(1291,2)
                ,(1292,2)
                ,(1293,2)
                ,(1294,1)
                ,(1295,1)
                ,(1296,1)
                ,(1297,1)
                ,(1298,1)
                ,(1299,1)
                ,(1300,3)
                ,(1301,3)
                ,(1302,1)
                ,(1303,1)
                ,(1304,3)
                ,(1305,1)
                ,(1306,2)
                ,(1307,1)
                ,(1308,1)
                ,(1309,2)
                ,(1310,2)
                ,(1311,1)
                ,(1312,2)
                ,(1313,1)
                ,(1314,3)
                ,(1315,3)
                ,(1316,2)
                ,(1317,2)
                ,(1318,3)
                ,(1319,3)
                ,(1320,1)
                ,(1321,1)
                ,(1322,2)
                ,(1323,2)
                ,(1324,2)
                ,(1325,1)
                ,(1326,2)
                ,(1327,2)
                ,(1328,3)
                ,(1329,1)
                ,(1330,2)
                ,(1331,3)
                ,(1332,1)
                ,(1333,3)
                ,(1334,3)
                ,(1335,3)
                ,(1336,2)
                ,(1337,1)
                ,(1338,1)
                ,(1339,1)
                ,(1340,2)
                ,(1341,2)
                ,(1342,1)
                ,(1343,1)
                ,(1344,1)
                ,(1345,2)
                ,(1346,2)
                ,(1347,2)
                ,(1348,3)
                ,(1349,3)
                ,(1350,1)
                ,(1351,2)
                ,(1352,3)
                ,(1353,1)
                ,(1354,1)
                ,(1355,1)
                ,(1356,2)
                ,(1357,3)
                ,(1358,1)
                ,(1359,3)
                ,(1360,2)
                ,(1361,2)
                ,(1362,2)
                ,(1363,3)
                ,(1364,1)
                ,(1365,2)
                ,(1366,3)
                ,(1367,2)
                ,(1368,3)
                ,(1369,1)
                ,(1370,2)
                ,(1371,1)
                ,(1372,3)
                ,(1373,1)
                ,(1374,3)
                ,(1375,2)
                ,(1376,1)
                ,(1377,3)
                ,(1378,2)
                ,(1379,1)
                ,(1380,2)
                ,(1381,2)
                ,(1382,2)
                ,(1383,3)
                ,(1384,3)
                ,(1385,3)
                ,(1386,1)
                ,(1387,2)
                ,(1388,3)
                ,(1389,3)
                ,(1390,3)
                ,(1391,2)
                ,(1392,3)
                ,(1393,1)
                ,(1394,3)
                ,(1395,2)
                ,(1396,3)
                ,(1397,3)
                ,(1398,3)
                ,(1399,2)
                ,(1400,2)
                ,(4,13)
                ,(4,6)
                ,(6,14)
                ,(6,17)
                ,(7,6)
                ,(8,16)
                ,(8,9)
                ,(9,17)
                ,(10,12)
                ,(11,6)
                ,(13,12)
                ,(14,5)
                ,(15,12)
                ,(15,11)
                ,(15,16)
                ,(16,4)
                ,(18,8)
                ,(20,8)
                ,(22,17)
                ,(24,14)
                ,(24,5)
                ,(24,9)
                ,(24,13)
                ,(25,13)
                ,(25,4)
                ,(25,11)
                ,(28,4)
                ,(31,6)
                ,(31,14)
                ,(31,11)
                ,(31,8)
                ,(34,5)
                ,(35,6)
                ,(35,7)
                ,(35,13)
                ,(35,9)
                ,(37,9)
                ,(38,14)
                ,(39,10)
                ,(39,5)
                ,(40,13)
                ,(40,9)
                ,(41,5)
                ,(42,16)
                ,(44,6)
                ,(44,4)
                ,(44,16)
                ,(49,10)
                ,(53,5)
                ,(54,9)
                ,(56,10)
                ,(56,6)
                ,(56,15)
                ,(56,5)
                ,(57,15)
                ,(57,12)
                ,(57,7)
                ,(58,13)
                ,(59,16)
                ,(59,15)
                ,(62,6)
                ,(63,14)
                ,(64,12)
                ,(64,5)
                ,(66,16)
                ,(66,15)
                ,(68,16)
                ,(68,6)
                ,(69,9)
                ,(69,7)
                ,(69,6)
                ,(69,11)
                ,(69,10)
                ,(70,6)
                ,(76,10)
                ,(79,12)
                ,(80,8)
                ,(80,13)
                ,(80,11)
                ,(81,12)
                ,(81,13)
                ,(81,5)
                ,(82,9)
                ,(84,10)
                ,(85,17)
                ,(85,6)
                ,(86,17)
                ,(88,14)
                ,(89,17)
                ,(90,17)
                ,(90,5)
                ,(90,16)
                ,(90,13)
                ,(90,11)
                ,(91,10)
                ,(91,5)
                ,(92,9)
                ,(92,17)
                ,(93,6)
                ,(93,10)
                ,(93,15)
                ,(94,6)
                ,(95,12)
                ,(96,6)
                ,(99,15)
                ,(99,9)
                ,(99,17)
                ,(99,13)
                ,(105,4)
                ,(108,8)
                ,(109,17)
                ,(110,7)
                ,(110,16)
                ,(110,9)
                ,(110,12)
                ,(115,6)
                ,(117,8)
                ,(117,15)
                ,(117,14)
                ,(117,12)
                ,(118,17)
                ,(119,17)
                ,(121,6)
                ,(121,4)
                ,(122,13)
                ,(123,5)
                ,(123,7)
                ,(123,4)
                ,(123,12)
                ,(126,13)
                ,(126,7)
                ,(127,4)
                ,(128,10)
                ,(128,13)
                ,(128,6)
                ,(128,4)
                ,(128,12)
                ,(129,5)
                ,(131,6)
                ,(131,11)
                ,(132,9)
                ,(132,4)
                ,(133,6)
                ,(133,10)
                ,(134,11)
                ,(134,15)
                ,(134,16)
                ,(136,7)
                ,(136,8)
                ,(136,12)
                ,(137,5)
                ,(137,11)
                ,(139,11)
                ,(139,4)
                ,(139,5)
                ,(141,4)
                ,(141,12)
                ,(142,17)
                ,(143,17)
                ,(143,6)
                ,(143,5)
                ,(143,15)
                ,(146,17)
                ,(153,6)
                ,(153,7)
                ,(154,10)
                ,(155,8)
                ,(155,16)
                ,(155,7)
                ,(155,5)
                ,(155,17)
                ,(157,14)
                ,(161,17)
                ,(163,11)
                ,(164,7)
                ,(165,8)
                ,(165,10)
                ,(166,10)
                ,(166,9)
                ,(166,14)
                ,(167,5)
                ,(169,10)
                ,(169,12)
                ,(170,9)
                ,(171,13)
                ,(171,10)
                ,(173,9)
                ,(174,8)
                ,(176,7)
                ,(176,10)
                ,(176,14)
                ,(176,17)
                ,(176,15)
                ,(176,8)
                ,(177,14)
                ,(178,5)
                ,(179,11)
                ,(179,17)
                ,(182,11)
                ,(182,14)
                ,(182,12)
                ,(183,11)
                ,(183,12)
                ,(183,7)
                ,(184,9)
                ,(186,5)
                ,(186,13)
                ,(186,4)
                ,(186,11)
                ,(189,5)
                ,(191,11)
                ,(197,15)
                ,(198,7)
                ,(203,10)
                ,(203,15)
                ,(203,9)
                ,(207,5)
                ,(207,6)
                ,(208,14)
                ,(210,11)
                ,(211,9)
                ,(211,13)
                ,(214,15)
                ,(214,5)
                ,(216,15)
                ,(216,4)
                ,(216,16)
                ,(219,9)
                ,(219,13)
                ,(222,4)
                ,(222,13)
                ,(222,5)
                ,(222,7)
                ,(225,4)
                ,(227,4)
                ,(227,6)
                ,(227,12)
                ,(228,14)
                ,(228,10)
                ,(228,4)
                ,(237,14)
                ,(238,9)
                ,(239,15)
                ,(239,6)
                ,(240,9)
                ,(240,13)
                ,(242,10)
                ,(243,9)
                ,(243,7)
                ,(243,11)
                ,(243,16)
                ,(244,4)
                ,(245,6)
                ,(246,11)
                ,(246,7)
                ,(248,4)
                ,(248,5)
                ,(248,15)
                ,(248,13)
                ,(248,17)
                ,(251,10)
                ,(251,11)
                ,(251,9)
                ,(254,15)
                ,(254,13)
                ,(255,16)
                ,(256,13)
                ,(258,17)
                ,(260,8)
                ,(261,8)
                ,(261,10)
                ,(261,5)
                ,(261,16)
                ,(261,14)
                ,(261,13)
                ,(264,17)
                ,(264,10)
                ,(264,8)
                ,(264,12)
                ,(265,13)
                ,(265,7)
                ,(265,15)
                ,(268,4)
                ,(268,10)
                ,(269,5)
                ,(269,6)
                ,(269,14)
                ,(275,6)
                ,(275,15)
                ,(275,4)
                ,(279,17)
                ,(280,7)
                ,(281,13)
                ,(286,8)
                ,(286,16)
                ,(288,10)
                ,(288,12)
                ,(288,4)
                ,(288,7)
                ,(289,17)
                ,(289,5)
                ,(292,6)
                ,(293,15)
                ,(294,12)
                ,(294,13)
                ,(294,8)
                ,(294,9)
                ,(297,12)
                ,(297,7)
                ,(297,9)
                ,(299,4)
                ,(300,7)
                ,(300,10)
                ,(300,14)
                ,(300,8)
                ,(301,12)
                ,(302,9)
                ,(303,4)
                ,(303,13)
                ,(304,15)
                ,(304,16)
                ,(304,9)
                ,(309,14)
                ,(309,15)
                ,(314,14)
                ,(314,9)
                ,(315,11)
                ,(315,13)
                ,(315,10)
                ,(315,14)
                ,(315,9)
                ,(315,12)
                ,(318,7)
                ,(323,6)
                ,(323,5)
                ,(323,17)
                ,(325,13)
                ,(325,5)
                ,(326,8)
                ,(326,16)
                ,(326,17)
                ,(328,15)
                ,(328,13)
                ,(331,5)
                ,(332,14)
                ,(335,10)
                ,(335,13)
                ,(336,10)
                ,(337,11)
                ,(339,17)
                ,(339,16)
                ,(340,15)
                ,(340,13)
                ,(341,15)
                ,(343,10)
                ,(345,8)
                ,(347,12)
                ,(348,16)
                ,(351,8)
                ,(356,6)
                ,(358,7)
                ,(358,5)
                ,(358,11)
                ,(361,4)
                ,(364,6)
                ,(364,14)
                ,(364,12)
                ,(365,16)
                ,(367,15)
                ,(367,5)
                ,(368,10)
                ,(368,4)
                ,(368,6)
                ,(369,8)
                ,(372,16)
                ,(372,11)
                ,(372,15)
                ,(372,12)
                ,(373,7)
                ,(373,12)
                ,(373,17)
                ,(373,8)
                ,(374,5)
                ,(375,7)
                ,(377,14)
                ,(377,17)
                ,(380,7)
                ,(382,14)
                ,(387,8)
                ,(387,10)
                ,(388,13)
                ,(389,9)
                ,(390,15)
                ,(392,13)
                ,(394,10)
                ,(395,14)
                ,(400,12)
                ,(400,9)
                ,(404,12)
                ,(406,17)
                ,(409,16)
                ,(410,16)
                ,(410,7)
                ,(412,16)
                ,(412,5)
                ,(416,10)
                ,(417,5)
                ,(417,17)
                ,(417,10)
                ,(418,9)
                ,(418,4)
                ,(422,12)
                ,(424,9)
                ,(424,15)
                ,(425,16)
                ,(425,13)
                ,(425,17)
                ,(426,12)
                ,(427,12)
                ,(427,4)
                ,(427,5)
                ,(427,17)
                ,(429,10)
                ,(430,15)
                ,(430,13)
                ,(431,5)
                ,(435,16)
                ,(436,4)
                ,(436,11)
                ,(437,10)
                ,(437,8)
                ,(438,7)
                ,(441,5)
                ,(441,4)
                ,(441,13)
                ,(441,14)
                ,(444,4)
                ,(444,5)
                ,(444,6)
                ,(444,9)
                ,(444,8)
                ,(447,10)
                ,(448,4)
                ,(451,6)
                ,(453,14)
                ,(453,10)
                ,(453,6)
                ,(454,11)
                ,(454,6)
                ,(454,8)
                ,(454,13)
                ,(454,5)
                ,(457,5)
                ,(458,13)
                ,(458,17)
                ,(458,14)
                ,(459,4)
                ,(460,14)
                ,(460,9)
                ,(461,10)
                ,(461,5)
                ,(462,13)
                ,(462,11)
                ,(462,15)
                ,(464,13)
                ,(464,5)
                ,(466,10)
                ,(468,8)
                ,(470,10)
                ,(470,5)
                ,(470,8)
                ,(474,5)
                ,(474,9)
                ,(475,10)
                ,(478,11)
                ,(478,4)
                ,(479,6)
                ,(479,13)
                ,(480,5)
                ,(480,9)
                ,(480,8)
                ,(480,7)
                ,(480,4)
                ,(481,6)
                ,(487,16)
                ,(489,10)
                ,(489,13)
                ,(491,8)
                ,(492,7)
                ,(492,9)
                ,(495,6)
                ,(495,17)
                ,(495,5)
                ,(496,4)
                ,(497,17)
                ,(498,5)
                ,(499,14)
                ,(499,11)
                ,(499,8)
                ,(509,10)
                ,(509,15)
                ,(509,11)
                ,(509,16)
                ,(518,15)
                ,(518,17)
                ,(519,4)
                ,(519,11)
                ,(520,17)
                ,(522,11)
                ,(522,13)
                ,(524,7)
                ,(524,10)
                ,(524,14)
                ,(526,15)
                ,(530,14)
                ,(530,5)
                ,(530,12)
                ,(531,14)
                ,(531,16)
                ,(532,13)
                ,(532,10)
                ,(532,9)
                ,(532,17)
                ,(532,14)
                ,(533,17)
                ,(533,14)
                ,(534,11)
                ,(534,9)
                ,(534,12)
                ,(535,17)
                ,(535,14)
                ,(535,9)
                ,(537,9)
                ,(537,15)
                ,(537,14)
                ,(538,9)
                ,(539,14)
                ,(540,14)
                ,(540,7)
                ,(540,15)
                ,(540,6)
                ,(541,5)
                ,(542,17)
                ,(542,10)
                ,(543,6)
                ,(543,9)
                ,(545,10)
                ,(545,6)
                ,(545,15)
                ,(545,5)
                ,(545,16)
                ,(546,17)
                ,(547,13)
                ,(549,17)
                ,(549,7)
                ,(549,14)
                ,(549,15)
                ,(550,16)
                ,(552,10)
                ,(553,9)
                ,(558,6)
                ,(558,14)
                ,(560,5)
                ,(562,11)
                ,(564,13)
                ,(564,15)
                ,(564,7)
                ,(565,4)
                ,(567,17)
                ,(567,14)
                ,(569,12)
                ,(570,17)
                ,(570,4)
                ,(571,10)
                ,(572,8)
                ,(573,15)
                ,(574,8)
                ,(577,14)
                ,(577,15)
                ,(578,17)
                ,(578,8)
                ,(585,16)
                ,(586,5)
                ,(586,16)
                ,(587,15)
                ,(588,17)
                ,(588,10)
                ,(589,12)
                ,(589,16)
                ,(592,7)
                ,(595,16)
                ,(595,8)
                ,(597,9)
                ,(598,4)
                ,(600,4)
                ,(605,5)
                ,(605,13)
                ,(605,7)
                ,(605,17)
                ,(606,15)
                ,(606,12)
                ,(607,12)
                ,(607,17)
                ,(608,16)
                ,(608,8)
                ,(611,10)
                ,(611,6)
                ,(612,14)
                ,(612,13)
                ,(613,11)
                ,(616,11)
                ,(617,6)
                ,(617,14)
                ,(617,15)
                ,(617,7)
                ,(619,10)
                ,(622,8)
                ,(623,16)
                ,(624,7)
                ,(626,9)
                ,(626,12)
                ,(627,16)
                ,(627,7)
                ,(629,9)
                ,(630,17)
                ,(630,4)
                ,(631,16)
                ,(634,10)
                ,(634,7)
                ,(634,12)
                ,(634,6)
                ,(635,11)
                ,(636,11)
                ,(636,9)
                ,(637,14)
                ,(639,12)
                ,(639,9)
                ,(640,13)
                ,(640,12)
                ,(640,9)
                ,(642,4)
                ,(643,16)
                ,(643,8)
                ,(643,13)
                ,(643,15)
                ,(644,7)
                ,(646,16)
                ,(646,15)
                ,(646,12)
                ,(648,6)
                ,(648,10)
                ,(650,11)
                ,(650,13)
                ,(650,10)
                ,(650,9)
                ,(652,4)
                ,(652,13)
                ,(654,15)
                ,(654,13)
                ,(654,8)
                ,(654,5)
                ,(654,12)
                ,(654,9)
                ,(655,5)
                ,(656,15)
                ,(659,17)
                ,(662,10)
                ,(662,12)
                ,(663,11)
                ,(664,16)
                ,(664,10)
                ,(664,8)
                ,(666,14)
                ,(668,6)
                ,(669,10)
                ,(670,17)
                ,(670,4)
                ,(670,10)
                ,(672,16)
                ,(672,14)
                ,(675,13)
                ,(675,5)
                ,(675,4)
                ,(676,10)
                ,(677,6)
                ,(686,7)
                ,(686,5)
                ,(687,12)
                ,(687,10)
                ,(687,14)
                ,(687,13)
                ,(688,8)
                ,(688,12)
                ,(691,17)
                ,(691,14)
                ,(691,8)
                ,(692,10)
                ,(694,17)
                ,(696,15)
                ,(697,17)
                ,(697,5)
                ,(697,14)
                ,(698,10)
                ,(699,17)
                ,(701,17)
                ,(701,11)
                ,(705,12)
                ,(708,8)
                ,(710,9)
                ,(710,14)
                ,(710,13)
                ,(710,15)
                ,(711,16)
                ,(711,9)
                ,(711,14)
                ,(716,6)
                ,(716,15)
                ,(719,17)
                ,(719,16)
                ,(719,11)
                ,(719,12)
                ,(721,4)
                ,(721,14)
                ,(722,8)
                ,(722,5)
                ,(724,10)
                ,(725,7)
                ,(726,15)
                ,(727,10)
                ,(730,7)
                ,(730,13)
                ,(731,8)
                ,(733,11)
                ,(736,17)
                ,(739,16)
                ,(740,13)
                ,(740,16)
                ,(741,4)
                ,(743,16)
                ,(744,16)
                ,(745,10)
                ,(745,15)
                ,(745,6)
                ,(745,16)
                ,(745,5)
                ,(746,17)
                ,(750,4)
                ,(754,16)
                ,(756,16)
                ,(756,6)
                ,(757,10)
                ,(757,17)
                ,(758,17)
                ,(758,6)
                ,(759,7)
                ,(760,15)
                ,(760,6)
                ,(760,4)
                ,(760,5)
                ,(761,14)
                ,(761,6)
                ,(761,12)
                ,(764,6)
                ,(765,15)
                ,(765,14)
                ,(767,15)
                ,(768,7)
                ,(771,11)
                ,(771,12)
                ,(771,15)
                ,(772,11)
                ,(773,12)
                ,(774,9)
                ,(775,9)
                ,(778,16)
                ,(778,12)
                ,(779,15)
                ,(779,12)
                ,(779,4)
                ,(779,5)
                ,(781,13)
                ,(781,14)
                ,(781,5)
                ,(781,17)
                ,(783,7)
                ,(783,17)
                ,(785,12)
                ,(785,15)
                ,(785,14)
                ,(785,9)
                ,(786,17)
                ,(786,7)
                ,(787,5)
                ,(789,10)
                ,(789,16)
                ,(790,13)
                ,(790,5)
                ,(791,12)
                ,(792,16)
                ,(793,16)
                ,(795,4)
                ,(801,13)
                ,(802,10)
                ,(802,8)
                ,(802,4)
                ,(802,6)
                ,(802,12)
                ,(803,8)
                ,(803,14)
                ,(803,11)
                ,(803,6)
                ,(805,14)
                ,(808,13)
                ,(809,7)
                ,(817,10)
                ,(817,4)
                ,(817,16)
                ,(817,8)
                ,(820,14)
                ,(820,9)
                ,(821,9)
                ,(822,7)
                ,(822,8)
                ,(822,9)
                ,(822,6)
                ,(822,14)
                ,(823,17)
                ,(824,4)
                ,(826,16)
                ,(826,7)
                ,(827,17)
                ,(828,10)
                ,(830,5)
                ,(831,15)
                ,(831,17)
                ,(831,11)
                ,(832,5)
                ,(835,16)
                ,(835,15)
                ,(837,10)
                ,(839,9)
                ,(840,8)
                ,(840,17)
                ,(840,14)
                ,(840,9)
                ,(840,16)
                ,(842,9)
                ,(843,13)
                ,(843,6)
                ,(844,6)
                ,(846,9)
                ,(849,11)
                ,(849,17)
                ,(851,16)
                ,(851,15)
                ,(851,4)
                ,(851,17)
                ,(852,11)
                ,(855,14)
                ,(855,8)
                ,(855,10)
                ,(855,9)
                ,(857,14)
                ,(858,4)
                ,(858,17)
                ,(859,14)
                ,(859,11)
                ,(861,5)
                ,(864,16)
                ,(865,9)
                ,(865,6)
                ,(865,10)
                ,(865,12)
                ,(868,14)
                ,(868,9)
                ,(869,6)
                ,(869,13)
                ,(869,7)
                ,(870,4)
                ,(870,7)
                ,(872,16)
                ,(872,7)
                ,(872,14)
                ,(873,11)
                ,(878,7)
                ,(879,17)
                ,(880,4)
                ,(880,13)
                ,(882,13)
                ,(882,8)
                ,(885,13)
                ,(886,14)
                ,(886,8)
                ,(888,16)
                ,(890,9)
                ,(894,12)
                ,(894,9)
                ,(894,4)
                ,(896,11)
                ,(897,6)
                ,(900,11)
                ,(900,6)
                ,(901,9)
                ,(901,11)
                ,(902,15)
                ,(902,8)
                ,(903,12)
                ,(903,6)
                ,(903,11)
                ,(903,14)
                ,(903,15)
                ,(906,10)
                ,(907,5)
                ,(908,16)
                ,(909,11)
                ,(909,17)
                ,(910,7)
                ,(910,4)
                ,(910,14)
                ,(912,6)
                ,(912,7)
                ,(912,9)
                ,(912,10)
                ,(913,13)
                ,(914,17)
                ,(914,10)
                ,(917,6)
                ,(917,17)
                ,(920,5)
                ,(920,17)
                ,(920,11)
                ,(920,6)
                ,(920,4)
                ,(920,9)
                ,(921,7)
                ,(921,4)
                ,(922,4)
                ,(923,7)
                ,(923,13)
                ,(925,13)
                ,(934,10)
                ,(934,8)
                ,(934,9)
                ,(936,7)
                ,(936,13)
                ,(936,16)
                ,(936,14)
                ,(939,9)
                ,(939,4)
                ,(941,13)
                ,(941,8)
                ,(941,9)
                ,(943,8)
                ,(944,4)
                ,(946,12)
                ,(948,16)
                ,(948,13)
                ,(949,11)
                ,(950,12)
                ,(951,7)
                ,(951,4)
                ,(951,8)
                ,(952,15)
                ,(952,16)
                ,(958,9)
                ,(959,7)
                ,(960,9)
                ,(962,12)
                ,(962,5)
                ,(962,14)
                ,(965,10)
                ,(965,11)
                ,(966,12)
                ,(966,5)
                ,(967,6)
                ,(970,5)
                ,(970,13)
                ,(971,11)
                ,(971,17)
                ,(971,14)
                ,(971,6)
                ,(971,8)
                ,(973,7)
                ,(973,17)
                ,(975,5)
                ,(976,7)
                ,(978,16)
                ,(979,11)
                ,(980,6)
                ,(980,10)
                ,(982,5)
                ,(982,14)
                ,(982,16)
                ,(982,4)
                ,(982,10)
                ,(982,12)
                ,(983,11)
                ,(983,9)
                ,(984,12)
                ,(985,17)
                ,(986,13)
                ,(986,10)
                ,(987,16)
                ,(988,6)
                ,(988,13)
                ,(988,8)
                ,(989,13)
                ,(989,12)
                ,(989,4)
                ,(989,14)
                ,(989,16)
                ,(989,5)
                ,(991,8)
                ,(991,10)
                ,(991,9)
                ,(993,11)
                ,(994,13)
                ,(998,15)
                ,(1003,11)
                ,(1005,7)
                ,(1006,13)
                ,(1007,17)
                ,(1007,8)
                ,(1007,5)
                ,(1008,9)
                ,(1009,15)
                ,(1011,17)
                ,(1015,12)
                ,(1015,7)
                ,(1016,12)
                ,(1017,8)
                ,(1017,17)
                ,(1017,9)
                ,(1018,11)
                ,(1019,14)
                ,(1020,9)
                ,(1020,7)
                ,(1022,10)
                ,(1023,10)
                ,(1028,12)
                ,(1029,16)
                ,(1029,5)
                ,(1031,14)
                ,(1031,12)
                ,(1032,9)
                ,(1032,11)
                ,(1032,4)
                ,(1032,12)
                ,(1033,15)
                ,(1035,14)
                ,(1039,6)
                ,(1040,13)
                ,(1040,17)
                ,(1043,16)
                ,(1043,10)
                ,(1046,10)
                ,(1046,12)
                ,(1047,16)
                ,(1048,7)
                ,(1048,11)
                ,(1048,8)
                ,(1048,5)
                ,(1050,4)
                ,(1055,15)
                ,(1055,11)
                ,(1062,5)
                ,(1063,13)
                ,(1066,14)
                ,(1068,17)
                ,(1068,8)
                ,(1068,7)
                ,(1071,12)
                ,(1071,17)
                ,(1073,4)
                ,(1073,13)
                ,(1074,13)
                ,(1074,15)
                ,(1077,4)
                ,(1077,13)
                ,(1078,17)
                ,(1078,4)
                ,(1082,7)
                ,(1084,17)
                ,(1084,8)
                ,(1084,12)
                ,(1085,7)
                ,(1085,13)
                ,(1085,9)
                ,(1085,8)
                ,(1090,13)
                ,(1090,7)
                ,(1091,17)
                ,(1093,10)
                ,(1094,10)
                ,(1094,4)
                ,(1094,14)
                ,(1099,16)
                ,(1099,5)
                ,(1099,11)
                ,(1099,4)
                ,(1100,6)
                ,(1101,10)
                ,(1102,6)
                ,(1102,15)
                ,(1102,4)
                ,(1103,4)
                ,(1104,14)
                ,(1112,14)
                ,(1112,9)
                ,(1112,7)
                ,(1112,12)
                ,(1112,8)
                ,(1114,4)
                ,(1115,13)
                ,(1115,12)
                ,(1117,16)
                ,(1117,17)
                ,(1117,14)
                ,(1117,4)
                ,(1117,11)
                ,(1118,10)
                ,(1118,13)
                ,(1120,14)
                ,(1125,14)
                ,(1127,15)
                ,(1136,13)
                ,(1136,11)
                ,(1136,12)
                ,(1139,12)
                ,(1139,15)
                ,(1139,7)
                ,(1143,13)
                ,(1143,8)
                ,(1143,15)
                ,(1145,4)
                ,(1147,9)
                ,(1149,9)
                ,(1150,9)
                ,(1157,9)
                ,(1157,17)
                ,(1157,15)
                ,(1157,6)
                ,(1158,16)
                ,(1158,9)
                ,(1158,10)
                ,(1158,5)
                ,(1161,6)
                ,(1161,8)
                ,(1161,13)
                ,(1161,16)
                ,(1162,13)
                ,(1165,6)
                ,(1166,4)
                ,(1166,5)
                ,(1167,15)
                ,(1167,5)
                ,(1169,8)
                ,(1171,17)
                ,(1171,7)
                ,(1172,12)
                ,(1172,17)
                ,(1174,7)
                ,(1174,16)
                ,(1174,13)
                ,(1174,17)
                ,(1174,14)
                ,(1176,14)
                ,(1179,11)
                ,(1179,12)
                ,(1179,13)
                ,(1180,8)
                ,(1180,6)
                ,(1181,9)
                ,(1181,14)
                ,(1181,11)
                ,(1181,7)
                ,(1181,5)
                ,(1182,16)
                ,(1183,4)
                ,(1183,12)
                ,(1183,16)
                ,(1183,13)
                ,(1183,14)
                ,(1185,9)
                ,(1185,12)
                ,(1187,13)
                ,(1191,17)
                ,(1192,16)
                ,(1196,6)
                ,(1196,10)
                ,(1196,11)
                ,(1197,15)
                ,(1199,11)
                ,(1199,17)
                ,(1199,4)
                ,(1199,15)
                ,(1200,16)
                ,(1201,8)
                ,(1201,12)
                ,(1201,11)
                ,(1202,13)
                ,(1202,16)
                ,(1202,6)
                ,(1202,8)
                ,(1203,13)
                ,(1204,9)
                ,(1204,5)
                ,(1204,10)
                ,(1204,7)
                ,(1208,14)
                ,(1208,11)
                ,(1208,15)
                ,(1208,5)
                ,(1209,14)
                ,(1209,4)
                ,(1210,16)
                ,(1212,7)
                ,(1213,12)
                ,(1214,15)
                ,(1214,12)
                ,(1215,10)
                ,(1219,15)
                ,(1219,12)
                ,(1220,16)
                ,(1221,6)
                ,(1221,11)
                ,(1221,4)
                ,(1222,6)
                ,(1222,17)
                ,(1222,12)
                ,(1225,15)
                ,(1225,13)
                ,(1226,15)
                ,(1227,9)
                ,(1227,14)
                ,(1227,7)
                ,(1227,4)
                ,(1228,10)
                ,(1228,11)
                ,(1228,15)
                ,(1228,6)
                ,(1228,14)
                ,(1229,10)
                ,(1229,11)
                ,(1230,13)
                ,(1230,16)
                ,(1233,11)
                ,(1234,7)
                ,(1235,8)
                ,(1235,10)
                ,(1236,9)
                ,(1236,4)
                ,(1236,13)
                ,(1238,8)
                ,(1239,12)
                ,(1240,15)
                ,(1240,12)
                ,(1243,10)
                ,(1243,14)
                ,(1244,15)
                ,(1244,10)
                ,(1244,4)
                ,(1245,10)
                ,(1246,8)
                ,(1247,17)
                ,(1248,5)
                ,(1249,17)
                ,(1250,7)
                ,(1253,6)
                ,(1254,7)
                ,(1254,11)
                ,(1257,8)
                ,(1260,4)
                ,(1263,5)
                ,(1263,15)
                ,(1263,14)
                ,(1263,16)
                ,(1263,9)
                ,(1264,8)
                ,(1264,6)
                ,(1264,13)
                ,(1264,14)
                ,(1264,5)
                ,(1265,7)
                ,(1268,10)
                ,(1270,5)
                ,(1272,17)
                ,(1274,8)
                ,(1274,10)
                ,(1275,5)
                ,(1276,4)
                ,(1277,13)
                ,(1277,16)
                ,(1278,6)
                ,(1278,14)
                ,(1278,12)
                ,(1278,4)
                ,(1282,10)
                ,(1282,16)
                ,(1282,12)
                ,(1285,6)
                ,(1286,10)
                ,(1286,7)
                ,(1288,10)
                ,(1289,16)
                ,(1289,5)
                ,(1289,10)
                ,(1289,15)
                ,(1291,7)
                ,(1292,7)
                ,(1292,13)
                ,(1292,9)
                ,(1292,10)
                ,(1294,15)
                ,(1294,12)
                ,(1295,17)
                ,(1296,17)
                ,(1296,7)
                ,(1298,15)
                ,(1298,16)
                ,(1298,11)
                ,(1298,7)
                ,(1298,10)
                ,(1299,11)
                ,(1299,6)
                ,(1300,15)
                ,(1301,17)
                ,(1303,14)
                ,(1304,11)
                ,(1304,13)
                ,(1304,12)
                ,(1304,14)
                ,(1305,16)
                ,(1307,8)
                ,(1309,14)
                ,(1309,5)
                ,(1310,5)
                ,(1312,7)
                ,(1312,6)
                ,(1312,4)
                ,(1312,13)
                ,(1315,4)
                ,(1315,13)
                ,(1315,9)
                ,(1316,11)
                ,(1316,4)
                ,(1317,11)
                ,(1318,10)
                ,(1318,15)
                ,(1318,4)
                ,(1318,12)
                ,(1318,17)
                ,(1318,6)
                ,(1319,8)
                ,(1320,8)
                ,(1321,16)
                ,(1321,12)
                ,(1321,17)
                ,(1321,11)
                ,(1321,5)
                ,(1323,8)
                ,(1323,12)
                ,(1323,15)
                ,(1326,10)
                ,(1326,11)
                ,(1328,11)
                ,(1329,7)
                ,(1329,6)
                ,(1329,15)
                ,(1329,17)
                ,(1331,10)
                ,(1332,16)
                ,(1333,5)
                ,(1333,13)
                ,(1334,10)
                ,(1334,4)
                ,(1334,8)
                ,(1334,12)
                ,(1334,6)
                ,(1335,7)
                ,(1335,5)
                ,(1335,13)
                ,(1336,16)
                ,(1336,13)
                ,(1337,10)
                ,(1338,16)
                ,(1338,7)
                ,(1341,17)
                ,(1344,4)
                ,(1346,16)
                ,(1346,10)
                ,(1349,9)
                ,(1349,11)
                ,(1350,9)
                ,(1351,11)
                ,(1352,5)
                ,(1352,16)
                ,(1355,11)
                ,(1355,13)
                ,(1355,6)
                ,(1355,16)
                ,(1355,15)
                ,(1355,5)
                ,(1358,5)
                ,(1358,9)
                ,(1362,6)
                ,(1363,11)
                ,(1365,6)
                ,(1365,14)
                ,(1366,6)
                ,(1366,9)
                ,(1370,17)
                ,(1371,6)
                ,(1373,6)
                ,(1373,15)
                ,(1374,11)
                ,(1375,4)
                ,(1378,13)
                ,(1378,5)
                ,(1381,6)
                ,(1383,16)
                ,(1383,4)
                ,(1383,15)
                ,(1387,16)
                ,(1387,9)
                ,(1388,10)
                ,(1388,5)
                ,(1389,13)
                ,(1389,15)
                ,(1391,7)
                ,(1391,12)
                ,(1392,17)
                ,(1394,9)
                ,(1395,16)
                ,(1395,8)
                ,(1395,9)
                ,(1395,4)
                ,(1395,15)
                ,(1397,8)
                ,(1397,16)
                ,(1397,9)
                ,(1398,12)
                ,(1398,4)
                ,(1399,4);

                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  1 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  2 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  3 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  4 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  5 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  6 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  7 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  8 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  9 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  10 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  11 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  12 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  13 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  14 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  15 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  16 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  17 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  18 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  19 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  20 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  21 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  22 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  23 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  24 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  25 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  26 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  27 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  28 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  29 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  30 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  31 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  32 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  33 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  34 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  35 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  36 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  37 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  38 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  39 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  40 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  41 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  42 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  43 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  44 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  45 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  46 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  47 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  48 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  49 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  50 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  51 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  52 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  53 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  54 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  55 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  56 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  57 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  58 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  59 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  60 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  61 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  62 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  63 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  64 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  65 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  66 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  67 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  68 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  69 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  70 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  71 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  72 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  73 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  74 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  75 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  76 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  77 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  78 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  79 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  80 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  81 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  82 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  83 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  84 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  85 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  86 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  87 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  88 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  89 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  90 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  91 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  92 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  93 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  94 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  95 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  96 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  97 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  98 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  99 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  100 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  101 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  102 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  103 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  104 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  105 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  106 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  107 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  108 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  109 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  110 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  111 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  112 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  113 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  114 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  115 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  116 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  117 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  118 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  119 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  120 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  121 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  122 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  123 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  124 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  125 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  126 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  127 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  128 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  129 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  130 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  131 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  132 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  133 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  134 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  135 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  136 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  137 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  138 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  139 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  140 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  141 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  142 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  143 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  144 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  145 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  146 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  147 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  148 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  149 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  150 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  151 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  152 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  153 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  154 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  155 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  156 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  157 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  158 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  159 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  160 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  161 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  162 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  163 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  164 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  165 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  166 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  167 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  168 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  169 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  170 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  171 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  172 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  173 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  174 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  175 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  176 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  177 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  178 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  179 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  180 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  181 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  182 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  183 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  184 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  185 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  186 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  187 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  188 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  189 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  190 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  191 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  192 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  193 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  194 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  195 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  196 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  197 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  198 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  199 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  200 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  201 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  202 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  203 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  204 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  205 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  206 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  207 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  208 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  209 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  210 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  211 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  212 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  213 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  214 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  215 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  216 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  217 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  218 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  219 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  220 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  221 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  222 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  223 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  224 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  225 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  226 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  227 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  228 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  229 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  230 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  231 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  232 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  233 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  234 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  235 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  236 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  237 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  238 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  239 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  240 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  241 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  242 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  243 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  244 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  245 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  246 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  247 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  248 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  249 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  250 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  251 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  252 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  253 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  254 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  255 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  256 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  257 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  258 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  259 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  260 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  261 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  262 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  263 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  264 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  265 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  266 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  267 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  268 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  269 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  270 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  271 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  272 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  273 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  274 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  275 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  276 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  277 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  278 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  279 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  280 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  281 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  282 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  283 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  284 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  285 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  286 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  287 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  288 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  289 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  290 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  291 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  292 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  293 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  294 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  295 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  296 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  297 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  298 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  299 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  300 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  301 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  302 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  303 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  304 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  305 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  306 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  307 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  308 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  309 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  310 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  311 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  312 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  313 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  314 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  315 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  316 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  317 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  318 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  319 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  320 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  321 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  322 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  323 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  324 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  325 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  326 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  327 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  328 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  329 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  330 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  331 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  332 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  333 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  334 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  335 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  336 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  337 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  338 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  339 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  340 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  341 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  342 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  343 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  344 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  345 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  346 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  347 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  348 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  349 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  350 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  351 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  352 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  353 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  354 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  355 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  356 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  357 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  358 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  359 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  360 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  361 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  362 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  363 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  364 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  365 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  366 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  367 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  368 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  369 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  370 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  371 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  372 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  373 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  374 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  375 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  376 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  377 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  378 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  379 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  380 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  381 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  382 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  383 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  384 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  385 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  386 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  387 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  388 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  389 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  390 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  391 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  392 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  393 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  394 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  395 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  396 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  397 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  398 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  399 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  400 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  401 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  402 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  403 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  404 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  405 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  406 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  407 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  408 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  409 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  410 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  411 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  412 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  413 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  414 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  415 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  416 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  417 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  418 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  419 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  420 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  421 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  422 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  423 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  424 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  425 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  426 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  427 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  428 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  429 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  430 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  431 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  432 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  433 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  434 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  435 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  436 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  437 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  438 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  439 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  440 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  441 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  442 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  443 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  444 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  445 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  446 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  447 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  448 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  449 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  450 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  451 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  452 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  453 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  454 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  455 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  456 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  457 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  458 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  459 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  460 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  461 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  462 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  463 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  464 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  465 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  466 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  467 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  468 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  469 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  470 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  471 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  472 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  473 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  474 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  475 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  476 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  477 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  478 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  479 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  480 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  481 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  482 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  483 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  484 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  485 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  486 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  487 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  488 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  489 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  490 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  491 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  492 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  493 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  494 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  495 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  496 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  497 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  498 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  499 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  500 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  501 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  502 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  503 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  504 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  505 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  506 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  507 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  508 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  509 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  510 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  511 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  512 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  513 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  514 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  515 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  516 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  517 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  518 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  519 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  520 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  521 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  522 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  523 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  524 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  525 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  526 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  527 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  528 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  529 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  530 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  531 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  532 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  533 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  534 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  535 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  536 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  537 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  538 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  539 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  540 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  541 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  542 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  543 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  544 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  545 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  546 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  547 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  548 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  549 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  550 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  551 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  552 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  553 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  554 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  555 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  556 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  557 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  558 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  559 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  560 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  561 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  562 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  563 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  564 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  565 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  566 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  567 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  568 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  569 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  570 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  571 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  572 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  573 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  574 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  575 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  576 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  577 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  578 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  579 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  580 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  581 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  582 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  583 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  584 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  585 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  586 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  587 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  588 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  589 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  590 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  591 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  592 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  593 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  594 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  595 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  596 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  597 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  598 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  599 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  600 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  601 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  602 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  603 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  604 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  605 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  606 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  607 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  608 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  609 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  610 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  611 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  612 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  613 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  614 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  615 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  616 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  617 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  618 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  619 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  620 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  621 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  622 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  623 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  624 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  625 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  626 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  627 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  628 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  629 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  630 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  631 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  632 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  633 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  634 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  635 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  636 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  637 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  638 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  639 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  640 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  641 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  642 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  643 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  644 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  645 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  646 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  647 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  648 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  649 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  650 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  651 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  652 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  653 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  654 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  655 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  656 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  657 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  658 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  659 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  660 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  661 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  662 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  663 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  664 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  665 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  666 ;

                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  667 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  668 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  669 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  670 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  671 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  672 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  673 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  674 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  675 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  676 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  677 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  678 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  679 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  680 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  681 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  682 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  683 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  684 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  685 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  686 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  687 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  688 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  689 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  690 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  691 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  692 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  693 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  694 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  695 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  696 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  697 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  698 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  699 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  700 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  701 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  702 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  703 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  704 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  705 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  706 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  707 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  708 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  709 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  710 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  711 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  712 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  713 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  714 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  715 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  716 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  717 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  718 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  719 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  720 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  721 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  722 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  723 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  724 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  725 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  726 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  727 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  728 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  729 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  730 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  731 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  732 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  733 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  734 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  735 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  736 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  737 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  738 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  739 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  740 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  741 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  742 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  743 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  744 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  745 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  746 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  747 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  748 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  749 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  750 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  751 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  752 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  753 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  754 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  755 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  756 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  757 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  758 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  759 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  760 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  761 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  762 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  763 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  764 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  765 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  766 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  767 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  768 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  769 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  770 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  771 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  772 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  773 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  774 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  775 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  776 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  777 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  778 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  779 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  780 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  781 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  782 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  783 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  784 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  785 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  786 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  787 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  788 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  789 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  790 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  791 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  792 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  793 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  794 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  795 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  796 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  797 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  798 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  799 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  800 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  801 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  802 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  803 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  804 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  805 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  806 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  807 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  808 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  809 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  810 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  811 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  812 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  813 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  814 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  815 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  816 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  817 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  818 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  819 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  820 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  821 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  822 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  823 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  824 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  825 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  826 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  827 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  828 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  829 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  830 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  831 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  832 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  833 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  834 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  835 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  836 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  837 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  838 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  839 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  840 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  841 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  842 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  843 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  844 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  845 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  846 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  847 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  848 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  849 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  850 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  851 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  852 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  853 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  854 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  855 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  856 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  857 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  858 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  859 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  860 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  861 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  862 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  863 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  864 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  865 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  866 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  867 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  868 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  869 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  870 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  871 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  872 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  873 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  874 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  875 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  876 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  877 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  878 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  879 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  880 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  881 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  882 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  883 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  884 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  885 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  886 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  887 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  888 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  889 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  890 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  891 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  892 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  893 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  894 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  895 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  896 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  897 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  898 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  899 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  900 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  901 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  902 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  903 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  904 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  905 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  906 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  907 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  908 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  909 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  910 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  911 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  912 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  913 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  914 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  915 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  916 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  917 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  918 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  919 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.'
                WHERE WarehouseID =  920 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  921 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  922 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  923 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  924 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  925 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.'
                WHERE WarehouseID =  926 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  927 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  928 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  929 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.'
                WHERE WarehouseID =  930 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.'
                WHERE WarehouseID =  931 ;
                UPDATE Warehouses
                SET WarehouseInformation= 'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.'
                WHERE WarehouseID =  932 ;
