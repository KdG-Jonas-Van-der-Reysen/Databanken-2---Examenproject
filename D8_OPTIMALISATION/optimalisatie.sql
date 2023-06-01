---- M8

-- Stap 1 - Voorbereiding
-- Query specifiek bereik (5% van de score)
SELECT voornaam, achternaam, score
FROM leerlingen
WHERE score between 55 and 60;

-- Statistieken berekenen
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS('PROJECT', 'SCHOLEN');
    DBMS_STATS.GATHER_TABLE_STATS('PROJECT', 'KLASSEN');
    DBMS_STATS.GATHER_TABLE_STATS('PROJECT', 'LEERLINGEN');
END;

-- Grootte tabel leerlingen bekijken
select segment_name,
       segment_type,
       sum(bytes / 1024 / 1024)              MB,
       (select COUNT(*) FROM LEERLINGEN) as table_count
from dba_segments
where segment_name = 'LEERLINGEN'
group by segment_name, segment_type;

-- Stap 2: Analyse voor optimalisatie
SELECT s.naam, k.naam, l.geslacht, COUNT(l.geslacht) AS aantal_in_bereik
FROM scholen s
         JOIN klassen k ON s.schoolid = k.scholen_schoolid
         JOIN leerlingen l ON k.klasid = l.klassen_klasid
WHERE s.naam = 'School 1' AND l.score BETWEEN 90 AND 100
GROUP BY s.naam, k.naam, l.geslacht
ORDER BY k.naam;

-- Stap 3: Optimalisatie & analyse
-- Partitionering werd uitgevoerd in CREATE_database_scholen
-- Kleine partities inschakelen
alter session set "_partition_large_extents" = false;

-- Statistieken opnieuw berekenen
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS('PROJECT', 'SCHOLEN');
    DBMS_STATS.GATHER_TABLE_STATS('PROJECT', 'KLASSEN');
    DBMS_STATS.GATHER_TABLE_STATS('PROJECT', 'LEERLINGEN');
END;

-- Query opnieuw uitvoeren
SELECT s.naam, k.naam, l.geslacht, COUNT(l.geslacht) AS aantal_in_bereik
FROM scholen s
         JOIN klassen k ON s.schoolid = k.scholen_schoolid
         JOIN leerlingen l ON k.klasid = l.klassen_klasid
WHERE s.naam = 'School 1' AND l.score BETWEEN 90 AND 100
GROUP BY s.naam, k.naam, l.geslacht
ORDER BY k.naam;

-- Grootte van tabel leerlingen bekijken
SELECT segment_name, segment_type, SUM(bytes / 1024 / 1024) mb, (SELECT COUNT(*) FROM leerlingen) AS table_count
FROM user_segments
WHERE segment_name = 'LEERLINGEN'
GROUP BY segment_name, segment_type;

-- Bekijk partities
SELECT table_name, partition_name, high_value
FROM user_tab_partitions;

-- Bekijk partities met grootte in MB
-- Grootte van tabel leerlingen bekijken
SELECT segment_name, segment_type, bytes / 1024 / 1024 mb
FROM user_segments
WHERE segment_name = 'LEERLINGEN';

SELECT COUNT(*) FROM leerlingen;