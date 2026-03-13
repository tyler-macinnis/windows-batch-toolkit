@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Opens Windows Computer Management console.
:: Usage         : Run directly.
:: Requirements  : Windows CMD
:: Notes         : Access disk, services, users, and event tools in one place.
:: ============================================================

start "" compmgmt.msc
exit /b 0
