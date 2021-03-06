/*
    ZAD 1
 */
SELECT NAZWISKO, ETAT, ID_ZESP FROM PRACOWNICY WHERE ID_ZESP = (SELECT ID_ZESP FROM PRACOWNICY WHERE NAZWISKO ='BRZEZINSKI')
ORDER BY NAZWISKO;

/*
    ZAD 2
 */
SELECT P.NAZWISKO, P.ETAT, Z.NAZWA FROM PRACOWNICY P
JOIN ZESPOLY Z ON P.ID_ZESP = Z.ID_ZESP
WHERE P.ID_ZESP = (SELECT ID_ZESP FROM PRACOWNICY WHERE NAZWISKO = 'BRZEZINSKI')
ORDER BY P.NAZWISKO;

/*
    ZAD 3
 */
SELECT NAZWISKO, ETAT, ZATRUDNIONY FROM PRACOWNICY
WHERE ETAT = 'PROFESOR' AND ZATRUDNIONY = (SELECT MIN(ZATRUDNIONY) FROM PRACOWNICY WHERE ETAT = 'PROFESOR');

/*
    ZAD 4
 */
SELECT NAZWISKO, ZATRUDNIONY, ID_ZESP FROM PRACOWNICY
WHERE ZATRUDNIONY IN (SELECT MAX(ZATRUDNIONY) FROM PRACOWNICY GROUP BY ID_ZESP HAVING ID_ZESP IS NOT NULL)
ORDER BY ZATRUDNIONY;

/*
    ZAD 5
 */
SELECT ID_ZESP, NAZWA, ADRES FROM ZESPOLY
WHERE ID_ZESP NOT IN (SELECT DISTINCT ID_ZESP FROM PRACOWNICY WHERE ID_ZESP IS NOT NULL);

/*
    ZAD 6
 */
SELECT NAZWISKO FROM PRACOWNICY
WHERE ETAT = 'PROFESOR' AND ID_PRAC NOT IN (SELECT ID_SZEFA FROM PRACOWNICY WHERE ETAT = 'STAZYSTA');

/*
    ZAD 7
 */
SELECT ID_ZESP, SUM(PLACA_POD) AS SUMA_PLAC
FROM PRACOWNICY GROUP BY ID_ZESP
HAVING SUM(PLACA_POD) = (SELECT MAX(SUM(PLACA_POD)) FROM PRACOWNICY GROUP BY ID_ZESP);

/*
    ZAD 8
 */
SELECT Z.NAZWA, SUM(P.PLACA_POD) AS SUMA_PLAC
FROM PRACOWNICY P INNER JOIN ZESPOLY Z ON P.ID_ZESP = Z.ID_ZESP
GROUP BY Z.ID_ZESP, Z.NAZWA
HAVING SUM(P.PLACA_POD) = (SELECT MAX(SUM(P.PLACA_POD)) FROM PRACOWNICY P INNER JOIN ZESPOLY Z ON P.ID_ZESP = Z.ID_ZESP GROUP BY P.ID_ZESP);

/*
    ZAD 9
 */
SELECT Z.NAZWA, COUNT(*) AS ILU_PRACOWNIKOW FROM
PRACOWNICY P INNER JOIN ZESPOLY Z ON P.ID_ZESP = Z.ID_ZESP
GROUP BY Z.ID_ZESP, Z.NAZWA HAVING COUNT(*) >
(SELECT COUNT(*) FROM
PRACOWNICY P INNER JOIN ZESPOLY Z ON P.ID_ZESP = Z.ID_ZESP
GROUP BY Z.ID_ZESP, Z.NAZWA HAVING Z.NAZWA = 'ADMINISTRACJA')
ORDER BY Z.NAZWA;

/*
    ZAD 10
 */
SELECT ETAT FROM PRACOWNICY
GROUP BY ETAT HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM PRACOWNICY GROUP BY ETAT);

/*
    ZAD 11
 */
SELECT ETAT, LISTAGG(NAZWISKO, ',') WITHIN GROUP (ORDER BY NAZWISKO) AS PRACOWNICY
FROM PRACOWNICY
GROUP BY ETAT HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM PRACOWNICY GROUP BY ETAT);

/*
    ZAD 12
 */
SELECT P.NAZWISKO AS PRACOWNIK, S.NAZWISKO AS SZEF
FROM PRACOWNICY P INNER JOIN PRACOWNICY S ON P.ID_SZEFA = S.ID_PRAC
WHERE ABS(P.PLACA_POD - S.PLACA_POD) = (SELECT MIN(ABS(P.PLACA_POD - S.PLACA_POD)) FROM PRACOWNICY P
INNER JOIN PRACOWNICY S ON P.ID_SZEFA = S.ID_PRAC);
