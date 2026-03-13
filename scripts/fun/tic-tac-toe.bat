@echo off
setlocal enabledelayedexpansion
color A

:: ============================================================
:: Description   : Two-player Tic Tac Toe game in the terminal.
:: Usage         : Run directly. Use numpad layout to pick squares.
:: Requirements  : Windows CMD
:: Notes         : Type "help" in-game for controls. Type "exit" to quit.
:: ============================================================

set /a p1Wins=0
set /a p2Wins=0

:replay
set one=-
set two=-
set three=-
set four=-
set five=-
set six=-
set seven=-
set eight=-
set nine=-
set /a turn=0
set /a numberOfTurns=0

:loop
cls

if !p1Wins! LSS 2 (
	if !p1Wins! GTR 0 (
		echo X player has !p1Wins! win
	) else (
		echo X player has !p1Wins! wins
	)
) else (
	echo X player has !p1Wins! wins
)

if !p2Wins! LSS 2 (
	if !p2Wins! GTR 0 (
		echo O player has !p2Wins! win
	) else (
		echo O player has !p2Wins! wins
	)
) else (
	echo O player has !p2Wins! wins
)

echo.

if !turn!==0 (
	echo It is the X player's turn
) else (
	echo It is the O player's turn
)
echo.

echo 	!one! ^| !two! ^| !three!
echo 	---------
echo 	!four! ^| !five! ^| !six!
echo 	---------
echo 	!seven! ^| !eight! ^| !nine!
echo.

:: rows
if !one! NEQ - (
	if !one!==!two! (
		if !two!==!three! (
			goto endgame
		)
	)
)

if !four! NEQ - (
	if !four!==!five! (
		if !five!==!six! (
			goto endgame
		)
	)
)

if !seven! NEQ - (
	if !seven!==!eight! (
		if !eight!==!nine! (
			goto endgame
		)
	)
)

:: columns
if !one! NEQ - (
	if !one!==!four! (
		if !four!==!seven! (
			goto endgame
		)
	)
)

if !two! NEQ - (
	if !two!==!five! (
		if !five!==!eight! (
			goto endgame
		)
	)
)

if !three! NEQ - (
	if !three!==!six! (
		if !six!==!nine! (
			goto endgame
		)
	)
)

:: diagonals
if !one! NEQ - (
	if !one!==!five! (
		if !five!==!nine! (
			goto endgame
		)
	)
)

if !three! NEQ - (
	if !three!==!five! (
		if !five!==!seven! (
			goto endgame
		)
	)
)

:: tie game
if !numberOfTurns!==9 (
	echo Cats Game!
	goto prompt
)

:turn
if !turn!==0 (
	set turnSymb=X
) else (
	set turnSymb=O
)

set /p userInput= :

if "!userInput!" EQU "help" (
	goto helpScreen
)

if "!userInput!" EQU "exit" (
	color 7
	echo Goodbye.
	pause
	cls
	exit 0
)

if "!userInput!" EQU "color" (
	goto changeColor
)

set /a input=!userInput!

if !input! EQU 7 (
	if !one! EQU - (
		set one=!turnSymb!
	) else (
		echo Space already taken!
		goto turn
	)
) else if !input! EQU 8 (
	if !two! EQU - (
		set two=!turnSymb!
	) else (
		echo Space already taken!
		goto turn
	)
) else if !input! EQU 9 (
	if !three! EQU - (
		set three=!turnSymb!
	) else (
		echo Space already taken!
		goto turn
	)
) else if !input! EQU 4 (
	if !four! EQU - (
		set four=!turnSymb!
	) else (
		echo Space already taken!
		goto turn
	)
) else if !input! EQU 5 (
	if !five! EQU - (
		set five=!turnSymb!
	) else (
		echo Space already taken!
		goto turn
	)
) else if !input! EQU 6 (
	if !six! EQU - (
		set six=!turnSymb!
	) else (
		echo Space already taken!
		goto turn
	)
) else if !input! EQU 1 (
	if !seven! EQU - (
		set seven=!turnSymb!
	) else (
		echo Space already taken!
		goto turn
	)
) else if !input! EQU 2 (
	if !eight! EQU - (
		set eight=!turnSymb!
	) else (
		echo Space already taken!
		goto turn
	)
) else if !input! EQU 3 (
	if !nine! EQU - (
		set nine=!turnSymb!
	) else (
		echo Space already taken!
		goto turn
	)
) else (
	echo Invalid option!
	echo Type "help" for help, "exit" to quit, "color" to change color.
	pause
	goto loop
)

if !turn!==0 (
	set /a turn=1
) else (
	set /a turn=0
)

set /a numberOfTurns=!numberOfTurns!+1
goto loop

:endgame
if !turn!==0 (
	echo The O player has won the game!
	set /a p2Wins=!p2Wins!+1
) else (
	echo The X player has won the game!
	set /a p1Wins=!p1Wins!+1
)

:prompt
set userPrompt=y
echo.
echo Would you like to play again? [y/n]
set /p userPrompt=:

if /I "!userPrompt!" EQU "y" (
	goto replay
) else if /I "!userPrompt!" EQU "n" (
	echo Goodbye.
) else (
	echo Invalid option!
	goto prompt
)

pause
endlocal
exit 0

:helpScreen
cls
echo The standard rules of Tic Tac Toe apply.
echo.
echo Use the numpad layout to pick a square:
echo.
echo 	7 ^| 8 ^| 9
echo 	---------
echo 	4 ^| 5 ^| 6
echo 	---------
echo 	1 ^| 2 ^| 3
echo.
echo Type "color" to change the game color.
echo Type "exit" to quit at any time.
echo.
pause
goto loop

:changeColor
cls
echo Choose a color:
echo 1) Green
echo 2) Light Blue
echo 3) Red
echo 4) Purple
echo 5) Yellow
echo 6) White
echo 7) Default
set /p input=:

if "!input!" EQU "1" (
	color A
) else if "!input!" EQU "2" (
	color B
) else if "!input!" EQU "3" (
	color C
) else if "!input!" EQU "4" (
	color D
) else if "!input!" EQU "5" (
	color E
) else if "!input!" EQU "6" (
	color F
) else if "!input!" EQU "7" (
	color 7
) else (
	echo Invalid option!
	pause
	goto changeColor
)
goto loop
