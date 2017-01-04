-- Last modification date: 2016-12-31 14:51:16.07

-- tables

DROP TABLE Alerts ;
DROP TABLE Measurments;
DROP TABLE Sensors;


-- Table: Alerts
CREATE TABLE Alerts (
    sensor varchar(20)  NOT NULL,
    date timestamp  NOT NULL,
    description varchar(100)  NOT NULL
);

-- Table: Measurments
CREATE TABLE Measurments (
    value int  NOT NULL,
    sensor varchar(20)  NOT NULL,
    measureDate timestamp  NOT NULL
);

-- Table: Sensors
CREATE TABLE Sensors (
    mac varchar(20)  NOT NULL,
    type int  NOT NULL, --1 - temp , 2- motion, 3- heater
    description varchar(100)  NOT NULL,
    status int NOT NULL,
    CONSTRAINT Sensors_pk PRIMARY KEY (mac, type)
);

INSERT INTO Sensors (mac, type, description, status) VALUES (
  '00126FC21D7C', 1, 'drzwi wejsciowe', 1
);

INSERT INTO Sensors (mac, type, description, status) VALUES (
  '00126FC21D7C', 2, 'drzwi wejsciowe', 1
);

INSERT INTO Sensors (mac, type, description, status) VALUES (
  '00126FC21D7C', 1, 'drzwi wejsciowe', 1
);

INSERT INTO Sensors (mac, type, description, status) VALUES (
  '00126FC21D7C', 1, 'drzwi wejsciowe', 1
);

commit;


-- End of file.
