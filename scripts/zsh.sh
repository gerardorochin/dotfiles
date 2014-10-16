#!/usr/bin/env bash
#
# zsh
#
# http://www.zsh.org/
# Zsh is a shell designed for interactive use, although it is also a powerful scripting language
#
set -e

echo "Zsh"

# check for zsh
if test $(which zsh)
then
    # Oh my zsh 
    # http://ohmyz.sh/
    # framework for managing your ZSH configuration.
    if [[ ! -d ~/.oh-my-zsh ]]; then
        echo "Installing Oh my zsh:"
        curl -L http://install.ohmyz.sh | sh

        # config dir
        if [[ -d ../configs ]]; then
            zshrc=../configs/zshrc
        else
            zshrc=configs/zshrc
        fi

        # .zshrc file
        if [[ -f  $zshrc ]]; then
            cp -f $zshrc ~/.zshrc
        fi
    else
        echo "Oh my zsh is already installed"
    fi
    echo -e "Done\n"
else
    echo "zsh not installed"
fi