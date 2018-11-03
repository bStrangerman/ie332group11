CREATE TABLE IF NOT EXISTS Notification_Types_Types (
  TypeTypeID int(11) AUTO_INCREMENT,
  TypeTypeShortName varchar(12) UNIQUE,
  TypeTypeName varchar(30),
  TypeTypeIcon varchar(30),
  PRIMARY KEY(TypeTypeID)
);

INSERT INTO Notification_Types_Types (TypeTypeShortName, TypeTypeName, TypeTypeIcon)
VALUES ('contract', 'Contract Update', 'fa-bell');

CREATE TABLE IF NOT EXISTS Notification_Types (
  TypeID int(11) AUTO_INCREMENT,
  TypeTypeID int(11),
  TypeShortName varchar(12) UNIQUE,
  TypeName varchar(30),
  TypeIcon varchar(30),
  PRIMARY KEY(TypeID),
  FOREIGN KEY(TypeTypeID) REFERENCES Notification_Types_Types(TypeTypeID)
);

INSERT INTO `notification_types` (`TypeID`, `TypeTypeID`, `TypeShortName`, `TypeName`, `TypeIcon`) VALUES
(1, 'approved', 'Approved Contract', 'fa-check'),
(1, 'denied', 'Denied Contract', 'fa-times');

CREATE TABLE IF NOT EXISTS Notifications (
  NotificationID int(11) AUTO_INCREMENT,
  UserID int(11),
  NotificationType int(11),
  Message varchar(200),
  NotificationTime timestamp DEFAULT CURRENT_TIMESTAMP,
  LinksTo varchar(100),
  PRIMARY KEY(NotificationID),
  FOREIGN KEY(UserID) REFERENCES phprbac_users(UserID),
  FOREIGN KEY(NotificationType) REFERENCES Notification_Types(TypeID)
);
