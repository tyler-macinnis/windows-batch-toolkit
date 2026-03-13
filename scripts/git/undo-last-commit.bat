@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Soft-resets HEAD by one commit, keeping changes staged.
:: Usage         : Run inside a Git repository.
:: Requirements  : Windows CMD, git
:: Notes         : Does not affect the working tree. Changes remain staged.
:: ============================================================

git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
    echo ERROR: Current directory is not a Git repository.
    pause
    exit /b 1
)

echo Last commit:
git log --oneline -1

echo.
set /P "CONFIRM=Undo this commit? Changes will remain staged. (Y/N): "
if /I not "%CONFIRM%"=="Y" (
    echo Aborted.
    pause
    exit /b 0
)

git reset --soft HEAD~1
echo.
echo Commit undone. Changes are now staged.
echo.
git status
echo.
pause
exit /b 0
