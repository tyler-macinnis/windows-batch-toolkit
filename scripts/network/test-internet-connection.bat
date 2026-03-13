@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Tests connectivity to common internet endpoints.
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
