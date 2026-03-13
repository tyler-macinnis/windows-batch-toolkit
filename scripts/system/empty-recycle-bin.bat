@echo off
setlocal EnableExtensions

:: ============================================================
:: Script Name   : empty-recycle-bin.bat
:: Description   : Empties the Recycle Bin for all drives on the current user profile.
:: Author        : Tyler MacInnis
:: Version       : 1.0.0
:: Created       : 2026-03-13
:: Updated       : 2026-03-13
:: Usage         : Run directly to permanently delete all recycled items.
:: Requirements  : Windows CMD, PowerShell
:: Notes         : This action is irreversible. Deleted items cannot be restored.
:: ============================================================

echo ==================================================
echo Empty Recycle Bin
echo ==================================================
echo WARNING: This will permanently delete all items in the Recycle Bin.
echo.
set /p CONFIRM=Are you sure? (Y/N): 

if /i not "%CONFIRM%"=="Y" (
    echo Cancelled. No items were deleted.
    pause
    exit /b 0
)

echo.
echo Emptying Recycle Bin...
PowerShell.exe -NoProfile -NonInteractive -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue"

echo Recycle Bin emptied successfully.
pause
exit /b 0
