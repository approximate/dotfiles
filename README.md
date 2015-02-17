This repository hold the configuration of my most used tools:

* bash
* ViM
* screen
* tmux
* readline
* Git
* Pentadactyl (FF extention for ViM-like browsing)
* Autojump (http://github.com/joelthelion/autojump.git)
* ctags

What I should use more if I can:
* zsh 
 * oh-my-zsh (https://github.com/robbyrussell/oh-my-zsh)
 * or prezto (https://github.com/sorin-ionescu/prezto)
* Ack or ag (the-silver-searcher) (grep replacements)
* Powerline
* virtualenv (useful for python)
* wemux (https://github.com/zolrath/wemux, screen sharing for tmux)


I use this repo to quickly set up a new machine/account, so it is
intended to be more-or-less compatible with most of the OSes I use
on a regular basis:
* Solaris 10/11
* Linux (Debian, RHEL, Fedora, CentOS)
* HP/UX 11.23 and 11.31
* Mac OS X
* occasional AIX


Color schemes:
* Solarized (dark for work, light for personal)
  (https://github.com/altercation/solarized/tree/master/)
* Good fonts have to support: cyrillic, legible letters at both small and
  normal size, clear difference of |iIl1 and oO0 chars
* Good fonts: anonymous pro, consolas, deja vu sans mono, liberation mono,
  lucida typewriter (http://hivelogic.com/articles/top-10-programming-fonts/)

Vim:
* Vundle as a plugin manager
* ... a lot of other goodies
* should probably remove NERDtree in favor of more flexible file finder (ctrlp)

TODO:
* fix the PATH/MANPATH on all systems (work promarily) using new functions
* remove all hardcoded colors from .vimrc
* create one local .bashrc.<hostname> for each of the servers I work with, then
  rewrite this bit in main .bashrc
* check new Vim plugins, adapt main .vimrc for that
