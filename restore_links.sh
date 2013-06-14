#!/usr/bin/env bash

for file in `ls -1` ; do
    if [[ ! -d $file ]] ; then
        # it's a regular file, let's link it to the home directory
        if [[ -r $HOME/.${file} ]] ; then
            rm $file && ln $HOME/.${file} $file
        fi
    fi
done
