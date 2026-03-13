@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Displays all enabled Windows Firewall rules grouped by direction.
:: Usage         : Run directly. Run as Administrator for full rule details.
:: Requirements  : Windows CMD, netsh
:: Notes         : Output can be lengthy. Consider piping to a file for review.
:: ============================================================

echo ==================================================
echo Windows Firewall - Inbound Rules (Enabled)
echo ==================================================
echo.

netsh advfirewall firewall show rule name=all dir=in status=enabled

echo.
echo ==================================================
echo Windows Firewall - Outbound Rules (Enabled)
echo ==================================================
echo.

netsh advfirewall firewall show rule name=all dir=out status=enabled

echo.
pause
exit /b 0
