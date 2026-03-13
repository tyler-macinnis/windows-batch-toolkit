@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ============================================================
:: Description   : Displays all environment variables sorted alphabetically.
:: Usage         : Run directly. Optionally pass filter string.
:: Requirements  : Windows CMD
:: Notes         : Filter is case-insensitive partial match.
:: ============================================================

set "FILTER=%~1"

echo.
if "%FILTER%"=="" (
    echo All Environment Variables:
) else (
    echo Environment Variables matching "%FILTER%":
)
echo ============================================================
echo.

if "%FILTER%"=="" (
    set | sort
) else (
    set | findstr /i "%FILTER%" | sort
)

echo.
exit /b 0
