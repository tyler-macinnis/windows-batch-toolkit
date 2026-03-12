@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ============================================================
:: Script Name   : rename-files-safe.bat
:: Description   : Renames files in a folder by replacing spaces with underscores.
:: Author        : Tyler MacInnis
:: Version       : 1.0.0
:: Created       : 2026-03-12
:: Updated       : 2026-03-12
:: Usage         : Edit TARGET_DIR, review output, then run.
:: Requirements  : Windows CMD
:: Notes         : Current version only replaces spaces with underscores.
:: ============================================================

set "TARGET_DIR=%USERPROFILE%\Downloads"

echo Target Folder: %TARGET_DIR%
echo.

if not exist "%TARGET_DIR%" (
    echo ERROR: Target folder does not exist.
    pause
    exit /b 1
)

for %%F in ("%TARGET_DIR%\*") do (
    set "OLD_NAME=%%~nxF"
    set "NEW_NAME=!OLD_NAME: =_!"
    if /I not "!OLD_NAME!"=="!NEW_NAME!" (
        echo Renaming: "!OLD_NAME!" -^> "!NEW_NAME!"
        ren "%%~fF" "!NEW_NAME!"
    )
)

echo.
echo Rename complete.
pause
exit /b 0
