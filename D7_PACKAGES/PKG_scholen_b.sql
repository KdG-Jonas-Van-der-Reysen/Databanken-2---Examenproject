CREATE OR REPLACE PACKAGE BODY pkg_scholen AS
    -- Private helper (mostly lookup) functions
    PROCEDURE print(p_string IN VARCHAR2)
        IS
        v_timestamp VARCHAR2(22);
    BEGIN
        v_timestamp := '[' || TO_CHAR(SYSDATE, 'yyyy-mm-dd hh24:mi:ss') || '] ';
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
        t_postalcode   type_tab_postalcode;
        v_postalcode   gemeentes.postcode%TYPE;
        v_random_index NUMBER;
    BEGIN
        SELECT postcode BULK COLLECT
        INTO t_postalcode
        FROM gemeentes;

        if t_postalcode.COUNT = 0 then
            print('No postal codes found in the database');
        end if;

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
        t_schoolid     type_tab_schoolid;
        v_schoolid     scholen.schoolid%TYPE;
        v_random_index NUMBER;
    BEGIN
        SELECT scholen.SCHOOLID BULK COLLECT
        INTO t_schoolid
        FROM scholen;

        v_random_index := random_number(1, t_schoolid.COUNT);

        v_schoolid := t_schoolid(v_random_index);
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
        p_klasnummer IN NUMBER,
        p_score IN NUMBER
    ) IS
    BEGIN
        INSERT INTO LEERLINGEN (KLASSEN_KLASID, VOORNAAM, ACHTERNAAM, GESLACHT, KLASNUMMER, SCORE)
        VALUES (p_klasid, p_voornaam, p_achternaam, p_geslacht, p_klasnummer, p_score);
    END add_leerling;

