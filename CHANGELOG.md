# Changelog

## [v0.1.0] - 2025-06-20
### Added
- Basic Pomodoro functionality (Work, Break, Cycle)
- Terminal output with colors
- Timer countdown using `sleep`
- `notify-send` for alerts or terminal bell as fallback

### Known Limitations
- No logging or stats
- No config file
- No CLI help or flags

## [v0.2.0] - 2025-06-21
### Added
- `--help` flag to show usage instructions
- Input validation for minutes and cycles
- Function to check positive integers

### Changed
- Improved error messages
- Cleaner Bash syntax
- Inline comments for better understanding
<<<<<<< HEAD
  
## [v1.0.0] - 2025-06-21
### Added
- Config file support via `~/.pomodoro.conf`
- `--silent` flag to disable beeps/notifications
- `--log` flag to enable logging to `logs/`
- Daily logs saved as `session-YYYY-MM-DD.log`

### Changed
- Command-line arguments override config
- Help message improved and includes defaults
=======

## [v1.0.0] - 2026-08-24
### Added
- Python wrapper and added .sh inside it.
- Simplified the code 
- Added 'h' key for quick help access

### Changed
- Improved the complexity
- Cleaned the code

## [v1.0.1] - 2026-08-24
### Added
- Added ci.yml and cd.yml for automation
- In ci.yml added: 
    - python runner version checks
    - syntax checks for .sh
- In cd.yml added:
    - delivery of a package after every trigger

### Changed
- Manual deployment to auto deployment with syntax and version checks
- Cleaned the code
