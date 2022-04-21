#!/usr/bin/env bash
#
# vim
#
# http://www.vim.org/
# vim editor
#
set -e

echo "Vim"

# check for vim
if test $(which vim)
then
    # vim-pathogen
    # https://github.com/tpope/vim-pathogen
    # manage your runtimepath

    # install
    echo "Install pathogen"
    if [[ ! -d ~/.vim/autoload && ! -d ~/.vim/bundle ]]; then
        mkdir -p ~/.vim/autoload ~/.vim/bundle && \
        curl --insecure -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
    else
        echo "pathogen is already installed"
    fi

    # vim plugins (github)
    declare -a plugins=(
        Raimondi/delimitMate
        airblade/vim-gitgutter
        altercation/vim-colors-solarized
        editorconfig/editorconfig-vim
        junegunn/fzf.vim
        mattn/emmet-vim
        mxw/vim-jsx
        nathanaelkane/vim-indent-guides
        pangloss/vim-javascript
        pearofducks/ansible-vim
        scrooloose/nerdtree
        terryma/vim-multiple-cursors
        tomlion/vim-solidity
        tpope/vim-fugitive
        vim-airline/vim-airline
        vim-airline/vim-airline-themes
        vim-syntastic/syntastic
    )

    echo "Install plugins"
    for plugin in "${plugins[@]}"
    do
        # get dest
        dest=${plugin#*/}
        dest=${dest%%.git}

        cd ~/.vim/bundle
        if [[ ! -d $dest ]]; then
            echo "Installing ${plugin}"
            git clone ssh://github.com/$plugin.git
        else
            echo "Plugin ${plugin} exists"
            echo "Updating.."
            cd $dest
            git pull origin master
        fi
    done

    # vimrc file
    ln -sfn ~/.dotfiles/configs/vimrc ~/.vimrc
    ln -sfn ~/.dotfiles/configs/gvimrc ~/.gvimrc

    # Dockerfile syntax
    ln -sfn ~/.dotfiles/init/Dockerfile ~/.vim/bundle

    echo -e "Done\n"
else
    echo "vim not installed"
fi
