#!/bin/bash

source "$(dirname "$0")/config.sh"

# Check if the flag file exists
if [ -f "$FLAG_FILE" ]; then
    echo "Config files have already been installed.\n This is meant to be run on a fresh system."
    exit 0
fi

if sudo -v; then
    echo "Beginning installation..."
else
    echo "Authentication failed. Exiting..."
    exit 1
fi

#### Check for yay ####
echo "Checking Paru..."

if command -v paru >/dev/null 2>&1; then
    echo "Paru already installed, skipping..."
else
    echo "Cloning paru..."
    git clone https://aur.archlinux.org/paru.git
    cd paru

    echo "Installing paru..."
    makepkg -si

    echo "Paru Cleanup..."
    cd .. && rm -rf paru
fi

### Use wifi?
read -n1 -rep 'Do you intend to use WiFi? (y,n) ' USE_WIFI
echo

### Disable WiFi powersave?
if [[ $USE_WIFI == "Y" || $USE_WIFI == "y" ]]; then
    read -n1 -rep 'Would you like to disable WiFi powersave? (y,n) ' WIFI
    echo
    
    if [[ $WIFI == "Y" || $WIFI == "y" ]]; then
        LOC="/etc/NetworkManager/conf.d/wifi-powersave.conf"
        echo -e "The following has been added to $LOC.\n"
        echo -e "[connection]\nwifi.powersave = 2" | sudo tee -a $LOC
        echo -e "\n"
        echo -e "Restarting NetworkManager service...\n"
        sudo systemctl restart NetworkManager
        sleep 3
    fi
else
    echo "WiFi will not be used. Skipping WiFi configuration."
fi

### Install all of the above pacakges ####
read -n1 -rep 'Would you like to install the packages? (y,n)' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
    paru -S --noconfirm "${packages[@]}"

    # Start the bluetooth service
    echo -e "Starting the Bluetooth Service...\n"
    sudo systemctl enable --now bluetooth.service
    sleep 2
    
    # Clean out other portals
    echo -e "Cleaning out conflicting xdg portals...\n"
    paru -R --noconfirm xdg-desktop-portal-gnome xdg-desktop-portal-gtk
fi

### Symlink Config Files ###
read -n1 -rep 'Would you like to symlink config files? (y,n) ' CFG
echo
if [[ $CFG == "Y" || $CFG == "y" ]]; then
    echo -e "Creating symlinks for config files...\n"
    for dir in "${xdg_config_dirs[@]}"; do
        ln -s "$(pwd)/$dir" ~/.config/
        echo "Symlinked $dir"
    done

    for file in "${extra_config_files[@]}"; do
        ln -s "$(pwd)/$file" ~/.config/
        echo "Symlinked $file"
    done
    
    # Set some files as executable
    chmod +x ~/.config/hypr/xdg-portal-hyprland
    chmod +x ~/.config/waybar/scripts/waybar-wttr.py
fi

### Set zsh as the default shell ###
read -n1 -rep 'Would you like to set zsh as the default shell? (y,n) ' SET_ZSH
echo
if [[ $SET_ZSH == "Y" || $SET_ZSH == "y" ]]; then
    echo -e "Setting zsh as the default shell...\n"
    chsh -s $(which zsh)
    echo -e "zsh has been set as the default shell.\n"

    read -n1 -rep 'Would you like to set zsh as the sudo shell as well? (y,n) ' SET_SUDO_ZSH
    echo
    if [[ $SET_SUDO_ZSH == "Y" || $SET_SUDO_ZSH == "y" ]]; then
        echo -e "Setting zsh as the sudo shell...\n"
        sudo chsh -s $(which zsh)
        echo -e "zsh has been set as the sudo shell.\n"
    fi
fi

### Script is done ###
touch "$FLAG_FILE"
echo -e "Script had completed. Flag file created at $FLAG_FILE."
echo -e "You can start Hyprland by typing Hyprland (note the capital H).\n"
read -n1 -rep 'Would you like to start Hyprland now? (y,n)' HYP
if [[ $HYP == "Y" || $HYP == "y" ]]; then
    exec Hyprland
else
    exit
fi
