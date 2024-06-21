#!/bin/bash

source "$(dirname "$0")/config.sh"

# Check if the flag file exists
if [ ! -f "$FLAG_FILE" ]; then
    echo "Configuration has not been applied. Nothing to clean up."
    exit 0
fi

# Prompt for sudo at the beginning
if sudo -v; then
    echo "Beginning cleanup..."
else
    echo "Authentication failed. Exiting..."
    exit 1
fi

### Remove symlinks for config directories ###
echo -e "Removing symlinks for config directories...\n"
for dir in "${xdg_config_dirs[@]}"; do
    if [ -L "$HOME/.config/$dir" ]; then
        rm "$HOME/.config/$dir"
        echo "Removed symlink $HOME/.config/$dir"
    else
        echo "Symlink $HOME/.config/$dir does not exist. Skipping..."
    fi
done

### Remove symlinks for extra config files ###
echo -e "Removing symlinks for extra config files...\n"
for file in "${extra_config_files[@]}"; do
    if [ -L "$HOME/.config/$file" ]; then
        rm "$HOME/.config/$file"
        echo "Removed symlink $HOME/.config/$file"
    else
        echo "Symlink $HOME/.config/$file does not exist. Skipping..."
    fi
done

### Re-enable WiFi powersave if it was disabled ###
LOC="/etc/NetworkManager/conf.d/wifi-powersave.conf"
if [ -f "$LOC" ]; then
    echo -e "Removing WiFi powersave configuration...\n"
    sudo rm "$LOC"
    echo -e "Restarting NetworkManager service...\n"
    sudo systemctl restart NetworkManager
    sleep 3
fi

### Restore default shell if zsh was set ###
read -n1 -rep 'Would you like to restore the default shell from zsh? (y,n) ' RESTORE_SHELL
echo
if [[ $RESTORE_SHELL == "Y" || $RESTORE_SHELL == "y" ]]; then
    echo -e "Restoring default shell for user...\n"
    chsh -s $(which bash)
    echo -e "Restored default shell for user to bash.\n"

    read -n1 -rep 'Would you like to restore the default sudo shell from zsh? (y,n) ' RESTORE_SUDO_SHELL
    echo
    if [[ $RESTORE_SUDO_SHELL == "Y" || $RESTORE_SUDO_SHELL == "y" ]]; then
        echo -e "Restoring default shell for sudo user...\n"
        sudo chsh -s $(which bash) root
        echo -e "Restored default shell for sudo user to bash.\n"
    fi
fi

### Remove the flag file ###
if [ -f "$FLAG_FILE" ]; then
    rm "$FLAG_FILE"
    echo "Removed flag file $FLAG_FILE."
fi

echo -e "Cleanup completed. Your system has been reverted to its previous state.\n"
echo -e "Note: This script does not remove any packages that were installed during the configuration process.\n"
echo -e "This is done to prevent accidental removal of packages that may be in use by other applications.\n"
echo -e "If you would like to remove the installed packages, please do so manually.\n"
