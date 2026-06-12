@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Updates installed WinGet packages.
:: Usage         : Run directly; run as Administrator for system-wide apps.
:: Requirements  : Windows 10/11, Windows Package Manager (winget)
:: Notes         : Inspired by Ryan-Adams57/Windows-Bash-And-Batch-Scripts Winget-Update-All-Local-Software.bat.
:: ============================================================

where winget.exe >nul 2>&1
if errorlevel 1 (
    echo WinGet was not found on this computer.
    echo Install App Installer from Microsoft Store, then run this script again.
    pause
    exit /b 1
)

echo ==================================================
echo WinGet Package Updates
echo ==================================================
echo.

net session >nul 2>&1
if errorlevel 1 (
    echo Note: This prompt is not elevated.
    echo Some package updates may require Administrator privileges.
    echo Right-click this script and choose Run as administrator if updates fail.
    echo.
)

set "WINGET_ARGS=upgrade --all --include-unknown --accept-source-agreements --accept-package-agreements"
set /P "SILENT=Use silent mode when supported? (Y/N): "
if /I "%SILENT%"=="Y" set "WINGET_ARGS=%WINGET_ARGS% --silent"

echo.
echo Running: winget %WINGET_ARGS%
echo.

winget %WINGET_ARGS%
if errorlevel 1 (
    echo.
    echo One or more WinGet updates failed.
    pause
    exit /b 1
)

echo.
echo WinGet update process complete.
pause
exit /b 0
