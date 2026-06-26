@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ============================================================
:: Description   : Pulls updates for all Git repos under a directory, including submodules.
:: Usage         : pull-all-repos.bat [directory]
::                 If no directory is provided, uses the current working directory.
:: Requirements  : Windows CMD, git
:: Notes         : Skips repos with uncommitted changes, detached HEAD, or no upstream.
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
set "REPOS_UP_TO_DATE=0"
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
    set "SKIPPED_REPO_!REPOS_SKIPPED!=%~1"
    popd
    echo.
    exit /b 0
)

git diff --cached --quiet 2>nul
if errorlevel 1 (
    echo SKIPPED: Staged changes detected.
    set /A REPOS_SKIPPED+=1
    set "SKIPPED_REPO_!REPOS_SKIPPED!=%~1"
    popd
    echo.
    exit /b 0
)

:: Check for detached HEAD
git symbolic-ref -q HEAD >nul 2>&1
if errorlevel 1 (
    echo SKIPPED: Detached HEAD state.
    set /A REPOS_SKIPPED+=1
    set "SKIPPED_REPO_!REPOS_SKIPPED!=%~1"
    popd
    echo.
    exit /b 0
)

:: Check for an upstream branch
git rev-parse --abbrev-ref --symbolic-full-name @{u} >nul 2>&1
if errorlevel 1 (
    echo SKIPPED: No upstream branch configured.
    set /A REPOS_SKIPPED+=1
    set "SKIPPED_REPO_!REPOS_SKIPPED!=%~1"
    popd
    echo.
    exit /b 0
)

:: Refresh remote refs and check whether anything is available to pull
git fetch --quiet --recurse-submodules
if errorlevel 1 (
    echo WARNING: Fetch failed.
    set /A REPOS_SKIPPED+=1
    set "SKIPPED_REPO_!REPOS_SKIPPED!=%~1"
    popd
    echo.
    exit /b 0
)

set "INCOMING_COMMITS=0"
for /F %%C in ('git rev-list --count HEAD..@{u} 2^>nul') do set "INCOMING_COMMITS=%%C"

if "%INCOMING_COMMITS%"=="0" (
    echo Already up to date.
    set /A REPOS_UP_TO_DATE+=1
    set "UP_TO_DATE_REPO_!REPOS_UP_TO_DATE!=%~1"
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
    set "SKIPPED_REPO_!REPOS_SKIPPED!=%~1"
    popd
    echo.
    exit /b 0
)

:: Update submodules
git submodule update --init --recursive 2>nul

echo SUCCESS: Updated with %INCOMING_COMMITS% incoming commit(s).
set /A REPOS_UPDATED+=1
set "UPDATED_REPO_!REPOS_UPDATED!=%~1"
popd
echo.
exit /b 0

:summary

echo ==================================================
echo Summary:
echo   Repos found:   %REPOS_FOUND%
echo   Up to date:    %REPOS_UP_TO_DATE%
echo   Updated:       %REPOS_UPDATED%
echo   Skipped:       %REPOS_SKIPPED%
echo ==================================================
echo.
echo Up-to-date repos:
if !REPOS_UP_TO_DATE! GTR 0 (
    for /L %%I in (1,1,!REPOS_UP_TO_DATE!) do call echo   %%UP_TO_DATE_REPO_%%I%%
) else (
    echo   None
)
echo.
echo Updated repos:
if !REPOS_UPDATED! GTR 0 (
    for /L %%I in (1,1,!REPOS_UPDATED!) do call echo   %%UPDATED_REPO_%%I%%
) else (
    echo   None
)
echo.
echo Skipped repos:
if !REPOS_SKIPPED! GTR 0 (
    for /L %%I in (1,1,!REPOS_SKIPPED!) do call echo   %%SKIPPED_REPO_%%I%%
) else (
    echo   None
)

pause
exit /b 0
