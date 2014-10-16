#!/usr/bin/env bash
#
# bootstrap
#
# Install and configure full environment
#
set -e

echo "Dotfiles"

# scripts enabled
declare -a sources=(
    brew
    git
    zsh
)

# run scripts enabled
for src in "${sources[@]}"
do
    script="scripts/${src}.sh"
    if [[ -f  $script ]]; then
        source $script
    fi
done

echo "Done."