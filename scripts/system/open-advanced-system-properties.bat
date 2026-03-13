@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Opens the Windows Environment Variables dialog.
:: Usage         : Run directly to open advanced system properties.
:: Requirements  : Windows CMD
:: Notes         : Opens the system UI only.
:: ============================================================

start "" SystemPropertiesAdvanced.exe
exit /b 0
