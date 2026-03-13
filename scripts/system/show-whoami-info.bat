@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ============================================================
:: Description   : Displays detailed identity information for the current user.
:: Usage         : Run directly to display user, group, and privilege details.
:: Requirements  : Windows CMD
:: Notes         : Shows logged-in user info even when run as Administrator.
:: ============================================================

:: Get the actual logged-in user (not the elevated admin)
for /f "tokens=2 delims=\" %%U in ('wmic computersystem get username /value 2^>nul ^| findstr "="') do set "LOGGED_IN_USER=%%U"
for /f "tokens=1 delims==" %%D in ('wmic computersystem get username /value 2^>nul ^| findstr "="') do (
    for /f "tokens=2 delims=\" %%X in ('wmic computersystem get username /value 2^>nul ^| findstr "="') do set "LOGGED_IN_FULL=%%X"
)
for /f "tokens=2 delims==" %%F in ('wmic computersystem get username /value 2^>nul ^| findstr "="') do set "LOGGED_IN_FULL=%%F"

:: Check if running elevated
net session >nul 2>&1
if %ERRORLEVEL%==0 (
    set "ELEVATED=Yes"
) else (
    set "ELEVATED=No"
)

echo ==================================================
echo Session Information
echo ==================================================
echo Logged-in User:    %LOGGED_IN_FULL%
echo Running As:        %USERDOMAIN%\%USERNAME%
echo Elevated (Admin):  %ELEVATED%
echo Computer Name:     %COMPUTERNAME%
echo.

echo ==================================================
echo Current Process Identity
echo ==================================================
whoami /user
echo.

echo ==================================================
echo Group Memberships
echo ==================================================
whoami /groups
echo.

echo ==================================================
echo Privileges
echo ==================================================
whoami /priv
echo.
pause
exit /b 0
