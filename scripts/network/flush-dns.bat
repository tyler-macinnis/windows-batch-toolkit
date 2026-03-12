@echo off
setlocal EnableExtensions

:: ============================================================
:: Script Name   : flush-dns.bat
:: Description   : Flushes the Windows DNS resolver cache.
:: Author        : Tyler MacInnis
:: Version       : 1.0.0
:: Created       : 2026-03-12
:: Updated       : 2026-03-12
:: Usage         : Run as needed for DNS troubleshooting.
:: Requirements  : Windows CMD
:: Notes         : Some environments may require admin privileges.
:: ============================================================

echo Flushing DNS cache...
ipconfig /flushdns
echo.
pause
exit /b 0
