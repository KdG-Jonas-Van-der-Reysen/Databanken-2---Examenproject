CREATE OR REPLACE PACKAGE pkg_scholen
AS
    -- Moeten deze private?
    -- Random data generators
    FUNCTION random_number(p_lowerBound NUMBER, p_upperBound NUMBER) RETURN NUMBER;
    FUNCTION random_string(p_length NUMBER) RETURN VARCHAR2;
    FUNCTION random_date(date_start DATE, date_end DATE) RETURN DATE;
    FUNCTION random_street_name RETURN scholen.straat%TYPE;
    FUNCTION random_first_name RETURN beheerders.voornaam%TYPE;
    FUNCTION random_last_name RETURN beheerders.achternaam%TYPE;
    FUNCTION random_email(p_voornaam IN VARCHAR2, p_achternaam IN VARCHAR2) RETURN beheerders.emailadres%TYPE;
    FUNCTION random_geslacht RETURN beheerders.geslacht%TYPE;

    -- Random row selectors
    FUNCTION random_abonnement RETURN abonnementen.abonnementid%TYPE;
    FUNCTION random_postalcode RETURN gemeentes.postcode%TYPE;
    FUNCTION random_school RETURN scholen.schoolid%TYPE;
    FUNCTION random_beheerder RETURN beheerders.beheerderid%TYPE;

    -- Empty tables
    PROCEDURE empty_tables;

    -- Single row inserts
    PROCEDURE add_land(p_landCode IN VARCHAR2, p_landNaam IN VARCHAR2);
    PROCEDURE add_gemeente(
        p_postcode IN NUMBER,
        p_gemeente IN VARCHAR2,
        p_land IN VARCHAR2
    );
    PROCEDURE add_school_strings(
        p_naam IN VARCHAR2,
        p_straat IN VARCHAR2,
        p_huisnummer IN VARCHAR2,
        p_gemeente IN VARCHAR2,
        p_abonnement IN VARCHAR2);
    PROCEDURE add_beheerder(
        p_voornaam IN VARCHAR2,
        p_achternaam IN VARCHAR2,
        p_emailadres IN VARCHAR2,
        p_wachtwoord IN VARCHAR2,
        p_geslacht IN VARCHAR2
    );
    PROCEDURE add_schoolbeheerder(
        p_school IN VARCHAR2,
        p_beheerder_voornaam IN VARCHAR2,
        p_beheerder_achernaam IN VARCHAR2
    );
    PROCEDURE add_klas(
        p_school IN VARCHAR2,
        p_naam IN VARCHAR2,
        p_leerjaar IN NUMBER
    );
    PROCEDURE add_leerling(
        p_klas IN VARCHAR2,
        p_school IN VARCHAR2,
        p_voornaam IN VARCHAR2,
        p_achternaam IN VARCHAR2,
        p_geslacht IN VARCHAR2,
        p_klasnummer IN NUMBER
    );
    PROCEDURE add_abonnement(
        p_naam IN VARCHAR2,
        p_prijs IN NUMBER,
        p_supportSLA IN NUMBER
    );

    -- Multiple row generation many-to-many
    PROCEDURE generateSchools(p_amount IN NUMBER);
    PROCEDURE generateBeheerders(p_amount NUMBER);
    PROCEDURE generateRandomSchoolBeheerders(p_amount NUMBER);
    PROCEDURE genereer_veel_op_veel(
        p_amount_schools NUMBER,
        p_amount_beheerders NUMBER,
        p_amount_schoolBeheerders NUMBER
    );

    -- Multiple row generation 3 deep
    PROCEDURE generateClassesForEachSchool(p_amount_of_classes NUMBER);
    PROCEDURE generatePupilsForEachClass(p_amount_of_pupils NUMBER);
    PROCEDURE generate_2_levels(
        p_amount_of_classes NUMBER,
        p_amount_of_pupils NUMBER
    );

    -- Bewijs milestone 5
    PROCEDURE bewijs_milestone_5;

    -- Optellen gegeven tabel Z voor rij uit tabel X
    PROCEDURE calculate_pupils_of_gender_in_school(p_school_name scholen.naam%TYPE, p_gender leerlingen.geslacht%TYPE);

END pkg_scholen;

