#!/bin/bash

DOT_FILES=(.bashrc .bash_profile .zshrc .vimrc .dein.toml .gvimrc .latexmkrc .header.h .template_tex)

for file in ${DOT_FILES[@]}
do
	ln -s $HOME/dotfiles/$file $HOME/$file
done

if [ ! -e .header.h.pch ]; then
    clang++ -std=gnu++1y -x c++-header .header.h -o .header.h.pch
fi

