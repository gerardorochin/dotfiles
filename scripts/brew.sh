#!/usr/bin/env bash
#
# Homebrew
#
# http://brew.sh/
# The missing package manager for OS X
#
set -e

echo "Homebrew"

os=`uname`
if [[ $os == "Darwin" ]]; then
    # check for homebrew
    if test ! $(which brew) || [[ $1 -eq "-f" ]]
    then
        if [[ $1 -eq "-eq" ]]; then
                echo "Force mode"
                echo "Removing brew"
		sudo rm -rf /usr/local/Cellar /usr/local/.git
                brew prune || exit 0
                brew cleanup || exit 0
                sudo rm -rf ~/Library/Caches/Homebrew
                sudo rm -rf ~/Library/Logs/Homebrew
                sudo rm -rf /Library/Caches/Homebrew
	    fi

        echo "Installing brew core"
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

        echo "Installing brew packages"
        brew install \
            bash \
            binutils \
            boot2docker \
            coreutils \
            docker \
            git \
            grc \
            htop-osx \
            iftop \
            mysql --client-only \
            openssl \
            pwgen \
            ssh-copy-id \
            tree \
            vim \
            wget \
            zsh

       echo "Brew cleanup"
       brew cleanup

       if [[ -f /usr/local/bin/zsh ]]; then
           echo "Enable zsh on /etc/shells"
           echo "/usr/local/bin/zsh" | sudo tee -a /etc/shells
       fi

       echo "Installing brew cask"
       brew install caskroom/cask/brew-cask

       echo "Installing brew packages"
       brew cask install \
           google-chrome \
           iterm2 \
           macvim \
           sequel-pro \
           spotify \
           vagrant

       echo "Brew cask cleanup"
       brew cask cleanup

    else
        echo "Homebrew is already installed"
    fi
    echo -e "Done\n"
else
    echo -e "OS not Supported\n"
fi
