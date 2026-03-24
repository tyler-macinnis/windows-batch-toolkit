@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Compacts WSL2 virtual disk files (ext4.vhdx) to reclaim space.
:: Usage         : Run this script (will auto-elevate to Administrator).
:: Requirements  : Windows CMD, PowerShell, WSL2, Administrator privileges
:: Notes         : Based on https://github.com/mikemaccana/compact-wsl2-disk
:: ============================================================

echo ==================================================
echo Compact WSL2 Disk
echo ==================================================
echo.
echo This script will compact WSL2 ext4.vhdx files to reclaim disk space.
echo WSL will be shut down during this process.
echo.
echo Requesting Administrator privileges...
echo.

:: Get the directory where this script is located
set "SCRIPT_DIR=%~dp0"

:: Run the PowerShell script as Administrator
powershell.exe -NoProfile -Command "Start-Process powershell.exe -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File \"%SCRIPT_DIR%compact-wsl2-disk.ps1\"' -Verb RunAs -Wait"

echo.
echo Done.
pause
exit /b 0
