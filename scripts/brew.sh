#!/usr/bin/env bash
#
# Homebrew
#
# http://brew.sh/
# The missing package manager for OS X
#
set -e

# check for homebrew
if test ! $(which brew)
then
    echo "Installing brew core:"
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

    echo "Installing brew packages:"
    brew install \
        bash \
        binutils \
        boot2docker \
        coreutils \
        docker \
        git \
        htop-osx \
        iftop \
        openssl \
        openvpn \
        packer \
        pwgen \
        ssh-copy-id \
        tree \
        vim \
        wget \
        zsh
else
    echo "Homebrew is already installed"
fi