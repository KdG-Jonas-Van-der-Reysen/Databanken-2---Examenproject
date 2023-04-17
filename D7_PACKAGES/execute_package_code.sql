BEGIN
    pkg_scholen.empty_tables();


    -- Landen
    /*INSERT INTO landen(landcode, landnaam)
    VALUES ('be', 'België');*/

    pkg_scholen.add_land('be','België');

-- Gemeentes
    /*INSERT INTO GEMEENTES (POSTCODE, GEMEENTE, LANDEN_LANDID)
    VALUES (2990, 'Wuustwezel', (SELECT landid from landen where LANDNAAM = 'België'));*/
    pkg_scholen.add_gemeente(2990, 'Wuustwezel', 'België');

    /*INSERT INTO GEMEENTES (POSTCODE, GEMEENTE, LANDEN_LANDID)
    VALUES (2960, 'Brecht', (SELECT landid from landen where LANDNAAM = 'België'));*/
    pkg_scholen.add_gemeente(2960, 'Brecht', 'België');


    /*INSERT INTO GEMEENTES (POSTCODE, GEMEENTE, LANDEN_LANDID)
    VALUES (2920, 'Kalmthout', (SELECT landid from landen where LANDNAAM = 'België'));*/
    pkg_scholen.add_gemeente(2920, 'Kalmthout', 'België');

    /*INSERT INTO GEMEENTES (POSTCODE, GEMEENTE, LANDEN_LANDID)
    VALUES (2910, 'Essen', (SELECT landid from landen where LANDNAAM = 'België'));*/
    pkg_scholen.add_gemeente(2910, 'Essen', 'België');

-- Scholen
    /*INSERT INTO SCHOLEN (NAAM, STRAAT, HUISNUMMER, GEMEENTES_POSTCODE)
    VALUES ('GBS t Blokje', 'Kerkblokstraat', 14, 2990);*/
    pkg_scholen.add_school('GBS t Blokje', 'Kerkblokstraat', 14, 'Wuustwezel');

    /*INSERT INTO SCHOLEN (NAAM, STRAAT, HUISNUMMER, GEMEENTES_POSTCODE)
    VALUES ('Basisschool int groen', 'Leopoldstraat', 15, 2960);*/
    pkg_scholen.add_school('Basisschool int groen', 'Leopoldstraat', 15, 'Brecht');

    /*INSERT INTO SCHOLEN (NAAM, STRAAT, HUISNUMMER, GEMEENTES_POSTCODE)
    VALUES ('GBS Kadrie', 'Driehoekstraat', 41, 2920);*/
    pkg_scholen.add_school('GBS Kadrie', 'Driehoekstraat', 41, 'Kalmthout');

    /*INSERT INTO SCHOLEN (NAAM, STRAAT, HUISNUMMER, GEMEENTES_POSTCODE)
    VALUES ('GBS Wigo', 'De Vondert', 1, 2910);*/
    pkg_scholen.add_school('GBS Wigo', 'De Vondert', 1, 'Essen');

    /*INSERT INTO SCHOLEN (NAAM, STRAAT, HUISNUMMER, GEMEENTES_POSTCODE)
    VALUES ('GBS De Klimboom', 'Klimboomstraat', 1, 2990);*/
    pkg_scholen.add_school('GBS De Klimboom', 'Klimboomstraat', 1, 'Wuustwezel');

-- Beheerders
    /*INSERT INTO BEHEERDERS (VOORNAAM, ACHTERNAAM, EMAILADRES, WACHTWOORD, GESLACHT)
    VALUES ('Jef', 'Janssens', 'jef.janssens@hotmail.com', 'jef', 'M');*/
    pkg_scholen.add_beheerder('Jef','Janssens','jef.janssens@hotmail.com','jef','M');

    /*INSERT INTO BEHEERDERS (VOORNAAM, ACHTERNAAM, EMAILADRES, WACHTWOORD, GESLACHT)
    VALUES ('Laura', 'Peters', 'laura.peters@gmail.com', 'laura', 'V');*/
    pkg_scholen.add_beheerder('Laura','Peters','laura.peters@gmail.com','laura','V');

    /*INSERT INTO BEHEERDERS (VOORNAAM, ACHTERNAAM, EMAILADRES, WACHTWOORD, GESLACHT)
    VALUES ('Peter', 'Vermeulen', 'peter.vermeulen@yahoo.com', 'peter', 'X');*/
    pkg_scholen.add_beheerder('Peter','Vermeulen','peter.vermeulen@yahoo.com','peter','X');

    /*INSERT INTO BEHEERDERS (VOORNAAM, ACHTERNAAM, EMAILADRES, WACHTWOORD, GESLACHT)
    VALUES ('Marie', 'De Vries', 'marie.devries@outlook.com', 'marie', 'V');*/
    pkg_scholen.add_beheerder('Marie','De Vries','marie.devries@outlook.com','marie','V');

    /*INSERT INTO BEHEERDERS (VOORNAAM, ACHTERNAAM, EMAILADRES, WACHTWOORD, GESLACHT)
    VALUES ('Jan', 'Van der Meer', 'jan.vandermeer@gmail.com', 'jan', 'M');*/
    pkg_scholen.add_beheerder('Jan','Van der Meer','jan.vandermeer@gmail.com','jan','M');

    -- Schoolbeheerders
