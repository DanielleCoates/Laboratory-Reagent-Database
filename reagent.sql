# my-ddl.sql


# Drop all tables

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS reagent;
DROP TABLE IF EXISTS storage;
DROP TABLE IF EXISTS supplier;
DROP TABLE IF EXISTS supply;

# ... 
SET FOREIGN_KEY_CHECKS=1;

# Create reagent( id, name, CAS nubmer, chemical formula, molecular weight, description, 
# concentration, form, color, density, melting point, boiling point, solubility)
# 
# CAS number - unique identifier by american chemical society in the form of numbers and dashes ex: NaCl = 7647-14-5
# 

BEGIN;
CREATE TABLE reagent(
    id int primary key,
    name varchar(32) NOT NULL,
    CAS varchar(32) UNIQUE,
    chemicalFormula varchar(32) NOT NULL,
    molecularWeight decimal(10, 2)
    description varchar(1024) NOT NULL,
    concentration decimal(6,2) NOT NULL,
    form varchar(32),
    color varchar(32),
    density varchar(32),
    meltingPoint decimal(10,2),
    boilingPoint decimal(10,2),
    solubility varchar(32)

);
COMMIT;

BEGIN;
# create supplier(id, manufacturer, catalog number, unit price)
CREATE TABLE supplier(
    id int primary key,
    manufacturer varchar(64),
    catalogNumber varchar(64),
    unitPrice decimal(20,2),
    purchaseURL varchar(108)

);
COMMIT;


# Create reagent_supply(supplier_id, reagent_id, quantity available, dateRecieved, dateOpened, expirationDate)

BEGIN;
CREATE TABLE reagent_supply (
    reagent_id int foreign key,
    supplier_id int foreign key, 
    dateRecieved date NOT NULL,
    dateOpened date NOT NULL,
    expirationDate date NOT NULL,

    PRIMARY KEY(reagent_id, supplier_id),
    FOREIGN KEY(reagent_id) REFERENCES reagent(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(supplier_id) REFERENCES supplier(id) ON DELETE CASCADE ON UPDATE CASCADE
);
COMMIT;



BEGIN;
# Section 6
# Create safety( id, skills_id, people_id, date_acquired )
CREATE TABLE safety(
    reagent_id int primary key,
    hazardClassification varchar(64),
    safetyDataSheetLink varchar(128),
    storageConditions varchar(256),
    FOREIGN KEY(reagent_id) REFERENCES reagent(id) ON DELETE CASCADE ON UPDATE CASCADE
);
COMMIT;


