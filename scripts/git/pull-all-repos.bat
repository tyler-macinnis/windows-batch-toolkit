@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Pulls updates for all Git repos under a directory, including submodules.
:: Usage         : pull-all-repos.bat [directory]
::                 If no directory is provided, uses the current working directory.
:: Requirements  : Windows CMD, git
:: Notes         : Skips repos with uncommitted changes or detached HEAD.
:: ============================================================

set "ROOT_DIR=%~1"
if "%ROOT_DIR%"=="" set "ROOT_DIR=%CD%"

if not exist "%ROOT_DIR%" (
    echo ERROR: Directory does not exist: %ROOT_DIR%
    pause
    exit /b 1
)

echo ==================================================
echo Pulling updates for all repos under:
echo %ROOT_DIR%
echo ==================================================
echo.

set "REPOS_FOUND=0"
set "REPOS_UPDATED=0"
set "REPOS_SKIPPED=0"

for /F "usebackq delims=" %%D in (`dir /AD /B /S "%ROOT_DIR%\.git" 2^>nul`) do (
    for %%P in ("%%D\..") do (
        call :process_repo "%%~fP"
    )
)
goto :summary

:process_repo
set /A REPOS_FOUND+=1
echo --------------------------------------------------
echo Repo: %~1
echo --------------------------------------------------
pushd "%~1"

:: Check for uncommitted changes
git diff --quiet 2>nul
if errorlevel 1 (
    echo SKIPPED: Uncommitted changes detected.
    set /A REPOS_SKIPPED+=1
    popd
    echo.
    exit /b 0
)

git diff --cached --quiet 2>nul
if errorlevel 1 (
    echo SKIPPED: Staged changes detected.
    set /A REPOS_SKIPPED+=1
    popd
    echo.
    exit /b 0
)

:: Check for detached HEAD
git symbolic-ref -q HEAD >nul 2>&1
if errorlevel 1 (
    echo SKIPPED: Detached HEAD state.
    set /A REPOS_SKIPPED+=1
    popd
    echo.
    exit /b 0
)

:: Pull updates
echo Pulling latest changes...
git pull --recurse-submodules
if errorlevel 1 (
    echo WARNING: Pull failed or had conflicts.
    set /A REPOS_SKIPPED+=1
    popd
    echo.
    exit /b 0
)

:: Update submodules
git submodule update --init --recursive 2>nul

echo SUCCESS: Updated.
set /A REPOS_UPDATED+=1
popd
echo.
exit /b 0

:summary

echo ==================================================
echo Summary:
echo   Repos found:   %REPOS_FOUND%
echo   Updated:       %REPOS_UPDATED%
echo   Skipped:       %REPOS_SKIPPED%
echo ==================================================

pause
exit /b 0
