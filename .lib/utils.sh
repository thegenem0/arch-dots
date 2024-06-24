#!/bin/bash

### Utilities imported by other scripts

_sym() {
    symlink="$1"
    linksource="$2"
    linktarget="$3"
    
    if [ -L "${symlink}" ]; then
        rm "${symlink}"
        ln -s "${linksource}" "${linktarget}"
        echo ":: Symlink ${linksource} -> ${linktarget} created."
    elif [ -d "${symlink}" ]; then
        rm -rf "${symlink}"
        ln -s "${linksource}" "${linktarget}"
        echo ":: Symlink for directory ${linksource} -> ${linktarget} created."
    elif [ -f "${symlink}" ]; then
        rm "${symlink}"
        ln -s "${linksource}" "${linktarget}"
        echo ":: Symlink to file ${linksource} -> ${linktarget} created."
    else
        ln -s "${linksource}" "${linktarget}"
        echo ":: New symlink ${linksource} -> ${linktarget} created."
    fi
}

_copyWallpapers() {
	mkdir -p "$HOME/wallpapers"

	cp -r "$HOME/.dotfiles/wallpapers/*" "$HOME/wallpapers"
}
