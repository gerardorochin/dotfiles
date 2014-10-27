#!/usr/bin/env bash
#
# bootstrap
#
# Install and configure full environment
#
set -e
sudo -v
clear

echo -e "* Dotfiles\n"

# scripts enabled
declare -a sources=(
    brew
    git
    zsh
    vim
)

# run scripts enabled
for src in "${sources[@]}"
do
    script="scripts/${src}.sh"
    if [[ -f  $script ]]; then
        . $script $1
    fi
done

echo "** Done."
