@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Lists programs configured to run at Windows startup.
:: Usage         : Run directly. No elevated privileges required.
:: Requirements  : Windows CMD, reg
:: Notes         : Checks both HKCU and HKLM run keys.
:: ============================================================

echo ==================================================
echo Startup Programs
echo ==================================================
echo.

echo [HKCU - Current User]
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" 2>nul
echo.

echo [HKLM - All Users]
reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" 2>nul
echo.

echo [HKLM - 32-bit on 64-bit Windows]
reg query "HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" 2>nul
echo.

pause
exit /b 0
