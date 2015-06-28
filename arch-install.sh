#!/bin/bash

echo "================================================="
echo "This script installs my Arch Linux Default system"
echo "Make sure you run with elevated rights!"
echo "================================================="
echo ""
echo -n "Proceed with installation? [Y/n] "
read answer

function install {
    # update base install first
    pacman -Syyu --noconfirm

    # File transfer
    pacman -S wget curl --noconfirm

    # Install yaourt
    base=$(pacman -Qs base-devel)
    if [[ $base == "" ]]; then
        pacman -S base-devel
    fi
    echo "Retrieving package-query and yaourt..."
    curl -O https://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz
    curl -O https://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz
    echo "Uncompressing package-query and yaourt..."
    tar zxvf package-query.tar.gz
    tar zxvf yaourt.tar.gz
    echo "Installing package-query and yaourt..."
    cd package-query
    makepkg -si --noconfirm
    cd ..
    cd yaourt
    makepkg -si --noconfirm
    echo "Removing installers..."
    cd ..
    rm -r package-query.tar.gz yaourt.tar.gz package-query yaourt

    #Installing Desktop and start on tty1"
    pacman -S cinnamon nemo nemo-fileroller
    echo "[[ -z \$DISPLAY && \$XDG_VTNR -eq 1 ]] && exec startx" >> ~/.bashrc

    # Compression
    pacman -S zip unzip --noconfirm
    # Media player
    pacman -S vlc --noconfirm
    # Programming
    pacman -S base-devel python-virtualenv nodejs npm --noconfirm
    # Web browser
    pacman -S chromium
    yaourt -S chromium-pepper-flash
    # Graphics
    pacman -S tiled
    yaourt -S aseprite

    # AUR packages

    # Progamming IDEs
    yaourt -S intellij-idea-community-edition atom-editor --noconfirm
}

if [[ $answer == "Y" || $answer == "y" || $answer == "" ]]; then
    install
else
    echo "Exiting..."
    exit 1
fi
