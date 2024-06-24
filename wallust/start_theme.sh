#!/bin/bash

if pgrep -x "swww-daemon" > /dev/null; then
    echo "swww-daemon is already running"
else
    echo "Starting swww-daemon"
    swww-daemon &
    sleep 0.5
fi

# Get the full path of the provided wallpaper
wallpaper=$HOME/.config/.current_wallpaper

# Use wallust to generate and apply the color scheme
wallust run "$wallpaper"

# Restart services that rely on wallust colors
~/.config/waybar/launch.sh

# Set the wallpaper using swww
swww img "$wallpaper" --transition-type=wipe --transition-duration=0.7

# Notify the user
dunstify "Wallpaper changed!" "New wallpaper set: $(basename "$wallpaper")"
