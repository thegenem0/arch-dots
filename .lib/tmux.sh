#!/bin/bash

_setupTmuxTpm() {
	if [ -d ~/.tmux/plugins/tpm ] ; then
		echo ":: Tmux Plugin Manager already installed, skipping..."
	else
		echo ":: Cloning tmux-plugin-manager..."
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	fi
}
