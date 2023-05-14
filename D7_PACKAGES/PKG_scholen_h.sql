CREATE OR REPLACE PACKAGE pkg_scholen
AS
    -- Empty tables


    -- Single row inserts
    PROCEDURE add_land(
        p_landCode IN VARCHAR2, p_landNaam IN VARCHAR2
    );
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
        p_klasnummer IN NUMBER,
        p_score IN NUMBER
    );
    PROCEDURE add_abonnement(
        p_naam IN VARCHAR2,
        p_prijs IN NUMBER,
        p_supportSLA IN NUMBER
    );

    -- =======================
    -- Generating data (bulk)
    -- =======================
    PROCEDURE genereer_veel_op_veel(
        p_amount_schools NUMBER,
        p_amount_beheerders NUMBER,
        p_amount_schoolBeheerders NUMBER
    );
    PROCEDURE generate_2_levels(
        p_amount_of_classes NUMBER,
        p_amount_of_pupils NUMBER
    );

    -- =======================
    -- Generating data
    -- =======================
    PROCEDURE genereer_veel_op_veel_bulk(
        p_amount_schools NUMBER,
        p_amount_beheerders NUMBER,
        p_amount_schoolBeheerders NUMBER
    );
    PROCEDURE generate_2_levels_bulk(
        p_amount_of_classes NUMBER,
        p_amount_of_pupils NUMBER
    );

    -- =======================
    -- Milestone 5 bewijs
    -- =======================
    PROCEDURE bewijs_milestone_5;

    -- ===========================
    -- Data management procedures
    -- ===========================

    PROCEDURE empty_tables;
    PROCEDURE calculate_pupils_of_gender_in_school(p_school_name scholen.naam%TYPE, p_gender leerlingen.geslacht%TYPE);
    PROCEDURE printreport_2_levels(p_n_schools NUMBER, p_n_classes NUMBER, p_n_pupils NUMBER);

END pkg_scholen;

