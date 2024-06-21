# config.sh

$FLAG_FILE="$HOME/.config_install_done"

# Packages to install
packages=(
    hyprland
    kitty
    waybar
    swww
    hyprlock
    hypridle
    wofi
    nwg-displays
    wlogout
    dunst
    thunar
    ttf-jetbrains-mono-nerd
    noto-fonts-emoji
    polkit-gnome
    starship
    swappy
    grim
    slurp
    pamixer
    brightnessctl
    gvfs
    bluez
    bluez-utils
    lxappearance
    xfce4-settings
    dracula-gtk-theme
    dracula-icons-git
    xdg-desktop-portal-hyprland
)


# Configuration directories
xdg_config_dirs=(
    hypr
    kitty
    dunst
    waybar
    hyprlock
    wofi
)

# Extra configuration files
extra_config_files=(
    starship.toml
)

