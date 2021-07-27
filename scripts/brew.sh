!/usr/bin/env bash
#
# Homebrew
#
# http://brew.sh/
# The missing package manager for OS X
#
set -ex

echo "Homebrew"

os=`uname`
if [[ $os == "Darwin" ]]; then
    # check for homebrew
    if test ! $(which brew) || [[ $1 -eq "-f" ]]
    then
        echo "Installing brew core"
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

        echo "Installing brew packages"
        brew install \
            ansible \
            bash \
            binutils \
            coreutils \
            fzf	\
            git \
            gnupg \
            gpg \
            grc \
            htop-osx \
            iftop \
            jq \
            macvim \
            most \
            openssl \
            pinentry-mac \
            pwgen \
            ssh-copy-id \
            tree \
            wget

       echo "Brew cleanup"
       brew cleanup

       echo "Installing brew cask packages"
       brew cask install \
           google-chrome \
           iterm2 \
           spotify \
           postman

       echo "Installing brew cask fonts"
       brew tap homebrew/cask-fonts
       brew cask install \
           font-source-code-pro

       brew tap teamookla/speedtest
       brew update
       brew install speedtest --force

       echo "Brew cleanup"
       brew cleanup
    else
        echo "Homebrew is already installed"
    fi
    echo -e "Done\n"
else
    echo -e "OS not Supported\n"
fi
