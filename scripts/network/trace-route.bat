@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ============================================================
:: Description   : Runs a traceroute to a target host and saves the output to a file.
:: Usage         : trace-route.bat [hostname_or_ip]
::                 If no target provided, prompts for input.
:: Requirements  : Windows CMD
:: Notes         : Output file is saved beside the script. Uses numeric hops to avoid slow DNS lookups.
:: ============================================================

set "TARGET=%~1"
if "!TARGET!"=="" (
    set /P "TARGET=Enter target hostname or IP: "
)
if "!TARGET!"=="" (
    echo ERROR: No target specified.
    pause
    exit /b 1
)

set "OUTPUT_FILE=%~dp0traceroute-!TARGET!.txt"

echo.
echo Running traceroute to !TARGET!...
echo Output will be saved to: !OUTPUT_FILE!
echo This can take a minute or two if hops do not respond.
echo.

tracert -d "!TARGET!" > "!OUTPUT_FILE!"
set "TRACERT_EXIT=!errorlevel!"
type "!OUTPUT_FILE!"

if not "!TRACERT_EXIT!"=="0" (
    echo.
    echo ERROR: Traceroute failed with exit code !TRACERT_EXIT!.
    echo Check that the target name is valid and that tracert is available.
    pause
    exit /b !TRACERT_EXIT!
)

echo.
echo Saved: !OUTPUT_FILE!
echo.
pause
exit /b 0
