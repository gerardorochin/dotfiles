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

    if [[ $1 -eq "-f" ]]; then
        echo "Force mode"
        echo "Removing of oh-my-zsh if exists!"
        rm -fdR ~/.oh-my-zsh
    fi

    if [[ ! -d ~/.oh-my-zsh ]]; then
        echo "Installing Oh my zsh:"
        curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
        # zshrc file
        ln -sfn ~/.dotfiles/configs/zshrc ~/.zshrc
        source ~/.zshrc
        git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    else
        echo "Oh my zsh is already installed"
    fi
    echo -e "Done\n"
else
    echo -e "zsh not installed\n"
fi
