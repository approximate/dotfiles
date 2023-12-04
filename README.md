# Dotfiles, reincarnated

This is yet another incarnation of my dotfiles.

A few assumptions:
- mostly Linux with some Windows bits thrown in (Git/Bash, PS), Solaris/HP-UX/AIX is not supported/required anymore
- managed using [chezmoi](https://www.chezmoi.io/)
- out-of-the-box support for multiple machines using chezmoi templates


## Supported platforms

- Linux (internal Traxpay hosts, WSL, Claranet)
- Linux-like (Git/Bash)
- Windows (Traxpay laptop)

## Main tools

- Shell: bash
    - it's available everywhere, and can be easily installed when not provided out-of-the-box
    - readline is configured as part of bash config, and is used in many other CLI utils
    - alternatives: zsh/fish
- Editor: vim
    - it's also available everywhere, can be easily installed
    - alternatives: Nvim/Chad
- Terminal multiplexor: tmux
- VCS: git


## Additional tools

- Terminal
- alternative CLI utilities (replacement for GNU tools):
    - bat
    - zoxide
    - httpie
    - bottom
    - delta
    - eza
    - fzf

