@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ============================================================
:: Script Name   : clear-temp-files.bat
:: Description   : Clears common temporary files from the current user temp directory.
:: Author        : Tyler MacInnis
:: Version       : 1.0.0
:: Created       : 2026-03-12
:: Updated       : 2026-03-12
:: Usage         : Run directly to clear user temp files.
:: Requirements  : Windows CMD
:: Notes         : Some locked files may be skipped.
:: ============================================================

echo Cleaning user temp directory...
echo Target: %TEMP%
echo.

if exist "%TEMP%\*" (
    del /f /q "%TEMP%\*" >nul 2>&1
    for /d %%D in ("%TEMP%\*") do rd /s /q "%%~fD" >nul 2>&1
)

echo Temp cleanup complete.
pause
exit /b 0
