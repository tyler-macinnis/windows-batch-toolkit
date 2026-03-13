@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ============================================================
:: Description   : Encodes or decodes Base64 text.
:: Usage         : Pass mode (encode/decode) and text, or run interactively.
:: Requirements  : Windows CMD, PowerShell
:: Notes         : Result is copied to clipboard.
:: ============================================================

set "MODE=%~1"
set "INPUT=%~2"

if "%MODE%"=="" (
    echo Select mode:
    echo   1. Encode
    echo   2. Decode
    set /p "CHOICE="
    if "!CHOICE!"=="1" set "MODE=encode"
    if "!CHOICE!"=="2" set "MODE=decode"
)

if /i not "%MODE%"=="encode" if /i not "%MODE%"=="decode" (
    echo Invalid mode. Use: encode or decode
    exit /b 1
)

if "%INPUT%"=="" (
    echo Enter text:
    set /p "INPUT="
)

if "%INPUT%"=="" (
    echo No input provided. Exiting.
    exit /b 1
)

echo.

if /i "%MODE%"=="encode" (
    for /f "delims=" %%R in ('powershell -NoProfile -Command "[Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes('%INPUT%'))"') do set "RESULT=%%R"
    echo Encoded:
) else (
    for /f "delims=" %%R in ('powershell -NoProfile -Command "[System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String('%INPUT%'))"') do set "RESULT=%%R"
    echo Decoded:
)

echo %RESULT%
echo %RESULT%| clip

echo.
echo (Copied to clipboard)
exit /b 0
