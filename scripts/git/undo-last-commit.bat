@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Soft-resets HEAD by one commit, keeping changes staged.
:: Usage         : undo-last-commit.bat [directory]
::                 If no directory provided, uses current directory.
:: Requirements  : Windows CMD, git
:: Notes         : Does not affect the working tree. Changes remain staged.
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

echo Last commit:
git log --oneline -1

echo.
set /P "CONFIRM=Undo this commit? Changes will remain staged. (Y/N): "
if /I not "%CONFIRM%"=="Y" (
    echo Aborted.
    if not "%REPO_DIR%"=="" popd
    pause
    exit /b 0
)

git reset --soft HEAD~1
echo.
echo Commit undone. Changes are now staged.
echo.
git status
echo.
if not "%REPO_DIR%"=="" popd
pause
exit /b 0
