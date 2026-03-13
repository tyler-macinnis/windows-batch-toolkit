@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ============================================================
:: Description   : Backs up one folder to another using robocopy.
:: Usage         : backup-folder.bat [source] [destination]
::                 If not provided, prompts for source and destination.
:: Requirements  : Windows CMD, robocopy
:: Notes         : Review paths before running.
:: ============================================================

set "SOURCE_DIR=%~1"
set "DEST_DIR=%~2"

if "!SOURCE_DIR!"=="" (
    set /P "SOURCE_DIR=Enter source folder: "
)
if "!DEST_DIR!"=="" (
    set /P "DEST_DIR=Enter destination folder: "
)

echo Source      : !SOURCE_DIR!
echo Destination : !DEST_DIR!
echo.

if not exist "!SOURCE_DIR!" (
    echo ERROR: Source folder does not exist.
    pause
    exit /b 1
)

if not exist "!DEST_DIR!" (
    mkdir "!DEST_DIR!"
)

robocopy "!SOURCE_DIR!" "!DEST_DIR!" /E /R:1 /W:1

echo.
echo Backup complete.
pause
exit /b 0
