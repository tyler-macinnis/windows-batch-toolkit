@echo off
setlocal EnableExtensions

:: ============================================================
:: Script Name   : export-path.bat
:: Description   : Exports the current PATH environment variable to a text file.
:: Author        : Tyler MacInnis
:: Version       : 1.0.0
:: Created       : 2026-03-12
:: Updated       : 2026-03-12
:: Usage         : Run directly to save PATH contents.
:: Requirements  : Windows CMD
:: Notes         : Useful for troubleshooting environment issues.
:: ============================================================

set "OUTPUT_FILE=%~dp0path-export.txt"

echo PATH export file:
echo %OUTPUT_FILE%
echo.

echo %PATH% > "%OUTPUT_FILE%"

echo Done.
pause
exit /b 0
