@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Lists all installed software on the system.
:: Usage         : Run directly.
:: Requirements  : Windows CMD
:: Notes         : Queries both 64-bit and 32-bit registry hives.
:: ============================================================

echo ==================================================
echo Installed Software
echo ==================================================
echo.
echo 64-bit applications:
echo --------------------------------------------------
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /s /v DisplayName 2>nul | findstr /I "DisplayName"

echo.
echo 32-bit applications (WOW64):
echo --------------------------------------------------
reg query "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall" /s /v DisplayName 2>nul | findstr /I "DisplayName"

echo.
pause
exit /b 0
