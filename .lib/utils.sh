#!/bin/bash

### Utilities imported by other scripts

_sym() {
    symlink="$1"
    linksource="$2"
    linktarget="$3"
    
    if [ -L "${symlink}" ]; then
        rm "${symlink}"
        ln -s "${linksource}" "${linktarget}"
        echo ":: Symlink ${linksource} -> ${linktarget} created."
    elif [ -d "${symlink}" ]; then
        rm -rf "${symlink}"
        ln -s "${linksource}" "${linktarget}"
        echo ":: Symlink for directory ${linksource} -> ${linktarget} created."
    elif [ -f "${symlink}" ]; then
        rm "${symlink}"
        ln -s "${linksource}" "${linktarget}"
        echo ":: Symlink to file ${linksource} -> ${linktarget} created."
    else
        ln -s "${linksource}" "${linktarget}"
        echo ":: New symlink ${linksource} -> ${linktarget} created."
    fi
}

_copyWallpapers() {
	cp -r "$HOME/.dotfiles/wallpapers" "$HOME"
}


_checkPacman() {
    package="$1";
    check="$(sudo pacman -Qs --color always "${package}" | grep "local" | grep "${package} ")";
    if [ -n "${check}" ] ; then
        echo 0; #'0' means 'true' in Bash
        return; #true
    fi;
    echo 1; #'1' means 'false' in Bash
    return; #false
}

_checkAur() {
    package="$1";
    check="$(paru -Qs --color always "${package}" | grep "local" | grep "\." | grep "${package} ")";
    if [ -n "${check}" ] ; then
        echo 0; #'0' means 'true' in Bash
        return; #true
    fi;
    echo 1; #'1' means 'false' in Bash
    return; #false
}

_pacmanInstall() {
    toInstall=();
    
    # Iterate over each argument, which is expected to be the name of a package array
    for category in "$@"; do

        eval "packages=(\"\${${category}[@]}\")"
        echo "PACKAGES: ${packages[@]}"
        
        echo "Installing packages in category: ${category}"
        for pkg in "${packages[@]}"; do
            if [[ $(_checkPacman "${pkg}") == 0 ]]; then
                echo ":: ${pkg} is already installed."
                continue;
            fi;
            toInstall+=("${pkg}")
        done
    done

    if [[ "${#toInstall[@]}" -eq 0 ]] ; then
        echo "All packages are already installed."
        return
    fi

    sudo pacman --noconfirm -S "${toInstall[@]}"
}

_aurInstall() {
    toInstall=();
    
    # Iterate over each argument, which is expected to be the name of a package array
    for category in "$@"; do

        eval "packages=(\"\${${category}[@]}\")"
        echo "PACKAGES: ${packages[@]}"
        
        echo "Installing packages in category: ${category}"
        for pkg in "${packages[@]}"; do
            if [[ $(_checkAur "${pkg}") == 0 ]]; then
                echo ":: ${pkg} is already installed."
                continue;
            fi;
            toInstall+=("${pkg}")
        done
    done

    if [[ "${#toInstall[@]}" -eq 0 ]] ; then
        echo "All packages are already installed."
        return
    fi

    paru --noconfirm -S "${toInstall[@]}"
}

