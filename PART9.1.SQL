/*
    ZAD 1
 */
CREATE TABLE PROJEKTY (
    ID_PROJEKTU NUMBER(4) GENERATED ALWAYS AS IDENTITY,
    OPIS_PROJEKTU VARCHAR(20),
    DATA_ROZPOCZECIA DATE DEFAULT CURRENT_DATE,
    DATA_ZAKONCZENIA DATE,
    FUNDUSZ NUMBER(7, 2)
);

/*
    ZAD 2
 */
INSERT INTO PROJEKTY (OPIS_PROJEKTU, DATA_ROZPOCZECIA, DATA_ZAKONCZENIA, FUNDUSZ) VALUES
    ('Indeksy bitmapowe', DATE '1999-04-02', DATE '2001-08-31', 25000);
INSERT INTO PROJEKTY (OPIS_PROJEKTU, DATA_ZAKONCZENIA, FUNDUSZ) VALUES
    ('Sieci kręgosłupowe', NULL, 19000);

/*
    ZAD 3
 */
SELECT ID_PROJEKTU, OPIS_PROJEKTU FROM PROJEKTY;

/*
    ZAD 4
 */
INSERT INTO PROJEKTY (OPIS_PROJEKTU, DATA_ROZPOCZECIA, DATA_ZAKONCZENIA, FUNDUSZ) VALUES
    ('Indeksy drzewiaste', DATE '2013-12-24', DATE '2014-01-01', 1200);

/*
    ZAD 5
 */
UPDATE PROJEKTY P SET P.ID_PROJEKTU = 10 WHERE P.ID_PROJEKTU = 3; -- NIE

/*
    ZAD 6
 */
CREATE TABLE PROJEKTY_KOPIA AS (SELECT * FROM PROJEKTY);
SELECT * FROM PROJEKTY_KOPIA;

/*
    ZAD 7
    UDA SIĘ. KOPIUJAC TABELE PROJEKTY NIE SKOPIOWALISMY JEJ ATRYBUTÓW (AUTO INCREMENT). ID_PROJEKTU NIE JEST JUZ UNIKATOWE
 */
INSERT INTO PROJEKTY_KOPIA (ID_PROJEKTU, OPIS_PROJEKTU, DATA_ROZPOCZECIA, DATA_ZAKONCZENIA, FUNDUSZ) VALUES (10, 'Sieci lokalne', CURRENT_DATE, CURRENT_DATE + INTERVAL '1' YEAR , 1200);
SELECT * FROM PROJEKTY_KOPIA;

/*
    ZAD 8
    NIE, NIE ZOSTAŁ. KOPIA JEST ODBICIEM LUSTRZANYM WERSJI Z PRZESZLOSCI, ZMIANY W TABELI PROJEKTY NIE WPLYNA NA KOPIE.
 */
DELETE FROM PROJEKTY WHERE OPIS_PROJEKTU = 'Indeksy drzewiaste';
SELECT * FROM PROJEKTY;
SELECT * FROM PROJEKTY_KOPIA;

/*
    ZAD 9
 */
SELECT TABLE_NAME FROM TABS ORDER BY TABLE_NAME;
