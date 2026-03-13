@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ============================================================
:: Description   : Converts numbers between binary, decimal, octal, hex with endianness options.
:: Usage         : Run with arguments or interactively. Examples:
::                   convert-number.bat dec 255
::                   convert-number.bat hex FF
::                   convert-number.bat bin 11111111
:: Requirements  : Windows CMD, PowerShell
:: Notes         : Supports endianness conversion for hex values.
:: ============================================================

set "INPUT_FORMAT=%~1"
set "INPUT_VALUE=%~2"

if "%INPUT_FORMAT%"=="" goto :interactive

:: Validate format
set "VALID_FORMAT=0"
for %%F in (dec decimal bin binary oct octal hex hexadecimal) do (
    if /i "%INPUT_FORMAT%"=="%%F" set "VALID_FORMAT=1"
)

if "%VALID_FORMAT%"=="0" (
    echo Invalid format: %INPUT_FORMAT%
    echo Valid formats: dec, bin, oct, hex
    exit /b 1
)

if "%INPUT_VALUE%"=="" (
    echo No value provided.
    exit /b 1
)

goto :convert

:interactive
echo.
echo ============================================================
echo   Number Base Converter
echo ============================================================
echo.
echo Input format:
echo   1. Decimal  (dec)
echo   2. Binary   (bin)
echo   3. Octal    (oct)
echo   4. Hexadecimal (hex)
echo.
set /p "FORMAT_CHOICE=Select format (1-4): "

if "%FORMAT_CHOICE%"=="1" set "INPUT_FORMAT=dec"
if "%FORMAT_CHOICE%"=="2" set "INPUT_FORMAT=bin"
if "%FORMAT_CHOICE%"=="3" set "INPUT_FORMAT=oct"
if "%FORMAT_CHOICE%"=="4" set "INPUT_FORMAT=hex"

if "%INPUT_FORMAT%"=="" (
    echo Invalid selection.
    exit /b 1
)

echo.
set /p "INPUT_VALUE=Enter value: "

if "%INPUT_VALUE%"=="" (
    echo No value provided.
    exit /b 1
)

:convert
:: Normalize format names
if /i "%INPUT_FORMAT%"=="decimal" set "INPUT_FORMAT=dec"
if /i "%INPUT_FORMAT%"=="binary" set "INPUT_FORMAT=bin"
if /i "%INPUT_FORMAT%"=="octal" set "INPUT_FORMAT=oct"
if /i "%INPUT_FORMAT%"=="hexadecimal" set "INPUT_FORMAT=hex"

:: Remove common prefixes
set "CLEAN_VALUE=%INPUT_VALUE%"
if /i "%INPUT_FORMAT%"=="hex" (
    set "CLEAN_VALUE=!INPUT_VALUE:0x=!"
    set "CLEAN_VALUE=!CLEAN_VALUE:0X=!"
)
if /i "%INPUT_FORMAT%"=="bin" (
    set "CLEAN_VALUE=!INPUT_VALUE:0b=!"
    set "CLEAN_VALUE=!CLEAN_VALUE:0B=!"
)
if /i "%INPUT_FORMAT%"=="oct" (
    if "!INPUT_VALUE:~0,1!"=="0" if not "!INPUT_VALUE:~0,2!"=="0x" (
        set "CLEAN_VALUE=!INPUT_VALUE:~1!"
    )
)

echo.
echo ============================================================
echo   Input: %INPUT_VALUE% (%INPUT_FORMAT%)
echo ============================================================
echo.

:: Create temp PowerShell script
set "PS_SCRIPT=%TEMP%\convert-number-%RANDOM%.ps1"

(
echo $inputFormat = '%INPUT_FORMAT%'.ToLower^(^)
echo $inputValue = '%CLEAN_VALUE%'
echo.
echo try {
echo     switch ^($inputFormat^) {
echo         'dec' { $decimal = [int64]$inputValue }
echo         'bin' { $decimal = [Convert]::ToInt64^($inputValue, 2^) }
echo         'oct' { $decimal = [Convert]::ToInt64^($inputValue, 8^) }
echo         'hex' { $decimal = [Convert]::ToInt64^($inputValue, 16^) }
echo     }
echo.
echo     $binary = [Convert]::ToString^($decimal, 2^)
echo     $octal = [Convert]::ToString^($decimal, 8^)
echo     $hex = [Convert]::ToString^($decimal, 16^).ToUpper^(^)
echo.
echo     Write-Host "Decimal:      $decimal"
echo     Write-Host "Binary:       $binary"
echo     Write-Host "Octal:        $octal"
echo     Write-Host "Hexadecimal:  $hex"
echo     Write-Host ""
echo     Write-Host "With Prefixes:"
echo     Write-Host "  Binary:     0b$binary"
echo     Write-Host "  Octal:      0$octal"
echo     Write-Host "  Hex:        0x$hex"
echo.
echo     # Endianness for hex ^(only if 2+ bytes^)
echo     if ^($hex.Length -ge 2^) {
echo         $paddedHex = if ^($hex.Length %% 2 -ne 0^) { '0' + $hex } else { $hex }
echo         $bytes = @^(^)
echo         for ^($i = 0; $i -lt $paddedHex.Length; $i += 2^) {
echo             $bytes += $paddedHex.Substring^($i, 2^)
echo         }
echo         $bigEndian = $bytes -join ' '
echo         $littleEndian = ^($bytes[^($bytes.Length-1^)..0]^) -join ' '
echo         Write-Host ""
echo         Write-Host "Byte Order:"
echo         Write-Host "  Big Endian:     $bigEndian"
echo         Write-Host "  Little Endian:  $littleEndian"
echo         $beCompact = $bytes -join ''
echo         $leCompact = ^($bytes[^($bytes.Length-1^)..0]^) -join ''
echo         Write-Host "  BE (compact):   $beCompact"
echo         Write-Host "  LE (compact):   $leCompact"
echo     }
echo.
echo     # Character representation ^(if printable ASCII^)
echo     if ^($decimal -ge 32 -and $decimal -le 126^) {
echo         Write-Host ""
echo         Write-Host "ASCII Char:   $^([char]$decimal^)"
echo     }
echo.
echo     # Signed interpretation
echo     Write-Host ""
echo     Write-Host "Signed Interpretation:"
echo     if ^($decimal -le 255^) {
echo         $signed8 = if ^($decimal -gt 127^) { $decimal - 256 } else { $decimal }
echo         Write-Host "  8-bit:      $signed8"
echo     }
echo     if ^($decimal -le 65535^) {
echo         $signed16 = if ^($decimal -gt 32767^) { $decimal - 65536 } else { $decimal }
echo         Write-Host "  16-bit:     $signed16"
echo     }
echo     if ^($decimal -le 4294967295^) {
echo         $signed32 = if ^($decimal -gt 2147483647^) { $decimal - 4294967296 } else { $decimal }
echo         Write-Host "  32-bit:     $signed32"
echo     }
echo.
echo } catch {
echo     Write-Host "Error: Invalid input value for the specified format." -ForegroundColor Red
echo     Write-Host $_.Exception.Message
echo     exit 1
echo }
) > "!PS_SCRIPT!"

powershell -NoProfile -ExecutionPolicy Bypass -File "!PS_SCRIPT!"
del "!PS_SCRIPT!" 2>nul

echo.
exit /b 0
