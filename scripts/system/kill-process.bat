@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Terminates a running process by name.
:: Usage         : Edit PROCESS_NAME, then run as Administrator.
:: Requirements  : Windows CMD, taskkill
:: Notes         : Use the .exe name as it appears in Task Manager.
:: ============================================================

set "PROCESS_NAME=notepad.exe"

echo Attempting to terminate: %PROCESS_NAME%
echo.

tasklist /FI "IMAGENAME eq %PROCESS_NAME%" 2>nul | find /I "%PROCESS_NAME%" >nul
if errorlevel 1 (
    echo Process not found: %PROCESS_NAME%
    pause
    exit /b 1
)

taskkill /IM "%PROCESS_NAME%" /F
if errorlevel 1 (
    echo ERROR: Failed to terminate %PROCESS_NAME%. Try running as Administrator.
    pause
    exit /b 1
)

echo.
echo Process terminated successfully.
pause
exit /b 0
