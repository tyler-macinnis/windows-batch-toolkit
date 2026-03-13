@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ============================================================
:: Description   : Interactive menu to browse and run toolkit scripts.
:: Usage         : Run directly. Navigate with number keys.
:: Requirements  : Windows CMD
:: Notes         : Dynamically discovers scripts from subfolders.
:: ============================================================

set "BASE_DIR=%~dp0"

:: ============================================================
:main_menu
cls
echo.
echo  ====================================================
echo    Windows Batch Toolkit
echo  ====================================================
echo.
echo    Select a category:
echo.

set "CAT_COUNT=0"
for /F "usebackq delims=" %%D in (`dir /AD /B "%BASE_DIR%" 2^>nul`) do (
    if /I not "%%D"=="templates" (
        set /A CAT_COUNT+=1
        set "CAT_!CAT_COUNT!=%%D"
        echo     [!CAT_COUNT!]  %%D
    )
)

echo.
echo     [0]  Exit
echo.
set /P "CHOICE=    Choice: "

if "!CHOICE!"=="0" goto :done
set /A CHOICE_NUM=!CHOICE! 2>nul
if !CHOICE_NUM! LSS 1 goto :main_menu
if !CHOICE_NUM! GTR !CAT_COUNT! goto :main_menu

call set "SELECTED_CAT=%%CAT_!CHOICE_NUM!%%"
goto :script_menu

:: ============================================================
:script_menu
cls
echo.
echo  ====================================================
echo    Windows Batch Toolkit  ^>  !SELECTED_CAT!
echo  ====================================================
echo.
echo    Select a script:
echo.

set "FILE_COUNT=0"
for /F "usebackq delims=" %%F in (`dir /B /A-D "!BASE_DIR!!SELECTED_CAT!\*.bat" 2^>nul`) do (
    set /A FILE_COUNT+=1
    set "FILE_!FILE_COUNT!=%%~nxF"
    echo     [!FILE_COUNT!]  %%~nxF
)

if !FILE_COUNT!==0 (
    echo    No scripts found in this category.
)

echo.
echo     [B]  Back      [0]  Exit
echo.
set /P "CHOICE=    Choice: "

if /I "!CHOICE!"=="B" goto :main_menu
if "!CHOICE!"=="0" goto :done
set /A CHOICE_NUM=!CHOICE! 2>nul
if !CHOICE_NUM! LSS 1 goto :script_menu
if !CHOICE_NUM! GTR !FILE_COUNT! goto :script_menu

call set "RUN_FILE=%%FILE_!CHOICE_NUM!%%"

cls
echo.
echo  ====================================================
echo    Running: !SELECTED_CAT!\!RUN_FILE!
echo  ====================================================
echo.

call "!BASE_DIR!!SELECTED_CAT!\!RUN_FILE!"

echo.
echo  ====================================================
echo    Done. Press any key to return to the menu...
echo  ====================================================
pause >nul
goto :script_menu

:: ============================================================
:done
cls
exit /b 0
