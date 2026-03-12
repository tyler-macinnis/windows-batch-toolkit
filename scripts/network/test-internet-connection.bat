@echo off
setlocal EnableExtensions

:: ============================================================
:: Script Name   : test-internet-connection.bat
:: Description   : Tests connectivity to common internet endpoints.
:: Author        : Tyler MacInnis
:: Version       : 1.0.0
:: Created       : 2026-03-12
:: Updated       : 2026-03-12
:: Usage         : Run directly to perform quick connectivity tests.
:: Requirements  : Windows CMD
:: Notes         : Uses ping for basic connectivity checks.
:: ============================================================

echo Testing connectivity...
echo.

ping -n 1 8.8.8.8
echo.
ping -n 1 1.1.1.1
echo.
ping -n 1 google.com
echo.
pause
exit /b 0
