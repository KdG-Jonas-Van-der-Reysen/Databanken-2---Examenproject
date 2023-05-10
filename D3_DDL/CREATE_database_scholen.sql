DROP TABLE leerlingen;
DROP TABLE klassen;
DROP TABLE schoolbeheerders;
DROP TABLE beheerders;
DROP TABLE scholen;
DROP TABLE abonnementen;
DROP TABLE gemeentes;
DROP TABLE landen;


CREATE TABLE beheerders
(
    beheerderid NUMBER(6) GENERATED ALWAYS AS IDENTITY (start with 1 increment by 1) NOT NULL PRIMARY KEY,
    voornaam    VARCHAR2(25 BYTE),
    achternaam  VARCHAR2(50 BYTE),
    emailadres  VARCHAR2(320 BYTE)                                                   NOT NULL,
    wachtwoord  VARCHAR2(20 BYTE)                                                    NOT NULL,
    geslacht    CHAR(1)
        CONSTRAINT beheerder_geslacht_MVX CHECK ( geslacht IN ('M', 'V', 'X') )
);

CREATE TABLE landen
(
    landid   number(6) GENERATED ALWAYS AS IDENTITY (start with 1 increment by 1) NOT NULL PRIMARY KEY,
    landcode VARCHAR2(2),
    landnaam VARCHAR(20)
);

CREATE TABLE gemeentes
(
    postcode      VARCHAR2(6) NOT NULL PRIMARY KEY,
    gemeente      VARCHAR2(20),
    landen_landid NUMBER(6)
);

CREATE TABLE klassen
(
    klasid           NUMBER(6) GENERATED ALWAYS AS IDENTITY (start with 1 increment by 1) NOT NULL PRIMARY KEY,
    scholen_schoolid NUMBER(6)                                                            NOT NULL,
    naam             VARCHAR2(15),
    leerjaar         NUMBER                                                               NOT NULL
        CONSTRAINT klassen_leerjaar_1_6 CHECK ( leerjaar BETWEEN 1 AND 6 )
);

CREATE TABLE leerlingen
(
    leerlingid     NUMBER(6) GENERATED ALWAYS AS IDENTITY (start with 1 increment by 1) NOT NULL PRIMARY KEY,
    klassen_klasid NUMBER(6)                                                            NOT NULL,
    voornaam       VARCHAR2(25),
    achternaam     VARCHAR2(50),
    geslacht       CHAR(1)
        CONSTRAINT leerlingen_geslacht_MVX CHECK ( geslacht IN ('M', 'V', 'X') ),
    klasnummer     NUMBER                                                               NOT NULL
        CONSTRAINT leerlingen_klasnummer_tss_0_40 CHECK ( klasnummer BETWEEN 1 AND 40 ),
    score NUMBER(3, 0)
        CONSTRAINT leerlingen_score_percentage_tss_0_100 CHECK ( score BETWEEN 0 AND 100 )
);

CREATE TABLE scholen
(
    schoolid                  NUMBER(6) GENERATED ALWAYS AS IDENTITY (start with 1 increment by 1) NOT NULL PRIMARY KEY,
    naam                      VARCHAR2(25 BYTE),
    straat                    VARCHAR2(20 BYTE),
    huisnummer                VARCHAR2(6 BYTE),
    gemeentes_postcode        VARCHAR2(6)                                                          NOT NULL,
    abonnementen_abonnementId NUMBER(6)
);

CREATE TABLE schoolbeheerders
(
    scholen_schoolid       NUMBER(6) NOT NULL,
    beheerders_beheerderid NUMBER(6) NOT NULL,
    CONSTRAINT schoolbeheerders_pk PRIMARY KEY (scholen_schoolid, beheerders_beheerderid)
);

CREATE TABLE abonnementen
(
    abonnementid  NUMBER(6) GENERATED ALWAYS AS IDENTITY (start with 1 increment by 1) NOT NULL PRIMARY KEY,
    naam          VARCHAR2(25 BYTE),
    prijsPerMaand NUMBER(6, 2)                                                         NOT NULL,
    supportSLA    NUMBER(6)
);

ALTER TABLE klassen
    ADD CONSTRAINT klassen_scholen_fk FOREIGN KEY (scholen_schoolid)
        REFERENCES scholen (schoolid);

ALTER TABLE leerlingen
    ADD CONSTRAINT leerlingen_klassen_fk FOREIGN KEY (klassen_klasid)
        REFERENCES klassen (klasid);

ALTER TABLE scholen
    ADD CONSTRAINT scholen_gemeentes_fk FOREIGN KEY (gemeentes_postcode)
        REFERENCES gemeentes (postcode)
    ADD CONSTRAINT abonnementen_scholen_fk FOREIGN KEY (abonnementen_abonnementId)
        REFERENCES abonnementen (abonnementId);

ALTER TABLE gemeentes
    ADD CONSTRAINT gemeentes_landen_fk FOREIGN KEY (landen_landid)
        REFERENCES landen (landid);

ALTER TABLE schoolbeheerders
    ADD CONSTRAINT schoolbeheerders_beheerders_fk FOREIGN KEY (beheerders_beheerderid)
        REFERENCES beheerders (beheerderid)
            ON DELETE CASCADE;

ALTER TABLE schoolbeheerders
    ADD CONSTRAINT schoolbeheerders_scholen_fk FOREIGN KEY (scholen_schoolid)
        REFERENCES scholen (schoolid)
            ON DELETE CASCADE;