@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Opens the Windows Recycle Bin.
:: Usage         : Run directly.
:: Requirements  : Windows CMD
:: Notes         : Opens the Recycle Bin folder in File Explorer.
:: ============================================================

start "" shell:RecycleBinFolder
exit /b 0
