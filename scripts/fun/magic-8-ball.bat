@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ============================================================
:: Description   : Ask the Magic 8-Ball a yes/no question.
:: Usage         : Run directly and enter your question.
:: Requirements  : Windows CMD
:: Notes         : All answers are final. The 8-Ball is never wrong.
:: ============================================================

echo.
echo   +---------------------------+
echo   ^|   Magic 8-Ball  ^|  8  ^|
echo   +---------------------------+
echo.
set /P "Q=  Ask your question: "
echo.
echo   Consulting the 8-Ball...
ping -n 2 127.0.0.1 >nul

set /A ROLL=!RANDOM! %% 12

if !ROLL!==0  set "ANS=It is certain."
if !ROLL!==1  set "ANS=Without a doubt."
if !ROLL!==2  set "ANS=You may rely on it."
if !ROLL!==3  set "ANS=Signs point to yes."
if !ROLL!==4  set "ANS=Outlook good."
if !ROLL!==5  set "ANS=Ask again later."
if !ROLL!==6  set "ANS=Cannot predict now."
if !ROLL!==7  set "ANS=Concentrate and ask again."
if !ROLL!==8  set "ANS=Don't count on it."
if !ROLL!==9  set "ANS=My sources say no."
if !ROLL!==10 set "ANS=Very doubtful."
if !ROLL!==11 set "ANS=Outlook not so good."

echo.
echo   +---------------------------+
echo    ^> !ANS!
echo   +---------------------------+
echo.
pause
exit /b 0
