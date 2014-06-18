#!/usr/bin/env bash
set -e

echo "Dotfiles"

# Brew Packages
if [[ ! -f /usr/local/bin/brew ]]; then
    echo "Installing brew core:"
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

    echo "Installing packages:"
    brew install git coreutils binutils bash boot2docker docker htop-osx iftop openssl openvpn packer wget tree

    # Git settings
    git config --global user.name "Gerardo Rochín"
    git config --global user.email gerardorochin@gmail.com
    git config --global color.ui true
    git config --global core.editor "vim"
else
    echo "Homebrew is already installed"
fi

# Oh my zsh
if [[ ! -d ~/.oh-my-zsh ]]; then
    echo "Installing Oh my zsh:"
    curl -L http://install.ohmyz.sh | sh
else
    echo "Oh my zsh is already installed"
fi

echo "Done"