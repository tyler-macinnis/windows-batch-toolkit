@echo off
setlocal enabledelayedexpansion

:: ============================================================
:: Description   : Converts text files in the target directory to UTF-8 without BOM.
:: Usage         : Run directly. Modify TARGET_DIR, FILE_PATTERNS, and RECURSE as needed.
:: Requirements  : Windows CMD, PowerShell
:: Notes         : This script uses PowerShell and writes UTF-8 without BOM.
:: ============================================================

:: Define the target directory (use "." for the current directory)
set "TARGET_DIR=."

:: Define file patterns to convert (comma-separated). Easy to add more patterns.
set "FILE_PATTERNS=*.cs,*.manifest,*.settings,*.csproj,*.json,*.yaml,*.resx,*.datasource,*.config,*.sln,*.md"

:: Set to 1 to include subdirectories, 0 for current directory only
set "RECURSE=1"

if not exist "%TARGET_DIR%" (
        echo ERROR: Target directory "%TARGET_DIR%" does not exist.
        exit /b 1
)

echo Converting files in "%TARGET_DIR%" to UTF-8 without BOM...
echo Patterns: %FILE_PATTERNS%
if "%RECURSE%"=="1" (
        echo Recursion: enabled
) else (
        echo Recursion: disabled
)

powershell -NoProfile -ExecutionPolicy Bypass -Command "$TargetDir = $env:TARGET_DIR; $FilePatterns = $env:FILE_PATTERNS; $Recurse = [int]$env:RECURSE; $utf8NoBom = New-Object System.Text.UTF8Encoding($false); $patterns = $FilePatterns.Split(',') | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne '' }; $fileMap = @{}; foreach ($pattern in $patterns) { $gciParams = @{ Path = $TargetDir; Filter = $pattern; File = $true }; if ($Recurse -eq 1) { $gciParams.Recurse = $true }; $matches = Get-ChildItem @gciParams -ErrorAction Stop; foreach ($match in $matches) { $fileMap[$match.FullName] = $match } }; $files = $fileMap.Values; if (-not $files) { Write-Host 'No matching files found.'; exit 0 }; $converted = 0; foreach ($file in $files) { try { $content = [System.IO.File]::ReadAllText($file.FullName); [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom); $converted++; Write-Host ('Converted: ' + $file.FullName) } catch { Write-Warning ('Skipped: ' + $file.FullName + ' -> ' + $_.Exception.Message) } }; Write-Host ('Done. Converted files: ' + $converted)"

if errorlevel 1 (
        echo Conversion finished with errors.
        exit /b 1
)

echo Conversion complete.
pause