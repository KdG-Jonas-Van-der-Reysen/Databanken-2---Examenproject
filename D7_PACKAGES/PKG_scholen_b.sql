CREATE
    OR REPLACE PACKAGE BODY pkg_scholen AS
    -- Private helper (mostly lookup) functions
    FUNCTION lookup_land(p_land IN varchar2) RETURN NUMBER IS
        v_landid landen.landid % TYPE;

    BEGIN
        SELECT landid
        INTO v_landid
        FROM landen
        WHERE landnaam = p_land;

        return v_landid;

    END lookup_land;

    FUNCTION lookup_gemeente(p_naam IN varchar2) RETURN NUMBER IS
        v_postcode landen.landid % TYPE;
    BEGIN
        SELECT postcode
        INTO v_postcode
        FROM GEMEENTES
        WHERE LOWER(gemeente) = LOWER(p_naam);

        return v_postcode;

    END lookup_gemeente;

    FUNCTION lookup_school(p_school IN varchar2) RETURN NUMBER IS
        v_schoolid scholen.schoolid % TYPE;

    BEGIN
        SELECT schoolid
        INTO v_schoolid
        FROM scholen
        WHERE naam = p_school;

        RETURN v_schoolid;

    END lookup_school;

    FUNCTION lookup_beheerder(p_voornaam IN VARCHAR2, p_achternaam IN VARCHAR2) RETURN NUMBER IS
        v_beheerderid beheerders.beheerderid % TYPE;

    BEGIN
        SELECT beheerderid
        INTO v_beheerderid
        FROM beheerders
        WHERE LOWER(voornaam) = LOWER(p_voornaam)
          AND LOWER(achternaam) = LOWER(p_achternaam);

        RETURN v_beheerderid;

    END lookup_beheerder;

    FUNCTION lookup_klas(p_klasnaam IN VARCHAR2, p_schoolnaam IN VARCHAR2)
        RETURN NUMBER IS
        v_klasid klassen.klasid % TYPE;
        v_schoolid scholen.schoolid % TYPE;
    BEGIN
        v_schoolid := lookup_school(p_schoolnaam);

        SELECT klasid
        INTO v_klasid
        FROM klassen
        WHERE LOWER(naam) = LOWER(p_klasnaam)
          AND scholen_schoolid = v_schoolid;

        RETURN v_klasid;
    END lookup_klas;


-- Public procedures & functions
    PROCEDURE empty_tables IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate TABLE leerlingen';

        EXECUTE IMMEDIATE 'truncate TABLE klassen';

        EXECUTE IMMEDIATE 'truncate TABLE schoolbeheerders';

        EXECUTE IMMEDIATE 'truncate TABLE beheerders';

        EXECUTE IMMEDIATE 'truncate TABLE scholen';

        EXECUTE IMMEDIATE 'truncate TABLE gemeentes';

        DBMS_OUTPUT.PUT_LINE('De tabellen zijn leeggemaakt');

    END empty_tables;

-- Add land
    PROCEDURE add_land(p_landCode IN VARCHAR2, p_landNaam IN VARCHAR2) IS
    BEGIN
        INSERT INTO landen(landcode, landnaam)
        VALUES (p_landCode, p_landNaam);

    END;

-- Add gemeente met landid
    PROCEDURE add_gemeente(
        p_postcode IN NUMBER,
        p_gemeente IN VARCHAR2,
        p_landid IN NUMBER
    ) IS
    BEGIN
        INSERT INTO GEMEENTES (POSTCODE, GEMEENTE, LANDEN_LANDID)
        VALUES (p_postcode, p_gemeente, p_landid);

    END add_gemeente;

-- Add gemeente met landnaam
    PROCEDURE add_gemeente(
        p_postcode IN NUMBER,
        p_gemeente IN VARCHAR2,
        p_land IN VARCHAR2
    ) IS
        v_landid landen.landid % TYPE;

    BEGIN
        v_landid := lookup_land(p_land);

        add_gemeente(p_postcode, p_gemeente, v_landid);

    END add_gemeente;

-- Add school met postcode
    PROCEDURE add_school(
        p_naam IN VARCHAR2,
        p_straat IN VARCHAR2,
        p_huisnummer IN VARCHAR2,
        p_gemeentes_postcode IN NUMBER
    ) IS
    BEGIN
        INSERT INTO SCHOLEN (NAAM, STRAAT, HUISNUMMER, GEMEENTES_POSTCODE)
        VALUES (p_naam,
                p_straat,
                p_huisnummer,
                p_gemeentes_postcode);

    END add_school;

