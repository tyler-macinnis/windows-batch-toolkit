@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ============================================================
:: Description   : Pings every host in a configurable IP range to find active devices.
:: Usage         : Edit BASE_IP, START_RANGE, and END_RANGE, then run.
:: Requirements  : Windows CMD
:: Notes         : Uses a single ping packet per host for speed.
:: ============================================================

set "BASE_IP=192.168.1"
set /a START_RANGE=1
set /a END_RANGE=254

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
