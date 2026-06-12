# Contributing

## Guidelines

- Use lowercase dash-separated file names
- Put scripts in the correct category folder (`system`, `network`, `files`, `dev`, `git`, `fun`)
- Include the standard batch script header (Description, Usage, Requirements, Notes)
- Keep scripts focused on one purpose
- Add comments for non-obvious logic
- Avoid destructive actions unless clearly documented
- Write scripts as `.bat` files; do not add standalone `.ps1` files
- If PowerShell is needed, call it from within the `.bat` file (inline
  `powershell -Command` or an embedded `<# : ... #>` hybrid section) and keep
  it Windows PowerShell 5.1 compatible

## Recommended Workflow

1. Copy `scripts/templates/script-template.bat`
2. Rename it for the new script
3. Update the header
4. Implement the logic
5. Test it on Windows to verify it works as described
6. Update `README.md` if needed

## Style Notes

- Prefer `setlocal EnableExtensions EnableDelayedExpansion` when needed
- Use `exit /b 0` for success
- Use `exit /b 1` for failures
- Echo helpful status messages
- Pause only for interactive scripts
