@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Runs git gc --prune=now --aggressive on all Git repos under a directory.
:: Usage         : gc-all-repos.bat [directory]
::                 If no directory is provided, uses the current working directory.
:: Requirements  : Windows CMD, git
:: Notes         : Aggressive GC can take a long time on large repos.
:: ============================================================

set "ROOT_DIR=%~1"
if "%ROOT_DIR%"=="" set "ROOT_DIR=%CD%"

if not exist "%ROOT_DIR%" (
    echo ERROR: Directory does not exist: %ROOT_DIR%
    pause
    exit /b 1
)

echo ==================================================
echo Running git gc on all repos under:
echo %ROOT_DIR%
echo ==================================================
echo.

set "REPOS_FOUND=0"
set "REPOS_DONE=0"
set "REPOS_FAILED=0"

for /F "usebackq delims=" %%D in (`dir /AD /B /S "%ROOT_DIR%\.git" 2^>nul`) do (
    for %%P in ("%%D\..") do (
        call :process_repo "%%~fP"
    )
)
goto :summary

:process_repo
set /A REPOS_FOUND+=1
echo --------------------------------------------------
echo Optimizing: %~1
echo --------------------------------------------------
pushd "%~1"

git gc --prune=now --aggressive
if errorlevel 1 (
    echo FAILED: git gc reported an error.
    set /A REPOS_FAILED+=1
) else (
    echo Done.
    set /A REPOS_DONE+=1
)

popd
echo.
exit /b 0

:summary
echo ==================================================
echo Summary
echo ==================================================
echo Repos found   : %REPOS_FOUND%
echo Repos optimized: %REPOS_DONE%
echo Repos failed   : %REPOS_FAILED%
echo ==================================================
pause
exit /b 0