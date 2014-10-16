#!/usr/bin/env bash
#
# Git
#
# http://git-scm.com/
# Distributed version control system 
#
set -e

# check for git
if test $(which git)
then
    echo "Setting git configs"

    # Git settings
    git config --global user.name "Gerardo Rochín"
    git config --global user.email gerardorochin@gmail.com
    git config --global color.ui true
    git config --global core.editor "vim"
else
    echo "Git not installed"
fi