@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Opens Windows Event Viewer.
:: Usage         : Run directly.
:: Requirements  : Windows CMD
:: Notes         : View system, application, and security logs.
:: ============================================================

start "" eventvwr.msc
exit /b 0
