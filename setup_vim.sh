#!/usr/bin/env bash

mkdir -p ~/.vim/bundle ~/.vim/.cache 
cd ~/.vim/bundle 
git clone http://github.com/VundleVim/Vundle.vim
cd ~/.vim/.cache 
mkdir -p backup undo swap fuzzyfind ctrlp yankring 
vim +PluginInstall +qall
