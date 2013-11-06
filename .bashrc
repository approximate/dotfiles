# KMZ big huge .bashrc {
# vim: ai tw=74 fen fdm=marker nospell fmr={,}

# This file is largely based on Boyd Adamson's .bashrc
# REQUIRES bash version >= 2.04
# }

# COMMENTS & DOCUMENTATION {

# NOTE!!!! Don't make changes to this file for a single machine. Use
# .bashrc.local. See "Local Customisations" below.

# General {

# This file is designed on the assumption that bash is NOT our login
# shell. If it was then the env variable setting should be in the
# .bash_profile file, not the .bashrc. I've made a special effort to keep
# the number of external calls to a minimum, since it was getting to the
# point that it would take 5 seconds to fire up bash on an Sun Ultra 10!
# As a result, there are some unusual constructs in here. There are still
# some external calls left (e.g. calls to sed) but they are not in loops
# and I doubt they make that much difference to performance.
# }

# Local Customisations {

# It's best not to change this file on a machine-by-machine basis. For
# local extensions this file calls ~/.bashrc.local if it exists. It's
# called twice...  once before all processing with a single parameter ($1)
# "pre" and once after all processing with a single parameter "post".

# In addition, a number of variables are set and are available for use by
# the ~/.bashrc.local script. These variables are UNset before this file
# exits, so they are not available once the shell is interactive.

# The variables set by this script are:
#   _debugging                          Manually set (see below) to "1" if
#                                       parts of this and called scripts
#                                       should be verbose in their output.
#                                       Unset otherwise. NOTE that some
#                                       non-interactive tools (e.g. rsync)
#                                       get confused by stuff being
#                                       printed at shell startup so
#                                       normally this should be OFF.

#   _shell_is_interactive               Set to "1" if this is an interactive
#                                       session, and unset otherwise. No
#                                       output should be produced if this
#                                       is set.

#   _running_X                          Set to "1" if we are running under
#                                       X and appropriate stuff should be
#                                       done.  NOTE that when the "pre"
#                                       call to ~/.bashrc.local is made,
#                                       _running_X is based on a VERY
#                                       simple test (is DISPLAY set?).  By
#                                       the time the "post" call is made
#                                       _running_X reflects more thorough
#                                       probes for a usable X server. It's
#                                       best to wait for the "post" call
#                                       before using X since timeouts on
#                                       non-existant servers may cause
#                                       this script to appear to hang

# }

# TODO: Main list {
#   It seems that I'm constantly adding new features that leap-frog the
#   todo list below, so this is really a SHOULDDO list, but for what it's
#   worth:
#     - surround the ENV var and other once-only stuff with a big if,
#       testing $0 or something for login-shellness then call this file
#       from /.bash_profile with something like:
#       [ -r ~/.bashrc ] && . /.bashrc
#     - exclude lots of things such as alises etc in case our session
#       is not interactive
#     - Policy question: Should stuff in the /usr/local tree be used in
#       preference to stuff in system directories like /usr/bin? At the
#       moment the path has the /usr/local stuff later. That means that a
#       newer version of software installed there won't get used.
# }
# }

# Set up some variables for later {

# NOTE: If a variable is added here it should be unset at the end of the
# file!

# _debugging=1

# $- contains the options provided to the shell
[[ $- == *i* ]] && _shell_is_interactive=1
[[ -n "$DISPLAY" ]] && _running_X=1
[[ -n "$ENABLE_X" ]] || _running_X=0
# }

# Make the first call on the local settings file {
[ -r $HOME/.bashrc.local ] && . $HOME/.bashrc.local pre
# }

# PATH, MANPATH, LD_LIBRARY_PATH {

# Comments {
# We do this first since we might need them later.

# Selective adding of installed programs:
# LOCALPROGS allows programs to be installed in
# /usr/local/<progname>/{bin,man,sbin,lib} and still be found.  OPTPROGS
# does the same thing for /opt/<progname> - mostly for Solaris. MYUSRPROGS
# is the same thing for ~/usr

# Here we add EVERY path we're likely to need, independant of OS. We will
# strip the ones that don't exist later
# }

# Variable setup {
# I don't normally set these to a complete list since not all users need
# all apps, but if either of the {LOCAL,OPT}PROGS variables is not set it
# will be automatically filled below with all values from the disk.

# Here's another idea how to populate the PATH and MANPATH variables

