@echo off
title Cichy Automat Przegladarkowy

:: --- KONFIGURACJA ---
set "adres_url=https://zyciesokolowa.pl/static/avatars/233/8/228663_1748700997.jpg"
set max_czas=60
:: --------------------

:: 1. Losowanie czasu
set /a losowy_czas=%random% %% %max_czas% + 1
echo Wylosowano: %losowy_czas% s. Czekam...
timeout /t %losowy_czas% /nobreak >nul

:: 2. URUCHAMIANIE (Tylko jeśli przeglądarka istnieje)
echo.
echo Otwieranie dostepnych przegladarek...

:: --- GOOGLE CHROME ---
if exist "C:\Program Files\Google\Chrome\Application\chrome.exe" (
    start "" "C:\Program Files\Google\Chrome\Application\chrome.exe" "%adres_url%"
) else if exist "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" (
    start "" "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "%adres_url%"
)

:: --- MOZILLA FIREFOX ---
if exist "C:\Program Files\Mozilla Firefox\firefox.exe" (
    start "" "C:\Program Files\Mozilla Firefox\firefox.exe" "%adres_url%"
) else if exist "C:\Program Files (x86)\Mozilla Firefox\firefox.exe" (
    start "" "C:\Program Files (x86)\Mozilla Firefox\firefox.exe" "%adres_url%"
)

:: --- MICROSOFT EDGE ---
:: Edge jest systemowy, więc zazwyczaj start msedge działa, ale dla pewności ścieżka:
if exist "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" (
    start "" "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" "%adres_url%"
) else (
    :: Awaryjna próba uruchomienia po nazwie (ukrycie błędów w konsoli)
    start "" msedge "%adres_url%" >nul 2>&1
)

:: --- OPERA ---
:: Opera instaluje się często w folderze użytkownika
if exist "%LOCALAPPDATA%\Programs\Opera\launcher.exe" (
    start "" "%LOCALAPPDATA%\Programs\Opera\launcher.exe" "%adres_url%"
)

:: --- BRAVE ---
if exist "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe" (
    start "" "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe" "%adres_url%"
)

:: 3. Czekanie 5 sekund
timeout /t 5 /nobreak >nul

:: 4. Zamykanie (Bez wyświetlania błędów "nie znaleziono procesu")
echo.
echo Zamykanie...
taskkill /F /IM chrome.exe /T >nul 2>&1
taskkill /F /IM firefox.exe /T >nul 2>&1
taskkill /F /IM msedge.exe /T >nul 2>&1
taskkill /F /IM opera.exe /T >nul 2>&1
taskkill /F /IM brave.exe /T >nul 2>&1

exit
