@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Generates a new GUID/UUID and copies it to clipboard.
:: Usage         : Run directly. Optionally pass format: guid, registry, raw
:: Requirements  : Windows CMD, PowerShell
:: Notes         : Default format includes braces and hyphens.
:: ============================================================

set "FORMAT=%~1"
if "%FORMAT%"=="" set "FORMAT=guid"

for /f "delims=" %%G in ('powershell -NoProfile -Command "[guid]::NewGuid().ToString()"') do set "GUID=%%G"

if /i "%FORMAT%"=="raw" (
    set "OUTPUT=%GUID:-=%"
) else if /i "%FORMAT%"=="registry" (
    set "OUTPUT={%GUID%}"
) else (
    set "OUTPUT=%GUID%"
)

echo %OUTPUT%
echo %OUTPUT%| clip

echo.
echo (Copied to clipboard)
exit /b 0