-- Add leerling met klas naam en school naam
    PROCEDURE
        add_leerling(
        p_klas IN VARCHAR2,
        p_school IN VARCHAR2,
        p_voornaam IN VARCHAR2,
        p_achternaam IN VARCHAR2,
        p_geslacht IN VARCHAR2,
        p_klasnummer IN NUMBER,
        p_score IN NUMBER
    ) IS
        v_klasid klassen.klasid % TYPE;
    BEGIN
        v_klasid := lookup_klas(p_klas, p_school);

        add_leerling(v_klasid, p_voornaam, p_achternaam, p_geslacht, p_klasnummer, p_score);
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
        t_scholen type_coll_school := type_coll_school();
    BEGIN
        print('4.1 generateSchools(' || p_amount || ')');
        -- Generate schools
        t_scholen.extend(p_amount);
        FOR i IN 1 .. p_amount
            LOOP
                t_scholen(i).naam := 'School ' || i;
                t_scholen(i).straat := random_street_name();
                t_scholen(i).huisnummer := i;
                t_scholen(i).gemeentes_postcode := random_postalcode();
                t_scholen(i).abonnementen_abonnementid := random_abonnement();
            END LOOP;

        -- Insert schools
        /*FORALL i IN INDICES OF t_scholen
            INSERT INTO scholen
            VALUES t_scholen(i);*/

        -- Insert schools
        FORALL i IN INDICES OF t_scholen
            INSERT INTO scholen (NAAM, STRAAT, HUISNUMMER, GEMEENTES_POSTCODE, ABONNEMENTEN_ABONNEMENTID)
            VALUES (t_scholen(i).naam,
                    t_scholen(i).straat,
                    t_scholen(i).huisnummer,
                    t_scholen(i).gemeentes_postcode,
                    t_scholen(i).abonnementen_abonnementid);

        print('  generateSchools(' || p_amount || ') generated ' || SQL%ROWCOUNT || ' schools');
    END generateSchools;

    -- Generate beheerders
    PROCEDURE
        generateBeheerders(p_amount NUMBER)
        IS

        -- Declare a collection of beheerders
        TYPE type_coll_beheerder
            IS TABLE OF beheerders%ROWTYPE;

        -- Declare a variable of the collection
        t_beheerders type_coll_beheerder := type_coll_beheerder();
        v_firstName  beheerders.voornaam%TYPE;
        v_lastName   beheerders.achternaam%TYPE;
    BEGIN
        print('4.2 generateBeheerders(' || p_amount || ')');
        -- Generate beheerders
        t_beheerders.extend(p_amount);
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
        /*FORALL i IN INDICES OF t_beheerders
            INSERT INTO beheerders
            VALUES t_beheerders(i);*/

        -- Insert beheerders
        FORALL i IN INDICES OF t_beheerders
            INSERT INTO beheerders (VOORNAAM, ACHTERNAAM, EMAILADRES, WACHTWOORD, GESLACHT)
            VALUES (t_beheerders(i).voornaam,
                    t_beheerders(i).achternaam,
                    t_beheerders(i).emailadres,
                    t_beheerders(i).wachtwoord,
                    t_beheerders(i).geslacht);

        print('  generateBeheerders(' || p_amount || ') generated ' || SQL%ROWCOUNT || ' beheerders');
    END generateBeheerders;

    -- Generate schoolbeheerders
    PROCEDURE generateRandomSchoolBeheerders(p_amount NUMBER)
        IS
        -- Declare a collection of schoolbeheerders
        TYPE type_coll_schoolbeheerder
            IS TABLE OF schoolbeheerders%ROWTYPE;

        -- Declare a variable of the collection
        t_schoolbeheerders       type_coll_schoolbeheerder := type_coll_schoolbeheerder();

        -- Declare helper variables
        v_successfully_generated NUMBER                    := 0;
        v_already_exists         BOOLEAN                   := FALSE;
        v_beheerderid            beheerders.beheerderid%TYPE;
        v_schoolid               scholen.schoolid%TYPE;
    BEGIN
        print('4.3 generateRandomSchoolBeheerders(' || p_amount || ')');

        -- Generate schoolbeheerders
        t_schoolbeheerders.extend(p_amount);

        -- While v_successfully_generated < p_amount
        WHILE v_successfully_generated < p_amount
            LOOP
                v_schoolid := random_school();
                v_beheerderid := random_beheerder();

                -- Check if schoolbeheerder already exists in the collection
                v_already_exists := FALSE;
                FOR i IN 1 .. t_schoolbeheerders.COUNT
                    LOOP
                        IF v_schoolid = t_schoolbeheerders(i).scholen_schoolid AND
                           v_beheerderid = t_schoolbeheerders(i).beheerders_beheerderid
                        THEN
                            v_already_exists := TRUE;
                        END IF;
                    END LOOP;

                -- If schoolbeheerder doesn't exist in the collection, add it
                IF NOT v_already_exists
                THEN
                    t_schoolbeheerders(v_successfully_generated + 1).scholen_schoolid := v_schoolid;
                    t_schoolbeheerders(v_successfully_generated + 1).beheerders_beheerderid := v_beheerderid;
                    v_successfully_generated := v_successfully_generated + 1;
                END IF;
            END LOOP;

        -- Insert schoolbeheerders
        /*FORALL i IN INDICES OF t_schoolbeheerders
            INSERT INTO schoolbeheerders
            VALUES t_schoolbeheerders(i);*/

        -- Insert schoolbeheerders
        FORALL i IN INDICES OF t_schoolbeheerders
            INSERT INTO schoolbeheerders (SCHOLEN_SCHOOLID, BEHEERDERS_BEHEERDERID)
            VALUES (t_schoolbeheerders(i).scholen_schoolid, t_schoolbeheerders(i).beheerders_beheerderid);

        print('  generateRandomSchoolBeheerders(' || p_amount || ') generated ' || SQL%ROWCOUNT ||
              ' schoolBeheerders');
    END generateRandomSchoolBeheerders;

    PROCEDURE genereer_veel_op_veel(p_amount_schools NUMBER, p_amount_beheerders NUMBER,
                                    p_amount_schoolBeheerders NUMBER)
        IS
        v_start_generation_time  NUMBER;
        v_finish_generation_time NUMBER;
    BEGIN
        v_start_generation_time := DBMS_UTILITY.get_time();
        generateSchools(p_amount_schools);
        generateBeheerders(p_amount_beheerders);
        generateRandomSchoolBeheerders(p_amount_schoolBeheerders);
        v_finish_generation_time := DBMS_UTILITY.get_time();

        print('The duration of genereer_veel_op_veel was: ' || (v_finish_generation_time - v_start_generation_time) ||
              ' s');
    END;

    PROCEDURE generateClassesForEachSchool(p_amount_of_classes NUMBER)
        IS

        -- Declare a collection of schools
        TYPE type_coll_schools
            IS TABLE OF scholen%ROWTYPE;

        -- Declare a variable of the collection
        t_schools type_coll_schools;

        -- Declare a collection of classes
        TYPE type_coll_classes
            IS TABLE OF klassen%ROWTYPE;

        -- Declare a variable of the collection
        t_classes type_coll_classes := type_coll_classes();

    BEGIN
        print('5.2 generateClassesForEachSchool(' || p_amount_of_classes || ')');

        -- Start by getting all schools
        SELECT * BULK COLLECT INTO t_schools FROM scholen;

        -- Now, loop through each school
        FOR schoolIndex IN 1 .. t_schools.COUNT
            LOOP
                -- Generate classes
                FOR classIndex IN 1 .. p_amount_of_classes
                    LOOP
                        t_classes.extend;
                        t_classes(t_classes.last).naam := 'Klas ' || classIndex || '-S' || schoolIndex;
                        t_classes(t_classes.last).leerjaar := random_number(1, 6);
                        t_classes(t_classes.last).scholen_schoolid := t_schools(schoolIndex).schoolid;
                    END LOOP;
            END LOOP;

        -- Insert classes
        FORALL i IN INDICES OF t_classes
            INSERT INTO klassen (SCHOLEN_SCHOOLID, NAAM, LEERJAAR)
            VALUES (t_classes(i).scholen_schoolid,
                    t_classes(i).naam,
                    t_classes(i).leerjaar);

        print('  generateClassesForEachSchool(' || p_amount_of_classes || ') generated ' || SQL%ROWCOUNT ||
              ' classes');

    END generateClassesForEachSchool;

    PROCEDURE generatePupilsForEachClass(p_amount_of_pupils NUMBER)
        IS

        -- Declare a collection of classes
        TYPE type_coll_classes
            IS TABLE OF klassen%ROWTYPE;

        -- Declare a variable of the collection
        t_classes type_coll_classes;

        -- Declare a collection of pupils
        TYPE type_coll_pupils
            IS TABLE OF leerlingen%ROWTYPE;

        -- Declare a variable of the collection
        t_pupils  type_coll_pupils := type_coll_pupils();

    BEGIN
        print('5.3 generatePupilsForEachClass(' || p_amount_of_pupils || ')');

        -- Start by getting all classes
        SELECT * BULK COLLECT INTO t_classes FROM klassen;

        -- Now, loop through each school
        FOR classIndex IN 1 .. t_classes.COUNT
            LOOP
                -- Generate classes
                FOR pupilIndex IN 1 .. p_amount_of_pupils
                    LOOP
                        t_pupils.extend;
                        t_pupils(t_pupils.last).voornaam := random_first_name();
                        t_pupils(t_pupils.last).achternaam := random_last_name();
                        t_pupils(t_pupils.last).geslacht := random_geslacht();
                        t_pupils(t_pupils.last).klasnummer := random_number(1, 40);
                        t_pupils(t_pupils.last).score := random_number(0, 100);
                        t_pupils(t_pupils.last).klassen_klasid := t_classes(classIndex).klasid;
                    END LOOP;
            END LOOP;

        -- Insert pupils
        FORALL i IN INDICES OF t_pupils
            INSERT INTO leerlingen (KLASSEN_KLASID, VOORNAAM, ACHTERNAAM, GESLACHT, KLASNUMMER, SCORE)
            VALUES (t_pupils(i).klassen_klasid,
                    t_pupils(i).voornaam,
                    t_pupils(i).achternaam,
                    t_pupils(i).geslacht,
                    t_pupils(i).klasnummer,
                    t_pupils(i).score);

        print('  generatePupilsForEachClass(' || p_amount_of_pupils || ') generated ' || SQL%ROWCOUNT ||
              ' pupils');

    END generatePupilsForEachClass;

    PROCEDURE generate_2_levels(p_amount_of_classes NUMBER, p_amount_of_pupils NUMBER)
        IS
        v_generation_start_time NUMBER;
        v_generation_end_time   NUMBER;
        v_amount_of_schools     NUMBER;
    BEGIN
        v_generation_start_time := DBMS_UTILITY.get_time();

        -- Get amount of schools
        SELECT COUNT(schoolid)
        INTO v_amount_of_schools
        FROM scholen;

        print('5.1 We already have ' || v_amount_of_schools || ' schools --> Skip schools');
        generateClassesForEachSchool(p_amount_of_classes);
        generatePupilsForEachClass(p_amount_of_pupils);
        v_generation_end_time := DBMS_UTILITY.get_time();

        print('The duration of generate_2_levels was: ' || (v_generation_end_time - v_generation_start_time) ||
              ' ms');
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

        -- 5 - 2 levels generation
        print('5 - Starting 2-levels generation: generate_2_levels(40,50)');
        generate_2_levels(40, 50);

        COMMIT;
    END bewijs_milestone_5;

    PROCEDURE calculate_pupils_of_gender_in_school(p_school_name scholen.naam%TYPE, p_gender leerlingen.geslacht%TYPE)
        IS
        -- School to calculate for
        v_school         scholen.schoolid%TYPE;

        -- School's classes
        TYPE type_coll_classes
            IS TABLE OF klassen.klasid%TYPE;

        -- Declare a variable of the collection
        t_classes        type_coll_classes;

        -- Counting variables
        v_n_gender       NUMBER := 0;
        v_n_gender_class NUMBER;
    BEGIN
        -- First, get the school
        SELECT schoolid
        INTO v_school
        FROM scholen
        WHERE naam = p_school_name;

        print('School: ' || v_school);

        -- Now, get the classes
        SELECT klasid BULK COLLECT
        INTO t_classes
        FROM klassen
        WHERE scholen_schoolid = v_school;

        print('Classes: ' || t_classes.COUNT);

        -- Finally, loop through each class and calculate the pupils that are male
        FOR i IN 1 .. t_classes.COUNT
            LOOP
                select count(geslacht)
                INTO v_n_gender_class
                FROM LEERLINGEN
                WHERE geslacht = p_gender
                  AND klassen_klasid = t_classes(i);

                v_n_gender := v_n_gender + v_n_gender_class;
            END LOOP;

        print('Er zijn ' || v_n_gender || ' mensen met het gender ' || p_gender || ' op school ' || v_school);

    END calculate_pupils_of_gender_in_school;

    PROCEDURE printreport_2_levels(p_n_schools NUMBER, p_n_classes NUMBER, p_n_pupils NUMBER)
        IS
        -- Cursor for schools
        CURSOR cur_school IS
            SELECT s.schoolid,
                   s.naam,
                   s.straat || ' ' || s.huisnummer || ', ' || g.postcode || ' ' || g.gemeente || ', ' ||
                   landen.landnaam            as adres,
                   ROUND(AVG(l.score)) || '%' as "Average score"
            FROM scholen s
                     JOIN gemeentes g ON s.gemeentes_postcode = g.postcode
                     JOIN landen ON g.landen_landid = landen.landid
                     LEFT JOIN klassen k ON s.schoolid = k.scholen_schoolid
                     LEFT JOIN leerlingen l ON k.klasid = l.klassen_klasid
            GROUP BY s.schoolid, s.naam, s.straat, s.huisnummer, g.postcode, g.gemeente, landen.landnaam
            ORDER BY s.schoolid;

        -- Cursor for classes
        CURSOR cur_class (p_schoolid NUMBER) IS
            SELECT k.klasid, k.naam, k.leerjaar, ROUND(AVG(l.score)) || '%' as "Average score"
            FROM klassen k
                     INNER JOIN leerlingen l ON k.klasid = l.klassen_klasid
            WHERE k.scholen_schoolid = p_schoolid
            GROUP BY k.klasid, k.naam, k.leerjaar;

        -- Cursor for pupils
        CURSOR cur_pupil (p_classid NUMBER) IS
            SELECT leerlingid, voornaam || ' ' || achternaam as "NAAM", score || '%' as "SCORE"
            FROM leerlingen
            WHERE klassen_klasid = p_classid;
    BEGIN
        print('____________________________________________________________________________________');
        print('| ID | NAAM       | ADRES                                              | AVG Score |');


        FOR r_school IN cur_school
            LOOP

                print('|----------------------------------------------------------------------------------|');

                -- | 1  | School 1   | Vijverlaan 1, 2910 Essen, België                   | 51%       |
                print(
                            '| '
                            ||
                            RPAD(r_school.schoolid, 3)
                            || '| ' ||
                            RPAD(r_school.naam, 11)
                            || '| ' ||
                            RPAD(r_school.adres, 51)
                            || '| ' ||
                            RPAD(r_school."Average score", 10)
                            || '|'
                    );

                print('|----------------------------------------------------------------------------------|');
                print('|   Klassen:                                                                       |');
                print('|   ________________________________________________________________________       |');
                print('|   | ID | NAAM         | AVG score                                        |       |');

                -- TODO: Error when there are no classes
                -- Print classes
                FOR r_class in cur_class(r_school.schoolid)
                    LOOP
                        if(cur_class%NOTFOUND AND cur_class%ROWCOUNT = 0) then
                            print('No classes found');
                        end if;

                        print('|   |----------------------------------------------------------------------|       |');

                        -- |   | 1  | Klas 2-S1    | 35%                                              |       |
                        print(
                                    '|   | '
                                    || RPAD(r_class.klasid, 3) ||
                                    '| ' || RPAD(r_class.naam, 13) ||
                                    '| ' || RPAD(r_class."Average score", 49) || '|       |');

                        print('|   |----------------------------------------------------------------------|       |');
                        print('|   |   Leerlingen:                                                        |       |');
                        print('|   |   _____________________________________________________________      |       |');
                        print('|   |   | ID | VOLLEDIGE NAAM        | Score                        |      |       |');

                        -- TODO: Error when there are no pupils
                        -- Print pupils
                        FOR r_pupil IN cur_pupil(r_class.klasid)
                            LOOP
                                print('|   |   |-----------------------------------------------------------|      |       |');
                                -- |   |   | 1  | Maarten Van Dijk      | 49%                          |      |       |
                                print('|   |   | '
                                    || RPAD(r_pupil.leerlingid, 3) ||
                                      '| ' || RPAD(r_pupil.naam, 22) || '| ' || RPAD(r_pupil.score, 29)
                                    || '|      |       |');

                                EXIT WHEN cur_pupil%ROWCOUNT = p_n_pupils;
                            END LOOP;
                        print('|   |   |-----------------------------------------------------------|      |       |');
                        print('|   |                                                                      |       |');
                        EXIT WHEN cur_class%ROWCOUNT = p_n_classes;
                    END LOOP;

                print('|   |----------------------------------------------------------------------|       |');
                print('|                                                                                  |');
                EXIT WHEN cur_school%ROWCOUNT = p_n_schools;
            END LOOP;
        print('|----------------------------------------------------------------------------------|');


    END printreport_2_levels;
END pkg_scholen;

