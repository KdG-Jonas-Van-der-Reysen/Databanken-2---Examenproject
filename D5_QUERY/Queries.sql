-- Table counts
SELECT 'beheerders' AS tabel, COUNT(*)
FROM beheerders
UNION ALL
SELECT 'gemeentes' AS tabel, COUNT(*)
FROM gemeentes
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
FROM schoolbeheerders;

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
SELECT
    s.NAAM as schoolnaam,
    s.STRAAT as straat,
    s.HUISNUMMER as huisnummer,
    g.POSTCODE as postcode,
    g.GEMEENTE as gemeente
FROM SCHOLEN S
         join GEMEENTES G on s.GEMEENTES_POSTCODE = G.POSTCODE;