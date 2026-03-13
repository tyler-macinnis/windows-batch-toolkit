@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Shows recent Error and Warning events from the System and Application logs.
:: Usage         : Run directly.
:: Requirements  : Windows CMD, wevtutil
:: Notes         : Displays the last 20 errors from each log. Run as Administrator for full access.
:: ============================================================

echo ==================================================
echo Recent System Log Errors
echo ==================================================
echo.
wevtutil qe System /c:20 /rd:true /f:text /q:"*[System[(Level=1 or Level=2)]]" 2>nul | findstr /B /C:"Date" /C:"Source" /C:"Description" /C:"Level"

echo.
echo ==================================================
echo Recent Application Log Errors
echo ==================================================
echo.
wevtutil qe Application /c:20 /rd:true /f:text /q:"*[System[(Level=1 or Level=2)]]" 2>nul | findstr /B /C:"Date" /C:"Source" /C:"Description" /C:"Level"

echo.
pause
exit /b 0
