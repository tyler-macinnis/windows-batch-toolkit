@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Runs the System File Checker to scan and repair protected system files.
:: Usage         : Run as Administrator.
:: Requirements  : Windows CMD, Administrator privileges
:: Notes         : Results are logged to %SystemRoot%\Logs\CBS\CBS.log.
:: ============================================================

echo ==================================================
echo System File Checker
echo ==================================================
echo.
echo This may take several minutes. Do not close this window.
echo.

sfc /scannow

echo.
echo Scan complete. Review output above for any issues.
echo Full log: %SystemRoot%\Logs\CBS\CBS.log
echo.
pause
exit /b 0
