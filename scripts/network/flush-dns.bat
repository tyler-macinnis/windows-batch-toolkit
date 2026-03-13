@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Flushes the Windows DNS resolver cache.
:: Usage         : Run as needed for DNS troubleshooting.
:: Requirements  : Windows CMD
:: Notes         : Some environments may require admin privileges.
:: ============================================================

echo Flushing DNS cache...
ipconfig /flushdns
echo.
pause
exit /b 0
