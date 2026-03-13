@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Checks and repairs the Windows component store using DISM.
:: Usage         : Run as Administrator.
:: Requirements  : Windows CMD, DISM, Administrator privileges
:: Notes         : Run ScanHealth first, then RestoreHealth only if needed.
:: ============================================================

echo ==================================================
echo DISM - Windows Image Repair
echo ==================================================
echo.
echo Step 1 of 2: Checking image health...
echo.

DISM /Online /Cleanup-Image /CheckHealth

echo.
echo Step 2 of 2: Scanning component store for corruption...
echo This may take several minutes.
echo.

DISM /Online /Cleanup-Image /ScanHealth

echo.
set /P "RESTORE=Corruption found or want to force repair? Run RestoreHealth? (Y/N): "
if /I not "%RESTORE%"=="Y" goto :done

echo.
echo Running RestoreHealth. This may take 15-30 minutes...
echo.
DISM /Online /Cleanup-Image /RestoreHealth

echo.
echo RestoreHealth complete. A reboot is recommended.

:done
echo.
pause
exit /b 0
