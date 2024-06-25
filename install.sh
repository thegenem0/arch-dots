#!/bin/bash

XDG_CONFIG_DIR=$HOME/.config
DOTFILES_DIR=$HOME/.dotfiles

source .lib/utils.sh
source .lib/link.sh
source .lib/git.sh
source .lib/ssh.sh
source .lib/shell.sh
source .lib/nvim.sh
source .lib/docker.sh
source sddm/install_sddm.sh

source packages/pacman_packages.sh
source packages/aur_packages.sh

_pacmanInstall wmPackages fonts systemPackages langs cliTools

_aurInstall aurPackages

_installDots $HOME $XDG_CONFIG_DIR $DOTFILES_DIR

_installHyprDots $HOME $XDG_CONFIG_DIR $DOTFILES_DIR

_installSddm

_installSddmTheme

_linkGitConfig $HOME $DOTFILES_DIR "$HOME/dev/personal" "$HOME/dev/work"

_linkSSHConfig $HOME $DOTFILES_DIR

_setDefaultZsh

_configureZsh $HOME $DOTFILES_DIR

_configureNvim $XDG_CONFIG_DIR $DOTFILES_DIR

_setupDocker

_copyWallpapers
