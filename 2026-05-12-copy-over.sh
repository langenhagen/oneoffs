#!/usr/bin/env bash
# Recursively copy a directory to a destination as a backup.
set -euo pipefail

src="$HOME/Downloads/m/"
dst=  # implement

time rsync \
  -aHAX \
  --info=progress2 \
  --partial \
  --append-verify \
  --numeric-ids \
  --delete-delay \
  --human-readable \
  --mkpath \
  --exclude='.venv/' \
  --exclude='venv/' \
  --exclude='__pycache__/' \
  --exclude='*.pyc' \
  --exclude='.mypy_cache/' \
  --exclude='.pytest_cache/' \
  --exclude='.ruff_cache/' \
  --exclude='node_modules/' \
  "$src" "$dst"
