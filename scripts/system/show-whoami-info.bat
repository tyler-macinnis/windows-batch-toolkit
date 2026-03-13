@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Displays detailed identity information for the current user.
:: Usage         : Run directly to display user, group, and privilege details.
:: Requirements  : Windows CMD
:: Notes         : Read-only informational script.
:: ============================================================

echo ==================================================
echo User Identity
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
