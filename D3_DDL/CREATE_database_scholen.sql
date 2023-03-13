DROP TABLE leerlingen CASCADE CONSTRAINTS;
DROP TABLE klassen CASCADE CONSTRAINTS;
DROP TABLE schoolbeheerders CASCADE CONSTRAINTS;
DROP TABLE beheerders CASCADE CONSTRAINTS;
DROP TABLE gemeentes CASCADE CONSTRAINTS;
DROP TABLE scholen CASCADE CONSTRAINTS;


CREATE TABLE beheerders
(
    beheerderid NUMBER(6) GENERATED ALWAYS AS IDENTITY (start with 1 increment by 1) NOT NULL PRIMARY KEY,
    voornaam    VARCHAR2(25 BYTE),
    achternaam  VARCHAR2(50 BYTE),
    emailadres  VARCHAR2(320 BYTE)                                                     NOT NULL,
    wachtwoord  VARCHAR2(20 BYTE)                                                      NOT NULL,
    geslacht    CHAR(1) CHECK ( geslacht IN ('M', 'V', 'X') )
);

CREATE TABLE gemeentes
(
    postcode VARCHAR2(6) NOT NULL PRIMARY KEY,
    gemeente VARCHAR2(20),
    land     VARCHAR2(20)
);

CREATE TABLE klassen
(
    klasid           NUMBER(6) GENERATED ALWAYS AS IDENTITY (start with 1 increment by 1) NOT NULL PRIMARY KEY,
    scholen_schoolid NUMBER(6)                                                                NOT NULL,
    naam             VARCHAR2(15),
    leerjaar         NUMBER                                                                 NOT NULL CHECK ( leerjaar BETWEEN 1 AND 6 )
);

CREATE TABLE leerlingen
(
    leerlingid     NUMBER(6) GENERATED ALWAYS AS IDENTITY (start with 1 increment by 1) NOT NULL PRIMARY KEY,
    klassen_klasid NUMBER(6)                                                            NOT NULL,
    voornaam       VARCHAR2(25),
    achternaam     VARCHAR2(50),
    geslacht       CHAR(1) CHECK ( geslacht IN ('M', 'V', 'X') ),
    klasnummer     NUMBER                                                                 NOT NULL
);

CREATE TABLE scholen
(
    schoolid           NUMBER(6) GENERATED ALWAYS AS IDENTITY (start with 1 increment by 1) NOT NULL PRIMARY KEY,
    naam               VARCHAR2(25 BYTE),
    straat             VARCHAR2(20 BYTE),
    huisnummer         VARCHAR2(6 BYTE),
    gemeentes_postcode VARCHAR2(6)                                                        NOT NULL
);

CREATE TABLE schoolbeheerders
(
    scholen_schoolid       NUMBER(6)     NOT NULL,
    beheerders_beheerderid NUMBER(6) NOT NULL,
    CONSTRAINT schoolbeheerders_pk PRIMARY KEY ( scholen_schoolid, beheerders_beheerderid )
);

ALTER TABLE klassen
    ADD CONSTRAINT klassen_scholen_fk FOREIGN KEY (scholen_schoolid)
        REFERENCES scholen (schoolid);

ALTER TABLE leerlingen
    ADD CONSTRAINT leerlingen_klassen_fk FOREIGN KEY (klassen_klasid)
        REFERENCES klassen (klasid);

ALTER TABLE scholen
    ADD CONSTRAINT scholen_gemeentes_fk FOREIGN KEY (gemeentes_postcode)
        REFERENCES gemeentes (postcode);

ALTER TABLE schoolbeheerders
    ADD CONSTRAINT schoolbeheerders_beheerders_fk FOREIGN KEY (beheerders_beheerderid)
        REFERENCES beheerders (beheerderid)
            ON DELETE CASCADE;

ALTER TABLE schoolbeheerders
    ADD CONSTRAINT schoolbeheerders_scholen_fk FOREIGN KEY (scholen_schoolid)
        REFERENCES scholen (schoolid)
            ON DELETE CASCADE;