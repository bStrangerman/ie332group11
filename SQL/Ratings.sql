CREATE TABLE IF NOT EXISTS RatingFor (
  RatingForID int(11) AUTO_INCREMENT,
  RatingFor varchar(15) NOT NULL,
  PRIMARY KEY(RatingForID)
);

INSERT INTO RatingFor VALUES
(1,'Lessee'),
(2,'Space'),
(3,'Warehouse'),
(4,'Owner'),
(5,'Our Company');

CREATE TABLE IF NOT EXISTS Numeric_Rating_Types (
  NumericRatingID int(11) AUTO_INCREMENT,
  RatingShortName VARCHAR(15) NOT NULL UNIQUE,
  RatingResultDescription varchar(150) NOT NULL,
  RatingFor int(11) NOT NULL,
  PRIMARY KEY(NumericRatingID),
  FOREIGN KEY(RatingFor) REFERENCES RatingFor(RatingForID) ON DELETE RESTRICT
);

INSERT INTO Numeric_Rating_Types (RatingShortName, RatingResultDescription, RatingFor) VALUES
  ('Overall', '','2'),
  ('Accuracy', '','2'),
  ('Communication', '','2'),
  ('StaffFriend', '','2'),
  ('Location', '','2'),
  ('SpaceValue', '','2');

CREATE TABLE IF NOT EXISTS Text_Rating_Types (
  TextRatingID int(11) AUTO_INCREMENT,
  RatingShortName VARCHAR(15) NOT NULL UNIQUE,
  RatingResultDescription varchar(150) NOT NULL,
  RatingFor int(11) NOT NULL,
  PRIMARY KEY(TextRatingID),
  FOREIGN KEY(RatingFor) REFERENCES RatingFor(RatingForID) ON DELETE RESTRICT
);

INSERT INTO Text_Rating_Types (RatingShortName, RatingResultDescription, RatingFor) VALUES
  ('Title', '', '2'),
  ('Body', '', '2'),
  ('Feedback', '', '2');

CREATE TABLE IF NOT EXISTS Numeric_Contract_Ratings (
  ContractID int(11),
  NumericRatingID int(11),
  RatingResult int(5),
  PRIMARY KEY(ContractID, NumericRatingID),
  FOREIGN KEY(ContractID) REFERENCES Contracts(ContractID) ON DELETE CASCADE,
  FOREIGN KEY(NumericRatingID) REFERENCES Numeric_Rating_Types(NumericRatingID) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Ratings_Pictures (
  ContractID int(11),
  FileName varchar(50) UNIQUE,
  Description varchar(400),
  PRIMARY KEY(ContractID, FileName),
  FOREIGN KEY(ContractID) REFERENCES Contracts(ContractID) ON DELETE CASCADE,
);

CREATE TABLE IF NOT EXISTS Text_Contract_Ratings (
  ContractID int(11),
  TextRatingID int(11),
  RatingResult int(5),
  PRIMARY KEY(ContractID, TextRatingID),
  FOREIGN KEY(ContractID) REFERENCES Contracts(ContractID) ON DELETE CASCADE,
  FOREIGN KEY(TextRatingID) REFERENCES Text_Rating_Types(TextRatingID) ON DELETE RESTRICT
);
