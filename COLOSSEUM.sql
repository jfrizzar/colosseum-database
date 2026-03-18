DROP DATABASE IF EXISTS COLOSSEUM;
CREATE DATABASE COLOSSEUM;
USE COLOSSEUM;

/*
For historical reasons any integer/decimal number that would usually be represented as so 
will be represented in Roman numerals for historical purposes.
*/

CREATE TABLE GLADIATOR(
	GLADIATOR_ID VARCHAR(10) PRIMARY KEY, 
    FIRST_NAME VARCHAR(25) NOT NULL,
    LAST_NAME VARCHAR(25) NOT NULL,
    SUFFIX VARCHAR(10),
    YOB VARCHAR(10), /*Year of birth*/
    BIOGRAPHY VARCHAR(300)
    );
    
CREATE TABLE ARMORY(
	WEAPON_ID VARCHAR(10) PRIMARY KEY,
	WEAPON_TYPE VARCHAR(50) NOT NULL,
    LONG_RANGE CHAR(1) NOT NULL, #Can be T or F
    MATERIAL VARCHAR(20) NOT NULL
    );


CREATE TABLE ANIMAL(
	SPECIES VARCHAR(50) PRIMARY KEY,
    COIN_TYPE VARCHAR(10) NOT NULL, /*Coin type can be gold, silver, bronze, etc.*/
    COIN_COUNT VARCHAR(10) NOT NULL
    );

/*
A Lanista is comparable to a manager/boss of gladiator(s).
*/
CREATE TABLE LANISTA(
	LANISTA_ID VARCHAR(10) PRIMARY KEY, 
    FIRST_NAME VARCHAR(25) NOT NULL,
    LAST_NAME VARCHAR(25) NOT NULL,
    SUFFIX VARCHAR(5),
    YOB VARCHAR(10)
);

CREATE TABLE MANAGES(
	LANISTA_ID VARCHAR(4),
    GLADIATOR_ID VARCHAR(4),
    PRIMARY KEY (LANISTA_ID, GLADIATOR_ID),
    FOREIGN KEY(LANISTA_ID) REFERENCES LANISTA(LANISTA_ID),
    FOREIGN KEY(GLADIATOR_ID) REFERENCES GLADIATOR(GLADIATOR_ID)
);

/*CREATE TABLE EXHIBITION (
GLADIATOR VARCHAR(4), #Add weapon relation, it is many to many so a bridge has to be created with the weapons table
SPECIES VARCHAR(50),
#WEAPON_TYPE VARCHAR(50), Limit is 2
#DEGREES
#CLOUDS
#WIND
PRIMARY KEY (GLADIATOR, SPECIES),
FOREIGN KEY (GLADIATOR) REFERENCES GLADIATOR(GLADIATOR_ID),
FOREIGN KEY (SPECIES) REFERENCES ANIMAL_TYPE(SPECIES)
);

/*Insert at least 5 records for each table*/

INSERT INTO GLADIATOR VALUES 
('I', 'Spartacus', 'Prospectus', 'III','XXII', 'Spartacus is a Thracian gladiator
 who was one of the escaped slave leaders in the Third Servile War, a major slave 
 uprising against the Roman Republic.'),
 
('II', 'Flamma', 'Maximus','I', 'XXVI', 'Flamma is a revolutionary Syrian, and
dissatisfied Roman auxiliary. He was most likely forced into slavery and then 
into a gladiator school. He fought as a secutor, a class of gladiators 
in Rome. His common opponents were thus retiarii. '),

('III', 'Commodus', 'Flavicus', 'V', 'XX', ''),
('IIII', 'Crixus', 'Attilius', 'II', 'XVII', ''),
('V', 'Carpophorus', 'Hermes', 'I', 'XXXI', '');

INSERT INTO LANISTA VALUES 
('I', 'Johnaticus', 'Doeius', '', 'XX'),
('II', 'Marcus', 'Proclius', 'II', 'I'),
('III', 'Edwardicus', 'Clippius', '', 'III'),
('IIII', 'Laynius', 'Trisius', 'III', 'XV'),
('V', 'Tixius', 'Clipto', '', 'XXX');

INSERT INTO MANAGES VALUES 
('I', 'II'),
('I', 'III'),
('II', 'II'),
('III', 'IIII'),
('IIII', 'V'),
('IIII', 'I'),
('V', 'III');

/*2 Table Query
Show all lanistas and the amount of times they appear as managers*/
SELECT CONCAT_WS(' ', LANISTA.FIRST_NAME, LANISTA.LAST_NAME) AS 'Lanista'
FROM LANISTA, MANAGES
WHERE LANISTA.LANISTA_ID = MANAGES.LANISTA_ID;

/*3 Table Query
Show all lanistas and the gladiators that they manage in alphabetical order of The gladiator's first name*/
SELECT CONCAT_WS(' ', LANISTA.FIRST_NAME, LANISTA.LAST_NAME) AS 'Lanista', CONCAT_WS(' ', GLADIATOR.FIRST_NAME, GLADIATOR.LAST_NAME) AS 'Gladiator'
FROM LANISTA, GLADIATOR, MANAGES
WHERE LANISTA.LANISTA_ID = MANAGES.LANISTA_ID
AND MANAGES.GLADIATOR_ID = GLADIATOR.GLADIATOR_ID 
ORDER BY GLADIATOR.FIRST_NAME;

/*TODO
Create a special query with IN or EXISTS*/
SELECT *
FROM LANISTA
WHERE EXISTS(
SELECT FIRST_NAME FROM LANISTA
WHERE LANISTA_ID = "II");

/*TODO
INSERT INTO ARMORY VALUES 
('I', 'Longsword', 'F', 'Steel'),
('II', 'Dagger', 'F', 'Steel'),
('III', 'Scimitar', 'F', 'Bronze'),
('IIII', 'Longbow', 'T', 'Wood'),
('V', 'Crossbow', 'F', 'Wood');*/






