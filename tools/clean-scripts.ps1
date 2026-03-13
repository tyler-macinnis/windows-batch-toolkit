$scriptsDir = Join-Path (Split-Path -Parent $PSScriptRoot) "scripts"

$targets = Get-ChildItem -Path $scriptsDir -Recurse -File -Include "*.txt" |
    Where-Object { $_.DirectoryName -ne $scriptsDir -or $true }

if ($targets.Count -eq 0) {
    Write-Host "Nothing to clean."
    exit 0
}

foreach ($file in $targets) {
    $relative = $file.FullName.Substring($scriptsDir.Length + 1)
    Remove-Item -Path $file.FullName -Force
    Write-Host "Deleted: $relative"
}

Write-Host ""
Write-Host "Cleaned $($targets.Count) file(s)."
