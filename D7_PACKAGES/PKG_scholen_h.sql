CREATE OR REPLACE PACKAGE pkg_scholen
AS
    -- =======================
    -- Manual fill
    -- =======================
    PROCEDURE basic_seed;
    PROCEDURE manual_fill;

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
    -- Milestone 5 & 7 bewijs
    -- =======================
    PROCEDURE bewijs_milestone_5;
    PROCEDURE bewijs_milestone_7;
    PROCEDURE Comparison_Single_Bulk_M7(p_amount_schools NUMBER, p_amount_classes NUMBER, p_amount_pupils NUMBER);

    -- ===========================
    -- Data management procedures
    -- ===========================

    PROCEDURE empty_tables;
    PROCEDURE calculate_pupils_of_gender_in_school(p_school_name scholen.naam%TYPE, p_gender leerlingen.geslacht%TYPE);
    PROCEDURE printreport_2_levels(p_n_schools NUMBER, p_n_classes NUMBER, p_n_pupils NUMBER);

END pkg_scholen;

