@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Displays network interface and adapter information using netsh.
:: Usage         : Run directly.
:: Requirements  : Windows CMD, netsh
:: Notes         : Shows interface state, IP addresses, and adapter details.
:: ============================================================

echo ==================================================
echo Network Interfaces
echo ==================================================
echo.

netsh interface show interface

echo.
echo ==================================================
echo IP Addresses (All Interfaces)
echo ==================================================
echo.

netsh interface ip show addresses

echo.
echo ==================================================
echo DNS Servers (All Interfaces)
echo ==================================================
echo.

netsh interface ip show dnsservers

echo.
echo ==================================================
echo Network Adapters (Physical + Virtual)
echo ==================================================
echo.

netsh interface ipv4 show interfaces

echo.
pause
exit /b 0
