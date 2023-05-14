BEGIN
    pkg_scholen.empty_tables();
    COMMIT;
END;

-- Manual fill
BEGIN
    pkg_scholen.add_land('be', 'België');

    pkg_scholen.add_abonnement('Standaard', 10.00, 40);
    pkg_scholen.add_abonnement('Premium', 20.00, 24);
    pkg_scholen.add_abonnement('Platinum', 50.00, 8);

    pkg_scholen.add_gemeente(2990, 'Wuustwezel', 'België');
    pkg_scholen.add_gemeente(2960, 'Brecht', 'België');
    pkg_scholen.add_gemeente(2920, 'Kalmthout', 'België');
    pkg_scholen.add_gemeente(2910, 'Essen', 'België');

    pkg_scholen.add_school_strings('GBS t Blokje', 'Kerkblokstraat', 14, 'Wuustwezel', 'Standaard');
    pkg_scholen.add_school_strings('Basisschool int groen', 'Leopoldstraat', 15, 'Brecht', 'Premium');
    pkg_scholen.add_school_strings('GBS Kadrie', 'Driehoekstraat', 41, 'Kalmthout', 'Standaard');
    pkg_scholen.add_school_strings('GBS Wigo', 'De Vondert', 1, 'Essen', 'Platinum');
    pkg_scholen.add_school_strings('GBS De Klimboom', 'Klimboomstraat', 1, 'Wuustwezel', 'Standaard');

    pkg_scholen.add_beheerder('Jef', 'Janssens', 'jef.janssens@hotmail.com', 'jef', 'M');
    pkg_scholen.add_beheerder('Laura', 'Peters', 'laura.peters@gmail.com', 'laura', 'V');
    pkg_scholen.add_beheerder('Peter', 'Vermeulen', 'peter.vermeulen@yahoo.com', 'peter', 'X');
    pkg_scholen.add_beheerder('Marie', 'De Vries', 'marie.devries@outlook.com', 'marie', 'V');
    pkg_scholen.add_beheerder('Jan', 'Van der Meer', 'jan.vandermeer@gmail.com', 'jan', 'M');

    pkg_scholen.add_schoolbeheerder('GBS t Blokje', 'Jef', 'Janssens');
    pkg_scholen.add_schoolbeheerder('GBS Kadrie', 'Peter', 'Vermeulen');
    pkg_scholen.add_schoolbeheerder('GBS Wigo', 'Jef', 'Janssens');
    pkg_scholen.add_schoolbeheerder('GBS Wigo', 'Peter', 'Vermeulen');
    pkg_scholen.add_schoolbeheerder('GBS De Klimboom', 'Laura', 'Peters');

    pkg_scholen.add_klas_string('GBS t Blokje', '1A', 1);
    pkg_scholen.add_klas_string('GBS t Blokje', '1B', 1);
    pkg_scholen.add_klas_string('GBS t Blokje', '2A', 2);
    pkg_scholen.add_klas_string('GBS t Blokje', '2B', 2);
    pkg_scholen.add_klas_string('Basisschool int groen', '1A', 1);
    pkg_scholen.add_klas_string('Basisschool int groen', '1B', 1);
    pkg_scholen.add_klas_string('Basisschool int groen', '2A', 2);
    pkg_scholen.add_klas_string('Basisschool int groen', '2B', 2);

    pkg_scholen.add_leerling('1A', 'GBS t Blokje', 'Jef', 'Janssens', 'M', 1, 39);
    pkg_scholen.add_leerling('1B', 'GBS t Blokje', 'Sofie', 'Peeters', 'V', 2, 49);
    pkg_scholen.add_leerling('2B', 'GBS t Blokje', 'Tom', 'Vermeulen', 'M', 3, 12);
    pkg_scholen.add_leerling('1A', 'GBS t Blokje', 'Lisa', 'De Smet', 'V', 4, 94);
    pkg_scholen.add_leerling('1A', 'Basisschool int groen', 'Bart', 'Van Damme', 'M', 5, 28);
    pkg_scholen.add_leerling('1A', 'Basisschool int groen', 'Bert', 'Van Sesamstraat', 'M', 6, 73);
    pkg_scholen.add_leerling('2A', 'Basisschool int groen', 'Ernie', 'Van de Banaan', 'M', 7, 16);

    COMMIT;
END;


-- Milestone 5
BEGIN
    pkg_scholen.empty_tables();

    -- Landen
    pkg_scholen.add_land('be', 'België');

    -- Abonnementen
    pkg_scholen.add_abonnement('Standaard', 10.00, 40);
    pkg_scholen.add_abonnement('Premium', 20.00, 24);
    pkg_scholen.add_abonnement('Platinum', 50.00, 8);

    -- Gemeentes
    pkg_scholen.add_gemeente(2990, 'Wuustwezel', 'België');
    pkg_scholen.add_gemeente(2960, 'Brecht', 'België');
    pkg_scholen.add_gemeente(2920, 'Kalmthout', 'België');
    pkg_scholen.add_gemeente(2910, 'Essen', 'België');

    pkg_scholen.BEWIJS_MILESTONE_5();
    COMMIT;
end;

-- Milestone 6
BEGIN
    pkg_scholen.printreport_2_levels(3, 2, 5);
end;

