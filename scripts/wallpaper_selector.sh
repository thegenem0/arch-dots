#!/bin/bash

source utils.sh

# Directory containing your wallpapers
wallpaper_folder="${HOME}/wallpapers"

echo "WALLPAPER_FOLDER: $wallpaper_folder"

# Check if the wallpaper directory exists
if [ ! -d "$wallpaper_folder" ]; then
    echo "Error: Wallpaper directory not found - $wallpaper_folder"
    exit 1
fi

# List wallpapers with paths and icons
entries=$(ls "$wallpaper_folder" | while read -r wallpaper; do
    wallpaper_path="${wallpaper_folder}/${wallpaper}"
    echo -e "${wallpaper}"
done)

# Select wallpaper using rofi
selected_entry=$(echo -e "$entries" | rofi -dmenu -markup-rows -p "Select Wallpaper" -show-icons)

# Extract the wallpaper path
selected_wallpaper=$(echo "$selected_entry" | awk '{print $1}')

# Check if a wallpaper was selected
if [ -z "$selected_wallpaper" ]; then
    echo "No wallpaper selected"
    exit 1
fi

echo "Selected wallpaper: $selected_wallpaper"

_setWallpaper "$wallpaper_folder/$selected_wallpaper"
