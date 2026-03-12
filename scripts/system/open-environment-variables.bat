@echo off
setlocal EnableExtensions

:: ============================================================
:: Script Name   : open-environment-variables.bat
:: Description   : Opens the Windows Environment Variables dialog.
:: Author        : Tyler MacInnis
:: Version       : 1.0.0
:: Created       : 2026-03-12
:: Updated       : 2026-03-12
:: Usage         : Run directly to open advanced system properties.
:: Requirements  : Windows CMD
:: Notes         : Opens the system UI only.
:: ============================================================

start "" SystemPropertiesAdvanced.exe
exit /b 0
