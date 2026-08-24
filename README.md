# Pomodoro Timer

A simple CLI Pomodoro Timer built with **Python and Bash**, using Python `subprocess` to orchestrate Bash automation.

## Features

* Work, break, and cycle configuration
* Countdown timer
* Runtime help with `h`
* `Ctrl+C` to stop the timer
* Optional logging
* Optional desktop notifications
* Python + Bash automation
* GitHub Actions CI/CD automation

## Architecture

```text
Python
   │
   │ subprocess
   ▼
Bash Timer
   │
   ├── Countdown
   ├── Logging
   └── Notifications
```

<<<<<<< HEAD
=======
## CI/CD

GitHub Actions automates the project workflow.
>>>>>>> e34e3dd (Added CI/CD)

**CI** checks:

* Python runner/version
* Bash syntax

**CD** delivers a packaged version of the project after the workflow trigger.

```text
Push
 ↓
CI Checks
 ↓
CD
 ↓
Release Package 📦
```

## Usage

```bash
./pomodoro.sh
```

Custom timer:

```bash
./pomodoro.sh 25 5 4
```

Enable logging:

```bash
./pomodoro.sh 25 5 4 --log
```

Silent mode:

```bash
./pomodoro.sh 25 5 4 --silent
```

## Runtime Controls

| Key      | Action     |
| -------- | ---------- |
| `h`      | Show help  |
| `Ctrl+C` | Stop timer |

## Logging

When logging is enabled:

```text
logs/session-YYYY-MM-DD.log
```

## Requirements

* Python 3
* Bash
* Linux/macOS
* `notify-send` for Linux desktop notifications (optional)

## Version

Current version: **v1.0.1**

See [CHANGELOG.md](CHANGELOG.md) for release history.

## License

MIT
