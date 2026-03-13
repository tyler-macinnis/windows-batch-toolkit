@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Resets key Windows network components for troubleshooting.
:: Usage         : Run as administrator when resolving network issues.
:: Requirements  : Windows CMD, Administrator privileges
:: Notes         : A reboot may be required after running.
:: ============================================================

echo ==================================================
echo Resetting Network Stack
echo ==================================================
echo.

ipconfig /release
ipconfig /renew
ipconfig /flushdns
netsh winsock reset
netsh int ip reset

echo.
echo Network reset commands completed.
echo Reboot recommended.
pause
exit /b 0
