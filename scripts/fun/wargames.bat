@echo off
setlocal EnableExtensions EnableDelayedExpansion
color 0A

:: ============================================================
:: Description   : Simulates the WOPR terminal sequence from the movie WarGames (1983).
:: Usage         : Run directly.
:: Requirements  : Windows CMD
:: Notes         : Purely cosmetic. No actual network activity.
:: ============================================================

cls
ping -n 2 127.0.0.1 >nul

echo.
echo   LOGON:
ping -n 2 127.0.0.1 >nul
echo.
echo   IDENTIFICATION NOT RECOGNIZED BY SYSTEM
echo   ------------------------------------------
echo   LAST LOGIN: !DATE! !TIME!
ping -n 3 127.0.0.1 >nul

cls
echo.
echo.
echo                 GREETINGS, PROFESSOR FALKEN.
echo.
ping -n 3 127.0.0.1 >nul

echo.
echo.
echo                 SHALL WE PLAY A GAME?
echo.
ping -n 4 127.0.0.1 >nul

cls
echo.
echo   ============================================================
echo    W O P R  --  WAR OPERATION PLAN RESPONSE
echo    NORAD / CHEYENNE MOUNTAIN COMPLEX
echo   ============================================================
echo.
echo   AVAILABLE GAMES:
echo.
ping -n 2 127.0.0.1 >nul
echo     1.  CHESS
ping -n 1 127.0.0.1 >nul
echo     2.  CHECKERS
ping -n 1 127.0.0.1 >nul
echo     3.  BACKGAMMON
ping -n 1 127.0.0.1 >nul
echo     4.  POKER
ping -n 1 127.0.0.1 >nul
echo     5.  FIGHTER COMBAT
ping -n 1 127.0.0.1 >nul
echo     6.  GUERRILLA ENGAGEMENT
ping -n 1 127.0.0.1 >nul
echo     7.  DESERT WARFARE
ping -n 1 127.0.0.1 >nul
echo     8.  AIR-TO-GROUND ACTIONS
ping -n 1 127.0.0.1 >nul
echo     9.  THEATERWIDE TACTICAL WARFARE
ping -n 1 127.0.0.1 >nul
echo    10.  THEATERWIDE CONVENTIONAL WARFARE
ping -n 1 127.0.0.1 >nul
echo    11.  GLOBAL THERMONUCLEAR WAR
echo.
ping -n 3 127.0.0.1 >nul

echo.
set /p "CHOICE=   ENTER SELECTION: "
echo.
ping -n 2 127.0.0.1 >nul

cls
echo.
echo   SELECTION: GLOBAL THERMONUCLEAR WAR
echo.
ping -n 2 127.0.0.1 >nul
echo   FINE.
echo.
ping -n 3 127.0.0.1 >nul

cls
echo.
echo   INITIATING SIMULATION...
echo.
ping -n 2 127.0.0.1 >nul
echo   ACCESSING PRIMARY LAUNCH NODES...
ping -n 2 127.0.0.1 >nul
echo   AUTHENTICATION:  *** CONFIRMED ***
ping -n 2 127.0.0.1 >nul
echo   STRATEGIC AIR COMMAND:  STANDING BY
ping -n 2 127.0.0.1 >nul
echo.
echo   TARGET ACQUISITION IN PROGRESS...
echo.

for %%C in (
    "MOSCOW          -- ICBM TRAJECTORY CONFIRMED"
    "LENINGRAD       -- ICBM TRAJECTORY CONFIRMED"
    "VLADIVOSTOK     -- ICBM TRAJECTORY CONFIRMED"
    "NOVOSIBIRSK     -- ICBM TRAJECTORY CONFIRMED"
    "MINSK           -- ICBM TRAJECTORY CONFIRMED"
    "WARSAW          -- ICBM TRAJECTORY CONFIRMED"
    "EAST BERLIN     -- ICBM TRAJECTORY CONFIRMED"
    "PRAGUE          -- ICBM TRAJECTORY CONFIRMED"
    "BUDAPEST        -- ICBM TRAJECTORY CONFIRMED"
) do (
    ping -n 1 127.0.0.1 >nul
    echo     %%~C
)

echo.
ping -n 3 127.0.0.1 >nul

cls
echo.
echo   INCOMING RETALIATION TRAJECTORIES DETECTED:
echo.
ping -n 2 127.0.0.1 >nul

for %%C in (
    "NEW YORK        -- IMPACT IN 00:08:42"
    "WASHINGTON D.C. -- IMPACT IN 00:07:11"
    "LOS ANGELES     -- IMPACT IN 00:09:03"
    "CHICAGO         -- IMPACT IN 00:08:55"
    "SEATTLE         -- IMPACT IN 00:10:17"
    "DALLAS          -- IMPACT IN 00:09:44"
    "MIAMI           -- IMPACT IN 00:09:21"
    "DENVER          -- IMPACT IN 00:08:38"
) do (
    ping -n 1 127.0.0.1 >nul
    echo     %%~C
)

echo.
ping -n 3 127.0.0.1 >nul

cls
echo.
echo   RUNNING SIMULATIONS...
echo.
ping -n 2 127.0.0.1 >nul

set /a SIM=0
:simloop
set /a SIM+=1
if !SIM! GTR 36 goto simend
set /a W1=!RANDOM! %% 900 + 100
set /a W2=!RANDOM! %% 900 + 100
echo   SCENARIO !SIM!  --  US: !W1! MT  ^|  USSR: !W2! MT  ^|  RESULT: TOTAL ANNIHILATION
ping -n 1 127.0.0.1 >nul
goto simloop

:simend
echo.
ping -n 3 127.0.0.1 >nul

cls
echo.
echo.
echo         . . . S T R A N G E   G A M E . . .
echo.
ping -n 4 127.0.0.1 >nul
echo.
echo.
echo         THE ONLY WINNING MOVE IS NOT TO PLAY.
echo.
ping -n 5 127.0.0.1 >nul
echo.
echo.
echo         HOW ABOUT A NICE GAME OF CHESS?
echo.
ping -n 3 127.0.0.1 >nul
echo.
pause
color 07
exit /b 0
