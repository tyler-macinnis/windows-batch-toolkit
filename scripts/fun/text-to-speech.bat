@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Speaks any text you type using Windows text-to-speech.
:: Usage         : Run directly and enter text at the prompt.
:: Requirements  : Windows CMD, PowerShell
:: Notes         : Special batch characters (& | < >) may cause issues in input.
:: ============================================================

set /P "MSG=Enter text to speak: "
if "%MSG%"=="" (
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
