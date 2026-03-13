@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ============================================================
:: Description   : Terminates a running process by name.
:: Usage         : kill-process.bat [process_name]
::                 Example: kill-process.bat notepad.exe
::                 If not provided, prompts for process name.
:: Requirements  : Windows CMD, taskkill
:: Notes         : Use the .exe name as it appears in Task Manager.
:: ============================================================

set "PROCESS_NAME=%~1"
if "!PROCESS_NAME!"=="" (
    set /P "PROCESS_NAME=Enter process name (e.g., notepad.exe): "
)
if "!PROCESS_NAME!"=="" (
    echo ERROR: No process name provided.
    pause
    exit /b 1
)

echo Attempting to terminate: !PROCESS_NAME!
echo.

tasklist /FI "IMAGENAME eq !PROCESS_NAME!" 2>nul | find /I "!PROCESS_NAME!" >nul
if errorlevel 1 (
    echo Process not found: !PROCESS_NAME!
    pause
    exit /b 1
)

taskkill /IM "!PROCESS_NAME!" /F
if errorlevel 1 (
    echo ERROR: Failed to terminate !PROCESS_NAME!. Try running as Administrator.
    pause
    exit /b 1
)

echo.
echo Process terminated successfully.
pause
exit /b 0