# # prepend_colon(val, var)
# prepend_colon() {
#   if [ -z "$2" ]; then
#     echo $1
#   else
#     echo $1:$2
#   fi
# }
#
# # unshift_path(path)
# unshift_path() {
#   if [ -d $1/sbin ]; then
#     export PATH=$(prepend_colon "$1/sbin" $PATH)
#   fi
#   if [ -d $1/bin ]; then
#     export PATH=$(prepend_colon "$1/bin" $PATH)
#   fi
#
#   if [ -d $1/share/man ]; then
#     export MANPATH=$(prepend_colon "$1/share/man" $MANPATH)
#   fi
# }
#
# # TABULA RASA
# # NOTE: Not a good idea to unset $PATH and similar vars, since interactive shell should
# #   probably inherit those variables from the process that started it
# export PATH=""
# export MANPATH=""
#
# unshift_path "/usr/X11"
# unshift_path ""
# unshift_path "/usr"
# unshift_path "/usr/local"
# unshift_path "/opt/local"
# unshift_path "$HOME/local"
# unshift_path "$HOME/etc"
#
# export PATH=$(prepend_colon ".local" $PATH)
# The end of the idea section}}

# TODO: This has to be fixed for MacOSX, where Homebrew puts stuff directly
# into /usr/local/bin

#LOCALPROGS="vim screen teTeX"
#OPTPROGS="SUNWcluster SUNWmd"
#MYUSRPROGS=""

# Basic Entries
PATH=/sbin:/usr/sbin:/usr/bin:/usr/dt/bin:$PATH
# Solaris entries
PATH=$PATH:/usr/ccs/bin:/usr/openwin/bin:/usr/sfw/bin:/usr/perl5/bin
# SunCluster entries (inc DTK)
PATH=$PATH:/usr/cluster/bin:/usr/cluster/lib/sc:/usr/cluster/dtk/bin
# SunFire 15k path
PATH=$PATH:/opt/SUNWSMS/bin
# Tru64 entries
PATH=$PATH:/usr/bin/X11:/usr/tcb/bin
# MacOSX entries
PATH=/sw/bin:/sw/sbin:/Developer/Tools:$PATH
# TODO: HP/UX and Linux entries should be here
# My entries
PATH=$PATH:/usr/local/bin:$HOME/scripts
# Late Solaris entries - definitely want these at the end
PATH=$PATH:/usr/ucb

MANPATH=/sw/share/man:/usr/share/man:/usr/dt/share/man
MANPATH=$MANPATH:/usr/local/man:/usr/openwin/man
MANPATH=$MANPATH:/usr/X11R6/man/:/usr/perl5/man
MANPATH=$MANPATH:/opt/SUNWSMS/man
MANPATH=$MANPATH:/usr/cluster/man:/usr/cluster/dtk/man:/usr/sfw/man
LD_LIBRARY_PATH=/usr/local/lib
# }

# Auto-add paths {

# /usr/local {
if [ -d /usr/local ]; then
    for PROG in ${LOCALPROGS:-$(cd /usr/local; echo *)}
    do
        if [ -d /usr/local/$PROG/bin ]; then
            PATH=/usr/local/$PROG/bin:$PATH
        fi
        if [ -d /usr/local/$PROG/sbin ]; then
            PATH=/usr/local/$PROG/sbin:$PATH
        fi
        if [ -d /usr/local/$PROG/man ]; then
            MANPATH=/usr/local/$PROG/man:$MANPATH
        fi
        if [ -d /usr/local/$PROG/lib ]; then
            LD_LIBRARY_PATH=/usr/local/$PROG/lib:$LD_LIBRARY_PATH
        fi
    done
fi
# }
# /opt {
if [ -d /opt ]; then
    for PROG in ${OPTPROGS:-$(cd /opt; echo *)}
    do
        if [ -d /opt/$PROG/bin ]; then
            PATH=$PATH:/opt/$PROG/bin
        fi
        if [ -d /opt/$PROG/sbin ]; then
            PATH=$PATH:/opt/$PROG/sbin
        fi
        if [ -d /opt/$PROG/man ]; then
            MANPATH=$MANPATH:/opt/$PROG/man
        fi
        if [ -d /opt/$PROG/lib ]; then
            LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/$PROG/lib
        fi
    done
fi
# }
# $HOME/usr {
# TODO: This section has to be rewritten, as it currently breaks on my
# multiplatform $HOME/usr.
# Don't do this if our home directory is /. This won't affect the
# resulting PATH but it will make the loop below faster
# if [ -d $HOME/usr -a $HOME != "/" ]; then
#     for PROG in ${MYUSRPROGS:-$(cd $HOME/usr; echo *)}
#     do
#         if [ -d $HOME/usr/$PROG/bin ]; then
#             PATH=$HOME/usr/$PROG/bin:$PATH
#         fi
#         if [ -d $HOME/usr/$PROG/sbin ]; then
#             PATH=$HOME/usr/$PROG/sbin:$PATH
#         fi
#         if [ -d $HOME/usr/$PROG/man ]; then
#             MANPATH=$HOME/usr/$PROG/man:$MANPATH
#         fi
#         if [ -d $HOME/usr/$PROG/lib ]; then
#             LD_LIBRARY_PATH=$HOME/usr/$PROG/lib:$LD_LIBRARY_PATH
#         fi
#     done
# fi
# }

