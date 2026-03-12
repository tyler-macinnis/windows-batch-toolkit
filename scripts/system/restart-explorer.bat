@echo off
setlocal EnableExtensions

:: ============================================================
:: Script Name   : restart-explorer.bat
:: Description   : Restarts Windows Explorer.
:: Author        : Tyler MacInnis
:: Version       : 1.0.0
:: Created       : 2026-03-12
:: Updated       : 2026-03-12
:: Usage         : Run to restart Explorer after shell issues.
:: Requirements  : Windows CMD
:: Notes         : Explorer windows will close and reopen.
:: ============================================================

echo Stopping explorer.exe...
taskkill /f /im explorer.exe >nul 2>&1

timeout /t 2 /nobreak >nul

echo Starting explorer.exe...
start explorer.exe

echo Explorer restarted.
exit /b 0
