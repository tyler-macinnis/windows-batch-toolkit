@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Empties the Recycle Bin for all drives on the current user profile.
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
