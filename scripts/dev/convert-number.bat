<# : batch portion
@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ============================================================
:: Description   : Converts numbers between binary, decimal, octal, hex with endianness options.
:: Usage         : Run with arguments or interactively. Examples:
::                   convert-number.bat dec 255
::                   convert-number.bat hex FF
::                   convert-number.bat bin 11111111
:: Requirements  : Windows CMD, Windows PowerShell 5.1
:: Notes         : Supports endianness conversion for hex values. The PowerShell
::                 code is embedded below and run from this .bat file.
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

:: Run the embedded PowerShell code below (no temp .ps1 files needed)
powershell -NoProfile -ExecutionPolicy Bypass -Command "iex (${%~f0} | Out-String)"

echo.
exit /b %ERRORLEVEL%

: end batch / begin PowerShell #>

# Number conversion - embedded PowerShell (Windows PowerShell 5.1 compatible)
# Inputs are passed from the batch portion via environment variables.
$inputFormat = "$env:INPUT_FORMAT".ToLower()
$inputValue = "$env:CLEAN_VALUE"

try {
    switch ($inputFormat) {
        'dec' { $decimal = [int64]$inputValue }
        'bin' { $decimal = [Convert]::ToInt64($inputValue, 2) }
        'oct' { $decimal = [Convert]::ToInt64($inputValue, 8) }
        'hex' { $decimal = [Convert]::ToInt64($inputValue, 16) }
    }

    $binary = [Convert]::ToString($decimal, 2)
    $octal = [Convert]::ToString($decimal, 8)
    $hex = [Convert]::ToString($decimal, 16).ToUpper()

    Write-Host "Decimal:      $decimal"
    Write-Host "Binary:       $binary"
    Write-Host "Octal:        $octal"
    Write-Host "Hexadecimal:  $hex"
    Write-Host ""
    Write-Host "With Prefixes:"
    Write-Host "  Binary:     0b$binary"
    Write-Host "  Octal:      0$octal"
    Write-Host "  Hex:        0x$hex"

    # Endianness for hex (only if 2+ bytes)
    if ($hex.Length -ge 2) {
        $paddedHex = if ($hex.Length % 2 -ne 0) { '0' + $hex } else { $hex }
        $bytes = @()
        for ($i = 0; $i -lt $paddedHex.Length; $i += 2) {
            $bytes += $paddedHex.Substring($i, 2)
        }
        $bigEndian = $bytes -join ' '
        $littleEndian = ($bytes[($bytes.Length-1)..0]) -join ' '
        Write-Host ""
        Write-Host "Byte Order:"
        Write-Host "  Big Endian:     $bigEndian"
        Write-Host "  Little Endian:  $littleEndian"
        $beCompact = $bytes -join ''
        $leCompact = ($bytes[($bytes.Length-1)..0]) -join ''
        Write-Host "  BE (compact):   $beCompact"
        Write-Host "  LE (compact):   $leCompact"
    }

    # Character representation (if printable ASCII)
    if ($decimal -ge 32 -and $decimal -le 126) {
        Write-Host ""
        Write-Host "ASCII Char:   $([char]$decimal)"
    }

    # Signed interpretation
    Write-Host ""
    Write-Host "Signed Interpretation:"
    if ($decimal -le 255) {
        $signed8 = if ($decimal -gt 127) { $decimal - 256 } else { $decimal }
        Write-Host "  8-bit:      $signed8"
    }
    if ($decimal -le 65535) {
        $signed16 = if ($decimal -gt 32767) { $decimal - 65536 } else { $decimal }
        Write-Host "  16-bit:     $signed16"
    }
    if ($decimal -le 4294967295) {
        $signed32 = if ($decimal -gt 2147483647) { $decimal - 4294967296 } else { $decimal }
        Write-Host "  32-bit:     $signed32"
    }

} catch {
    Write-Host "Error: Invalid input value for the specified format." -ForegroundColor Red
    Write-Host $_.Exception.Message
    exit 1
}
