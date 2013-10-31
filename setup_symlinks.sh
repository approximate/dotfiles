#!/usr/bin/env bash

#u
#u This script will make symlinks in your $HOME to the files in dotfiles repo dir.
#u
#u Set $DOTFILES to point to your repo dir, otherwise default $HOME/dotfiles/ is used
#u
#u Usage: $0 [flags]
#u   where flags can be one or more of the following:
#u     -v | --verbose  : Show info messages, not only errors
#u     -f | --force    : Actually change files. Without this, scripts makes a dry run (just shows commands)
#u     -h | --help     : Show usage information (this text)
#u

repo=${DOTFILES:-$HOME/dotfiles}

error()
{
    echo $*
    exit 1
}

show_info()
{
    [ "$verbose" == y ] && echo $*
}

usage()
{
    if [ $# -ne 0 ] ; then
        echo $*
    fi
    grep -e "^#u" $0 | sed -e 's/^#u \?//'
}

dry_run="echo "

while true ; do
    case $1 in
        -v | --verbose )
            verbose=y
            shift
            ;;
        -f | --force )
            dry_run=""
            shift
            ;;
        -h | --help )
            usage
            exit 0
            ;;
        -* )
            usage "ERROR: Unrecognized flag $1"
            exit 1
            ;;
        * )
            break
            ;;
    esac
done

# We will only work with files already in the repo
# in order not to include any new/unknown files
#
# We also assume that the repo is not empty, since you've probably
# cloned it from GitHub
# TODO: find a better way to consider all necessary files
#     I actually want this:
#        .bashrc*
#        .tmux.conf
#        .inputrc
#        .screenrc
#        .git* (only files)
#        .vim* (only files)
#        .pentadactylrc
files=".bashrc \
    .bashrc.aliases \
    .tmux.conf \
    .inputrc \
    .screenrc \
    .pentadactylrc \
    .vimrc \
    .vimpagerrc \
    .gitconfig \
    .gitignore \
    .gitmessage \
"

# filelist=`find $repo -maxdepth 1 -type f -name .\* | sed -e 's#.*/##'`

timestamp="$(date +%F_%H.%M.%S)"

# Create symlinks in $dest that point to files in $src
#
# I experimented with hardlinks, but this got screwed by "git pull", which
# just created new files
for file in $files ; do

    [ ! -r $repo/$file ] && { show_info "- Source file $file not found in repo, skipping..." ; continue ; }

    if [ -e "$HOME/$file" ] ; then

        show_info "File $file exists in $HOME"

        if [ ! -L "$HOME/$file" ] ; then
            show_info "+ Ordinary file $file found, renaming to ${file}.$timestamp"
            $dry_run mv "$HOME/$file" "$HOME/${file}.$timestamp" || error "Cannot rename $file, aborting..."
        else
            if [ -x $(which readlink) ] ; then
                show_info "? Found symlink at $HOME/$file, checking destination..."
                _dest_file=$(readlink -q --canonicalize $HOME/$file)

                if [ -f $_dest_file ] && [ "$_dest_file" == "$repo/$file" ] ; then
                    show_info "- Symlink to $file is correct, skipping..."
                    continue
                fi
            fi

            show_info "+ Symlink points to unknown file, renaming..."
            $dry_run mv "$HOME/$file" "$HOME/${file}.$timestamp" || error "Cannot rename $file, aborting..."
        fi
    fi

    show_info "+ Creating symlink to $file"
    $dry_run ln -s "$repo/$file" "$HOME/$file" || error "Cannot create symlink to $file, aborting..."
done

# Handle .bashrc.local
if [ -e $repo/.bashrc.$HOSTNAME ] ; then
    show_info "+ Creating symlink to .bashrc.$HOSTNAME"
    [ -e $HOME/.bashrc.local ] && $dry_run mv $HOME/.bashrc.local $HOME/.bashrc.local.${timestamp}
    $dry_run ln -s $repo/.bashrc.$HOSTNAME $HOME/.bashrc.local || error "Cannot create symlink to .bashrc.$HOSTNAME, aborting..."
fi
