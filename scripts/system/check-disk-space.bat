@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ============================================================
:: Description   : Shows disk usage information for local drives with visual indicators.
:: Usage         : Run directly. Optionally pass drive letter (e.g., C:).
:: Requirements  : Windows CMD, PowerShell
:: Notes         : Shows human-readable sizes, percentages, and visual bars.
:: ============================================================

set "DRIVE_FILTER=%~1"

powershell -NoProfile -ExecutionPolicy Bypass -Command "$f='%DRIVE_FILTER%'; function Fmt($b){if($b -ge 1TB){'{0:N2} TB'-f($b/1TB)}elseif($b -ge 1GB){'{0:N2} GB'-f($b/1GB)}elseif($b -ge 1MB){'{0:N2} MB'-f($b/1MB)}else{'{0:N2} KB'-f($b/1KB)}}; function Bar($p){$x=[math]::Round($p*20/100);('='*$x)+('-'*(20-$x))}; Write-Host ''; Write-Host '============================================================' -Fore Cyan; Write-Host '  DISK SPACE INFORMATION' -Fore Cyan; Write-Host '============================================================' -Fore Cyan; Write-Host ''; $d=Get-WmiObject Win32_LogicalDisk -Filter 'DriveType=3'; if($f){$d=$d|?{$_.DeviceID -eq $f}}; if(-not $d){Write-Host 'No drives found.' -Fore Red;exit 1}; foreach($x in $d){$t=$x.Size;$fr=$x.FreeSpace;$u=$t-$fr;$pu=[math]::Round(($u/$t)*100,1);$pf=[math]::Round(($fr/$t)*100,1);$c='Green';if($pu -ge 70){$c='Yellow'};if($pu -ge 90){$c='Red'};$b=Bar $pu; Write-Host ('Drive '+$x.DeviceID) -Fore White -NoNewline; if($x.VolumeName){Write-Host (' ['+$x.VolumeName+']') -Fore Gray}else{Write-Host ''}; Write-Host ('  ['+$b+'] '+$pu+'%% used') -Fore $c; Write-Host ''; Write-Host ('  Total:      '+(Fmt $t)) -Fore White; Write-Host ('  Used:       '+(Fmt $u)) -Fore $c; Write-Host ('  Free:       '+(Fmt $fr)) -Fore Green; Write-Host ''; if($pf -lt 10){Write-Host '  WARNING: Low disk space!' -Fore Red;Write-Host ''}}; Write-Host '============================================================' -Fore Cyan"

echo.
pause
exit /b 0
