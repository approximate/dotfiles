#!/usr/bin/env bash

mkdir -p ~/.vim/bundle ~/.vim/.cache || exit 1
cd ~/.vim/bundle || exit 1
git clone http://github.com/VundleVim/Vundle.vim
cd ~/.vim/.cache || exit 1
mkdir -p backup undo swap fuzzyfind ctrlp yankring || exit 1
vim +PluginInstall +qall
