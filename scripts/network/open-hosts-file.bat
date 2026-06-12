@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Opens the Windows hosts file in Notepad (elevated).
:: Usage         : Run as Administrator.
:: Requirements  : Windows CMD, Administrator privileges
:: Notes         : Hosts file location: %SystemRoot%\System32\drivers\etc\hosts
:: ============================================================

set "HOSTS_FILE=%SystemRoot%\System32\drivers\etc\hosts"

echo.
echo Opening hosts file for editing...
echo Location: %HOSTS_FILE%
echo.

if not exist "%HOSTS_FILE%" (
    echo ERROR: Hosts file not found at expected location.
    exit /b 1
)

notepad "%HOSTS_FILE%"

exit /b 0
