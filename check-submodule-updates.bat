@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ============================================================
:: Description   : Checks submodules for remote updates without changing pinned commits.
:: Usage         : check-submodule-updates.bat [submodule-folder]
::                 If no folder is provided, checks all submodules in .gitmodules.
:: Requirements  : Windows CMD, git, network access
:: Notes         : Run from repository root (same location as .gitmodules).
:: ============================================================

for %%I in ("%~dp0.") do set "REPO_ROOT=%%~fI"

set "SUBMODULE_ROOT=%~1"
set "FILTER_ENABLED=0"
if not "%SUBMODULE_ROOT%"=="" (
    set "FILTER_ENABLED=1"
    set "SUBMODULE_ROOT=!SUBMODULE_ROOT:\=/!"
    if "!SUBMODULE_ROOT:~-1!"=="/" set "SUBMODULE_ROOT=!SUBMODULE_ROOT:~0,-1!"
)

pushd "%REPO_ROOT%" >nul 2>&1
if errorlevel 1 (
    echo ERROR: Could not access repository root: %REPO_ROOT%
    pause
    exit /b 1
)

if not exist ".git" (
    echo ERROR: Script must be located in a Git repository root.
    echo Expected .git at: %REPO_ROOT%\.git
    popd
    pause
    exit /b 1
)

if not exist ".gitmodules" (
    echo No .gitmodules file found. No submodules are configured.
    popd
    pause
    exit /b 0
)

echo ==================================================
echo Checking submodule updates from .gitmodules
if "%FILTER_ENABLED%"=="1" echo Folder filter: %SUBMODULE_ROOT%
echo Repository root: %REPO_ROOT%
echo ==================================================
echo.

set "MODULES_FOUND=0"
set "MODULES_CHECKED=0"
set "MODULES_WITH_UPDATES=0"
set "MODULES_UP_TO_DATE=0"
set "MODULES_FAILED=0"

for /F "tokens=1,2 delims= " %%A in ('git config --file .gitmodules --get-regexp path 2^>nul') do (
    set /A MODULES_FOUND+=1
    call :maybe_check_submodule "%%B"
)

echo.
echo ==================================================
echo Summary
echo ==================================================
echo Submodules in .gitmodules : %MODULES_FOUND%
echo Submodules checked        : %MODULES_CHECKED%
echo With updates              : %MODULES_WITH_UPDATES%
echo Up to date                : %MODULES_UP_TO_DATE%
echo Failed checks             : %MODULES_FAILED%
echo ==================================================

popd
pause
exit /b 0

:maybe_check_submodule
set "SUBMODULE_PATH=%~1"
set "SUBMODULE_PATH=%SUBMODULE_PATH:\=/%"

if "%FILTER_ENABLED%"=="0" (
    call :check_submodule "%SUBMODULE_PATH%"
    exit /b 0
)

if /I "%SUBMODULE_PATH%"=="%SUBMODULE_ROOT%" (
    call :check_submodule "%SUBMODULE_PATH%"
    exit /b 0
)

echo(%SUBMODULE_PATH%| findstr /I /B /C:"%SUBMODULE_ROOT%/" >nul
if errorlevel 1 (
    exit /b 0
)

call :check_submodule "%SUBMODULE_PATH%"
exit /b 0

:check_submodule
set /A MODULES_CHECKED+=1
set "SUBMODULE_PATH=%~1"
set "SUBMODULE_PATH_WIN=%SUBMODULE_PATH:/=\%"

echo --------------------------------------------------
echo Submodule: %SUBMODULE_PATH%
echo --------------------------------------------------

if not exist "%REPO_ROOT%\%SUBMODULE_PATH_WIN%\.git" (
    echo FAILED: Submodule directory is missing or not initialized.
    set /A MODULES_FAILED+=1
    echo.
    exit /b 0
)

pushd "%REPO_ROOT%\%SUBMODULE_PATH_WIN%" >nul 2>&1
if errorlevel 1 (
    echo FAILED: Could not enter submodule path.
    set /A MODULES_FAILED+=1
    echo.
    exit /b 0
)

git remote update --prune >nul 2>&1
if errorlevel 1 (
    echo FAILED: Could not fetch remote updates.
    set /A MODULES_FAILED+=1
    popd
    echo.
    exit /b 0
)

set "TARGET_REF="
for /F "delims=" %%R in ('git symbolic-ref -q --short refs/remotes/origin/HEAD 2^>nul') do set "TARGET_REF=%%R"

if not defined TARGET_REF (
    git rev-parse --verify --quiet origin/main >nul 2>&1
    if not errorlevel 1 set "TARGET_REF=origin/main"
)

if not defined TARGET_REF (
    git rev-parse --verify --quiet origin/master >nul 2>&1
    if not errorlevel 1 set "TARGET_REF=origin/master"
)

if not defined TARGET_REF (
    echo FAILED: Could not determine remote default branch.
    set /A MODULES_FAILED+=1
    popd
    echo.
    exit /b 0
)

set "COMMITS_BEHIND="
for /F "delims=" %%C in ('git rev-list --count HEAD..%TARGET_REF% 2^>nul') do set "COMMITS_BEHIND=%%C"

if not defined COMMITS_BEHIND (
    echo FAILED: Could not compare HEAD with %TARGET_REF%.
    set /A MODULES_FAILED+=1
    popd
    echo.
    exit /b 0
)

if %COMMITS_BEHIND% GTR 0 (
    echo UPDATE AVAILABLE: %COMMITS_BEHIND% commits behind %TARGET_REF%
    set /A MODULES_WITH_UPDATES+=1
) else (
    echo UP TO DATE with %TARGET_REF%
    set /A MODULES_UP_TO_DATE+=1
)

popd
echo.
exit /b 0