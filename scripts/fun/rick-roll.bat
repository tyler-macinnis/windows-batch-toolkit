@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Opens a very important and urgent message in your browser.
:: Usage         : Run directly.
:: Requirements  : Windows CMD, default web browser
:: Notes         : You will never want to give this up.
:: ============================================================

echo Preparing a very important system message...
ping -n 2 127.0.0.1 >nul
echo Loading critical update...
ping -n 2 127.0.0.1 >nul
echo Almost there...
ping -n 2 127.0.0.1 >nul

start "" "https://www.youtube.com/watch?v=dQw4w9WgXcQ"

echo.
echo Never gonna give you up.
echo Never gonna let you down.
echo.
pause
exit /b 0
