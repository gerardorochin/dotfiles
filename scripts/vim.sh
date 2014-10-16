#!/usr/bin/env bash
#
# vim
#
# http://www.vim.org/
# vim editor
#
set -e

# check for vim
if test $(which vim)
then
    
    # vim-pathogen
    # https://github.com/tpope/vim-pathogen
    # manage your runtimepath

    # install
    mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

    # vim plugins (github)
    declare -a plugins=(
        altercation/vim-colors-solarized
        bling/vim-airline
        scrooloose/nerdtree
    )

    # run scripts enabled
    for plugin in "${plugins[@]}"
    do
        # get dest
        dest=${plugin#*/}
        dest=${dest%%.git}
        
        cd ~/.vim/bundle
        if [[ ! -d $dest ]]; then
            git clone git://github.com/$plugin.git
        else
            cd $dest
            git pull origin master
        fi
    done

    # config dir
    if [[ -d ../configs ]]; then
        vimrc=../configs/vimrc
    else
        vimrc=configs/vimrc
    fi

    # .vimrc file
    if [[ -f  $vimrc ]]; then
        cp -f $vimrc ~/.vimrc
    fi
else
    echo "vim not installed"
fi
