CREATE OR REPLACE PACKAGE BODY pkg_scholen AS
    -- Private helper (mostly lookup) functions
    PROCEDURE print(p_string IN VARCHAR2)
    IS
        v_timestamp VARCHAR2(22);
    BEGIN
        v_timestamp := '[' || TO_CHAR (SYSDATE,'yyyy-mm-dd hh24:mi:ss') || '] ';
        -- Print timestamp
        DBMS_OUTPUT.PUT_LINE(v_timestamp || p_string);
    END print;

    FUNCTION lookup_abonnement(p_abonnement IN varchar2) RETURN NUMBER IS
        v_abonnementid abonnementen.abonnementid % TYPE;
    BEGIN
        SELECT abonnementid
        INTO v_abonnementid
        FROM abonnementen
        WHERE LOWER(naam) = LOWER(p_abonnement);

        return v_abonnementid;

    END lookup_abonnement;

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
        v_klasid   klassen.klasid % TYPE;
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

    -- Data generation helper functions
    FUNCTION random_number(p_lowerBound NUMBER, p_upperBound NUMBER)
        RETURN NUMBER
        IS
        v_generated_number NUMBER(6, 0);
    BEGIN
        v_generated_number := DBMS_RANDOM.VALUE(p_lowerBound, p_upperBound);
        return v_generated_number;
    END;

    FUNCTION random_string(p_length NUMBER)
        RETURN VARCHAR2
        IS
        v_generated_string VARCHAR2(100);
    BEGIN
        v_generated_string := DBMS_RANDOM.STRING('A', p_length);
        return v_generated_string;
    END;

    FUNCTION random_date(date_start DATE, date_end DATE)
        RETURN DATE
        IS
        v_generated_date  DATE;
        v_days_in_between NUMBER;
    BEGIN
        v_days_in_between := date_end - date_start;
        v_generated_date := date_start + random_number(0, v_days_in_between);
        return v_generated_date;
    END;

    FUNCTION random_street_name
        RETURN scholen.straat%TYPE
        IS
        TYPE type_tab_street IS TABLE OF
            scholen.straat%TYPE
            INDEX BY PLS_INTEGER;
        t_straat type_tab_street := type_tab_street(
                1 => 'Jan Steenlaan',
                2 => 'Kerkstraat',
                3 => 'Molenweg',
                4 => 'Beukenlaan',
                5 => 'Prins Hendrikstraat',
                6 => 'Wilhelminastraat',
                7 => 'Vijverlaan',
                8 => 'Parkweg',
                9 => 'Van Goghstraat',
                10 => 'Burg. de Vlugtlaan'
            );
    BEGIN
        RETURN t_straat(random_number(1, t_straat.COUNT));
    END random_street_name;

    FUNCTION random_first_name
        RETURN beheerders.voornaam%TYPE
        IS
        TYPE type_tab_first_name IS TABLE OF
            beheerders.voornaam%TYPE
            INDEX BY PLS_INTEGER;
        t_first_name type_tab_first_name := type_tab_first_name(
                1=> 'Jan',
                2=> 'Pieter',
                3=> 'Henk',
                4=> 'Johan',
                5=> 'Maria',
                6=> 'Anna',
                7=> 'Petra',
                8=> 'Erik',
                9=> 'Maarten',
                10=> 'Sara'
            );
    BEGIN
        RETURN t_first_name(random_number(1, t_first_name.COUNT));
    END random_first_name;

    FUNCTION random_last_name
        RETURN beheerders.achternaam%TYPE
        IS
        TYPE type_tab_last_name IS TABLE OF
            beheerders.achternaam%TYPE
            INDEX BY PLS_INTEGER;
        t_last_name type_tab_last_name := type_tab_last_name(
                1=> 'Jansen',
                2=> 'de Jong',
                3=> 'van Dijk',
                4=> 'Visser',
                5=> 'Smit',
                6=> 'Meijer',
                7=> 'van der Linden',
                8=> 'Kok',
                9=> 'Bakker',
                10 => 'de Vries'
            );
    BEGIN
        RETURN t_last_name(random_number(1, t_last_name.COUNT));
    END random_last_name;

    FUNCTION random_email(p_voornaam IN VARCHAR2, p_achternaam IN VARCHAR2)
        RETURN beheerders.emailadres%TYPE
        IS
        TYPE type_tab_email IS TABLE OF
            beheerders.emailadres%TYPE
            INDEX BY PLS_INTEGER;
        t_email_domains type_tab_email := type_tab_email(
                1 => 'gmail.com',
                2 => 'hotmail.com',
                3 => 'outlook.com',
                4 => 'live.com',
                5 => 'yahoo.com',
                6 => 'icloud.com',
                7 => 'telenet.be',
                8 => 'proximus.be',
                9 => 'skynet.be',
                10 => 'mail.com'
            );
    BEGIN
        RETURN p_voornaam || '.' || p_achternaam || '@' || t_email_domains(random_number(1, t_email_domains.COUNT));
    END random_email;

    -- M, V, X
    FUNCTION random_geslacht
        RETURN beheerders.geslacht%TYPE
        IS
        TYPE type_tab_geslacht IS TABLE OF
            beheerders.geslacht%TYPE
            INDEX BY PLS_INTEGER;
        t_geslacht type_tab_geslacht := type_tab_geslacht(
                1=>'M',
                2=>'V',
                3=>'X'
            );
    BEGIN
        RETURN t_geslacht(random_number(1, t_geslacht.COUNT));
    END random_geslacht;

    -- Function that returns the id of a random row in the abonnement table
    FUNCTION random_abonnement
        RETURN abonnementen.abonnementid%TYPE
        IS
        TYPE type_tab_abonnement IS TABLE OF
            abonnementen.abonnementid%TYPE
            INDEX BY PLS_INTEGER;
        t_abonnement   type_tab_abonnement;
        v_abonnementid abonnementen.abonnementid%TYPE;
    BEGIN
        SELECT abonnementid BULK COLLECT
        INTO t_abonnement
        FROM abonnementen;

        v_abonnementid := t_abonnement(random_number(1, t_abonnement.COUNT));
        RETURN v_abonnementid;
    END random_abonnement;

    -- Function that returns the postalcode of a random row in the gemeentes table
    FUNCTION random_postalcode
        RETURN gemeentes.postcode%TYPE
        IS
        TYPE type_tab_postalcode IS TABLE OF
            gemeentes.postcode%TYPE
            INDEX BY PLS_INTEGER;
        t_postalcode type_tab_postalcode;
        v_postalcode gemeentes.postcode%TYPE;
    BEGIN
        SELECT postcode BULK COLLECT
        INTO t_postalcode
        FROM gemeentes;

        v_postalcode := t_postalcode(random_number(1, t_postalcode.COUNT));
        RETURN v_postalcode;
    END random_postalcode;

    -- Function that returns the schoolId of a random school in the scholen table
    FUNCTION random_school
        RETURN scholen.schoolid%TYPE
        IS
        TYPE type_tab_schoolid IS TABLE OF
            scholen.schoolid%TYPE
            INDEX BY PLS_INTEGER;
        t_schoolid type_tab_schoolid;
        v_schoolid scholen.schoolid%TYPE;
    BEGIN
        SELECT schoolid BULK COLLECT
        INTO t_schoolid
        FROM scholen;

        v_schoolid := t_schoolid(random_number(1, t_schoolid.COUNT));
        RETURN v_schoolid;
    END random_school;

    -- Function that returns the beheerderId of a random beheerder in the beheerders table
    FUNCTION random_beheerder
        RETURN beheerders.beheerderid%TYPE
        IS
        TYPE type_tab_beheerderid IS TABLE OF
            beheerders.beheerderid%TYPE
            INDEX BY PLS_INTEGER;
        t_beheerderid type_tab_beheerderid;
        v_beheerderid beheerders.beheerderid%TYPE;
    BEGIN
        SELECT schoolid BULK COLLECT
        INTO t_beheerderid
        FROM scholen;

        v_beheerderid := t_beheerderid(random_number(1, t_beheerderid.COUNT));
        RETURN v_beheerderid;
    END random_beheerder;

    -- Public procedures & functions
    PROCEDURE empty_tables IS
    BEGIN
        EXECUTE IMMEDIATE 'PURGE RECYCLEBIN';
        -- Clear data
        EXECUTE IMMEDIATE 'truncate TABLE leerlingen';
        EXECUTE IMMEDIATE 'truncate TABLE klassen';
        EXECUTE IMMEDIATE 'truncate TABLE schoolbeheerders';
        EXECUTE IMMEDIATE 'truncate TABLE beheerders';
        EXECUTE IMMEDIATE 'truncate TABLE scholen';
        EXECUTE IMMEDIATE 'truncate TABLE abonnementen';
        EXECUTE IMMEDIATE 'truncate TABLE gemeentes';
        EXECUTE IMMEDIATE 'truncate TABLE landen';

        -- Reset identity columns
        EXECUTE IMMEDIATE 'ALTER TABLE beheerders
            MODIFY beheerderid GENERATED ALWAYS as identity (start with 1)';
        EXECUTE IMMEDIATE 'ALTER TABLE landen
            MODIFY landid GENERATED ALWAYS as identity (start with 1)';
        EXECUTE IMMEDIATE 'ALTER TABLE klassen
            MODIFY klasid GENERATED ALWAYS as identity (start with 1)';
        EXECUTE IMMEDIATE 'ALTER TABLE leerlingen
            MODIFY leerlingid GENERATED ALWAYS as identity (start with 1)';
        EXECUTE IMMEDIATE 'ALTER TABLE scholen
            MODIFY schoolid GENERATED ALWAYS as identity (start with 1)';
        EXECUTE IMMEDIATE 'ALTER TABLE abonnementen
            MODIFY abonnementid GENERATED ALWAYS as identity (start with 1)';

        print('De tabellen zijn leeggemaakt');

    END empty_tables;

