@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Daily briefing script with system info, weather, and fun facts.
:: Usage         : Run directly to see your daily summary.
:: Requirements  : Windows CMD, PowerShell, Internet connection
:: Notes         : Uses free APIs for weather and fun facts.
:: ============================================================

:: Run the briefing in PowerShell for better compatibility
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0daily-briefing.ps1"

pause
exit /b 0
