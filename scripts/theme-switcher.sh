#!/bin/bash
set -euox pipefail

now=$(date +%H)

if [[ $now -ge 6 ]] && [[ $now -lt 21 ]]; then
    echo "Switching to light theme"
    gsettings set org.gnome.desktop.interface color-scheme default
    gsettings set org.gnome.desktop.interface gtk-theme Yaru-olive
else
    echo "Switching to dark theme"
    gsettings set org.gnome.desktop.interface color-scheme prefer-dark
    gsettings set org.gnome.desktop.interface gtk-theme Yaru-olive-dark
fi