-- Add land
    PROCEDURE
        add_land(p_landCode IN VARCHAR2, p_landNaam IN VARCHAR2) IS
    BEGIN
        INSERT INTO landen(landcode, landnaam)
        VALUES (p_landCode, p_landNaam);

    END;

-- Add gemeente met landid
    PROCEDURE
        add_gemeente(
        p_postcode IN NUMBER,
        p_gemeente IN VARCHAR2,
        p_landid IN NUMBER
    ) IS
    BEGIN
        INSERT INTO GEMEENTES (POSTCODE, GEMEENTE, LANDEN_LANDID)
        VALUES (p_postcode, p_gemeente, p_landid);

    END add_gemeente;

-- Add gemeente met landnaam
    PROCEDURE
        add_gemeente(
        p_postcode IN NUMBER,
        p_gemeente IN VARCHAR2,
        p_land IN VARCHAR2
    ) IS
        v_landid landen.landid % TYPE;

    BEGIN
        v_landid := lookup_land(p_land);

        add_gemeente(p_postcode, p_gemeente, v_landid);

    END add_gemeente;

-- Add school met postcode en abonnementid
    PROCEDURE
        add_school(
        p_naam IN VARCHAR2,
        p_straat IN VARCHAR2,
        p_huisnummer IN VARCHAR2,
        p_gemeentes_postcode IN NUMBER,
        p_abonnementId IN NUMBER
    )
        IS
    BEGIN
        INSERT INTO SCHOLEN (NAAM, STRAAT, HUISNUMMER, GEMEENTES_POSTCODE, ABONNEMENTEN_ABONNEMENTID)
        VALUES (p_naam,
                p_straat,
                p_huisnummer,
                p_gemeentes_postcode,
                p_abonnementId);

    END add_school;

