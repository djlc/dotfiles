#!/bin/bash

# symbolic links setting
DOT_FILES=(.bashrc .bash_profile .zshrc .vimrc .dein.toml .gvimrc .latexmkrc .header.h .template_tex)
for file in ${DOT_FILES[@]}
do
	ln -s $HOME/dotfiles/$file $HOME/$file
done

# create clang pch file
if [ ! -e .header.h.pch ]; then
    clang++ -std=gnu++1y -x c++-header .header.h -o .header.h.pch
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

