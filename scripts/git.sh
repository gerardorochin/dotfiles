#!/usr/bin/env bash
#
# Git
#
# http://git-scm.com/
# Distributed version control system 
#
set -e

echo "Git"

# check for git
if test $(which git)
then
    echo "Setting git configs"

    # Git settings
    git config --global user.name "Gerardo Rochín"
    git config --global user.email gerardorochin@gmail.com

    git config --global alias.graph "log --graph --color --pretty=format:'%C(yellow)%H%C(green)%d%C(reset)%n%x20%cd%n%x20%cn%x20(%ce)%n%x20%s%n'"
    git config --global alias.l "log --pretty=oneline -n 20 --graph --abbrev-commit"

    git config --global color.ui true
    git config --global color.diff.meta "yellow reverse bold"

    git config --global color.status true
    git config --global color.status.branch "green"
    git config --global color.status.added "green"
    git config --global color.status.changed "red"
    git config --global color.status.untracked "yellow"

    git config --global core.editor "vim"

    echo -e "Done\n"
else
    echo "Git not installed"
fi
