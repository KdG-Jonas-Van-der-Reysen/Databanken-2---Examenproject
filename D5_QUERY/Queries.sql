-- Table counts
SELECT 'beheerders' AS tabel, COUNT(*)
FROM beheerders
UNION ALL
SELECT 'gemeentes' AS tabel, COUNT(*)
FROM gemeentes
UNION ALL
SELECT 'landen' AS tabel, COUNT(*)
FROM landen
UNION ALL
SELECT 'klassen' AS tabel, COUNT(*)
FROM klassen
UNION ALL
SELECT 'leerlingen' AS tabel, COUNT(*)
FROM leerlingen
UNION ALL
SELECT 'scholen' AS tabel, COUNT(*)
FROM scholen
UNION ALL
SELECT 'schoolbeheerders' AS tabel, COUNT(*)
FROM schoolbeheerders
UNION ALL
SELECT 'abonnementen' AS tabel, COUNT(*)
FROM abonnementen;

-- Show many-to-many relationship
SELECT b.VOORNAAM,
       b.ACHTERNAAM,
       b.GESLACHT,
       s.NAAM AS Schoolnaam
FROM beheerders b

         INNER JOIN SCHOOLBEHEERDERS SB on b.BEHEERDERID = SB.BEHEERDERS_BEHEERDERID
         INNER JOIN SCHOLEN S on SB.SCHOLEN_SCHOOLID = S.SCHOOLID;

-- Show school - class - student relationship
SELECT s.NAAM as schoolnaam,
       k.NAAM as klasnaam,
       l.VOORNAAM,
       l.ACHTERNAAM
from SCHOLEN s
         join KLASSEN K on s.SCHOOLID = K.SCHOLEN_SCHOOLID
         join LEERLINGEN L on K.KLASID = L.KLASSEN_KLASID;

-- Show full school address
SELECT s.NAAM       as schoolnaam,
       s.STRAAT     as straat,
       s.HUISNUMMER as huisnummer,
       g.POSTCODE   as postcode,
       g.GEMEENTE   as gemeente,
       l.LANDNAAM   as land
FROM SCHOLEN S
        JOIN GEMEENTES G on s.GEMEENTES_POSTCODE = G.POSTCODE
        JOIN LANDEN L on g.LANDEN_LANDID = l.LANDID;








SELECT s.schoolid, s.naam, s.straat || ' ' || s.huisnummer || ', ' || g.postcode || ' ' || g.gemeente ||', ' || landen.landnaam as adres, ROUND(AVG(l.score))|| '%' as "Average score"
FROM scholen s
         JOIN gemeentes g ON s.gemeentes_postcode = g.postcode
         JOIN landen ON g.landen_landid = landen.landid
         JOIN klassen k ON s.schoolid = k.scholen_schoolid
         JOIN leerlingen l ON k.klasid = l.klassen_klasid
GROUP BY s.schoolid, s.naam, s.straat, s.huisnummer, g.postcode, g.gemeente, landen.landnaam
ORDER BY s.schoolid;

SELECT max(length(straat))
FROM scholen;


SELECT k.klasid, k.naam, k.leerjaar, ROUND(AVG(l.score)) || '%' as "Average score"
FROM klassen k
INNER JOIN leerlingen l ON k.klasid = l.klassen_klasid
WHERE k.scholen_schoolid = 1
GROUP BY k.klasid, k.naam, k.leerjaar;


SELECT leerlingid, voornaam, achternaam, score || '%' as "SCORE"
FROM leerlingen
WHERE klassen_klasid=1;

Select * from scholen;

select * from leerlingen;

select voornaam, achternaam FROM LEERLINGEN
FETCH FIRST 40 rows ONLY;






















