@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Shows a formatted recent commit log for the current repository.
:: Usage         : Run inside a Git repository.
:: Requirements  : Windows CMD, git
:: Notes         : Displays the last 20 commits with graph decoration.
:: ============================================================

git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
    echo ERROR: Current directory is not a Git repository.
    pause
    exit /b 1
)

echo.
echo Recent commits:
echo.
git log --oneline --graph --decorate --all -20

echo.
pause
exit /b 0
