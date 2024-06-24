#!/bin/bash

_setDefaultZsh () {
	sudo pacman -Syu --noconfirm zsh

	echo ":: Changing default shell to zsh for the current user..."
	chsh -s $(which zsh)

	echo ":: Changing default shell to zsh for sudo..."
	sudo chsh -s $(which zsh)
}

_configureZsh() {
	xdg_home_dir="$1";
	dotfiles_dir="$2";

	sudo pacman -Syu --noconfirm atuin zoxide exa fzf

	mkdir -p "${xdg_home_dir}/.scripts"

	curl -L git.io/antigen > "${xdg_home_dir}/.scripts/antigen.zsh"

	_sym "${xdg_home_dir}/.zshrc" "${dotfiles_dir}/zsh/zshrc" "${xdg_home_dir}/.zshrc"
}

