@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Shows git status for every repo found under a root folder.
:: Usage         : Edit ROOT_DIR, then run directly.
:: Requirements  : Windows CMD, git
:: Notes         : Only reports repos with uncommitted changes.
:: ============================================================

set "ROOT_DIR=C:\Projects"

if not exist "%ROOT_DIR%" (
    echo ERROR: Root folder does not exist: %ROOT_DIR%
    pause
    exit /b 1
)

echo ==================================================
echo Git Status for all repos under:
echo %ROOT_DIR%
echo ==================================================
echo.

for /F "usebackq delims=" %%D in (`dir /AD /B /S "%ROOT_DIR%\.git" 2^>nul`) do (
    for %%P in ("%%D\..") do (
        echo --------------------------------------------------
        echo Repo: %%~fP
        echo --------------------------------------------------
        pushd "%%~fP"
        git status --short
        popd
        echo.
    )
)

pause
exit /b 0
