#!/bin/bash

source utils.sh

CURRENT_WALLPAPER=$HOME/.config/.current_wallpaper
BLURRED_WALLPAPER=$HOME/.config/.blurred_wallpaper

if [ -L "$CURRENT_WALLPAPER" ] && [ -f "$BLURRED_WALLPAPER" ]; then
	_setWallpaper $CURRENT_WALLPAPER
else
	_setWallpaper "$HOME/wallpapers/default.png"
fi
