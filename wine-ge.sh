#!/bin/bash
installedver=$(cat /home/$USER/.local/share/lutris/runners/wine/version)
releasever=$(curl --silent "https://api.github.com/repos/GloriousEggroll/wine-ge-custom/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")' | cut -d'v' -f2)
filename=$(curl --silent "https://api.github.com/repos/GloriousEggroll/wine-ge-custom/releases/latest" | grep -Po '"name": "\K.*?(?=")' | tail -n1)

if [ $installedver != $releasever ]; then
    echo "Wine GE: téléchargement de la version $releasever ..."
    wget -q https://github.com/GloriousEggroll/wine-ge-custom/releases/download/$releasever/$filename
    tar -xf $filename
    cp -r lutris-ge-* /home/$USER/.local/share/lutris/runners/wine/
    rm $filename
    rm -rf lutris-ge-*
    echo "$releasever" > /home/$USER/.local/share/lutris/runners/wine/version
    echo "Wine GE: mis à jour vers $releasever"
else
    echo "Wine GE: déjà à jour ($installedver)"
fi