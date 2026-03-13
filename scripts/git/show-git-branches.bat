@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Lists all local and remote branches with tracking info.
:: Usage         : Run inside a Git repository.
:: Requirements  : Windows CMD, git
:: Notes         : Fetches remotes before listing to ensure data is current.
:: ============================================================

git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
    echo ERROR: Current directory is not a Git repository.
    pause
    exit /b 1
)

echo Fetching remotes...
git fetch --all --prune >nul 2>&1

echo.
echo Local branches:
git branch -vv

echo.
echo Remote branches:
git branch -r

echo.
pause
exit /b 0
