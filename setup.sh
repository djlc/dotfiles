#!/bin/bash

# symbolic links setting
DOT_FILES=(.bashrc .bash_profile .zshrc .vimrc .dein.toml .gvimrc .latexmkrc .tmux.conf)
for file in ${DOT_FILES[@]}
do
	ln -s $HOME/dotfiles/$file $HOME/$file
done

# neovim
FILES=(init.vim dein.toml)
for file in ${FILES[@]}
do
	ln -s $HOME/dotfiles/$file $HOME/.config/nvim/$file
done

# git
git config --global user.name "djlc"
git config --global user.email "cdn60127@gmail.com"
git config --global core.editor 'vim -c "set fenc=utf-8'
git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto
git config --global core.precomposeunicode true
git config --global core.quotepath true

