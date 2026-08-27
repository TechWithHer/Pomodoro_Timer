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
=======
## CI/CD

GitHub Actions automates the project workflow.

**CI** checks:

* Python runner/version
* Bash syntax

**CD** delivers a packaged version of the project after the workflow trigger.

```text
Feature branch
      ↓
Push to GitHub
      ↓
Open Pull Request → main
      ↓
CI runs automatically
      ↓
CI passes ✅
      ↓
Code review by reviewer
      ↓
Reviewer approves ✅
      ↓
Manual merge to main
      ↓
Push to main triggers CI again
      ↓
Main branch validation ✅
```

## Usage

```text
python app.py
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

Current version: **v1.0.2**

- See [CHANGELOG.md](CHANGELOG.md) for release history.

- [Project Documentation and related Projects](https://ayushisingh.notion.site/Projects-Documentation-3c7df188b81e807a9e4ee0d1ff36c7d5?source=copy_link)

## License

MIT


## Related Projects

This project is part of the **DevOps Learning Journey** by TechWithHer. Explore the complete course and project series:

[DevOps Learning Journey — TechWithHer](https://ayushisingh.notion.site/Learn-Complete-DevOps-with-TechWithHer-d60df188b81e8221a5570156f5f8b477?source=copy_link)

