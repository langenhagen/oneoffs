#!/usr/bin/env bash
#
# Download videos from multiple YouTube channels using yt-dlp.
#
# Behavior:
# - Each yt-dlp invocation runs as a child process.
# - Pressing Ctrl+C (SIGINT) does NOT terminate the whole script.
# - Instead, the signal is intercepted and forwarded only to the currently
#   running yt-dlp process.
# - After interruption, the script continues with the next download task.
#
# Pattern explanation:
# - A global variable `current_pid` tracks the active child process.
# - A SIGINT trap (`trap handle_sigint INT`) overrides default Bash behavior.
# - The handler sends SIGINT specifically to the child (`kill -INT $current_pid`).
# - Each command is executed in the background via `run()`, which:
#     1. starts the command (`&`)
#     2. stores its PID
#     3. waits for it to finish (`wait`)
# - Because Bash itself does not receive the terminating SIGINT (it's handled),
#   the script continues execution instead of exiting.
#
# Optional extension:
# - Implement "double Ctrl+C to exit" by tracking interrupt state.

set -euo pipefail

current_pid=""

handle_sigint() {
    if [[ -n "${current_pid}" ]]; then
        kill -INT "${current_pid}" 2>/dev/null || true
    fi
}

trap handle_sigint INT

run() {
    "$@" &
    current_pid=$!
    wait "${current_pid}"
    current_pid=""
}

dl() {
    dir="$1"
    url="$2"

    cd "$dir"
    run yt-dlp \
        -f 'bv*[vcodec^=avc1][height<=1080]+ba[acodec^=mp4a]/b[ext=mp4]' \
        --merge-output-format mp4 \
        --ignore-errors \
        --no-overwrites \
        --output '%(autonumber)s-%(title)s.%(ext)s' \
        "$url"
    cd ..
}

dl pancreas 'https://www.youtube.com/@pancreasnowork9939/videos'
dl bones 'https://www.youtube.com/@pancreasnowork9939/videos'
dl amber 'https://www.youtube.com/@TheAmberKing/videos'
