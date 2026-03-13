@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Displays detailed Windows system information.
:: Usage         : Run directly to display system details.
:: Requirements  : Windows CMD
:: Notes         : Read-only informational script.
:: ============================================================

echo ==================================================
echo System Information
echo ==================================================
echo.

echo --- Identity ---
echo Computer Name  : %COMPUTERNAME%
echo User Name      : %USERNAME%
echo User Domain    : %USERDOMAIN%
echo.

echo --- Operating System ---
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"OS Build Type" /C:"Registered Owner" /C:"System Type"
echo.

echo --- Hardware ---
systeminfo | findstr /B /C:"Total Physical Memory" /C:"Available Physical Memory"
echo.
wmic cpu get name /value
wmic computersystem get manufacturer,model /value
echo.

echo --- Uptime ---
for /F "tokens=2 delims==" %%T in ('wmic os get lastbootuptime /value 2^>nul') do set "LBT=%%T"
echo Last Boot : %LBT:~0,4%-%LBT:~4,2%-%LBT:~6,2% %LBT:~8,2%:%LBT:~10,2%:%LBT:~12,2%
echo.

echo --- Environment ---
echo TEMP           : %TEMP%
echo SystemRoot     : %SystemRoot%
echo Processor Arch : %PROCESSOR_ARCHITECTURE%
echo Number of CPUs : %NUMBER_OF_PROCESSORS%
echo.

pause
exit /b 0
