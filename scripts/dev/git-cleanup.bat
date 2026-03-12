@echo off
setlocal EnableExtensions

:: ============================================================
:: Script Name   : git-cleanup.bat
:: Description   : Runs common Git cleanup and refresh commands in the current repository.
:: Author        : Tyler MacInnis
:: Version       : 1.0.0
:: Created       : 2026-03-12
:: Updated       : 2026-03-12
:: Usage         : Run inside a Git repository.
:: Requirements  : Windows CMD, git
:: Notes         : Does not delete local branches.
:: ============================================================

git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
    echo ERROR: Current directory is not a Git repository.
    pause
    exit /b 1
)

echo Fetching remotes...
git fetch --all --prune

echo.
echo Repository status:
git status

echo.
echo Recent branches:
git branch -vv

echo.
pause
exit /b 0
