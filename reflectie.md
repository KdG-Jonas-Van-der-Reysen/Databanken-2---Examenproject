Milestone 1: Onderwerp en Git
---

Student:
--------
Jonas Van der Reysen

Onderwerp: (veel op veel)
-------------------------
- M:N
    - School - Beheerder


- 2Level: School
    - School - Klas
    - Klas - Leerling


Entiteittypes:
--------------
- School
- SchoolBeheerder
- Beheerder
- Klas
- Student
- Adres

Relatietypes:
-------------
- School
  - Wordt beheerd door
  - Beheerder
- Leerling
  - Zit in
  - Klas
- Klas
  - Behoort tot
  - School
- School
  - Bevindt zich op
  - Adres

Attributen:
-----------

- School
  - naam
- Klas
  - naam
  - leerjaar
- Leerling
  - voornaam
  - familienaam
  - klasnummer
  - geslacht
- SchoolBeheerder
  - beheerderSinds
- Beheerder
  - voornaam
  - familienaam
  - e-mail adres
  - telefoonnummer
  - wachtwoord
  - geslacht
- Adres
  - straatnaam
  - huisnummer
  - bus
  - postcode
  - gemeente