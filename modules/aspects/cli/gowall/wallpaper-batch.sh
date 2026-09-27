#!/bin/bash
set -euo pipefail

DEFAULT_INPUT_DIR="$HOME/Pictures/Wallpapers"
DEFAULT_OUTPUT_BASE="$HOME/Pictures"

theme_name="$1"
input_dir="${2:-$DEFAULT_INPUT_DIR}"

# Find smallest image for preview
first_img=$(find "$input_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.avif" \) -exec du -b {} + 2>/dev/null | sort -n | head -n1 | cut -f2-) || true

if [ -n "$first_img" ]; then
  echo "Previewing theme '$theme_name' on $(basename "$first_img")..."
  gowall convert "$first_img" -t "$theme_name"

read -r -p "Apply this theme to all images? (y/N): " confirm

  if [ ! "$confirm" = "y" ] && [ ! "$confirm" = "Y" ]; then
    echo "Cancelled."
    exit 0
  fi
fi

# Set output folder name
folder_name=$(echo "$theme_name" | sed 's/ /-/g; s/[()]//g')
output_dir="$DEFAULT_OUTPUT_BASE/Wallpaper-$folder_name"
gowall convert --dir "$input_dir" --output "$output_dir" -t "$theme_name"
