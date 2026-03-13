@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Exports the directory tree of a target folder to a text file.
:: Usage         : export-directory-tree.bat [directory] [output_file]
::                 If no directory is provided, uses current directory.
::                 If no output file is provided, saves beside the script.
:: Requirements  : Windows CMD
:: Notes         : Output file is saved beside the script by default.
:: ============================================================

set "TARGET_DIR=%~1"
set "OUTPUT_FILE=%~2"
if "%TARGET_DIR%"=="" set "TARGET_DIR=%CD%"
if "%OUTPUT_FILE%"=="" set "OUTPUT_FILE=%~dp0directory-tree.txt"

echo Target Folder: %TARGET_DIR%
echo Output File  : %OUTPUT_FILE%
echo.

tree "%TARGET_DIR%" /F /A > "%OUTPUT_FILE%"

echo Directory tree exported.
pause
exit /b 0
