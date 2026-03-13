@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ============================================================
:: Description   : Displays the saved password for every Wi-Fi profile on this machine.
:: Usage         : Run as Administrator.
:: Requirements  : Windows CMD, netsh, Administrator privileges
:: Notes         : Passwords are stored in plain text in the output. Handle with care.
:: ============================================================

echo ==================================================
echo Wi-Fi Profile Passwords
echo ==================================================
echo.

for /F "tokens=2 delims=:" %%P in ('netsh wlan show profiles ^| findstr /C:"All User Profile"') do (
    set "SSID=%%P"
    set "SSID=!SSID:~1!"
    echo Profile: !SSID!
    netsh wlan show profile name="!SSID!" key=clear | findstr /C:"Key Content"
    echo.
)

pause
exit /b 0
