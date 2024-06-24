#!/bin/bash

_linkGitConfig() {
	xdg_home_dir="$1";
	dotfiles_dir="$2";
	personal_dir="$3";
	work_dir="$4";

	mkdir -p "${personal_dir}"
	mkdir -p "${work_dir}"

	_sym "${xdg_home_dir}/.gitconfig" "${dotfiles_dir}/git/.gitconfig" "${xdg_home_dir}/.gitconfig"
	_sym "${personal_dir}/.gitconfig.personal" "${dotfiles_dir}/git/.gitconfig.personal" "${personal_dir}/.gitconfig.personal"
	_sym "${work_dir}/.gitconfig.work" "${dotfiles_dir}/git/.gitconfig.work" "${work_dir}/.gitconfig.work"
}
