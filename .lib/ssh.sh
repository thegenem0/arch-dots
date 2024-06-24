#!/bin/bash

_linkSSHConfig() {
	xdg_home_dir="$1";
	dotfiles_dir="$2";

	mkdir -p "${xdg_home_dir}/.ssh"

	_sym "${xdg_home_dir}/.ssh/config" "${dotfiles_dir}/ssh/config" "${xdg_home_dir}/.ssh/config"
}
