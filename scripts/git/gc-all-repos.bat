@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Runs git gc --prune=now --aggressive on all Git repos under a directory.
:: Usage         : gc-all-repos.bat [directory]
::                 If no directory is provided, uses the current working directory.
:: Requirements  : Windows CMD, git, Windows PowerShell 5.1
:: Notes         : Aggressive GC can take a long time on large repos.
::                 Reports how much disk space was reclaimed per repo and in total.
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
set "TOTAL_SAVED_KB=0"

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

call :get_dir_bytes "%~1\.git"
set "BEFORE_BYTES=%RESULT_BYTES%"

git gc --prune=now --aggressive
if errorlevel 1 (
    echo FAILED: git gc reported an error.
    set /A REPOS_FAILED+=1
    popd
    echo.
    exit /b 0
)

echo Done.
set /A REPOS_DONE+=1

call :get_dir_bytes "%~1\.git"
set "AFTER_BYTES=%RESULT_BYTES%"

call :saved_kb "%BEFORE_BYTES%" "%AFTER_BYTES%"
set "SAVED_KB=%RESULT_KB%"
set /A TOTAL_SAVED_KB+=SAVED_KB

call :format_kb "%SAVED_KB%"
echo Space saved: %RESULT_HR%

popd
echo.
exit /b 0

:get_dir_bytes
:: %~1 = directory path; sets RESULT_BYTES to total size in bytes (0 if missing/empty)
set "RESULT_BYTES=0"
for /F "usebackq delims=" %%S in (`powershell -NoProfile -ExecutionPolicy Bypass -Command "$p='%~1'; if(Test-Path -LiteralPath $p){$s=(Get-ChildItem -LiteralPath $p -Recurse -Force -File -ErrorAction SilentlyContinue ^| Measure-Object -Sum Length).Sum; if($s){$s}else{0}}else{0}"`) do set "RESULT_BYTES=%%S"
if "%RESULT_BYTES%"=="" set "RESULT_BYTES=0"
exit /b 0

:saved_kb
:: %~1 = before bytes, %~2 = after bytes; sets RESULT_KB to KB saved (>= 0)
set "RESULT_KB=0"
for /F "usebackq delims=" %%K in (`powershell -NoProfile -ExecutionPolicy Bypass -Command "[math]::Max(0,[int64]([math]::Round(([int64]%~1 - [int64]%~2)/1024)))"`) do set "RESULT_KB=%%K"
if "%RESULT_KB%"=="" set "RESULT_KB=0"
exit /b 0

:format_kb
:: %~1 = size in KB; sets RESULT_HR to a human-readable string
set "RESULT_HR=0 KB"
for /F "usebackq delims=" %%H in (`powershell -NoProfile -ExecutionPolicy Bypass -Command "$kb=[double]%~1; if($kb -ge 1073741824){'{0:N2} TB' -f ($kb/1073741824)}elseif($kb -ge 1048576){'{0:N2} GB' -f ($kb/1048576)}elseif($kb -ge 1024){'{0:N2} MB' -f ($kb/1024)}else{'{0:N0} KB' -f $kb}"`) do set "RESULT_HR=%%H"
exit /b 0

:summary
call :format_kb "%TOTAL_SAVED_KB%"
echo ==================================================
echo Summary
echo ==================================================
echo Repos found    : %REPOS_FOUND%
echo Repos optimized: %REPOS_DONE%
echo Repos failed   : %REPOS_FAILED%
echo Space saved    : %RESULT_HR%
echo ==================================================
pause
exit /b 0