-- Milestone 7
BEGIN
    pkg_scholen.empty_tables();

    -- Landen
    pkg_scholen.add_land('be', 'België');

    -- Abonnementen
    pkg_scholen.add_abonnement('Standaard', 10.00, 40);
    pkg_scholen.add_abonnement('Premium', 20.00, 24);
    pkg_scholen.add_abonnement('Platinum', 50.00, 8);

    -- Gemeentes
    pkg_scholen.add_gemeente(2990, 'Wuustwezel', 'België');
    pkg_scholen.add_gemeente(2960, 'Brecht', 'België');
    pkg_scholen.add_gemeente(2920, 'Kalmthout', 'België');
    pkg_scholen.add_gemeente(2910, 'Essen', 'België');

    pkg_scholen.BEWIJS_MILESTONE_7();
    COMMIT;
end;
BEGIN
    pkg_scholen.Comparison_Single_Bulk_M7(20,40,50);
    pkg_scholen.Comparison_Single_Bulk_M7(20,40,500);
end;


-- Fill to test error of no classes
BEGIN
    pkg_scholen.empty_tables();

    pkg_scholen.add_land('be', 'België');

    pkg_scholen.add_abonnement('Standaard', 10.00, 40);
    pkg_scholen.add_abonnement('Premium', 20.00, 24);
    pkg_scholen.add_abonnement('Platinum', 50.00, 8);

    pkg_scholen.add_gemeente(2990, 'Wuustwezel', 'België');
    pkg_scholen.add_gemeente(2960, 'Brecht', 'België');
    pkg_scholen.add_gemeente(2920, 'Kalmthout', 'België');
    pkg_scholen.add_gemeente(2910, 'Essen', 'België');

    pkg_scholen.add_school_strings('GBS t Blokje', 'Kerkblokstraat', 14, 'Wuustwezel', 'Standaard');
    pkg_scholen.add_school_strings('Basisschool int groen', 'Leopoldstraat', 15, 'Brecht', 'Premium');
    pkg_scholen.add_school_strings('GBS Kadrie', 'Driehoekstraat', 41, 'Kalmthout', 'Standaard');
    pkg_scholen.add_school_strings('GBS Wigo', 'De Vondert', 1, 'Essen', 'Platinum');
    pkg_scholen.add_school_strings('GBS De Klimboom', 'Klimboomstraat', 1, 'Wuustwezel', 'Standaard');

    pkg_scholen.add_beheerder('Jef', 'Janssens', 'jef.janssens@hotmail.com', 'jef', 'M');
    pkg_scholen.add_beheerder('Laura', 'Peters', 'laura.peters@gmail.com', 'laura', 'V');
    pkg_scholen.add_beheerder('Peter', 'Vermeulen', 'peter.vermeulen@yahoo.com', 'peter', 'X');
    pkg_scholen.add_beheerder('Marie', 'De Vries', 'marie.devries@outlook.com', 'marie', 'V');
    pkg_scholen.add_beheerder('Jan', 'Van der Meer', 'jan.vandermeer@gmail.com', 'jan', 'M');

    pkg_scholen.add_schoolbeheerder('GBS t Blokje', 'Jef', 'Janssens');
    pkg_scholen.add_schoolbeheerder('GBS Kadrie', 'Peter', 'Vermeulen');
    pkg_scholen.add_schoolbeheerder('GBS Wigo', 'Jef', 'Janssens');
    pkg_scholen.add_schoolbeheerder('GBS Wigo', 'Peter', 'Vermeulen');
    pkg_scholen.add_schoolbeheerder('GBS De Klimboom', 'Laura', 'Peters');

    -- Klassen
    pkg_scholen.add_klas_string('GBS t Blokje', '1A', 1);
    pkg_scholen.add_klas_string('GBS t Blokje', '1B', 1);
    pkg_scholen.add_klas_string('GBS t Blokje', '2A', 2);
    pkg_scholen.add_klas_string('GBS t Blokje', '2B', 2);
    pkg_scholen.add_klas_string('Basisschool int groen', '1A', 1);
    pkg_scholen.add_klas_string('Basisschool int groen', '1B', 1);
    pkg_scholen.add_klas_string('Basisschool int groen', '2A', 2);
    pkg_scholen.add_klas_string('Basisschool int groen', '2B', 2);

    -- Leerlingen
    pkg_scholen.add_leerling('1A', 'GBS t Blokje', 'Jef', 'Janssens', 'M', 1, 39);
    pkg_scholen.add_leerling('1B', 'GBS t Blokje', 'Sofie', 'Peeters', 'V', 2, 49);
    pkg_scholen.add_leerling('2B', 'GBS t Blokje', 'Tom', 'Vermeulen', 'M', 3, 12);
    pkg_scholen.add_leerling('1A', 'GBS t Blokje', 'Lisa', 'De Smet', 'V', 4, 94);
    pkg_scholen.add_leerling('1A', 'Basisschool int groen', 'Bart', 'Van Damme', 'M', 5, 28);
    pkg_scholen.add_leerling('1A', 'Basisschool int groen', 'Bert', 'Van Sesamstraat', 'M', 6, 73);
    pkg_scholen.add_leerling('2A', 'Basisschool int groen', 'Ernie', 'Van de Banaan', 'M', 7, 16);

    COMMIT;
END;