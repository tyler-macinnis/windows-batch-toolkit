@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Lists all local and remote branches with tracking info.
:: Usage         : show-git-branches.bat [directory]
::                 If no directory provided, uses current directory.
:: Requirements  : Windows CMD, git
:: Notes         : Fetches remotes before listing to ensure data is current.
:: ============================================================

set "REPO_DIR=%~1"
if not "%REPO_DIR%"=="" (
    if not exist "%REPO_DIR%" (
        echo ERROR: Directory does not exist: %REPO_DIR%
        pause
        exit /b 1
    )
    pushd "%REPO_DIR%"
)

git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
    echo ERROR: Current directory is not a Git repository.
    if not "%REPO_DIR%"=="" popd
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
if not "%REPO_DIR%"=="" popd
pause
exit /b 0
