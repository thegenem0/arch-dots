#!/bin/bash

_installDots() {
	xdg_home_dir="$1";
	xdg_config_dir="$2";
	dotfiles_dir="$3";

	_sym "${xdg_config_dir}/dunst" "${dotfiles_dir}/dunst" "${xdg_config_dir}/dunst"
	_sym "${xdg_config_dir}/kitty" "${dotfiles_dir}/kitty" "${xdg_config_dir}/kitty"
	_sym "${xdg_config_dir}/rofi" "${dotfiles_dir}/rofi" "${xdg_config_dir}/rofi"
	_sym "${xdg_config_dir}/scripts" "${dotfiles_dir}/scripts" "${xdg_config_dir}/scripts"
	_sym "${xdg_config_dir}/wallust" "${dotfiles_dir}/wallust" "${xdg_config_dir}/wallust"
	_sym "${xdg_config_dir}/waybar" "${dotfiles_dir}/waybar" "${xdg_config_dir}/waybar"
	_sym "${xdg_config_dir}/wlogout" "${dotfiles_dir}/wlogout" "${xdg_config_dir}/wlogout"
	_sym "${xdg_config_dir}/fastfetch" "${dotfiles_dir}/fastfetch" "${xdg_config_dir}/fastfetch"
	_sym "${xdg_config_dir}/starship.toml" "${dotfiles_dir}/starship/starship.toml" "${xdg_config_dir}/starship.toml"


	_sym "${xdg_config_dir}/gtk-3.0" "${dotfiles_dir}/gtk/gtk-3.0" "${xdg_config_dir}/gtk-3.0"
	_sym "${xdg_config_dir}/xsettingsd" "${dotfiles_dir}/gtk/xsettingsd" "${xdg_config_dir}/xsettingsd"
	_sym "${xdg_home_dir}/.gtkrc-2.0" "${dotfiles_dir}/gtk/.gtkrc-2.0" "${xdg_home_dir}/.gtkrc-2.0"
	_sym "${xdg_home_dir}/.icons" "${dotfiles_dir}/gtk/.icons" "${xdg_home_dir}/.icons"
	_sym "${xdg_home_dir}/.ideavimrc" "${dotfiles_dir}/idea/ideavimrc" "${xdg_home_dir}/.ideavimrc"
}

_installHyprDots() {
	mkdir -p "${xdg_config_dir}/hypr"
	_sym "${xdg_config_dir}/hypr" "${dotfiles_dir}/hypr" "${xdg_config_dir}/hypr"
}



