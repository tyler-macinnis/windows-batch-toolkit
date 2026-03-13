@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ============================================================
:: Description   : Speaks any text you type using Windows text-to-speech.
:: Usage         : text-to-speech.bat [text]
::                 If no text provided, prompts for input.
:: Requirements  : Windows CMD, PowerShell
:: Notes         : Special batch characters (& | < >) may cause issues in input.
:: ============================================================

set "MSG=%*"
if "!MSG!"=="" (
    set /P "MSG=Enter text to speak: "
)
if "!MSG!"=="" (
    echo Nothing to say.
    pause
    exit /b 0
)

echo Speaking...
powershell -NoProfile -Command "Add-Type -AssemblyName System.Speech; $s = New-Object System.Speech.Synthesis.SpeechSynthesizer; $s.Speak($env:MSG)"

echo Done.
echo.
pause
exit /b 0
