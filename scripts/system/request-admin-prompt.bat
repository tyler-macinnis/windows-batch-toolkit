@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Opens an Administrator Command Prompt through the standard UAC prompt.
:: Usage         : Run directly.
:: Requirements  : Windows CMD, Windows PowerShell 5.1
:: Notes         : Inspired by AnixDevGit/UAC-Batpass bypass.bat; this version does not bypass UAC.
:: ============================================================

echo ==================================================
echo Administrator Command Prompt
echo ==================================================
echo.

net session >nul 2>&1
if not errorlevel 1 (
    echo Current prompt is already elevated. Opening another elevated prompt...
    start "" "%ComSpec%" /k "echo Administrator Command Prompt"
    exit /b 0
)

echo Requesting administrator privileges with the normal Windows UAC consent prompt...
echo.

powershell.exe -NoProfile -Command "Start-Process -FilePath $env:ComSpec -ArgumentList '/k echo Administrator Command Prompt' -Verb RunAs"
if errorlevel 1 (
    echo Failed to start the elevated Command Prompt.
    pause
    exit /b 1
)

exit /b 0
