@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ============================================================
:: Script Name   : list-large-files.bat
:: Description   : Lists files larger than a specified size in MB under a target folder.
:: Author        : Tyler MacInnis
:: Version       : 1.0.0
:: Created       : 2026-03-12
:: Updated       : 2026-03-12
:: Usage         : Edit TARGET_DIR and MIN_MB, then run.
:: Requirements  : Windows CMD
:: Notes         : Output is saved beside the script.
:: ============================================================

set "TARGET_DIR=%USERPROFILE%\Downloads"
set "OUTPUT_FILE=%~dp0large-files-report.txt"
set "MIN_MB=100"

echo Scanning: %TARGET_DIR%
echo Minimum Size: %MIN_MB% MB
echo Output: %OUTPUT_FILE%
echo.

break > "%OUTPUT_FILE%"
echo Large files report for %TARGET_DIR% > "%OUTPUT_FILE%"
echo Minimum size: %MIN_MB% MB >> "%OUTPUT_FILE%"
echo. >> "%OUTPUT_FILE%"

for /r "%TARGET_DIR%" %%F in (*) do (
    set /a FILE_MB=%%~zF / 1024 / 1024
    if !FILE_MB! GEQ %MIN_MB% (
        echo %%~fF ^| !FILE_MB! MB>> "%OUTPUT_FILE%"
    )
)

echo Scan complete.
pause
exit /b 0
