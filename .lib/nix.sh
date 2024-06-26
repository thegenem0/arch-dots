#!/bin/bash

_installNix() {
	if command -v nix &> /dev/null; then
		echo ":: Nix is already installed. Skipping installation."
	else
		echo ":: Getting Nix installer..."
		curl --proto '=https' --tlsv1.2 -sSfL https://nixos.org/nix/install -o nix-install.sh
		chmod +x nix-install.sh

		echo ":: Installing Nix..."
		./nix-install.sh

		echo ":: Cleanup..."
		rm -rf nix-install.sh
	fi
}
