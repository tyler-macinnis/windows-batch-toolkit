@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ============================================================
:: Description   : Pings every host in a configurable IP range to find active devices.
:: Usage         : ping-sweep.bat [base_ip] [start] [end]
::                 Example: ping-sweep.bat 192.168.1 1 254
::                 If not provided, defaults to 192.168.1.1-254
:: Requirements  : Windows CMD
:: Notes         : Uses a single ping packet per host for speed.
:: ============================================================

set "BASE_IP=%~1"
set "START_RANGE=%~2"
set "END_RANGE=%~3"
if "%BASE_IP%"=="" set "BASE_IP=192.168.1"
if "%START_RANGE%"=="" set /a START_RANGE=1
if "%END_RANGE%"=="" set /a END_RANGE=254

echo ==================================================
echo Ping Sweep: %BASE_IP%.%START_RANGE% - %BASE_IP%.%END_RANGE%
echo ==================================================
echo.

set /a FOUND=0
for /L %%i in (%START_RANGE%,1,%END_RANGE%) do (
    ping -n 1 -w 300 %BASE_IP%.%%i >nul 2>&1
    if !errorlevel!==0 (
        echo   ALIVE  --  %BASE_IP%.%%i
        set /a FOUND+=1
    )
)

echo.
echo ==================================================
echo Sweep complete. !FOUND! host(s) responded.
echo ==================================================
echo.
pause
exit /b 0
