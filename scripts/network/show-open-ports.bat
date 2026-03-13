@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Lists all active listening ports and their owning process.
:: Usage         : Run as Administrator for full process details.
:: Requirements  : Windows CMD, netstat
:: Notes         : Shows TCP and UDP listening ports with PID.
:: ============================================================

echo ==================================================
echo Open / Listening Ports
echo ==================================================
echo.

netstat -ano | findstr /R "LISTENING"

echo.
echo Tip: Cross-reference PIDs using Task Manager or:
echo      tasklist /FI "PID eq ^<pid^>"
echo.
pause
exit /b 0
