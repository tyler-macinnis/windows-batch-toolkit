@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Displays the current ARP cache table.
:: Usage         : Run directly.
:: Requirements  : Windows CMD
:: Notes         : Shows IP-to-MAC mappings for all network interfaces.
:: ============================================================

echo ==================================================
echo ARP Cache Table
echo ==================================================
echo.

arp -a

echo.
pause
exit /b 0
