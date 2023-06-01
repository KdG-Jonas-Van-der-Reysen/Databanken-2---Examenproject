CREATE OR REPLACE PACKAGE pkg_scholen
AS
    -- =======================
    -- Manual fill
    -- =======================
    PROCEDURE basic_seed;
    PROCEDURE manual_fill;

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