-- s1
-- b1
    /*INSERT INTO SCHOOLBEHEERDERS (SCHOLEN_SCHOOLID, BEHEERDERS_BEHEERDERID)
    values ((select SCHOOLID from SCHOLEN where NAAM = 'GBS t Blokje'),
            (select BEHEERDERID from BEHEERDERS where VOORNAAM = 'Jef'));*/
    pkg_scholen.add_schoolbeheerder('GBS t Blokje','Jef','Janssens');
-- s3
-- b3
    /*INSERT INTO SCHOOLBEHEERDERS (SCHOLEN_SCHOOLID, BEHEERDERS_BEHEERDERID)
    values ((select SCHOOLID from SCHOLEN where NAAM = 'GBS Kadrie'),
            (select BEHEERDERID from BEHEERDERS where VOORNAAM = 'Peter'));*/
    pkg_scholen.add_schoolbeheerder('GBS Kadrie','Peter','Vermeulen');

-- s4
-- b1
    /*INSERT INTO SCHOOLBEHEERDERS (SCHOLEN_SCHOOLID, BEHEERDERS_BEHEERDERID)
    values ((select SCHOOLID from SCHOLEN where NAAM = 'GBS Wigo'),
            (select BEHEERDERID from BEHEERDERS where VOORNAAM = 'Jef'));*/
    pkg_scholen.add_schoolbeheerder('GBS Wigo','Jef','Janssens');

-- s4
-- b3
    /*INSERT INTO SCHOOLBEHEERDERS (SCHOLEN_SCHOOLID, BEHEERDERS_BEHEERDERID)
    values ((select SCHOOLID from SCHOLEN where NAAM = 'GBS Wigo'),
            (select BEHEERDERID from BEHEERDERS where VOORNAAM = 'Peter'));*/
    pkg_scholen.add_schoolbeheerder('GBS Wigo','Peter','Vermeulen');

-- s5
-- b2
    /*INSERT INTO SCHOOLBEHEERDERS (SCHOLEN_SCHOOLID, BEHEERDERS_BEHEERDERID)
    values ((select SCHOOLID from SCHOLEN where NAAM = 'GBS De Klimboom'),
            (select BEHEERDERID from BEHEERDERS where VOORNAAM = 'Laura'));*/
    pkg_scholen.add_schoolbeheerder('GBS De Klimboom','Laura','Peters');

-- Klassen
    /*INSERT INTO KLASSEN (SCHOLEN_SCHOOLID, NAAM, LEERJAAR)
    VALUES ((select SCHOOLID from SCHOLEN where NAAM = 'GBS t Blokje'), '1A', 1);*/
    pkg_scholen.add_klas('GBS t Blokje', '1A', 1);

    /*INSERT INTO KLASSEN (SCHOLEN_SCHOOLID, NAAM, LEERJAAR)
    VALUES ((select SCHOOLID from SCHOLEN where NAAM = 'GBS t Blokje'), '1B', 1);*/
    pkg_scholen.add_klas('GBS t Blokje', '1B', 1);

    /*INSERT INTO KLASSEN (SCHOLEN_SCHOOLID, NAAM, LEERJAAR)
    VALUES ((select SCHOOLID from SCHOLEN where NAAM = 'GBS t Blokje'), '2A', 2);*/
    pkg_scholen.add_klas('GBS t Blokje', '2A', 2);

    /*INSERT INTO KLASSEN (SCHOLEN_SCHOOLID, NAAM, LEERJAAR)
    VALUES ((select SCHOOLID from SCHOLEN where NAAM = 'GBS t Blokje'), '2B', 2);*/
    pkg_scholen.add_klas('GBS t Blokje', '2B', 2);

    /*INSERT INTO KLASSEN (SCHOLEN_SCHOOLID, NAAM, LEERJAAR)
    VALUES ((select SCHOOLID from SCHOLEN where NAAM = 'Basisschool int groen'), '1A', 1);*/
    pkg_scholen.add_klas('Basisschool int groen', '1A', 1);

    /*INSERT INTO KLASSEN (SCHOLEN_SCHOOLID, NAAM, LEERJAAR)
    VALUES ((select SCHOOLID from SCHOLEN where NAAM = 'Basisschool int groen'), '1B', 1);*/
    pkg_scholen.add_klas('Basisschool int groen', '1B', 1);

    /*INSERT INTO KLASSEN (SCHOLEN_SCHOOLID, NAAM, LEERJAAR)
    VALUES ((select SCHOOLID from SCHOLEN where NAAM = 'Basisschool int groen'), '2A', 2); */
    pkg_scholen.add_klas('Basisschool int groen', '2A', 2);

    /*INSERT INTO KLASSEN (SCHOLEN_SCHOOLID, NAAM, LEERJAAR)
    VALUES ((select SCHOOLID from SCHOLEN where NAAM = 'Basisschool int groen'), '2B', 2);*/
    pkg_scholen.add_klas('Basisschool int groen', '2B', 2);

