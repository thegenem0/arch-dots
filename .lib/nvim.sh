#!/bin/bash

_installNvimDeps() {
	sudo pacman -Sy --noconfirm neovim
}

_configureNvim() {
	xdg_config_dir="$1";
	dotfiles_dir="$2";	

	_sym "${xdg_config_dir}/nvim" "${dotfiles_dir}/nvim" "${xdg_config_dir}/nvim"
}
