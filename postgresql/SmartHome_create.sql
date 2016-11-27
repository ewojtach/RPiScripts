-- Last modification date: 2016-12-31 14:51:16.07

-- tables
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
    date timestamp  NOT NULL
);

-- Table: Sensors
CREATE TABLE Sensors (
    mac varchar(20)  NOT NULL,
    type int  NOT NULL,
    description varchar(100)  NOT NULL,
    CONSTRAINT Sensors_pk PRIMARY KEY (mac)
);

-- foreign keys
-- Reference: Alerts_Sensors (table: Alerts)
ALTER TABLE Alerts ADD CONSTRAINT Alerts_Sensors
    FOREIGN KEY (sensor)
    REFERENCES Sensors (mac)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Measurments_Sensors (table: Measurments)
ALTER TABLE Measurments ADD CONSTRAINT Measurments_Sensors
    FOREIGN KEY (sensor)
    REFERENCES Sensors (mac)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

