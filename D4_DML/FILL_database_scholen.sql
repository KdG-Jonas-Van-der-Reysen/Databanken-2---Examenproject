-- Landen
INSERT INTO landen(landcode, landnaam)
VALUES ('be', 'België');

-- Abonnementen
INSERT INTO abonnementen (NAAM, PRIJSPERMAAND, SUPPORTSLA)
VALUES ('Standaard',10.00,40);

INSERT INTO abonnementen (NAAM, PRIJSPERMAAND, SUPPORTSLA)
VALUES ('Premium',20.00,24);

INSERT INTO abonnementen (NAAM, PRIJSPERMAAND, SUPPORTSLA)
VALUES ('Platinum',50.00,8);

-- Gemeentes
INSERT INTO GEMEENTES (POSTCODE, GEMEENTE, LANDEN_LANDID)
VALUES (2990, 'Wuustwezel', (SELECT landid from landen where LANDNAAM = 'België'));

INSERT INTO GEMEENTES (POSTCODE, GEMEENTE, LANDEN_LANDID)
VALUES (2960, 'Brecht', (SELECT landid from landen where LANDNAAM = 'België'));

INSERT INTO GEMEENTES (POSTCODE, GEMEENTE, LANDEN_LANDID)
VALUES (2920, 'Kalmthout', (SELECT landid from landen where LANDNAAM = 'België'));

INSERT INTO GEMEENTES (POSTCODE, GEMEENTE, LANDEN_LANDID)
VALUES (2910, 'Essen', (SELECT landid from landen where LANDNAAM = 'België'));

-- Scholen
INSERT INTO SCHOLEN (NAAM, STRAAT, HUISNUMMER, GEMEENTES_POSTCODE, ABONNEMENTEN_ABONNEMENTID)
VALUES ('GBS t Blokje', 'Kerkblokstraat', 14, 2990, (SELECT abonnementid from abonnementen WHERE naam = 'Standaard'));

INSERT INTO SCHOLEN (NAAM, STRAAT, HUISNUMMER, GEMEENTES_POSTCODE, ABONNEMENTEN_ABONNEMENTID)
VALUES ('Basisschool int groen', 'Leopoldstraat', 15, 2960, (SELECT abonnementid from abonnementen WHERE naam = 'Premium'));

INSERT INTO SCHOLEN (NAAM, STRAAT, HUISNUMMER, GEMEENTES_POSTCODE, ABONNEMENTEN_ABONNEMENTID)
VALUES ('GBS Kadrie', 'Driehoekstraat', 41, 2920, (SELECT abonnementid from abonnementen WHERE naam = 'Standaard'));

INSERT INTO SCHOLEN (NAAM, STRAAT, HUISNUMMER, GEMEENTES_POSTCODE, ABONNEMENTEN_ABONNEMENTID)
VALUES ('GBS Wigo', 'De Vondert', 1, 2910, (SELECT abonnementid from abonnementen WHERE naam = 'Platinum'));

INSERT INTO SCHOLEN (NAAM, STRAAT, HUISNUMMER, GEMEENTES_POSTCODE, ABONNEMENTEN_ABONNEMENTID)
VALUES ('GBS De Klimboom', 'Klimboomstraat', 1, 2990, (SELECT abonnementid from abonnementen WHERE naam = 'Standaard'));

-- Beheerders
INSERT INTO BEHEERDERS (VOORNAAM, ACHTERNAAM, EMAILADRES, WACHTWOORD, GESLACHT)
VALUES ('Jef', 'Janssens', 'jef.janssens@hotmail.com', 'jef', 'M');

INSERT INTO BEHEERDERS (VOORNAAM, ACHTERNAAM, EMAILADRES, WACHTWOORD, GESLACHT)
VALUES ('Laura', 'Peters', 'laura.peters@gmail.com', 'laura', 'V');

INSERT INTO BEHEERDERS (VOORNAAM, ACHTERNAAM, EMAILADRES, WACHTWOORD, GESLACHT)
VALUES ('Peter', 'Vermeulen', 'peter.vermeulen@yahoo.com', 'peter', 'X');

INSERT INTO BEHEERDERS (VOORNAAM, ACHTERNAAM, EMAILADRES, WACHTWOORD, GESLACHT)
VALUES ('Marie', 'De Vries', 'marie.devries@outlook.com', 'marie', 'V');

INSERT INTO BEHEERDERS (VOORNAAM, ACHTERNAAM, EMAILADRES, WACHTWOORD, GESLACHT)
VALUES ('Jan', 'Van der Meer', 'jan.vandermeer@gmail.com', 'jan', 'M');

-- Schoolbeheerders
-- s1
-- b1
INSERT INTO SCHOOLBEHEERDERS (SCHOLEN_SCHOOLID, BEHEERDERS_BEHEERDERID)
values ((select SCHOOLID from SCHOLEN where NAAM = 'GBS t Blokje'),
        (select BEHEERDERID from BEHEERDERS where VOORNAAM = 'Jef'));

-- s3
-- b3
INSERT INTO SCHOOLBEHEERDERS (SCHOLEN_SCHOOLID, BEHEERDERS_BEHEERDERID)
values ((select SCHOOLID from SCHOLEN where NAAM = 'GBS Kadrie'),
        (select BEHEERDERID from BEHEERDERS where VOORNAAM = 'Peter'));

-- s4
-- b1
INSERT INTO SCHOOLBEHEERDERS (SCHOLEN_SCHOOLID, BEHEERDERS_BEHEERDERID)
values ((select SCHOOLID from SCHOLEN where NAAM = 'GBS Wigo'),
        (select BEHEERDERID from BEHEERDERS where VOORNAAM = 'Jef'));

