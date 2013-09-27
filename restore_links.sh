#!/usr/bin/env bash

#u This script will make symlinks in your $HOME to the files in repo dir
#u
#u Default Git repo is at $HOME/dotfiles/

repo=$HOME/dotfiles

usage()
{
    if [ $# -ne 0 ] ; then
        echo $*
    fi
    grep -e "^#u" $0 | sed -e 's/^#u *//'
}

# Check command line parameters first
# TODO: implement option to skip certain files
if [[ $# != 0 ]] ; then
    usage "No parameters are accepted" && exit 1
fi

# We will only work with files already in the repo
# in order not to include any new/unknown files
#
# We also assume that the repo is not empty, since you've probably
# cloned it from GitHub
# TODO: find a better way to consider all necessary files
filelist=`find $repo -maxdepth 1 -type f -name .\* | sed -e 's#.*/##'`

timestamp="$(date +%F_%H.%M.%S)"

# Create symlinks in $dest that point to files in $src
# 
# I experimented with hardlinks, but this got screwed by "git pull", which 
# just created new files
for file in $filelist ; do
    echo "Checking file $file"
    if [ -e "$HOME/$file" ] ; then
        if [ ! -L "$HOME/$file" ] ; then
            # There is a normal file with the same name
            # Let's just rename it
            echo "Making backup..."
            mv "$HOME/$file" "$HOME/${file}.$timestamp" || exit 1
        else
            # There's a symlink already, let's see where it points
            # link -p $HOME/$file
            if [ -x $(which readlink) ] ; then
                echo "Checking the linked file..."
                _dest_file=$(readlink -q --canonicalize $HOME/$file)
                if [ -f $_dest_file ] && [ "$_dest_file" == "$repo/$file" ] ; then
                    echo "Looks like the link is correct, skipping..."
                else
                    echo "Links point somewhere else, needs changing..."
                fi
            fi
        fi
    else
        ln -s "$repo/$file" "$HOME/$file" || exit 1
        echo "Created symlink to $file"
    fi
done
