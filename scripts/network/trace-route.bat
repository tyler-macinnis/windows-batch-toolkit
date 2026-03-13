@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Runs a traceroute to a target host and saves the output to a file.
:: Usage         : Run directly. Enter a hostname or IP when prompted.
:: Requirements  : Windows CMD
:: Notes         : Output file is saved beside the script.
:: ============================================================

set /P "TARGET=Enter target hostname or IP: "
if "%TARGET%"=="" (
    echo ERROR: No target specified.
    pause
    exit /b 1
)

set "OUTPUT_FILE=%~dp0traceroute-%TARGET%.txt"

echo.
echo Running traceroute to %TARGET%...
echo Output will be saved to: %OUTPUT_FILE%
echo.

tracert %TARGET% | tee "%OUTPUT_FILE%" 2>nul
if errorlevel 1 (
    tracert %TARGET% > "%OUTPUT_FILE%"
    type "%OUTPUT_FILE%"
)

echo.
echo Saved: %OUTPUT_FILE%
echo.
pause
exit /b 0
