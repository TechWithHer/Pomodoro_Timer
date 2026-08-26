#!/usr/bin/env bash
# Pomodoro Timer v1.0.0
# Author: Ayushi Singh (@TechWithHer)
# License: MIT

set -euo pipefail

VERSION="1.0.0"

# ─────────────────────────────────────────────
# Configuration
# ─────────────────────────────────────────────

WORK_MIN=25
BREAK_MIN=5
CYCLES=4

LOG_DIR="./logs"
LOG_FILE="${LOG_DIR}/session-$(date '+%Y-%m-%d').log"

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
    echo "Work   : ${WORK_MIN} minutes"
    echo "Break  : ${BREAK_MIN} minutes"
    echo "Cycles : ${CYCLES}"
    echo
}

log() {
    local message="$1"

    mkdir -p "$LOG_DIR"

    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $message" \
        >> "$LOG_FILE"
}

notify() {
    local title="$1"
    local message="$2"

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

        if [[ -t 0 ]] && read -rsn1 -t 1 key; then
            if [[ "$key" == "h" ]]; then
                echo
                show_help
            fi
        else
            sleep 1
        fi

        total_seconds=$((total_seconds - 1))
    done

    printf "\r                                                  \r"
    echo
}

# ─────────────────────────────────────────────
# Start
# ─────────────────────────────────────────────

clear

echo -e "${BLUE}Pomodoro Timer v${VERSION}${RESET}"
echo "Work: ${WORK_MIN} min | Break: ${BREAK_MIN} min | Cycles: ${CYCLES}"
echo "────────────────────────────────────────────"

log "========================================"
log "Pomodoro session started"
log "Configuration: ${WORK_MIN} min work / ${BREAK_MIN} min break / ${CYCLES} cycles"

# ─────────────────────────────────────────────
# Pomodoro Loop
# ─────────────────────────────────────────────

for ((i = 1; i <= CYCLES; i++)); do

    # Work session
    echo -e "\n${GREEN}▶ Work Session ${i}/${CYCLES}${RESET}"

    log "Work session ${i}/${CYCLES} started"

    countdown "$WORK_MIN"

    log "Work session ${i}/${CYCLES} completed"

    notify \
        "Pomodoro" \
        "Work session ${i} complete. Break time!"

    # Break
    if (( i < CYCLES )); then

        echo -e "\n${RED}💤 Break ${i}/${CYCLES}${RESET}"

        log "Break ${i} started"

        countdown "$BREAK_MIN"

        log "Break ${i} completed"

        notify \
            "Pomodoro" \
            "Break complete. Back to work!"

    fi

done

# ─────────────────────────────────────────────
# Completion
# ─────────────────────────────────────────────

echo -e "\n${YELLOW}🎉 All sessions complete. Great job!${RESET}"

notify \
    "Pomodoro" \
    "Pomodoro session complete!"

log "Pomodoro session completed successfully"
log "========================================"