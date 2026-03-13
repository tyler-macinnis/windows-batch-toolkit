@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ============================================================
:: Description   : Switches the active Windows power plan interactively.
:: Usage         : Run directly. Run as Administrator for best results.
:: Requirements  : Windows CMD, powercfg
:: Notes         : Changes take effect immediately without a reboot.
:: ============================================================

echo ==================================================
echo Power Plan Manager
echo ==================================================
echo.
echo Current active plan:
powercfg /getactivescheme
echo.
echo Available plans:
echo --------------------------------------------------
powercfg /list
echo.

echo   1)  Balanced
echo   2)  High Performance
echo   3)  Power Saver
echo.
set /P "CHOICE=Select plan (1-3): "

if "!CHOICE!"=="1" (
    powercfg /setactive SCHEME_BALANCED
    echo Switched to: Balanced
) else if "!CHOICE!"=="2" (
    powercfg /setactive SCHEME_MIN
    echo Switched to: High Performance
) else if "!CHOICE!"=="3" (
    powercfg /setactive SCHEME_MAX
    echo Switched to: Power Saver
) else (
    echo Invalid option.
)

echo.
pause
exit /b 0
