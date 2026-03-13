@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Lists all scheduled tasks with their status and next run time.
:: Usage         : Run directly.
:: Requirements  : Windows CMD, schtasks
:: Notes         : Run as Administrator to see all tasks including system-level ones.
:: ============================================================

echo ==================================================
echo Scheduled Tasks
echo ==================================================
echo.

schtasks /query /fo LIST /v 2>nul | findstr /B /C:"TaskName" /C:"Status" /C:"Next Run Time" /C:"Last Run Time" /C:"Last Result"

echo.
pause
exit /b 0