-- s4
-- b3
INSERT INTO SCHOOLBEHEERDERS (SCHOLEN_SCHOOLID, BEHEERDERS_BEHEERDERID)
values ((select SCHOOLID from SCHOLEN where NAAM = 'GBS Wigo'),
        (select BEHEERDERID from BEHEERDERS where VOORNAAM = 'Peter'));

-- s5
-- b2
INSERT INTO SCHOOLBEHEERDERS (SCHOLEN_SCHOOLID, BEHEERDERS_BEHEERDERID)
values ((select SCHOOLID from SCHOLEN where NAAM = 'GBS De Klimboom'),
        (select BEHEERDERID from BEHEERDERS where VOORNAAM = 'Laura'));

-- Klassen
INSERT INTO KLASSEN (SCHOLEN_SCHOOLID, NAAM, LEERJAAR)
VALUES ((select SCHOOLID from SCHOLEN where NAAM = 'GBS t Blokje'), '1A', 1);

INSERT INTO KLASSEN (SCHOLEN_SCHOOLID, NAAM, LEERJAAR)
VALUES ((select SCHOOLID from SCHOLEN where NAAM = 'GBS t Blokje'), '1B', 1);

INSERT INTO KLASSEN (SCHOLEN_SCHOOLID, NAAM, LEERJAAR)
VALUES ((select SCHOOLID from SCHOLEN where NAAM = 'GBS t Blokje'), '2A', 2);

INSERT INTO KLASSEN (SCHOLEN_SCHOOLID, NAAM, LEERJAAR)
VALUES ((select SCHOOLID from SCHOLEN where NAAM = 'GBS t Blokje'), '2B', 2);

INSERT INTO KLASSEN (SCHOLEN_SCHOOLID, NAAM, LEERJAAR)
VALUES ((select SCHOOLID from SCHOLEN where NAAM = 'Basisschool int groen'), '1A', 1);

INSERT INTO KLASSEN (SCHOLEN_SCHOOLID, NAAM, LEERJAAR)
VALUES ((select SCHOOLID from SCHOLEN where NAAM = 'Basisschool int groen'), '1B', 1);

INSERT INTO KLASSEN (SCHOLEN_SCHOOLID, NAAM, LEERJAAR)
VALUES ((select SCHOOLID from SCHOLEN where NAAM = 'Basisschool int groen'), '2A', 2);

INSERT INTO KLASSEN (SCHOLEN_SCHOOLID, NAAM, LEERJAAR)
VALUES ((select SCHOOLID from SCHOLEN where NAAM = 'Basisschool int groen'), '2B', 2);

-- Leerlingen
INSERT INTO LEERLINGEN (KLASSEN_KLASID, VOORNAAM, ACHTERNAAM, GESLACHT, KLASNUMMER)
VALUES ((select KLASID
         from KLASSEN
         where NAAM = '1A'
           and SCHOLEN_SCHOOLID = (select SCHOOLID from SCHOLEN where NAAM = 'GBS t Blokje')),
        'Jef', 'Janssens', 'M', 1);

INSERT INTO LEERLINGEN (KLASSEN_KLASID, VOORNAAM, ACHTERNAAM, GESLACHT, KLASNUMMER)
VALUES ((select KLASID
         from KLASSEN
         where NAAM = '1B'
           and SCHOLEN_SCHOOLID = (select SCHOOLID from SCHOLEN where NAAM = 'GBS t Blokje')), 'Sofie', 'Peeters', 'V',
        2);

INSERT INTO LEERLINGEN (KLASSEN_KLASID, VOORNAAM, ACHTERNAAM, GESLACHT, KLASNUMMER)
VALUES ((select KLASID
         from KLASSEN
         where NAAM = '2B'
           and SCHOLEN_SCHOOLID = (select SCHOOLID from SCHOLEN where NAAM = 'GBS t Blokje')), 'Tom', 'Vermeulen', 'M',
        3);

INSERT INTO LEERLINGEN (KLASSEN_KLASID, VOORNAAM, ACHTERNAAM, GESLACHT, KLASNUMMER)
VALUES ((select KLASID
         from KLASSEN
         where NAAM = '1A'
           and SCHOLEN_SCHOOLID = (select SCHOOLID from SCHOLEN where NAAM = 'GBS t Blokje')), 'Lisa', 'De Smet', 'V',
        4);

INSERT INTO LEERLINGEN (KLASSEN_KLASID, VOORNAAM, ACHTERNAAM, GESLACHT, KLASNUMMER, SCORE)
VALUES ((select KLASID
         from KLASSEN
         where NAAM = '1A'
           and SCHOLEN_SCHOOLID = (select SCHOOLID from SCHOLEN where NAAM = 'Basisschool int groen')), 'Bart',
        'Van Damme', 'M', 5, 75);

INSERT INTO LEERLINGEN (KLASSEN_KLASID, VOORNAAM, ACHTERNAAM, GESLACHT, KLASNUMMER, SCORE)
VALUES ((select KLASID
         from KLASSEN
         where NAAM = '1A'
           and SCHOLEN_SCHOOLID = (select SCHOOLID from SCHOLEN where NAAM = 'Basisschool int groen')), 'Bert',
        'Van Sesamstraat', 'M', 6, 75);

INSERT INTO LEERLINGEN (KLASSEN_KLASID, VOORNAAM, ACHTERNAAM, GESLACHT, KLASNUMMER, SCORE)
VALUES ((select KLASID
         from KLASSEN
         where NAAM = '2A'
           and SCHOLEN_SCHOOLID = (select SCHOOLID from SCHOLEN where NAAM = 'Basisschool int groen')), 'Ernie',
        'Van de Banaan', 'M', 7, 75);
