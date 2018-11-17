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
