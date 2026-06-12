# Windows Batch Scripts

A simple, curated collection of useful Windows batch (`.bat`) scripts, organized
into a few categories. There is no installer, menu, or build step — just open a
folder and run the script you need.

## How to Use

Run any script directly from File Explorer (double-click) or from a command
prompt:

```bat
:: Run a script
scripts\system\show-system-info.bat

:: Many scripts accept optional arguments
scripts\files\list-large-files.bat C:\Downloads 50
scripts\files\find-old-files.bat "C:\Projects" 30
```

Some scripts need an elevated prompt. If a script reports that it requires
administrator rights, right-click it and choose **Run as administrator**, or
launch it from an elevated command prompt.

Each script begins with a short header describing what it does, how to run it,
its requirements, and any important notes.

## Categories

| Category  | Description                                                   |
|-----------|---------------------------------------------------------------|
| `system`  | System info, cleanup, services, power plans, repairs          |
| `network` | IP config, ports, WiFi, DNS, hosts file, ping sweep, traceroute |
| `files`   | Backup, large files, old files, folder sizes, directory trees |
| `dev`     | Base64, hashing, GUIDs, number conversion, PATH export        |
| `git`     | Status, branches, logs, pull all repos, undo commits          |
| `fun`     | Matrix rain, text-to-speech, magic 8-ball, daily briefing, and more |

Scripts live under `scripts/<category>/`. A starter template is available at
`scripts/templates/script-template.bat`.

Everything in this toolkit is a `.bat` file. When a script needs PowerShell,
the PowerShell code is embedded in (or invoked inline from) the `.bat` file
itself — there are no standalone `.ps1` files — and it targets Windows
PowerShell 5.1 for maximum compatibility.

## Docs

- [Contributing](docs/contributing.md)
- [Naming conventions](docs/naming-conventions.md)
- [Script template](docs/script-template.md)

## License

[MIT](LICENSE)
