@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Shows disk usage information for local drives.
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
