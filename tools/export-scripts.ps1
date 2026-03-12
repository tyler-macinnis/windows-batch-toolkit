$root = Split-Path -Parent $PSScriptRoot
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$exports = Join-Path $root "exports"
$source = Join-Path $root "scripts\*"
$zip = Join-Path $exports ("scripts-" + $timestamp + ".zip")

New-Item -ItemType Directory -Path $exports -Force | Out-Null
Compress-Archive -Path $source -DestinationPath $zip -Force