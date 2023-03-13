-- Table counts
SELECT 'beheerders' AS tabel, COUNT(*) FROM beheerders
UNION ALL
SELECT 'gemeentes' AS tabel, COUNT(*) FROM gemeentes
UNION ALL
SELECT 'klassen' AS tabel, COUNT(*) FROM klassen
UNION ALL
SELECT 'leerlingen' AS tabel, COUNT(*) FROM leerlingen
UNION ALL
SELECT 'scholen' AS tabel, COUNT(*) FROM scholen
UNION ALL
SELECT 'schoolbeheerders' AS tabel, COUNT(*) FROM schoolbeheerders;

-- 3 queries with at least 3 joins each
SELECT
    b.VOORNAAM AS Voornaam,
    b.ACHTERNAAM  AS Achternaam,
    s.NAAM AS Schoolnaam
FROM
    beheerders b

INNER JOIN SCHOOLBEHEERDERS SB on b.BEHEERDERID = SB.BEHEERDERS_BEHEERDERID
INNER JOIN SCHOLEN S on SB.SCHOLEN_SCHOOLID = S.SCHOOLID;