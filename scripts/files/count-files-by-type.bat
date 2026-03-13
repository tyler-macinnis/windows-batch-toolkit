@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ============================================================
:: Description   : Counts files grouped by extension in a target folder.
:: Usage         : Edit TARGET_DIR, then run.
:: Requirements  : Windows CMD
:: Notes         : Searches recursively. Counts files with no extension separately.
:: ============================================================

set "TARGET_DIR=%USERPROFILE%\Documents"

if not exist "%TARGET_DIR%" (
    echo ERROR: Target folder does not exist: %TARGET_DIR%
    pause
    exit /b 1
)

echo ==================================================
echo File Count by Type in:
echo %TARGET_DIR%
echo ==================================================
echo.

set "TMPFILE=%TEMP%\ext-count-tmp.txt"
if exist "%TMPFILE%" del "%TMPFILE%"

for /R "%TARGET_DIR%" %%F in (*) do (
    set "EXT=%%~xF"
    if "!EXT!"=="" (
        set "EXT=(no extension)"
    )
    echo !EXT! >> "%TMPFILE%"
)

if not exist "%TMPFILE%" (
    echo No files found.
    pause
    exit /b 0
)

sort "%TMPFILE%" > "%TMPFILE%.sorted"

set "LAST_EXT="
set /a COUNT=0
for /F "usebackq delims=" %%E in ("%TMPFILE%.sorted") do (
    if "%%E"=="!LAST_EXT!" (
        set /a COUNT+=1
    ) else (
        if not "!LAST_EXT!"=="" (
            echo   !COUNT!	!LAST_EXT!
        )
        set "LAST_EXT=%%E"
        set /a COUNT=1
    )
)
if not "!LAST_EXT!"=="" echo   !COUNT!	!LAST_EXT!

del "%TMPFILE%" "%TMPFILE%.sorted" >nul 2>&1

echo.
pause
exit /b 0
