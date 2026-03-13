@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Launches the Windows Disk Cleanup utility.
:: Usage         : Run directly. Optionally pass drive letter (e.g., C:).
:: Requirements  : Windows CMD
:: Notes         : Use /sageset:n to configure, /sagerun:n to run saved config.
:: ============================================================

set "DRIVE=%~1"

echo Launching Disk Cleanup...

if "%DRIVE%"=="" (
    start cleanmgr
) else (
    :: Remove colon if present
    set "DRIVE=%DRIVE::=%"
    start cleanmgr /d %DRIVE%
)

exit /b 0
