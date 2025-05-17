#!/bin/bash
# Backup, uninstall and reinstall `FreeTube` via `flatpak`.
#
# Didn't need the backup the first time but better safe than sorry.
#
# See also: https://docs.freetubeapp.io/usage/data-location/

# -a: retain timestamps + owners, implies -r aka recursive; -h: human friendly output, -v: verbose; --delete: non-existing files
rsync -ahv --delete "$HOME/.var/app/io.freetubeapp.FreeTube/config/FreeTube/" "$HOME/Desktop/freetube-backup"

flatpak uninstall io.freetubeapp.FreeTube

flatpak install io.freetubeapp.FreeTube -y
