#!/bin/bash
set -e

src_dir="${HOME}/Downloads"
dest_dir="${HOME}/Downloads/selection/unwatered"

counter=$(($(ls "$dest_dir" | wc -l) + 1))

# move/rename downloaded files to dest dir
for file in "$src_dir"/wmremove-transformed*.jpeg; do
    [ -e "$file" ] || exit 1
    newfilename=$(printf "%03d.jpeg" "$counter")
    mv "$file" "$dest_dir/$newfilename"
    ((counter++))
done

# remove files from to-unwater
to_unwater_dir="${HOME}/Downloads/selection/to-unwater"
processed_dir="${HOME}/Downloads/selection/processed"
mapfile -t files < <(find "$to_unwater_dir" -maxdepth 1 -type f -name "*.jpg" | sort | head -n 2)
for file in "${files[@]}"; do
    [ -e "$file" ] && mv "$file" "$processed_dir"
done

# show the unwatered & remaining files stats
set -x
ls "$dest_dir" | wc -l
ls "$HOME/Downloads/selection/to-unwater/" | wc -l
