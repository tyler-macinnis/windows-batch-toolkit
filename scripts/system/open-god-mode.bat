@echo off
setlocal EnableExtensions

:: ============================================================
:: Description   : Opens Windows God Mode - all settings in one place.
:: Usage         : Run directly.
:: Requirements  : Windows CMD
:: Notes         : God Mode provides access to all Control Panel settings.
:: ============================================================

echo Opening Windows God Mode...
explorer shell:::{ED7BA470-8E54-465E-825C-99712043E01C}
exit /b 0
