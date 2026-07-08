#!/bin/bash
# Find all audio files under the current directory, get their duration using `ffprobe`, and print
# the duration and filename if duration > certain amount of seconds.
#
# author: andreasl

cd "$HOME/Media/Audio/Hörbücher" || exit 1

min_duration_seconds=3300

find . \
    -type f \
    \( -iname "*.mp3" -o -iname "*.wav" -o -iname "*.flac" -o -iname "*.m4a" -o -iname "*.opus" \) \
    -exec bash -c '
    min_duration="$1"
    shift
    for f; do
        dur=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$f")
        awk -v duration="$dur" -v filename="$f" -v min="$min_duration" "BEGIN { if (duration > min) print duration, filename }"
    done
  ' _ "$min_duration_seconds" {} +

# last line explainer:
# _: placeholder for $0 in bash -c. Prevents first filename from being used as $0 (script name).
# "$min_duration_seconds": pass the variable to the inner script
# {}: replaced by found file paths by find.
# +: pass all found files at once (batch) to the command, not one by one.

# awk explainer
# -v set a variable into the awk program
# BEGIN in awk runs the code block once, before reading any input lines. Used here to execute a
#   conditional print without reading any lines from stdin

# ffprobe command explainer
# -v error: only print errors; suppress normal/log output.
# -show_entries format=duration: only show the duration field from the file's format section.
# -of default=noprint_wrappers=1:nokey=1:  output format
#     - noprint_wrappers=1: don't print section headers/footers
#     - nokey=1: don't print "duration=", just the value
