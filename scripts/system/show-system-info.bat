@echo off
setlocal EnableExtensions

:: ============================================================
:: Script Name   : show-system-info.bat
:: Description   : Displays basic Windows system information.
:: Author        : Tyler MacInnis
:: Version       : 1.0.0
:: Created       : 2026-03-12
:: Updated       : 2026-03-12
:: Usage         : Run directly to display system details.
:: Requirements  : Windows CMD
:: Notes         : Read-only informational script.
:: ============================================================

echo ==================================================
echo System Information
echo ==================================================
echo Computer Name : %COMPUTERNAME%
echo User Name     : %USERNAME%
echo Processor Arch: %PROCESSOR_ARCHITECTURE%
echo.

ver
echo.
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"System Type" /C:"Total Physical Memory"
echo.
wmic os get lastbootuptime /value
echo.
pause
exit /b 0
