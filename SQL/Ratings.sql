CREATE TABLE IF NOT EXISTS RatingFor (
  RatingForID int(11) AUTO_INCREMENT,
  RatingFor varchar(15) NOT NULL,
  PRIMARY KEY(RatingForID)
);

INSERT INTO RatingFor VALUES
(1,'Lessee'),
(2,'Space'),
(3,'Warehouse'),
(4,'Owner');

-- TODO might want to foreign key 'rating for' to Role Id
CREATE TABLE IF NOT EXISTS Rating_Types (
  RatingID int(11) AUTO_INCREMENT,
  RatingLongName VARCHAR(150) NOT NULL,
  RatingResultDescription varchar(150) NOT NULL,
  RatingFor int(11) NOT NULL,
  RatingType varchar(12),
  Value int(4),
  PRIMARY KEY(RatingID),
  FOREIGN KEY(RatingFor) REFERENCES RatingFor(RatingForID)
);

-- TODO numeric vs text responses
INSERT INTO Rating_Types (RatingLongName, RatingResultDescription, RatingFor) VALUES
('The space was how messey?', 'The messiness that the lessee left the space after their use', )

CREATE TABLE IF NOT EXISTS Contract_Ratings_Text (
  ContractID int(11),
  RatingID int(11),
  RatingResult varchar(500),
  PositivityRating real DEFAULT NULL,
  PRIMARY KEY(contractID, RatingID),
  FOREIGN KEY(ContractID) REFERENCES Contracts(ContractID),
  FOREIGN KEY(ContractID) REFERENCES Rating_(RatingID)
)
