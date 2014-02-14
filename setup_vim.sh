#!/usr/bin/env bash

mkdir -p ~/.vim/bundle ~/.vim/.cache || exit 1
git clone http://github.com/gmarik/vundle || exit 1
cd ~/.vim/.cache || exit 1
mkdir -p backup undo swap fuzzyfind ctrlp yankring || exit 1
vim +BundleInstall +qall
