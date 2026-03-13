@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Resets the Windows icon cache to fix corrupted or missing icons.
:: Usage         : Run as Administrator.
:: Requirements  : Windows CMD, Administrator privileges
:: Notes         : This will restart Explorer and may briefly interrupt your desktop.
:: ============================================================

echo Resetting Windows icon cache...
echo.

echo Stopping Explorer...
taskkill /im explorer.exe /f

cd /d %userprofile%\appdata\local
attrib -h -r -s iconcache.db
del iconcache.db /q

echo Starting Explorer...
start %windir%\explorer.exe

echo.
echo Icon cache has been reset.
exit /b 0
