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
