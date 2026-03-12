@echo off
setlocal EnableExtensions

:: ============================================================
:: Script Name   : reset-network-stack.bat
:: Description   : Resets key Windows network components for troubleshooting.
:: Author        : Tyler MacInnis
:: Version       : 1.0.0
:: Created       : 2026-03-12
:: Updated       : 2026-03-12
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
