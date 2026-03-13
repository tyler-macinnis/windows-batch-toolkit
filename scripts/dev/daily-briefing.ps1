# Daily Briefing - PowerShell Backend
# Called by daily-briefing.bat

$ErrorActionPreference = 'SilentlyContinue'

# Greeting based on time
$hour = (Get-Date).Hour
if ($hour -lt 12) { $greeting = 'Good Morning' }
elseif ($hour -lt 17) { $greeting = 'Good Afternoon' }
else { $greeting = 'Good Evening' }

$user = $env:USERNAME
$computer = $env:COMPUTERNAME
$date = Get-Date -Format 'dddd, MMMM dd, yyyy  -  HH:mm'
$dayName = (Get-Date).DayOfWeek

Clear-Host
Write-Host ''
Write-Host '  ============================================================' -ForegroundColor DarkCyan
Write-Host ''
Write-Host "     $greeting, $user!" -ForegroundColor Cyan
Write-Host ''
Write-Host "     $date"
Write-Host ''
Write-Host '  ============================================================' -ForegroundColor DarkCyan
Write-Host ''

# System Status
Write-Host '  [ SYSTEM STATUS ]' -ForegroundColor Yellow
Write-Host '  ------------------------------------------------------------' -ForegroundColor DarkGray
Write-Host ''

Write-Host "    Computer: $computer"

# RAM
$os = Get-CimInstance Win32_OperatingSystem
$totalRAM = [math]::Round($os.TotalVisibleMemorySize / 1MB)
$freeRAM = [math]::Round($os.FreePhysicalMemory / 1MB)
$usedRAM = $totalRAM - $freeRAM
Write-Host "    Memory: $usedRAM GB used / $totalRAM GB total"

# Disk
$disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
$totalDisk = [math]::Round($disk.Size / 1GB)
$freeDisk = [math]::Round($disk.FreeSpace / 1GB)
$usedDisk = $totalDisk - $freeDisk
Write-Host "    Disk (C:): $usedDisk GB used / $totalDisk GB total ($freeDisk GB free)"

# Battery
$battery = Get-CimInstance Win32_Battery
if ($battery) {
    $charge = $battery.EstimatedChargeRemaining
    $status = if ($battery.BatteryStatus -eq 2) { ' (Charging)' } else { '' }
    Write-Host "    Battery: $charge%$status"
} else {
    Write-Host '    Battery: N/A (Desktop)'
}

# Uptime
$uptime = (Get-Date) - $os.LastBootUpTime
$uptimeStr = '{0}d {1}h {2}m' -f $uptime.Days, $uptime.Hours, $uptime.Minutes
Write-Host "    Uptime: $uptimeStr"

Write-Host ''

# Location & Weather
Write-Host '  [ LOCATION & WEATHER ]' -ForegroundColor Yellow
Write-Host '  ------------------------------------------------------------' -ForegroundColor DarkGray
Write-Host ''

try {
    $loc = Invoke-RestMethod -Uri 'http://ip-api.com/json' -TimeoutSec 5
    $location = "$($loc.city), $($loc.regionName), $($loc.country)"
} catch {
    $location = 'Unable to determine'
}
Write-Host "    Location: $location"

try {
    $weather = (Invoke-RestMethod -Uri 'https://wttr.in/?format=%C+%t' -TimeoutSec 5).Trim()
} catch {
    $weather = 'Unable to fetch weather'
}
Write-Host "    Weather: $weather"

Write-Host ''

# Fun Fact
Write-Host '  [ FUN FACT OF THE DAY ]' -ForegroundColor Yellow
Write-Host '  ------------------------------------------------------------' -ForegroundColor DarkGray
Write-Host ''

try {
    $factResponse = Invoke-RestMethod -Uri 'https://uselessfacts.jsph.pl/random.json?language=en' -TimeoutSec 5
    $fact = $factResponse.text
} catch {
    $fact = 'Did you know? Honey never spoils. Archaeologists found 3000-year-old honey in Egyptian tombs that was still edible!'
}

# Word wrap the fact
$maxWidth = 60
$words = $fact -split '\s+'
$line = '    '
foreach ($word in $words) {
    if (($line.Length + $word.Length + 1) -gt ($maxWidth + 4)) {
        Write-Host $line
        $line = '    ' + $word
    } else {
        if ($line -eq '    ') { $line += $word }
        else { $line += ' ' + $word }
    }
}
if ($line.Trim()) { Write-Host $line }

Write-Host ''
Write-Host '  ============================================================' -ForegroundColor DarkCyan
Write-Host "     Have a great $dayName!" -ForegroundColor Green
Write-Host '  ============================================================' -ForegroundColor DarkCyan
Write-Host ''
