#!/usr/bin/env bash

#u This script will relink the dotfiles between local Git repo dir
#u and your home directory
#u
#u Please run as "$0 <source>", where <source> is one of the following:
#u   home     Link dotfiles $HOME -> Git repo
#u   repo     Link dotfiles Git repo -> $HOME
#u
#u Default Git repo is at $HOME/dotfiles/

usage()
{
	if [ $# -ne 0 ] ; then
		for i in $* ; do
			echo "$i"
		done
		echo
	fi
	grep -e "^#u" $0 | sed -e 's/^#u *//'
}

# Check command line parameters first
if [[ $# != 1 ]] ; then
	usage "Wrong number of parameters" && exit 1
elif [ x"$1" != "xhome" -a x"$1" != "xrepo" ] ; then
	usage "Wrong parameter " "$*" && exit 1
fi

mode=$1
repo=$HOME/dotfiles

# Check the repo permissions
[ ! -d $repo ] && usage "$repo does not exist" && exit 2
[ ! -w $repo ] && usage "$repo is not writable" && exit 2

# We will only work with files already in the repo
# in order not to include any new/unknown files
#
# We also assume that the repo is not empty, since you've probably
# cloned it from GitHub
filelist=`find $repo -maxdepth 1 -type f -name .\* | sed -e 's#.*/##'`

if [ "$mode" == "home" ] ; then
	src=$repo
	dest=$HOME
else
	src=$HOME
	dest=$repo
fi

# echo $filelist

# Create hardlinks in $dest that point to files in $src
for file in $filelist ; do
	[ -f "$dest/$file" -a -r "$dest/$file" ] && rm "$dest/$file"
	echo "Linking $file"
	ln "$src/$file" "$dest/$file"
done
