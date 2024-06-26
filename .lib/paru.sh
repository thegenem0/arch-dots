#!/bin/bash

_installParu() {
	if command -v paru >/dev/null 2>&1; then
		echo ":: Paru already installed, skipping..."
	else
		echo ":: Cloning paru..."
		git clone https://aur.archlinux.org/paru.git
		cd paru

		echo ":: Installing paru..."
		makepkg -si

		echo ":: Cleanup..."
		cd .. && rm -rf paru
	fi
}