-- Add school met gemeente naam
    PROCEDURE add_school(
        p_naam IN VARCHAR2,
        p_straat IN VARCHAR2,
        p_huisnummer IN VARCHAR2,
        p_gemeente IN VARCHAR2
    ) IS
        v_gemeentes_postcode gemeentes.postcode % TYPE;

    BEGIN
        v_gemeentes_postcode := lookup_gemeente(p_gemeente);
        add_school(
                p_naam,
                p_straat,
                p_huisnummer,
                v_gemeentes_postcode
            );

    END add_school;

-- Add beheerder
    PROCEDURE add_beheerder(
        p_voornaam IN VARCHAR2,
        p_achternaam IN VARCHAR2,
        p_emailadres IN VARCHAR2,
        p_wachtwoord IN VARCHAR2,
        p_geslacht IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO BEHEERDERS (VOORNAAM,
                                ACHTERNAAM,
                                EMAILADRES,
                                WACHTWOORD,
                                GESLACHT)
        VALUES (p_voornaam,
                p_achternaam,
                p_emailadres,
                p_wachtwoord,
                p_geslacht);

    END add_beheerder;

-- Add schoolbeheerder
    PROCEDURE add_schoolbeheerder(p_schoolid IN NUMBER, p_beheerderid IN NUMBER) IS
    BEGIN
        INSERT INTO SCHOOLBEHEERDERS (SCHOLEN_SCHOOLID, BEHEERDERS_BEHEERDERID)
        VALUES (p_schoolid, p_beheerderid);

    END add_schoolbeheerder;

-- Add schoolbeheerder met school naam & beheerder voor- en achternaam
    PROCEDURE add_schoolbeheerder(
        p_school IN VARCHAR2,
        p_beheerder_voornaam IN VARCHAR2,
        p_beheerder_achernaam IN VARCHAR2
    ) IS
        v_schoolid    scholen.schoolid % TYPE;
        v_beheerderid beheerders.beheerderid % TYPE;

    BEGIN
        v_schoolid := lookup_school(p_school);

        v_beheerderid := lookup_beheerder(p_beheerder_voornaam, p_beheerder_achernaam);

        add_schoolbeheerder(v_schoolid, v_beheerderid);

    END add_schoolbeheerder;

-- Add klassen
    PROCEDURE add_klas(
        p_schoolid IN NUMBER,
        p_naam IN VARCHAR2,
        p_leerjaar IN NUMBER
    ) IS
    BEGIN
        INSERT INTO KLASSEN (SCHOLEN_SCHOOLID, NAAM, LEERJAAR)
        VALUES (p_schoolid, p_naam, p_leerjaar);

    END add_klas;

-- Add klassen met school naam
    PROCEDURE add_klas(
        p_school IN VARCHAR2,
        p_naam IN VARCHAR2,
        p_leerjaar IN NUMBER
    ) IS
        v_schoolid scholen.schoolid % TYPE;

    BEGIN
        v_schoolid := lookup_school(p_school);

        add_klas(v_schoolid, p_naam, p_leerjaar);

    END add_klas;

-- Add leerling
    PROCEDURE add_leerling(
        p_klasid IN NUMBER,
        p_voornaam IN VARCHAR2,
        p_achternaam IN VARCHAR2,
        p_geslacht IN VARCHAR2,
        p_klasnummer IN NUMBER
    ) IS
    BEGIN
        INSERT INTO LEERLINGEN (KLASSEN_KLASID, VOORNAAM, ACHTERNAAM, GESLACHT, KLASNUMMER)
        VALUES (p_klasid, p_voornaam, p_achternaam, p_geslacht, p_klasnummer);
    END add_leerling;

    -- Add leerling met klas naam en school naam
    PROCEDURE add_leerling(
        p_klas IN VARCHAR2,
        p_school IN VARCHAR2,
        p_voornaam IN VARCHAR2,
        p_achternaam IN VARCHAR2,
        p_geslacht IN VARCHAR2,
        p_klasnummer IN NUMBER
    ) IS
        v_klasid klassen.klasid % TYPE;
    BEGIN
        v_klasid := lookup_klas(p_klas, p_school);

        add_leerling(v_klasid, p_voornaam, p_achternaam, p_geslacht, p_klasnummer);
    END add_leerling;


END pkg_scholen;