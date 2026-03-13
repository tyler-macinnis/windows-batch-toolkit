@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Tests connectivity to common internet endpoints.
:: Usage         : test-internet-connection.bat [host1] [host2] [host3]
::                 If no hosts provided, tests 8.8.8.8, 1.1.1.1, and google.com
:: Requirements  : Windows CMD
:: Notes         : Uses ping for basic connectivity checks.
:: ============================================================

set "HOST1=%~1"
set "HOST2=%~2"
set "HOST3=%~3"
if "%HOST1%"=="" set "HOST1=8.8.8.8"
if "%HOST2%"=="" set "HOST2=1.1.1.1"
if "%HOST3%"=="" set "HOST3=google.com"

echo Testing connectivity...
echo.

ping -n 1 %HOST1%
echo.
ping -n 1 %HOST2%
echo.
ping -n 1 %HOST3%
echo.
pause
exit /b 0
