@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ============================================================
:: Description   : Lists files larger than a specified size in MB under a target folder.
:: Usage         : list-large-files.bat [directory] [min_size_mb]
::                 If no directory is provided, uses current directory.
::                 If no size is provided, defaults to 100 MB.
:: Requirements  : Windows CMD
:: Notes         : Output is saved beside the script.
:: ============================================================

set "TARGET_DIR=%~1"
set "MIN_MB=%~2"
if "%TARGET_DIR%"=="" set "TARGET_DIR=%CD%"
if "%MIN_MB%"=="" set "MIN_MB=100"
set "OUTPUT_FILE=%~dp0large-files-report.txt"

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
