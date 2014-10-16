#!/usr/bin/env bash
#
# bootstrap
#
# Install and configure full environment
#
set -e

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
        source $script
    fi
done

echo "** Done."