unset PROG OPTPROGS LOCALPROGS

# Clean up path-like variables {
# Here we clean up the PATH and similar variables by removing non-existant
# dirs and duplicates.

# This whole thing is complicated by the fact that we want to keep the
# existing path components in order, so we can't just use sort -u

# We do this by declaring a function that cleans a variable. This function
# is left declared for future use.

# pathclean: Clean up path-like variables {
# arguments: name-of-var-to-clean

# Note that this function's parameter is the NAME of the variable to clean
# up, not the contents of the variable. The variable is changed in-place.
# This is the bash equivalent to pass-by-reference!

function pathclean() {
    # Variable Declarations
    local -a newpathcomps     # Array of new path components
    local -i alreadyseen      # Have we already seen this component?
    local component           # Current component we're looking at
    local -i i                # loop var
    local thevar=$1           # The NAME of the variable we're cleaning

    # Clean up the PATH
    # Expunge double /s and make : into a space. Unfortunatly, this breaks
    # on path entries with a space in them, as happens in the cygwin
    # environment with the fabulous "Program Files" directory, so we have
    # to kludge them into | and then back again...
    #
    # Changed by KZ:
    # - remove "/cygdrive" as I have local mounts
    # - remove directories not needed in cygwin (Program Files etc)
    #
    for component in $(echo ${!thevar} |
                        sed -e 's/ /|/g' -e 's/:/ /g' -e 's#//#/#g' \
                            -e 's#/cygdrive##g' )
    do
        if [[ -d ${component//|/ } ]]; then
            # The directory exists, lets check we haven't already seen it
            alreadyseen=0
            i=0
            while (( $i < ${#newpathcomps[*]} )); do
                if [[ ${newpathcomps[i]} == $component ]]; then
                    alreadyseen=1
                    break
                fi
                (( i = i + 1 ))
            done
            if (( ! alreadyseen )); then
                newpathcomps[i]=$component
            fi
        fi
    done
    # I'm just not game to wrap this line!
    eval "$thevar=\"$( echo ${newpathcomps[*]} | sed -e's/ /:/g' -e 's/|/ /g' )\""
    # eval "$thevar=\"$( echo ${newpathcomps[*]} | sed -e's/ /:/g' -e 's/|/ /g' -e 's/.*Program Files.*//g' )\""
}
# }
# Perform the cleaning {

pathclean PATH
pathclean MANPATH
pathclean LD_LIBRARY_PATH

export PATH MANPATH LD_LIBRARY_PATH

# }
# }
# }

# }

# Terminal setup {
# Set up the terminal (based on the TERM variable). Doesn't work properly
# on solaris (esp. in CDE) 'cos tset is Bezerkeley :-(
# TODO: I think there's a tset in /usr/ucb
if [[ "$_shell_is_interactive" == 1 && \
    $OSTYPE != solaris* && \
    $OSTYPE != cygwin* ]]; then
    if [[ $(type -p tset) ]]; then
        eval $(SHELL=/bin/sh tset -Q -I -s)
    fi
fi
# }

# Better X detection {
# Ok, we now have the PATH set, so we can be more ambitious (and therefore
# reliable) about setting the _running_X variable.  The general idea here
# is that we want to check that the DISPLAY variable is not only set, but
# set to a valid value. The easiest way to do this is to run an innocuous
# X program, and check for exit status. Unfortunately, X applications have
# RIDICULOUSLY long timeouts (e.g. 2 1/2 _MINUTES_ on solaris 8). We don't
# want to have to wait that long if the DISPLAY variable points at a
# non-existent host. So we ping first, which should be quicker. But then,
# of course ping syntax has it's own issues...

if (( _running_X )); then
    declare displayhost=${DISPLAY%:*}
    declare pingcmd
    case $OSTYPE in
        solaris*)
            pingcmd="ping $displayhost 1"
            ;;
        linux*)
            pingcmd="ping -c 1 $displayhost"
            ;;
        cygwin*)
            pingcmd="ping -n 1 -w 500 $displayhost"
            ;;
        *)
            ;;
        # TODO insert other flavors of ping here
    esac
    # If displayhost is blank DISPLAY is probably ":0" so we shouldn't ping
    [[ -z "$displayhost" ]] && pingcmd=""
    (( _debugging )) && echo Thorough X tests..
# This section takes AGES to execute on OSX, so I commented it out for the time being
# TODO: This can be rewritten by using xset instead of xdpyinfo -- should test on OSX

#    if ! ( $pingcmd && xdpyinfo ) >/dev/null 2>&1; then
#        # Either we can't ping the machine or xdpyinfo failed. Either way,
#        # X is probably not going to work!
#        (( _debugging )) && echo X seems to be broken!
#        unset _running_X
#    fi
    unset displayhost pingcmd
fi
# }

# Shell options {
# Set my preferred options
shopt -s cdspell checkwinsize histreedit globstar histappend nocaseglob

# If I hit <tab> on a blank line, I DON'T want to see a list of all the
# comands in my PATH - who would EVER want that??  This option appeared in
# bash 2.04, so it's not in the Solaris 8 version of bash.  Rather than
# checking for the version, check for the existance of the option:
[[ $(shopt) == *no_empty_cmd_completion* ]] &&
    shopt -s no_empty_cmd_completion

#Only put duplicate lines in the history once
HISTCONTROL=ignoredups
# }

# The following section should only be used for interactive shells {

if [[ $_shell_is_interactive == 1 ]] ; then
# Prompt and other terminal settings {

# Set the prompt {
# If it's an xterm then set the window title to reflect $PWD
# If we're root, make the prompt red
# TODO: Should use tput for a lot of this stuff
# Declare some variables to work with
declare basicprompt='\h:\W\$'
# We need extglob turned on, so save the current value
declare oldextglob=$( shopt extglob )
shopt -s extglob
declare settitle setcoloron setcoloroff
# set up complicated prompt stuff based on terminal type
case $TERM in
    dtterm*|*xterm*|screen*|linux)
        # These use the basic ANSI color sequences.
        setcoloroff="\[\033[0m\]"
        if (( ! $UID )); then
            # we are root... make the prompt red
            setcoloron="\[\033[0;31m\]"
        else
            # non-root, but I still like color
            setcoloron="\[\033[1;32m\]"
        fi
        if [[ $TERM == +(*xterm*|dtterm*|screen*) ]]; then
            # These terminals have a title that can be set.
            # This magic came from one of the linux HOWTOs
            #PS1='\[\033]0;\h: \w\007\]\h:\W\$ '
            case $TERM in
                *xterm*|dtterm*)
                    settitle="\[\033]0;\h: \w\007\]"
                    ;;
                screen*)
                    # for screen I want to set the window title to only
                    # the hostname, and use the hardstatus for the path.
                    # The escape sequences to set the hardstatus are the
                    # same as those to set the title in xterm.
                    settitle='\[\033k\h\033\\\033]0;\w\007\]'
                    ;;
            esac
        fi
        ;;
    *)
        # Nothing special here
        ;;
