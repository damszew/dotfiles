#!/usr/bin/env sh
set -eu

install_file() {
    local file_name=${1}
    local dot_file=${HOME}/.${file_name}

    if [ -f ${dot_file} ] # FILE exists and is a regular file
    then
        local backup_file=${dot_file}_backup
        echo "'${dot_file}' already exists! Creating backup -> '${backup_file}'"
        mv ${HOME}/${dot_file} ${HOME}/${backup_file}
    fi

    if [ -L ${dot_file} ] # FILE exists and is a symbolic link
    then 
        echo "Overwritting old symlink - Created new symlink '${dot_file} -> ${HOME}/dotfiles/${file_name}'"
        ln -sf ${HOME}/dotfiles/${file_name} ${dot_file}
    fi

    if [ ! -e ${dot_file} ] # NOT - FILE exists
    then 
        echo "Created new symlink '${dot_file} -> ${HOME}/dotfiles/${file_name}'"
        ln -sf ${HOME}/dotfiles/${file_name} ${dot_file}
    fi
}


if [ "$(pwd)" != "${HOME}/dotfiles" ]
then
    echo "This repository must be placed in ${HOME}/dotfiles'"
    exit 1
fi

echo "Installing dotfiles\n"
install_file bashrc
install_file zshrc
install_file gitconfig
install_file gitignore

