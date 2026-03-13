@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ============================================================
:: Description   : Launches a customizable list of applications.
:: Usage         : Edit the APP LIST section below, then run directly.
:: Requirements  : Windows CMD
:: Notes         : Self-contained launcher - no external files needed.
:: ============================================================

echo.
echo ============================================================
echo   App Launcher
echo ============================================================
echo.

set "COUNT=0"
set "LAUNCHED=0"

:: ============================================================
:: APP LIST - CUSTOMIZE THIS SECTION
:: ============================================================
:: Add or remove applications below.
:: Format: call :launch "Application Path or Name"
::
:: Examples:
::   call :launch "notepad.exe"
::   call :launch "C:\Program Files\Mozilla Firefox\firefox.exe"
::   call :launch "https://www.google.com"
::   call :launch "C:\Users\YourName\Desktop\Slack.lnk"
::   call :launch "C:\Projects"
::
:: Uncomment the lines below or add your own:

call :launch "notepad.exe"
:: call :launch "calc.exe"
:: call :launch "explorer.exe"
:: call :launch "https://www.google.com"
:: call :launch "C:\Program Files\Mozilla Firefox\firefox.exe"
:: call :launch "C:\Program Files\Google\Chrome\Application\chrome.exe"
:: call :launch "C:\Program Files\Microsoft VS Code\Code.exe"

:: ============================================================
:: END OF APP LIST
:: ============================================================

echo.
echo ============================================================
echo Launched %LAUNCHED% of %COUNT% application(s)
echo ============================================================
echo.
pause
exit /b 0

:: ============================================================
:: LAUNCH FUNCTION - DO NOT MODIFY BELOW THIS LINE
:: ============================================================
:launch
set /A COUNT+=1
set "APP=%~1"
echo Launching: %APP%
start "" "%APP%" 2>nul
if %ERRORLEVEL%==0 (
    set /A LAUNCHED+=1
) else (
    echo   [FAILED]
)
timeout /t 1 /nobreak >nul
goto :eof
