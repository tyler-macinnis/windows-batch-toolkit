@echo off
color 0A

:: ============================================================
:: Description   : Displays a Matrix-style number rain effect in the terminal.
:: Usage         : Run directly. Press Ctrl+C to exit.
:: Requirements  : Windows CMD
:: Notes         : Best viewed in a maximised window with a small font size.
:: ============================================================

:RAIN
echo %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random%
goto RAIN