esac
PS1="${settitle}${setcoloron}${basicprompt}${setcoloroff} "

# Remove any exporting of PS1 since it looks hideous in other shells and
# bash will just re-read this file anyway
export -n PS1

# set extglob back to how we found it
[[ $oldextglob == *off ]] && shopt -u extglob
unset basicprompt settitle setcoloron setcoloroff oldextglob
# }

# }

# Aliases {
# "rebash" and "realias" {
# Let me easily re-run this in case of a new installation or change to this
# file. I know, how lazy is this?
alias rebash='. ~/.bashrc'
alias realias='. ~/.bashrc.aliases'
# }
# Other aliases {
# Put the rest of stuff that you want aliased in .bashrc.aliases file
[ -r ~/.bashrc.aliases ] && source ~/.bashrc.aliases
# }
# }

# Functions {
# Easy extract
extract () {
  if [ -r $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar e $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}
# The ps function {
# This function lets me use either the System V (-ef) or BSD (aux) style
# switches on Solaris. It just runs the appropriate ps based on whether
# there's a - there or not.
# Been meaning to do this for a while, then came across one at
# http://www.beaglebros.com/unix - so I stole it. I've since changed it,
# but when do I stop crediting the inspiration?
if [[ $OSTYPE == solaris* ]]; then
    function ps {
        if [ -n "$1" ]; then
            if [[ $1 == -* ]]; then
                /usr/bin/ps $@
            else
                /usr/ucb/ps $@
            fi
        else
            /usr/bin/ps $@
        fi
    }

fi # end solaris function
# }
# }
fi # End of interactive-only section
# Make the last call on the local settings file {
[ -r $HOME/.bashrc.local ] && . $HOME/.bashrc.local post
# }

# Clean up {
unset _shell_is_interactive
unset _running_X
unset _debugging
# }
