#!/bin/bash

_setDefaultZsh () {
    # Check if the current shell for the user is already zsh
    current_user_shell=$(getent passwd "$USER" | cut -d: -f7)
    current_root_shell=$(getent passwd root | cut -d: -f7)

    if [[ "$current_user_shell" == "$(which zsh)" && "$current_root_shell" == "$(which zsh)" ]]; then
        echo ":: zsh is already the default shell for both the current user and sudo."
        return
    fi

    if [[ "$current_user_shell" != "$(which zsh)" ]]; then
        echo ":: Changing default shell to zsh for the current user..."
        chsh -s "$(which zsh)"
    fi

    if [[ "$current_root_shell" != "$(which zsh)" ]]; then
        echo ":: Changing default shell to zsh for sudo..."
        sudo chsh -s "$(which zsh)"
    fi
}

_configureZsh() {
	xdg_home_dir="$1";
	dotfiles_dir="$2";

	mkdir -p "${xdg_home_dir}/.scripts"

	curl -L git.io/antigen > "${xdg_home_dir}/.scripts/antigen.zsh"

	_sym "${xdg_home_dir}/.zshrc" "${dotfiles_dir}/zsh/zshrc" "${xdg_home_dir}/.zshrc"
}

