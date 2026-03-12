@echo off
setlocal EnableExtensions

:: ============================================================
:: Script Name   : export-directory-tree.bat
:: Description   : Exports the directory tree of a target folder to a text file.
:: Author        : Tyler MacInnis
:: Version       : 1.0.0
:: Created       : 2026-03-12
:: Updated       : 2026-03-12
:: Usage         : Edit TARGET_DIR if desired, then run.
:: Requirements  : Windows CMD
:: Notes         : Output file is saved beside the script.
:: ============================================================

set "TARGET_DIR=%USERPROFILE%"
set "OUTPUT_FILE=%~dp0directory-tree.txt"

echo Target Folder: %TARGET_DIR%
echo Output File  : %OUTPUT_FILE%
echo.

tree "%TARGET_DIR%" /F /A > "%OUTPUT_FILE%"

echo Directory tree exported.
pause
exit /b 0
