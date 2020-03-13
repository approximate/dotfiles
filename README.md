This repository holds the configuration of my most used tools:

* shell: bash (w/ readline config)
* editor: vim
* terminal: urxvt with 256 color support, alacritty on wayland
* multiplexer: screen *and* tmux
* wm/de: sway
* audio: none at the moment, thinking about mpd/mpc
* mail: mutt, offlineimap, fdm, msmtp, notmuch
* browser: qutebrowser, maybe w3m
* irc: -
* other configs: git, tridactyl (FF extention for vim-like browsing)

* Autojump (http://github.com/joelthelion/autojump.git)
* ctags
* Microsoft Visual Studio Code
* somethings else?

What I should use more if I can:
* virtualenv/pew (useful for python dev)
* bitlbee and weechat (IRC-based IM)


I use this repo to quickly set up a new machine/account, so it is
intended to be more-or-less compatible with most of the OSes I use
on a regular basis:
* Linux workstation (Debian, RHEL, Fedora, CentOS) -- this is what I use daily
* Mac OS X -- old-ish MacBook at home
* (almost never) Solaris 10/11, HP/UX 11.23/11.31, AIX


Color schemes:
* Solarized (dark for work, light for personal)
  (https://github.com/altercation/solarized/tree/master/)
* Good fonts must provide: cyrillic glyphs, legible letters at both small and
  normal size, clear difference of |iIl1 and oO0 chars
* Good fonts: anonymous pro, consolas, deja vu sans mono, liberation mono,
  lucida typewriter (http://hivelogic.com/articles/top-10-programming-fonts/)


Vim:
* Vundle as a plugin manager
* a short list of plugins that don't interfere with core Vim

Tmux:
* Plugin Manager is good to have

TODO:
* fix the PATH/MANPATH on all systems (work primarily) using new functions
* create one local .bashrc.<hostname> for each of the hosts I need it on, then rewrite this bit in main .bashrc
