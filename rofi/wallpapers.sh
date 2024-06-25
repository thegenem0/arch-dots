#!/bin/bash

_setWallpaper() {
	wallpaper_path="$1";

	if [ -L "${HOME}/.config/.current_wallpaper" ]; then
	   rm "${HOME}/.config/.current_wallpaper"
	fi

	ln -s "$wallpaper_path" "${HOME}/.config/.current_wallpaper"

	blurred_wallpaper="${HOME}/.config/.blurred_wallpaper"

	if [ -f "$blurred_wallpaper" ]; then
	   rm "$blurred_wallpaper"
	fi

	# Apply a blur effect using ImageMagick
	magick "$wallpaper_path" -blur 0x8 "$blurred_wallpaper"

	$HOME/.config/wallust/start_theme.sh
}

# Set some variables
wall_dir="${HOME}/wallpapers"
rofi_theme="${HOME}/.config/rofi/wallpapers.rasi"

selected=$( find "$wall_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | sort -R | while read rfile
    do
        echo -en "$rfile\x00icon\x1f$wall_dir/${rfile}\n"
    done | rofi -dmenu -i -replace -config ${rofi_theme})
    if [ ! "$selected" ]; then
        echo "No wallpaper selected"
        exit
    fi

# Set the wallpaper
if [ -n "$selected" ]; then
    _setWallpaper "$wall_dir/$selected"    
else
    exit 1
fi

exit 0
