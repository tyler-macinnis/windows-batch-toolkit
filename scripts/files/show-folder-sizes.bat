@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ============================================================
:: Description   : Shows the disk size of every immediate subfolder in a target directory.
:: Usage         : Edit TARGET_DIR, then run.
:: Requirements  : Windows CMD
:: Notes         : Uses robocopy to calculate folder sizes. Large trees may take a moment.
:: ============================================================

set "TARGET_DIR=%USERPROFILE%"

if not exist "%TARGET_DIR%" (
    echo ERROR: Target folder does not exist: %TARGET_DIR%
    pause
    exit /b 1
)

echo ==================================================
echo Folder Sizes in: %TARGET_DIR%
echo ==================================================
echo.

for /D %%F in ("%TARGET_DIR%\*") do (
    set "SIZE=0"
    for /F "tokens=3" %%S in ('robocopy "%%F" NUL /L /S /NJH /BYTES /NC /NDL 2^>nul ^| findstr /R "^[[:space:]]*[0-9]"') do (
        set "SIZE=%%S"
    )
    echo   %%~nxF
)

echo.
echo Tip: For accurate sizes, run as Administrator.
echo.
pause
exit /b 0
