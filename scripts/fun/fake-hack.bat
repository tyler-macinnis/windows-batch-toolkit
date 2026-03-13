@echo off
setlocal EnableExtensions EnableDelayedExpansion
color 0A
cls

:: ============================================================
:: Description   : Simulates a dramatic hacking sequence in the terminal.
:: Usage         : Run directly.
:: Requirements  : Windows CMD
:: Notes         : Purely cosmetic. No actual network activity.
:: ============================================================

echo.
echo  Initializing intrusion sequence...
ping -n 3 127.0.0.1 >nul
echo  Scanning target host...
ping -n 2 127.0.0.1 >nul
echo.

for /L %%i in (1,1,25) do (
    echo  [%%i]  Probing node 0x!RANDOM!!RANDOM!  --^>  port:!RANDOM!  ... OK
)

echo.
ping -n 2 127.0.0.1 >nul
echo  Bypassing firewall...
ping -n 2 127.0.0.1 >nul

for /L %%i in (1,1,20) do (
    echo       Decrypting segment [!RANDOM!] ... ^( !RANDOM! / 32767 bytes ^)
)

echo.
ping -n 2 127.0.0.1 >nul
echo  Uploading payload...
ping -n 3 127.0.0.1 >nul
echo  Establishing persistent backdoor...
ping -n 3 127.0.0.1 >nul
echo.
echo  ============================================
echo    ACCESS GRANTED
echo  ============================================
echo.
echo  Welcome, %USERNAME%. We've been expecting you.
echo.
pause
color 07
exit /b 0
