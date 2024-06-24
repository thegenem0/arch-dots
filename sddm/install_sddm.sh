#!/bin/bash

_installSddm() {
	paru -S --noconfirm sddm --ask 4
	sudo systemctl enable sddm.service
}


_installSddmTheme() {
	# Create sddm.conf.d folder
	if [ ! -d /etc/sddm.conf.d/ ]; then
		sudo mkdir /etc/sddm.conf.d
		echo ":: Folder /etc/sddm.conf.d created."
	fi


	sudo cp "${HOME}/.dotfiles/sddm/sddm.conf" /etc/sddm.conf.d/
	echo ":: File /etc/sddm.conf.d/sddm.conf updated."


	# Download and install sugar candy theme if not exists
	if [ ! -d /usr/share/sddm/themes/sugar-candy ]; then
		if [ -f ~/Downloads/sddm-sugar-candy-master.zip ] ;then
			rm ~/Downloads/sddm-sugar-candy-master.zip
		fi
		
		wget -P ~/Downloads/ https://framagit.org/MarianArlt/sddm-sugar-candy/-/archive/master/sddm-sugar-candy-master.zip

		if [ -f ~/Downloads/sddm-sugar-candy-master.zip ] ;then
		    unzip -o -q ~/Downloads/sddm-sugar-candy-master.zip -d ~/Downloads/
		    if [ ! -d /usr/share/sddm/themes/sugar-candy ] ;then
			sudo mkdir -p /usr/share/sddm/themes/sugar-candy
		    fi
		    sudo cp -r ~/Downloads/sddm-sugar-candy-master/* /usr/share/sddm/themes/sugar-candy
		    echo ":: SDDM Sugar Candy Theme installed"
		else
		    echo "ERROR: Sugar Candy Download not found"
		fi
	fi    


	if [ -f /usr/share/sddm/themes/sugar-candy/theme.conf ]; then
		sudo cp "${HOME}/.config/.current_wallpaper" /usr/share/sddm/themes/sugar-candy/Backgrounds/current_wallpaper.jpg
		echo ":: Wallpaper copied into /usr/share/sddm/themes/sugar-candy/Backgrounds/"

		sudo cp "${HOME}/.dotfiles/sddm/theme.conf" /usr/share/sddm/themes/sugar-candy/
		sudo sed -i 's/CURRENTWALLPAPER/'"current_wallpaper.jpg"'/' /usr/share/sddm/themes/sugar-candy/theme.conf
		echo ":: File theme.conf updated in /usr/share/sddm/themes/sugar-candy/"
	fi
}
