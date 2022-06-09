/*
    ZAD 1
 */
SELECT
    p.nazwisko,
    p.id_zesp,
    z.nazwa
FROM
    pracownicy p LEFT JOIN zespoly z ON p.id_zesp = z.id_zesp
ORDER BY
    p.nazwisko ASC;

/*
    ZAD 2
 */
SELECT
    z.nazwa,
    z.id_zesp,
    coalesce(p.nazwisko,'brak pracowników')
FROM
    zespoly z LEFT JOIN pracownicy p ON z.id_zesp = p.id_zesp
ORDER BY
    z.nazwa,p.nazwisko;

/*
    ZAD 3
 */
SELECT
    coalesce(z.nazwa,'brak zespolu'),
    coalesce(p.nazwisko,'brak pracowników')
FROM
    zespoly z FULL JOIN pracownicy p ON z.id_zesp = p.id_zesp
ORDER BY
    z.nazwa,p.nazwisko;

/*
    ZAD 4
 */
 SELECT
    z.nazwa,
    COUNT(p.id_prac) AS liczba,
    coalesce(SUM(p.placa_pod),0) AS suma_plac
FROM
    zespoly z LEFT JOIN pracownicy p ON z.id_zesp =p.id_zesp
GROUP BY
    z.nazwa
ORDER BY
    z.nazwa ASC;

/*
    ZAD 5
 */
 SELECT
    z.nazwa
FROM
    zespoly z LEFT JOIN pracownicy p ON z.id_zesp =p.id_zesp
WHERE
    p.id_prac IS NULL
ORDER BY
    z.nazwa ASC;

/*
    ZAD 6
 */
 SELECT
     p.nazwisko AS pracownik,
     p.id_prac  AS id_prac,
     s.nazwisko AS szef,
     s.id_prac  AS id_szefa
FROM
    pracownicy p LEFT JOIN pracownicy s ON p.id_szefa=s.id_prac
ORDER BY
    p.nazwisko;

/*
    ZAD 7
 */
 SELECT
    p.nazwisko          AS pracownik,
    COUNT(pod.id_prac)  AS liczba_podwladnych
FROM
    pracownicy p LEFT JOIN pracownicy pod ON p.id_prac=pod.id_szefa
GROUP BY
    p.nazwisko
ORDER BY
    p.nazwisko ASC;

/*
    ZAD 8
 */
 SELECT
    p.nazwisko,
    p.etat,
    p.placa_pod,
    z.nazwa         AS nazwa,
    szef.nazwisko   AS SZEF
FROM
    pracownicy p LEFT JOIN zespoly z ON p.id_zesp = z.id_zesp
    LEFT JOIN pracownicy szef ON p.id_szefa = szef.id_prac
Order by
    p.nazwisko;

/*
    ZAD 9
 */
 SELECT
    p.nazwisko,
    z.nazwa
FROM
    pracownicy p CROSS JOIN zespoly z
ORDER BY
    nazwisko;

/*
    ZAD 10
 */
 SELECT
    COUNT(*)
FROM
    (etaty e CROSS JOIN pracownicy p) CROSS JOIN zespoly z;

/*
    ZAD 11
 */
 SELECT
    etat
FROM
    pracownicy
WHERE
    EXTRACT(YEAR FROM (zatrudniony))=1992

INTERSECT

SELECT
    etat
FROM
    pracownicy
WHERE
    EXTRACT(YEAR FROM (zatrudniony))=1993;

/*
    ZAD 12
 */
 SELECT
    id_zesp
FROM
    zespoly

MINUS

SELECT
    id_zesp
FROM
    pracownicy;

/*
    ZAD 13
 */
SELECT z.id_zesp,z.nazwa FROM zespoly z
MINUS
SELECT p.id_zesp,zes.nazwa FROM pracownicy p INNER JOIN zespoly zes ON p.id_zesp=zes.id_zesp;

/*
    ZAD 14
 */
    SELECT
        nazwisko,
        placa_pod,
        'Poniżej 480 zotych'  AS "PROG"
    FROM
        pracownicy
    WHERE
        placa_pod <480

UNION

    SELECT
        nazwisko,
        placa_pod,
        'Dokladnie 480 złotych'
    FROM
        pracownicy
    WHERE
        placa_pod =480

UNION

    SELECT
        nazwisko,
        placa_pod,
        'Powyżej 480 złotych'
    FROM
        pracownicy
    WHERE
        placa_pod >480
    ORDER BY
        placa_pod;
