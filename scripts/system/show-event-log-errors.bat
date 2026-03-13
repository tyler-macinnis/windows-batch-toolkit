@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Shows recent Error and Warning events from the System and Application logs.
:: Usage         : show-event-log-errors.bat [count]
::                 If no count is provided, defaults to 20 events per log.
:: Requirements  : Windows CMD, wevtutil
:: Notes         : Run as Administrator for full access.
:: ============================================================

set "COUNT=%~1"
if "%COUNT%"=="" set "COUNT=20"

echo ==================================================
echo Recent System Log Errors
echo ==================================================
echo.
wevtutil qe System /c:%COUNT% /rd:true /f:text /q:"*[System[(Level=1 or Level=2)]]" 2>nul | findstr /B /C:"Date" /C:"Source" /C:"Description" /C:"Level"

echo.
echo ==================================================
echo Recent Application Log Errors
echo ==================================================
echo.
wevtutil qe Application /c:%COUNT% /rd:true /f:text /q:"*[System[(Level=1 or Level=2)]]" 2>nul | findstr /B /C:"Date" /C:"Source" /C:"Description" /C:"Level"

echo.
pause
exit /b 0
