# Dotfiles, reincarnated

This is yet another incarnation of my dotfiles.

A few assumptions:
- mostly Linux with some Windows bits thrown in (Git/Bash, PS), Solaris/HP-UX/AIX is not supported/required anymore
- managed using [chezmoi](https://www.chezmoi.io/)
- out-of-the-box support for multiple machines using chezmoi templates

Supported platforms
- Linux (internal company hosts, WSL, provie)
- Linux-like (Git/Bash)
- Windows (Traxpay laptop)

## How to use

[Install `chezmoi`](https://www.chezmoi.io/install/) if not installed yet.

Initialize the dotfiles repo, restart the session afterwards:
```shell
chezmoi init --apply https://github.com/approximate/dotfiles.git

## alternatively, use Traxpay Gitlab
```

Periodically update the dotfiles:
```shell
chezmoi update -v
```

Adding new files:
```shell
chezmoi add <file> # copy file (home -> source)
chezmoi cd
git commit -m "add new file"  # add change to local repo (source -> local)
git push # push to remote (local -> remote)
```

Changing existing files:
```shell
chezmoi edit <file>  # change the file at the source
chezmoi apply    # apply the change (source -> home)
chezmoi cd
git commit -m "changed file"  # add change to local repo (source -> local)
git push  # push to remote (local -> remote)
```


## Main tools

### Shell: [bash](doc/bash.md)

I use bash because it's available everywhere, and can be easily installed when not provided out-of-the-box. Also, readline is configured as part of bash config, and it is used in many other CLI utils.

Alternatives are zsh and fish, but I never made time to buckle down and learn them properly

### Editor: [vim](doc/vim.md)

It's also available for every platform and is often preinstalled, but can be easily installed if missing.

Alternatives: Nvim/Chad (terminal) or VS Code (GUI).

### Terminal multiplexor: [tmux](doc/tmux.md)

This can be partially achieved with terminal emulator features (windows/panes and remote sessions), but the persistence bit is seriously awesome

### Version control system: [git](doc/git.md)

No competition really.

## Additional tools

- Terminal: WezTerm
- Prompt: Starship
- alternative CLI utilities (replacement for GNU tools):
    - bat (cat/less)
    - zoxide (cd)
    - httpie (curl/wget)
    - bottom (top)
    - delta (diff)
    - eza (ls)
    - fzf (find and more)
    - fd (find)

## ToDo

- [ ] Add more documentation!
- [ ] Add scripts that do initial installation of all necessary tools. Ansible?