-- Leerlingen
    /*INSERT INTO LEERLINGEN (KLASSEN_KLASID, VOORNAAM, ACHTERNAAM, GESLACHT, KLASNUMMER)
    VALUES ((select KLASID
             from KLASSEN
             where NAAM = '1A'
               and SCHOLEN_SCHOOLID = (select SCHOOLID from SCHOLEN where NAAM = 'GBS t Blokje')),
            'Jef', 'Janssens', 'M', 1);*/
    pkg_scholen.add_leerling('1A', 'GBS t Blokje', 'Jef','Janssens','M', 1);

    /*INSERT INTO LEERLINGEN (KLASSEN_KLASID, VOORNAAM, ACHTERNAAM, GESLACHT, KLASNUMMER)
    VALUES ((select KLASID
             from KLASSEN
             where NAAM = '1B'
               and SCHOLEN_SCHOOLID = (select SCHOOLID from SCHOLEN where NAAM = 'GBS t Blokje')), 'Sofie', 'Peeters', 'V',
            2);*/
    pkg_scholen.add_leerling('1B', 'GBS t Blokje', 'Sofie','Peeters','V', 2);

    /*INSERT INTO LEERLINGEN (KLASSEN_KLASID, VOORNAAM, ACHTERNAAM, GESLACHT, KLASNUMMER)
    VALUES ((select KLASID
             from KLASSEN
             where NAAM = '2B'
               and SCHOLEN_SCHOOLID = (select SCHOOLID from SCHOLEN where NAAM = 'GBS t Blokje')), 'Tom', 'Vermeulen', 'M',
            3);*/
    pkg_scholen.add_leerling('2B', 'GBS t Blokje', 'Tom','Vermeulen','M', 3);

    /*INSERT INTO LEERLINGEN (KLASSEN_KLASID, VOORNAAM, ACHTERNAAM, GESLACHT, KLASNUMMER)
    VALUES ((select KLASID
             from KLASSEN
             where NAAM = '1A'
               and SCHOLEN_SCHOOLID = (select SCHOOLID from SCHOLEN where NAAM = 'GBS t Blokje')), 'Lisa', 'De Smet', 'V',
            4);*/
    pkg_scholen.add_leerling('1A', 'GBS t Blokje', 'Lisa','De Smet','V', 4);

    /*INSERT INTO LEERLINGEN (KLASSEN_KLASID, VOORNAAM, ACHTERNAAM, GESLACHT, KLASNUMMER)
    VALUES ((select KLASID
             from KLASSEN
             where NAAM = '1A'
               and SCHOLEN_SCHOOLID = (select SCHOOLID from SCHOLEN where NAAM = 'Basisschool int groen')), 'Bart',
            'Van Damme', 'M', 5);*/
    pkg_scholen.add_leerling('1A', 'Basisschool int groen', 'Bart','Van Damme','M', 5);

    /*INSERT INTO LEERLINGEN (KLASSEN_KLASID, VOORNAAM, ACHTERNAAM, GESLACHT, KLASNUMMER)
    VALUES ((select KLASID
             from KLASSEN
             where NAAM = '1A'
               and SCHOLEN_SCHOOLID = (select SCHOOLID from SCHOLEN where NAAM = 'Basisschool int groen')), 'Bert',
            'Van Sesamstraat', 'M', 6);*/
    pkg_scholen.add_leerling('1A', 'Basisschool int groen', 'Bert','Van Sesamstraat','M', 6);

    /*INSERT INTO LEERLINGEN (KLASSEN_KLASID, VOORNAAM, ACHTERNAAM, GESLACHT, KLASNUMMER)
    VALUES ((select KLASID
             from KLASSEN
             where NAAM = '2A'
               and SCHOLEN_SCHOOLID = (select SCHOOLID from SCHOLEN where NAAM = 'Basisschool int groen')), 'Bert',
            'Van Sesamstraat', 'M', 6);*/
    pkg_scholen.add_leerling('2A', 'Basisschool int groen', 'Bert','Van Sesamstraat','M', 6);

    /*INSERT INTO LEERLINGEN (KLASSEN_KLASID, VOORNAAM, ACHTERNAAM, GESLACHT, KLASNUMMER)
    VALUES ((select KLASID
             from KLASSEN
             where NAAM = '2A'
               and SCHOLEN_SCHOOLID = (select SCHOOLID from SCHOLEN where NAAM = 'Basisschool int groen')), 'Ernie',
            'Van de Banaan', 'M', 7);*/
    pkg_scholen.add_leerling('2A', 'Basisschool int groen', 'Ernie','Van de Banaan','M', 7);

END
