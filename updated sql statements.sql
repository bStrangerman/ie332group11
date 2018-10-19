CREATE TABLE Login_Info (
    username varchar(25),
    password varchar(25),
    PRIMARY KEY(username));
CREATE TABLE Owner (
    username varchar(25),
    name varchar(25),
    email varchar(25),
    phone_number varchar(11),
    PRIMARY KEY(username),
    FOREIGN KEY(username) REFERENCES Login_Info(username)
    ON DELETE CASCADE);

CREATE TABLE Lessee (
    username varchar(25),
    name varchar(25),
    zip_code varchar(5),
    email varchar(25),
    phone_number varchar(11),
    PRIMARY KEY(username),
    FOREIGN KEY(username) REFERENCES Login_Info (username)
    ON DELETE CASCADE);

CREATE TABLE Warehouse (
    warehouseID int(6) NOT NULL auto_increment,
    owner_username varchar(25) NOT NULL,
    size int,
    average_cost int,
    num_spaces int,
    address varchar(25),
    PRIMARY KEY(warehouseID),
    FOREIGN KEY(owner_username) REFERENCES Owner(username));

CREATE TABLE Spaces (
    spaceID int(6) NOT NULL auto_increment,
    warehouseID int(6) NOT NULL,
    size int,
    price int,
    storage_type varchar(25),
    PRIMARY KEY(spaceID),
    FOREIGN KEY(warehouseID) REFERENCES Warehouse(warehouseID));

CREATE TABLE Schedule (
    scheduleID int(6) NOT NULL auto_increment,
    spaceID int(6) NOT NULL,
    lessee_username varchar(25),
    start_date datetime,
    end_date datetime,
    warehouse_rating int(1),
    lessee_rating int(1),
    amount_charged int,
    contract_text text,
    reserved_time datetime,
    confirmed_time datetime,
    approved_time datetime,
    denied_time datetime,
    PRIMARY KEY(scheduleID),
    FOREIGN KEY(spaceID) REFERENCES Spaces(spaceID) ON DELETE CASCADE,
    FOREIGN KEY(lessee_username) REFERENCES Lessee(username));
CREATE TABLE Amenities (
    ID int(6) NOT NULL auto_increment,
    amenity_type varchar(50),
    PRIMARY KEY(ID));
CREATE TABLE Includes (
    spaceID int(6),
    ID int(6),
    PRIMARY KEY(spaceID, ID),
    FOREIGN KEY(spaceID) REFERENCES Spaces(spaceID),
    FOREIGN KEY(ID) REFERENCES Amenities(ID));
