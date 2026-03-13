# Contributing

## Guidelines

- Use lowercase dash-separated file names
- Put scripts in the correct category folder (`system`, `network`, `files`, `dev`, `git`, `fun`)
- Include the standard batch script header (Description, Usage, Requirements, Notes)
- Keep scripts focused on one purpose
- Add comments for non-obvious logic
- Avoid destructive actions unless clearly documented

## Recommended Workflow

1. Copy `scripts/templates/script-template.bat`
2. Rename it for the new script
3. Update the header
4. Implement the logic
5. Test locally
6. Update `README.md` if needed

## Style Notes

- Prefer `setlocal EnableExtensions EnableDelayedExpansion` when needed
- Use `exit /b 0` for success
- Use `exit /b 1` for failures
- Echo helpful status messages
- Pause only for interactive scripts
