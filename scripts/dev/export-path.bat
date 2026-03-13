@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ============================================================
:: Description   : Exports the current PATH variable to a text file, one entry per line.
:: Usage         : Run directly. Output file is saved next to this script.
:: Requirements  : Windows CMD
:: Notes         : Flags entries that do not exist on disk. Timestamped output.
:: ============================================================

:: Build a timestamped output filename using wmic (locale-independent)
for /F "tokens=2 delims==" %%I in ('wmic os get localdatetime /value 2^>nul') do set "LDT=%%I"
set "TIMESTAMP=!LDT:~0,8!_!LDT:~8,6!"
set "OUTPUT_FILE=%~dp0path-export-!TIMESTAMP!.txt"

echo ==================================================
echo PATH Export
echo ==================================================
echo Output: !OUTPUT_FILE!
echo.

:: Write header to file
echo PATH Export > "!OUTPUT_FILE!"
echo Generated : !LDT:~0,4!-!LDT:~4,2!-!LDT:~6,2! !LDT:~8,2!:!LDT:~10,2!:!LDT:~12,2! >> "!OUTPUT_FILE!"
echo -------------------------------------------------- >> "!OUTPUT_FILE!"

:: Split PATH on semicolons using a safe loop
set "MISSING=0"
set "COUNT=0"
set "REMAINING=!PATH!"

:split_loop
for /F "tokens=1* delims=;" %%A in ("!REMAINING!") do (
    set "ENTRY=%%A"
    set "REMAINING=%%B"
    set /A COUNT+=1

    if exist "!ENTRY!\" (
        set "STATUS=   OK"
    ) else (
        set "STATUS=  MISSING"
        set /A MISSING+=1
    )

    echo !STATUS!  !ENTRY!
    echo !STATUS!  !ENTRY! >> "!OUTPUT_FILE!"
)
if defined REMAINING goto :split_loop

echo -------------------------------------------------- >> "!OUTPUT_FILE!"
echo Total: !COUNT! entries, !MISSING! missing >> "!OUTPUT_FILE!"

echo.
echo --------------------------------------------------
echo Total : !COUNT! entries
if !MISSING! GTR 0 (
    echo Missing: !MISSING! ^(paths that do not exist on disk^)
) else (
    echo All entries exist on disk.
)
echo.
echo Saved to: !OUTPUT_FILE!
echo.
pause
exit /b 0
