@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Opens Windows Resource Monitor.
:: Usage         : Run directly.
:: Requirements  : Windows CMD
:: Notes         : Detailed CPU, memory, disk, and network usage.
:: ============================================================

start "" resmon.exe
exit /b 0
