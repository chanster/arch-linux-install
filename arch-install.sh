#!/bin/bash

echo "================================================="
echo "This script installs my Arch Linux Default system"
echo "================================================="
echo ""
echo -n "Proceed with installation? [Y/n] "
read answer

function install {
    # update base install first
    pacman -Syyu --noconfirm

    #Installing Desktop and start on tty1"
    pacman -S cinnamon nemo nemo-fileroller
    echo "[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx" >> ~/.bashrc

    pacman -S wget git curl --noconfirm
    # Compression
    pacman -S zip unzip --noconfirm
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
