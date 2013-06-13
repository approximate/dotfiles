#!/usr/bin/env bash

for file in `ls -1` ; do
    if [[ ! -d $file ]] ; then
        # it's a regular file, let's link it to the home directory
        ln $HOME/.${file} $file
    fi
done

