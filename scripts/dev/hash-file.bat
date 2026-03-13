@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ============================================================
:: Description   : Calculates hash of a file (MD5, SHA1, SHA256).
:: Usage         : Pass file path. Optionally pass algorithm (md5, sha1, sha256).
:: Requirements  : Windows CMD, CertUtil
:: Notes         : Default algorithm is SHA256. Hash is copied to clipboard.
:: ============================================================

set "FILE_PATH=%~1"
set "ALGORITHM=%~2"

if "%FILE_PATH%"=="" (
    echo Enter file path:
    set /p "FILE_PATH="
)

if "%FILE_PATH%"=="" (
    echo No file specified. Exiting.
    exit /b 1
)

if not exist "%FILE_PATH%" (
    echo File not found: %FILE_PATH%
    exit /b 1
)

if "%ALGORITHM%"=="" set "ALGORITHM=SHA256"

:: Normalize algorithm name for certutil
set "ALGORITHM=%ALGORITHM: =%"

echo.
echo File: %FILE_PATH%
echo Algorithm: %ALGORITHM%
echo.

:: Calculate hash using certutil
for /f "skip=1 tokens=*" %%H in ('certutil -hashfile "%FILE_PATH%" %ALGORITHM% 2^>nul') do (
    set "HASH=%%H"
    goto :got_hash
)

echo Failed to calculate hash. Check if algorithm is valid.
echo Valid algorithms: MD5, SHA1, SHA256, SHA384, SHA512
exit /b 1

:got_hash
:: Remove spaces from hash
set "HASH=%HASH: =%"

:: Check if it's actually the hash (not the completion message)
echo %HASH% | findstr /i "certutil" >nul
if %ERRORLEVEL%==0 (
    echo Failed to parse hash output.
    exit /b 1
)

echo %HASH%
echo %HASH%| clip

echo.
echo (Copied to clipboard)
exit /b 0
