#!/bin/bash

# symbolic links setting
DOT_FILES=(.bashrc .bash_profile .zshrc .vimrc .gvimrc .latexmkrc .tmux.conf)
for file in ${DOT_FILES[@]}
do
    if [ ! -e $HOME/$file ]; then
        ln -s $HOME/dotfiles/$file $HOME/$file
    fi
done

# neovim
mkdir -p $HOME/.config/nvim

FILES=(init.vim dein.toml)
for file in ${FILES[@]}
do
    if [ ! -e $HOME/.config/nvim/$file ]; then
        ln -s $HOME/dotfiles/$file $HOME/.config/nvim/$file
    fi
done

# neovim binary
if [ -e $HOME/nvim.appimage ]; then
    wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage -P $HOME/appimage
    sudo ln -s $HOME/appimage/nvim.appimage /usr/bin/nvim
    pip3 install --user pynvim
fi

# git
git config --global user.name "djlc"
git config --global user.email "cdn60127@gmail.com"
git config --global core.editor 'vim -c "set fenc=utf-8'
git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto
git config --global core.precomposeunicode true
git config --global core.quotepath true

