BEGIN
    pkg_scholen.empty_tables();
    COMMIT;
END;

-- Manual fill
BEGIN
   pkg_scholen.manual_fill();
END;


-- Milestone 5
BEGIN
    pkg_scholen.empty_tables();
    pkg_scholen.basic_seed();
    pkg_scholen.BEWIJS_MILESTONE_5();
    COMMIT;
end;

-- Milestone 6
BEGIN
    pkg_scholen.printreport_2_levels(3, 2, 5);
end;

DELETE FROM LEERLINGEN WHERE KLASSEN_KLASID = 7;
COMMIT;

-- Milestone 7
BEGIN
    pkg_scholen.empty_tables();
    pkg_scholen.basic_seed();

    pkg_scholen.BEWIJS_MILESTONE_7();
    COMMIT;
end;

BEGIN
    pkg_scholen.Comparison_Single_Bulk_M7(20,40,50);
    pkg_scholen.Comparison_Single_Bulk_M7(20,40,500);
end;
