@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Lists all saved Wi-Fi profiles on this machine.
:: Usage         : Run directly.
:: Requirements  : Windows CMD, netsh
:: Notes         : Does not reveal passwords. Use show-wifi-passwords.bat for that.
:: ============================================================

echo ==================================================
echo Saved Wi-Fi Profiles
echo ==================================================
echo.

netsh wlan show profiles

echo.
pause
exit /b 0
