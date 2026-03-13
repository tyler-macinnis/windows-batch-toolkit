@echo off
setlocal EnableExtensions

:: ============================================================
:: Script Name   : show-whoami-info.bat
:: Description   : Displays detailed identity information for the current user.
:: Author        : Tyler MacInnis
:: Version       : 1.0.0
:: Created       : 2026-03-13
:: Updated       : 2026-03-13
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
