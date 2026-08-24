```bash
#!/usr/bin/env bash
# Pomodoro Timer v1.0.0
# Author: Ayushi Singh (@TechWithHer)
# License: MIT

set -euo pipefail

VERSION="1.0.0"

# ─────────────────────────────────────────────
# Defaults
# ─────────────────────────────────────────────

WORK_MIN=25
BREAK_MIN=5
CYCLES=4
LOG_ENABLED=false
SILENT_MODE=false

LOG_DIR="./logs"

# ─────────────────────────────────────────────
# Colors
# ─────────────────────────────────────────────

if [[ -t 1 ]] && command -v tput >/dev/null 2>&1; then
    RED=$(tput setaf 1)
    GREEN=$(tput setaf 2)
    YELLOW=$(tput setaf 3)
    BLUE=$(tput setaf 4)
    RESET=$(tput sgr0)
else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    RESET=""
fi

# ─────────────────────────────────────────────
# Functions
# ─────────────────────────────────────────────

show_help() {
    echo
    echo "Pomodoro Timer Help"
    echo "────────────────────────────"
    echo "h       Show this help"
    echo "Ctrl+C  Stop the timer"
    echo
    echo "Work   : $WORK_MIN minutes"
    echo "Break  : $BREAK_MIN minutes"
    echo "Cycles : $CYCLES"
    echo
}

is_positive_int() {
    [[ "$1" =~ ^[1-9][0-9]*$ ]]
}

log() {
    [[ "$LOG_ENABLED" == true ]] || return 0

    mkdir -p "$LOG_DIR"

    echo "[$(date '+%H:%M:%S')] $1" \
        >> "$LOG_DIR/session-$(date '+%Y-%m-%d').log"
}

notify() {
    local title="$1"
    local message="$2"

    [[ "$SILENT_MODE" == true ]] && return 0

    if command -v notify-send >/dev/null 2>&1; then
        notify-send "$title" "$message"
    else
        printf '\a'
    fi
}

countdown() {
    local minutes="$1"
    local total_seconds=$((minutes * 60))
    local key=""

    while (( total_seconds > 0 )); do
        printf "\r⏳ %02d:%02d remaining...  [h: help | Ctrl+C: exit]" \
            "$((total_seconds / 60))" \
            "$((total_seconds % 60))"

        key=""

        if read -rsn1 -t 1 key; then
            if [[ "$key" == "h" ]]; then
                echo
                show_help
            fi
        fi

        total_seconds=$((total_seconds - 1))
    done

    printf "\r                                                  \r"
    echo
}

# ─────────────────────────────────────────────
# Argument Parsing
# ─────────────────────────────────────────────

POSITIONAL=()

for arg in "$@"; do
    case "$arg" in
        --help|-h)
            show_help
            exit 0
            ;;
        --silent)
            SILENT_MODE=true
            ;;
        --log)
            LOG_ENABLED=true
            ;;
        *)
            POSITIONAL+=("$arg")
            ;;
    esac
done

WORK_MIN="${POSITIONAL[0]:-$WORK_MIN}"
BREAK_MIN="${POSITIONAL[1]:-$BREAK_MIN}"
CYCLES="${POSITIONAL[2]:-$CYCLES}"

# ─────────────────────────────────────────────
# Validation
# ─────────────────────────────────────────────

if ! is_positive_int "$WORK_MIN" ||
   ! is_positive_int "$BREAK_MIN" ||
   ! is_positive_int "$CYCLES"; then

    echo "${RED}Error: work, break, and cycles must be positive integers.${RESET}"
    exit 1
fi

# ─────────────────────────────────────────────
# Start Timer
# ─────────────────────────────────────────────

clear

echo -e "${BLUE}Pomodoro Timer v${VERSION}${RESET}"
echo "Work: ${WORK_MIN} min | Break: ${BREAK_MIN} min | Cycles: ${CYCLES}"
echo "Silent: ${SILENT_MODE} | Logging: ${LOG_ENABLED}"
echo "────────────────────────────────────────────"

log "Session started: ${WORK_MIN}/${BREAK_MIN}, ${CYCLES} cycles"

# ─────────────────────────────────────────────
# Pomodoro Loop
# ─────────────────────────────────────────────

for ((i = 1; i <= CYCLES; i++)); do

    echo -e "\n${GREEN}▶ Work Session ${i}/${CYCLES}${RESET}"
    log "Work session ${i} started"

    countdown "$WORK_MIN"

    notify "Pomodoro" "Work session complete. Break time!"
    log "Work session ${i} completed"

    if (( i < CYCLES )); then
        echo -e "\n${RED}💤 Break${RESET}"
        log "Break ${i} started"

        countdown "$BREAK_MIN"

        notify "Pomodoro" "Break complete. Back to work!"
        log "Break ${i} completed"
    fi

done

echo -e "\n${YELLOW}🎉 All sessions complete. Great job!${RESET}"

notify "Pomodoro" "Pomodoro session complete!"
log "Session completed successfully"
```
