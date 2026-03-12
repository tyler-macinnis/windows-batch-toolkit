@echo off
setlocal EnableExtensions

:: ============================================================
:: Script Name   : backup-folder.bat
:: Description   : Backs up one folder to another using robocopy.
:: Author        : Tyler MacInnis
:: Version       : 1.0.0
:: Created       : 2026-03-12
:: Updated       : 2026-03-12
:: Usage         : Edit SOURCE_DIR and DEST_DIR, then run.
:: Requirements  : Windows CMD, robocopy
:: Notes         : Review paths before running.
:: ============================================================

set "SOURCE_DIR=C:\SourceFolder"
set "DEST_DIR=D:\BackupFolder"

echo Source      : %SOURCE_DIR%
echo Destination : %DEST_DIR%
echo.

if not exist "%SOURCE_DIR%" (
    echo ERROR: Source folder does not exist.
    pause
    exit /b 1
)

if not exist "%DEST_DIR%" (
    mkdir "%DEST_DIR%"
)

robocopy "%SOURCE_DIR%" "%DEST_DIR%" /E /R:1 /W:1

echo.
echo Backup complete.
pause
exit /b 0
