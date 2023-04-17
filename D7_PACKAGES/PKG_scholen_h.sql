CREATE OR REPLACE PACKAGE pkg_scholen
AS
    PROCEDURE empty_tables;

    PROCEDURE add_land(p_landCode IN VARCHAR2, p_landNaam IN VARCHAR2);

    PROCEDURE add_gemeente(
        p_postcode IN NUMBER,
        p_gemeente IN VARCHAR2,
        p_landid IN NUMBER
    );
    PROCEDURE add_gemeente(
        p_postcode IN NUMBER,
        p_gemeente IN VARCHAR2,
        p_land IN VARCHAR2
    );

    PROCEDURE add_school(
        p_naam IN VARCHAR2,
        p_straat IN VARCHAR2,
        p_huisnummer IN VARCHAR2,
        p_gemeentes_postcode IN NUMBER
    );
    PROCEDURE add_school(
        p_naam IN VARCHAR2,
        p_straat IN VARCHAR2,
        p_huisnummer IN VARCHAR2,
        p_gemeente IN VARCHAR2
    );

    PROCEDURE add_beheerder(
        p_voornaam IN VARCHAR2,
        p_achternaam IN VARCHAR2,
        p_emailadres IN VARCHAR2,
        p_wachtwoord IN VARCHAR2,
        p_geslacht IN VARCHAR2
    );

    PROCEDURE add_schoolbeheerder(p_schoolid IN NUMBER, p_beheerderid IN NUMBER);
    PROCEDURE add_schoolbeheerder(
        p_school IN VARCHAR2,
        p_beheerder_voornaam IN VARCHAR2,
        p_beheerder_achernaam IN VARCHAR2
    );

    PROCEDURE add_klas(
        p_schoolid IN NUMBER,
        p_naam IN VARCHAR2,
        p_leerjaar IN NUMBER
    );
    PROCEDURE add_klas(
        p_school IN VARCHAR2,
        p_naam IN VARCHAR2,
        p_leerjaar IN NUMBER
    );

    PROCEDURE add_leerling(
        p_klasid IN NUMBER,
        p_voornaam IN VARCHAR2,
        p_achternaam IN VARCHAR2,
        p_geslacht IN VARCHAR2,
        p_klasnummer IN NUMBER
    );
    PROCEDURE add_leerling(
        p_klas IN VARCHAR2,
        p_school IN VARCHAR2,
        p_voornaam IN VARCHAR2,
        p_achternaam IN VARCHAR2,
        p_geslacht IN VARCHAR2,
        p_klasnummer IN NUMBER
    );
END pkg_scholen;
