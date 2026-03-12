@echo off
setlocal EnableExtensions

:: ============================================================
:: Script Name   : show-ip-config.bat
:: Description   : Displays full IP configuration information and exports it to a text file.
:: Author        : Tyler MacInnis
:: Version       : 1.0.0
:: Created       : 2026-03-12
:: Updated       : 2026-03-12
:: Usage         : Run directly to view and save IP config details.
:: Requirements  : Windows CMD
:: Notes         : Output file is written beside the script.
:: ============================================================

set "OUTPUT_FILE=%~dp0ipconfig-output.txt"

echo Saving IP configuration to:
echo %OUTPUT_FILE%
echo.

ipconfig /all > "%OUTPUT_FILE%"
type "%OUTPUT_FILE%"

echo.
echo Done.
pause
exit /b 0
