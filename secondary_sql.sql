CREATE TABLE IF NOT EXISTS Search_Log (
  SearchID int(11) NOT NULL auto_increment,
  UserID int(11),
  SearchTerms varchar(400),
  FromLatitude real,
  FromLongitude real,
  FromIP varchar(15),
  SearchTime timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (SearchID),
  FOREIGN KEY (UserID) REFERENCES phprbac_users(UserID));

CREATE TABLE IF NOT EXISTS User_Clicks (
  ClickID int(11) NOT NULL auto_increment,
  UserID int(11),
  FromSearchID int(11),
  SpaceID int(11),
  FromLatitude real,
  FromLongitude real,
  FromIP varchar(15),
  ClickTime timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (ClickID),
  FOREIGN KEY (UserID) REFERENCES phprbac_users(UserID),
  FOREIGN KEY (FromSearchID) REFERENCES Search_Log(SearchID));
