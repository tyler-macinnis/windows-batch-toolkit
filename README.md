# Windows Batch Toolkit

A collection of portable Windows batch scripts for system administration, networking, development, and automation. No installation required — just run.

## Features

- **50+ ready-to-use scripts** organized by category
- **Interactive menu** (`toolkit.bat`) to browse and run scripts
- **Command-line friendly** — all scripts accept optional arguments
- **Zero dependencies** — pure batch, runs on any Windows machine

## Quick Start

```bat
:: Launch the interactive menu
scripts\toolkit.bat

:: Or run any script directly
scripts\system\show-system-info.bat
scripts\files\list-large-files.bat C:\Downloads 50
```

## Categories

| Category  | Description                                                   |
|-----------|---------------------------------------------------------------|
| `system`  | System info, cleanup, services, power plans, repairs          |
| `network` | IP config, ports, WiFi, DNS, ping sweep, traceroute           |
| `files`   | Backup, large files, old files, folder sizes, directory trees |
| `dev`     | Base64, hashing, GUIDs, number conversion, PATH export        |
| `git`     | Status, branches, logs, pull all repos, undo commits          |
| `fun`     | Matrix rain, text-to-speech, magic 8-ball, and more           |

## Usage

Most scripts work out of the box. Many accept optional arguments:

```bat
:: Use current directory
scripts\files\find-old-files.bat

:: Or specify a path and parameters
scripts\files\find-old-files.bat "C:\Projects" 30
```

Run `toolkit.bat` for an interactive menu with pagination and argument prompts.

## Contributing

See [docs/contributing.md](docs/contributing.md) for guidelines.

## License

MIT
