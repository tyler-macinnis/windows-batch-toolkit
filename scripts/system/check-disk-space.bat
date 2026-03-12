@echo off
setlocal EnableExtensions

:: ============================================================
:: Script Name   : check-disk-space.bat
:: Description   : Shows disk usage information for local drives.
:: Author        : Tyler MacInnis
:: Version       : 1.0.0
:: Created       : 2026-03-12
:: Updated       : 2026-03-12
:: Usage         : Run directly to list logical disk sizes and free space.
:: Requirements  : Windows CMD
:: Notes         : Uses WMIC for output.
:: ============================================================

echo ==================================================
echo Disk Space Information
echo ==================================================
wmic logicaldisk get caption,description,freespace,size
echo.
pause
exit /b 0
