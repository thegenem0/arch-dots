#!/bin/bash

XDG_CONFIG_DIR=$HOME/.config
DOTFILES_DIR=$HOME/.dotfiles

source .lib/utils.sh
source .lib/link.sh
source .lib/git.sh
source .lib/ssh.sh
source .lib/shell.sh
source sddm/install_sddm.sh

_installDots $HOME $XDG_CONFIG_DIR $DOTFILES_DIR

_installHyprDots $HOME $XDG_CONFIG_DIR $DOTFILES_DIR

_installSddm

_installSddmTheme

_linkGitConfig $HOME $DOTFILES_DIR "$HOME/dev/personal" "$HOME/dev/work"

_linkSSHConfig $HOME $DOTFILES_DIR

_setDefaultZsh

_configureZsh $HOME $DOTFILES_DIR
