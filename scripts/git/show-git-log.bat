@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Shows a formatted recent commit log for the current repository.
:: Usage         : show-git-log.bat [count]
::                 If no count is provided, defaults to 20 commits.
:: Requirements  : Windows CMD, git
:: Notes         : Displays commits with graph decoration.
:: ============================================================

set "COUNT=%~1"
if "%COUNT%"=="" set "COUNT=20"

git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
    echo ERROR: Current directory is not a Git repository.
    pause
    exit /b 1
)

echo.
echo Recent commits:
echo.
git log --oneline --graph --decorate --all -%COUNT%

echo.
pause
exit /b 0
