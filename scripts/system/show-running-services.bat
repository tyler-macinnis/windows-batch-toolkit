@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Lists all currently running Windows services.
:: Usage         : Run directly. Pipe to a file to save output.
:: Requirements  : Windows CMD, sc
:: Notes         : Shows service name and display name.
:: ============================================================

echo ==================================================
echo Running Windows Services
echo ==================================================
echo.

sc query type= all state= running | findstr /R "SERVICE_NAME DISPLAY_NAME"

echo.
pause
exit /b 0
