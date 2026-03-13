@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Lists files not modified in the last N days.
:: Usage         : find-old-files.bat [directory] [days]
::                 If no directory is provided, uses current directory.
::                 If no days value is provided, defaults to 90.
:: Requirements  : Windows CMD, forfiles
:: Notes         : Adjust days parameter to control the age threshold.
:: ============================================================

set "TARGET_DIR=%~1"
set "DAYS_OLD=%~2"
if "%TARGET_DIR%"=="" set "TARGET_DIR=%CD%"
if "%DAYS_OLD%"=="" set "DAYS_OLD=90"

if not exist "%TARGET_DIR%" (
    echo ERROR: Target folder does not exist: %TARGET_DIR%
    pause
    exit /b 1
)

echo ==================================================
echo Files not modified in the last %DAYS_OLD% days
echo Target: %TARGET_DIR%
echo ==================================================
echo.

forfiles /P "%TARGET_DIR%" /S /D -%DAYS_OLD% /C "cmd /c echo @fdate @ftime  @relpath" 2>nul

if errorlevel 1 (
    echo No files found older than %DAYS_OLD% days.
)

echo.
pause
exit /b 0
