-- 1. RAPORT PRZYCHODÓW WEDŁUG PLANÓW ABONAMENTOWYCH
-- Pozwala sprawdzić, który plan przynosi firmie największe zyski.

SELECT pa.Nazwa_planu,
COUNT(t.Id_transakcji) AS Liczba_transakcji,
SUM(t.Kwota) AS Wszystkie_przychody
FROM Plany_Abonamentowe pa
JOIN Subskrypcje s ON pa.Id_planu = s.Id_planu
JOIN Transakcje t ON s.Id_subskrypcji = t.Id_subskrypcji
WHERE t.Status_transakcji = 'Opłacona'
GROUP BY pa.Nazwa_planu
ORDER BY Wszystkie_przychody DESC;

-- 2. LISTA AKTYWNYCH KLIENTÓW I ICH METOD PŁATNOŚCI
-- Wyciąga dane kontaktowe osób, które mają obecnie opłacony dostęp.


SELECT u.Id_uzytkownika, u.Imie, u.Nazwisko, u.Email, mp.Nazwa_platnosci AS Metoda_Platnosci
FROM Uzytkownicy u 
JOIN Subskrypcje s ON u.Id_uzytkownika = s.Id_uzytkownika
JOIN Transakcje t ON s.Id_subskrypcji = t.Id_subskrypcji
JOIN Metody_Platnosci mp ON t.Id_metody = mp.Id_metody 
WHERE s.Status = 'Aktywna'
GROUP BY u.Id_uzytkownika, u.Imie, u.Nazwisko, u.Email, mp.Nazwa_platnosci; 


-- 3. ANALIZA NAJCZĘSTSZYCH BŁĘDÓW SYSTEMU PŁATNOŚCI
-- Pomaga działowi technicznemu sprawdzić, jakie problemy występują przy transakcjach.

SELECT lb.Kod_bledu, lb.Opis_bledu, 
COUNT(*) AS Liczba_wystapien
FROM Logi_bledow lb
GROUP BY lb.Kod_bledu, lb.Opis_bledu
ORDER BY Liczba_wystapien DESC;

-- 4. ANALIZA SEZONOWOŚCI REJESTRACJI
-- Pomaga działowi marketingu sprawdzić, w których miesiącach rejestruje się najwięcej użytkowników.

SELECT 
CASE STRFTIME('%m', u.Data_rejestracji)
WHEN '01' THEN 'Styczeń'
WHEN '02' THEN 'Luty'
WHEN '03' THEN 'Marzec'
WHEN '04' THEN 'Kwiecień'
WHEN '05' THEN 'Maj'
WHEN '06' THEN 'Czerwiec'
WHEN '07' THEN 'Lipiec'
WHEN '08' THEN 'Sierpień'
WHEN '09' THEN 'Wrzesień'
WHEN '10' THEN 'Październik'
WHEN '11' THEN 'Listopad'
WHEN '12' THEN 'Grudzień'
END AS Miesiac,
COUNT(u.Id_uzytkownika) AS Liczba_nowych_uzytkownikow
FROM Uzytkownicy u
GROUP BY STRFTIME('%m', u.Data_rejestracji)
ORDER BY Liczba_nowych_uzytkownikow DESC;

-- 5. ANALIZA WSKAŹNIKA REZYGNACJI DLA PLANÓW (CHURN RATE)
-- Pomaga działowi produktu zidentyfikować plany abonamentowe, które najczęściej tracą klientów.

SELECT p.Nazwa_planu,
COUNT(s.Id_subskrypcji) AS Liczba_anulowanych_subskrypcji
FROM Plany_Abonamentowe p
JOIN Subskrypcje s ON p.Id_planu = s.Id_planu
WHERE s.Status = 'Anulowana' 
GROUP BY p.Nazwa_planu
HAVING Liczba_anulowanych_subskrypcji > 1
ORDER BY Liczba_anulowanych_subskrypcji DESC;