-- Add school met gemeente naam en abonnement naam
    PROCEDURE
        add_school_strings(
        p_naam IN VARCHAR2,
        p_straat IN VARCHAR2,
        p_huisnummer IN VARCHAR2,
        p_gemeente IN VARCHAR2,
        p_abonnement IN VARCHAR2
    ) IS
        v_gemeentes_postcode gemeentes.postcode % TYPE;
        v_abonnement         abonnementen.abonnementId%TYPE;

    BEGIN
        v_gemeentes_postcode := lookup_gemeente(p_gemeente);
        v_abonnement := lookup_abonnement(p_abonnement);
        add_school(
                p_naam,
                p_straat,
                p_huisnummer,
                v_gemeentes_postcode,
                v_abonnement
            );

    END add_school_strings;

-- Add beheerder
    PROCEDURE
        add_beheerder(
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
    PROCEDURE
        add_schoolbeheerder(p_schoolid IN NUMBER, p_beheerderid IN NUMBER) IS
    BEGIN
        INSERT INTO SCHOOLBEHEERDERS (SCHOLEN_SCHOOLID, BEHEERDERS_BEHEERDERID)
        VALUES (p_schoolid, p_beheerderid);

    END add_schoolbeheerder;

-- Add schoolbeheerder met school naam & beheerder voor- en achternaam
    PROCEDURE
        add_schoolbeheerder(
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
    PROCEDURE
        add_klas(
        p_schoolid IN NUMBER,
        p_naam IN VARCHAR2,
        p_leerjaar IN NUMBER
    ) IS
    BEGIN
        INSERT INTO KLASSEN (SCHOLEN_SCHOOLID, NAAM, LEERJAAR)
        VALUES (p_schoolid, p_naam, p_leerjaar);

    END add_klas;

-- Add klassen met school naam
    PROCEDURE
        add_klas(
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
    PROCEDURE
        add_leerling(
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
    PROCEDURE
        add_leerling(
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

-- Add abonnement
    PROCEDURE
        add_abonnement(
        p_naam IN VARCHAR2,
        p_prijs IN NUMBER,
        p_supportSLA IN NUMBER
    ) IS
    BEGIN
        INSERT INTO ABONNEMENTEN (NAAM, PRIJSPERMAAND, SUPPORTSLA)
        VALUES (p_naam, p_prijs, p_supportSLA);
    END add_abonnement;

    -- =================
    -- Generating data
    -- =================

    -- Generate schools
    PROCEDURE
        generateSchools(p_amount IN NUMBER)
        IS
        -- Declare a collection of schools
        TYPE type_coll_school
            IS TABLE OF scholen%ROWTYPE;

        -- Declare a variable of the collection
        t_scholen type_coll_school;
    BEGIN
        -- Generate schools
        FOR i IN 1 .. p_amount
            LOOP
                t_scholen(i).naam := 'School ' || i;
                t_scholen(i).straat := random_street_name();
                t_scholen(i).huisnummer := i;
                t_scholen(i).gemeentes_postcode := random_postalcode();
                t_scholen(i).abonnementen_abonnementid := random_abonnement();
            END LOOP;

        -- Insert schools
        FORALL i IN INDICES OF t_scholen
            INSERT INTO scholen
            VALUES t_scholen(i);
    END generateSchools;

    -- Generate beheerders
    PROCEDURE
        generateBeheerders(p_amount NUMBER)
        IS

        -- Declare a collection of beheerders
        TYPE type_coll_beheerder
            IS TABLE OF beheerders%ROWTYPE;

        -- Declare a variable of the collection
        t_beheerders type_coll_beheerder;
        v_firstName  beheerders.voornaam%TYPE;
        v_lastName   beheerders.achternaam%TYPE;
    BEGIN
        -- Generate beheerders
        FOR i IN 1 .. p_amount
            LOOP
                v_firstName := random_first_name();
                v_lastName := random_last_name();
                t_beheerders(i).voornaam := v_firstName;
                t_beheerders(i).achternaam := v_lastName;
                t_beheerders(i).emailadres := random_email(v_firstName, v_lastName);
                t_beheerders(i).wachtwoord := random_string(random_number(10, 20));
                t_beheerders(i).geslacht := random_geslacht();
            END LOOP;

        -- Insert beheerders
        FORALL i IN INDICES OF t_beheerders
            INSERT INTO beheerders
            VALUES t_beheerders(i);
    END generateBeheerders;

    -- Generate schoolbeheerders
    PROCEDURE generateRandomSchoolBeheerder(p_amount NUMBER)
        IS
        -- Declare a collection of schoolbeheerders
        TYPE type_coll_schoolbeheerder
            IS TABLE OF schoolbeheerders%ROWTYPE;

        -- Declare a variable of the collection
        t_schoolbeheerders type_coll_schoolbeheerder;
    BEGIN
        -- Generate schoolbeheerders
        FOR i IN 1 .. p_amount
            LOOP
                t_schoolbeheerders(i).scholen_schoolid := random_school();
                t_schoolbeheerders(i).beheerders_beheerderid := random_beheerder();
            END LOOP;

        -- Insert schoolbeheerders
        FORALL i IN INDICES OF t_schoolbeheerders
            INSERT INTO schoolbeheerders
            VALUES t_schoolbeheerders(i);
    END generateRandomSchoolBeheerder;

    PROCEDURE genereer_veel_op_veel(p_amount_schools NUMBER, p_amount_beheerders NUMBER,
                                    p_amount_schoolBeheerders NUMBER)
        IS
    BEGIN
        generateSchools(p_amount_schools);
        generateBeheerders(p_amount_beheerders);
        generateRandomSchoolBeheerder(p_amount_schoolBeheerders);
    END;

    PROCEDURE generateClassesForEachSchool(p_amount_of_classes NUMBER)
        IS
        -- Declare a collection of classes
        TYPE type_coll_klassen
            IS TABLE OF klassen%ROWTYPE;

        -- Declare a variable of the collection
        t_klassen type_coll_klassen;

        -- Declare a collection of schools
        TYPE type_coll_school
            IS TABLE OF scholen%ROWTYPE;

        -- Declare a variable of the collection
        t_scholen type_coll_school;
    BEGIN
        -- Get all schools
        SELECT * BULK COLLECT
        INTO t_scholen
        FROM scholen;

        -- Loop over schools
        FOR i IN 1 .. t_scholen.COUNT
            LOOP
                -- Generate classes
                FOR j IN 1 .. p_amount_of_classes
                    LOOP
                        t_klassen(j).naam := 'Klas ' || j || '-S' || i;
                        t_klassen(j).leerjaar := random_number(1, 6);
                        t_klassen(j).scholen_schoolid := t_scholen(i).schoolid;
                    END LOOP;
            END LOOP;

        -- Insert classes
        FORALL i IN INDICES OF t_klassen
            INSERT INTO klassen
            VALUES t_klassen(i);
    END generateClassesForEachSchool;

    PROCEDURE generatePupilsForEachClass(p_amount_of_pupils NUMBER)
        IS
        -- Declare a collection of pupils
        TYPE type_coll_leerlingen
            IS TABLE OF leerlingen%ROWTYPE;

        -- Declare a variable of the collection
        t_leerlingen type_coll_leerlingen;

        -- Declare a collection of classes
        TYPE type_coll_classes
            IS TABLE OF klassen%ROWTYPE;

        -- Declare a variable of the collection
        t_klassen    type_coll_classes;
    BEGIN
        -- Get all classes
        SELECT * BULK COLLECT
        INTO t_klassen
        FROM klassen;

        -- Loop over klassen
        FOR i IN 1 .. t_klassen.COUNT
            LOOP
                -- Generate classes
                FOR j IN 1 .. p_amount_of_pupils
                    LOOP
                        t_leerlingen(j).voornaam := random_first_name();
                        t_leerlingen(j).achternaam := random_last_name();
                        t_leerlingen(j).geslacht := random_geslacht();
                        t_leerlingen(j).klassen_klasid := t_klassen(i).klasid;
                    END LOOP;
            END LOOP;

        -- Insert classes
        FORALL i IN INDICES OF t_leerlingen
            INSERT INTO leerlingen
            VALUES t_leerlingen(i);
    END generatePupilsForEachClass;

    PROCEDURE generate_2_levels(p_amount_of_schools NUMBER, p_amount_of_classes NUMBER, p_amount_of_pupils NUMBER)
        IS
    BEGIN
        generateSchools(p_amount_of_schools);
        generateClassesForEachSchool(p_amount_of_classes);
        generatePupilsForEachClass(p_amount_of_pupils);
    END generate_2_levels;

    PROCEDURE bewijs_milestone_5
        IS
    BEGIN
        -- Random number
        print('1 - random nummer teruggeeft binnen een nummerbereik');
        print('  random_number (5,25) --> ' || random_number(5, 25));

        -- Random date
        print('2 - random datum binnen een bereik');
        print('  random_date (to_date(''01012015'',''DDMMYYYY''), sysdate) --> ' ||
              random_date(to_date('01012015', 'DDMMYYYY'), sysdate));

        -- 3 - random string
        print('3 - random tekst string uit een lijst (straatnaam)');
        print('  random_street_name() --> ' || random_street_name());

        -- 4 - Many to many generation
        print('4 - Starting Many-to-many generation: genereer_veel_op_veel(20,20,50)');
        genereer_veel_op_veel(20, 20, 50);

    END bewijs_milestone_5;

END pkg_scholen;
