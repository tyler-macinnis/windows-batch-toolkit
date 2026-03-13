@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ============================================================
:: Description   : Interactive menu to browse and run toolkit scripts.
:: Usage         : Run directly. Navigate with number keys.
:: Requirements  : Windows CMD
:: Notes         : Dynamically discovers scripts from subfolders.
::                 Supports pagination and custom arguments.
:: ============================================================

set "BASE_DIR=%~dp0"
set "PAGE_SIZE=10"

:: ============================================================
:main_menu
cls
set "CAT_PAGE=1"

:main_menu_display
cls
echo.
echo  ====================================================
echo    Windows Batch Toolkit
echo  ====================================================
echo.
echo    Select a category:
echo.

:: Count categories
set "CAT_COUNT=0"
for /F "usebackq delims=" %%D in (`dir /AD /B "%BASE_DIR%" 2^>nul`) do (
    if /I not "%%D"=="templates" (
        set /A CAT_COUNT+=1
        set "CAT_!CAT_COUNT!=%%D"
    )
)

:: Calculate pages
set /A CAT_PAGES=(!CAT_COUNT!+!PAGE_SIZE!-1)/!PAGE_SIZE!
if !CAT_PAGE! GTR !CAT_PAGES! set "CAT_PAGE=!CAT_PAGES!"
if !CAT_PAGE! LSS 1 set "CAT_PAGE=1"

:: Calculate display range
set /A START_IDX=(!CAT_PAGE!-1)*!PAGE_SIZE!+1
set /A END_IDX=!CAT_PAGE!*!PAGE_SIZE!
if !END_IDX! GTR !CAT_COUNT! set "END_IDX=!CAT_COUNT!"

:: Display items for current page
set "DISPLAY_NUM=0"
for /L %%I in (!START_IDX!,1,!END_IDX!) do (
    set /A DISPLAY_NUM+=1
    call set "ITEM=%%CAT_%%I%%"
    echo     [!DISPLAY_NUM!]  !ITEM!
)

echo.
if !CAT_PAGES! GTR 1 (
    echo    Page !CAT_PAGE! of !CAT_PAGES!
    if !CAT_PAGE! GTR 1 echo     [P]  Previous Page
    if !CAT_PAGE! LSS !CAT_PAGES! echo     [N]  Next Page
    echo.
)
echo     [0]  Exit
echo.
set /P "CHOICE=    Choice: "

if "!CHOICE!"=="0" goto :done
if /I "!CHOICE!"=="N" (
    if !CAT_PAGE! LSS !CAT_PAGES! set /A CAT_PAGE+=1
    goto :main_menu_display
)
if /I "!CHOICE!"=="P" (
    if !CAT_PAGE! GTR 1 set /A CAT_PAGE-=1
    goto :main_menu_display
)

set /A CHOICE_NUM=!CHOICE! 2>nul
if !CHOICE_NUM! LSS 1 goto :main_menu_display
if !CHOICE_NUM! GTR !DISPLAY_NUM! goto :main_menu_display

:: Calculate actual index from display number
set /A ACTUAL_IDX=(!CAT_PAGE!-1)*!PAGE_SIZE!+!CHOICE_NUM!
call set "SELECTED_CAT=%%CAT_!ACTUAL_IDX!%%"
goto :script_menu

:: ============================================================
:script_menu
set "SCRIPT_PAGE=1"

:script_menu_display
cls
echo.
echo  ====================================================
echo    Windows Batch Toolkit  ^>  !SELECTED_CAT!
echo  ====================================================
echo.
echo    Select a script:
echo.

:: Count files
set "FILE_COUNT=0"
for /F "usebackq delims=" %%F in (`dir /B /A-D "!BASE_DIR!!SELECTED_CAT!\*.bat" 2^>nul`) do (
    set /A FILE_COUNT+=1
    set "FILE_!FILE_COUNT!=%%~nxF"
)

if !FILE_COUNT!==0 (
    echo    No scripts found in this category.
    echo.
    echo     [B]  Back      [0]  Exit
    echo.
    set /P "CHOICE=    Choice: "
    if /I "!CHOICE!"=="B" goto :main_menu
    if "!CHOICE!"=="0" goto :done
    goto :script_menu_display
)

:: Calculate pages
set /A FILE_PAGES=(!FILE_COUNT!+!PAGE_SIZE!-1)/!PAGE_SIZE!
if !SCRIPT_PAGE! GTR !FILE_PAGES! set "SCRIPT_PAGE=!FILE_PAGES!"
if !SCRIPT_PAGE! LSS 1 set "SCRIPT_PAGE=1"

:: Calculate display range
set /A START_IDX=(!SCRIPT_PAGE!-1)*!PAGE_SIZE!+1
set /A END_IDX=!SCRIPT_PAGE!*!PAGE_SIZE!
if !END_IDX! GTR !FILE_COUNT! set "END_IDX=!FILE_COUNT!"

:: Display items for current page
set "DISPLAY_NUM=0"
for /L %%I in (!START_IDX!,1,!END_IDX!) do (
    set /A DISPLAY_NUM+=1
    call set "ITEM=%%FILE_%%I%%"
    echo     [!DISPLAY_NUM!]  !ITEM!
)

echo.
if !FILE_PAGES! GTR 1 (
    echo    Page !SCRIPT_PAGE! of !FILE_PAGES!
    if !SCRIPT_PAGE! GTR 1 echo     [P]  Previous Page
    if !SCRIPT_PAGE! LSS !FILE_PAGES! echo     [N]  Next Page
    echo.
)
echo     [B]  Back      [0]  Exit
echo.
set /P "CHOICE=    Choice: "

if /I "!CHOICE!"=="B" goto :main_menu
if "!CHOICE!"=="0" goto :done
if /I "!CHOICE!"=="N" (
    if !SCRIPT_PAGE! LSS !FILE_PAGES! set /A SCRIPT_PAGE+=1
    goto :script_menu_display
)
if /I "!CHOICE!"=="P" (
    if !SCRIPT_PAGE! GTR 1 set /A SCRIPT_PAGE-=1
    goto :script_menu_display
)

set /A CHOICE_NUM=!CHOICE! 2>nul
if !CHOICE_NUM! LSS 1 goto :script_menu_display
if !CHOICE_NUM! GTR !DISPLAY_NUM! goto :script_menu_display

:: Calculate actual index from display number
set /A ACTUAL_IDX=(!SCRIPT_PAGE!-1)*!PAGE_SIZE!+!CHOICE_NUM!
call set "RUN_FILE=%%FILE_!ACTUAL_IDX!%%"

:: Prompt for arguments
cls
echo.
echo  ====================================================
echo    Script: !SELECTED_CAT!\!RUN_FILE!
echo  ====================================================
echo.
echo    Enter any command-line arguments for this script,
echo    or press ENTER to run without arguments:
echo.
set "SCRIPT_ARGS="
set /P "SCRIPT_ARGS=    Arguments: "

cls
echo.
echo  ====================================================
echo    Running: !SELECTED_CAT!\!RUN_FILE! !SCRIPT_ARGS!
echo  ====================================================
echo.

call "!BASE_DIR!!SELECTED_CAT!\!RUN_FILE!" !SCRIPT_ARGS!

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
