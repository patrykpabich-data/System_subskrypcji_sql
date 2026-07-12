# System_subskrypcji_sql
Projekt bazy danych SQLite dla systemu zarządzania subskrypcjami użytkowników. Zawiera kompletną strukturę tabel, dane testowe, analityczne zapytania SQL oraz diagram ERD.

![Diagram bazy danych](diagram.png)

## Struktura Bazy Danych
Baza składa się z następujących tabel:
- Użytkownicy: dane profilowe klientów oraz data rejestracji.
- Plany Abonamentowe: konfiguracja pakietów (rodzaj planu, cena, okres ważności w dniach).
- Subskrypcje: relacja łącząca użytkownika z planem, data rozpoczęcia/zakończenia oraz status.
- Metody Płatności: słownik dostępnych form płatności (karta, BLIK, paypal).
- Transakcje: historia wpłat powiązana z fakturowaniem i statusem płatności.
- Logi błędów: rejestr nieudanych operacji transakcyjnych do celów analitycznych.

## Jak uruchomić projekt lokalnie?
1. Pobierz plik bazy danych Subskrypcje_i_Płatności_Cykliczne z tego repozytorium.
2. Otwórz program DBeaver lub dowolny inny menedżer baz SQLite.
3. Utwórz nowe połączenie typu SQLite i wskaż pobrany plik bazy danych.
4. Wszystkie tabele, relacje oraz wprowadzone dane testowe będą od razu widoczne i gotowe do analizy.
