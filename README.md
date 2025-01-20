
# Dotfiles, reincarnated

This is yet another incarnation of my dotfiles.

A few assumptions:
- mostly Linux with some other OS's bits thrown in (Git/Bash, Windows, OS X)
  - Solaris/HP-UX/AIX are not supported, since I don't work with them anymore
- managed using [chezmoi](https://www.chezmoi.io/)
- this repo doesn't install anything (yet?), it only contains configuration files
  - all tools will need to be installed separately

Supported platforms:
- Linux (internal company hosts, VPS hosts, personal workstations and servers)
- Linux-like (WSL and Git/Bash on Traxpay laptop)
- Windows (Traxpay laptop, kids' desktops)
- OS X (Olga's laptop)

## ToDo

- [ ] Add more documentation!
- [ ] Add scripts that do initial installation of all necessary tools. Ansible?

## How to use

I'm using [chezmoi](https://www.chezmoi.io/) to manage my dotfiles: it has a couple of features that let me handle the complexity of multi-OS dotfiles much better, namely templates and ability to use Github repos as external config sources.

[Install `chezmoi`](https://www.chezmoi.io/install/) if not installed yet.

Initialize the dotfiles repo, restart the session afterwards:
```shell
chezmoi init --apply git@github.com:approximate/dotfiles.git

## alternatively, use Traxpay Gitlab
chezmoi init --apply git@gitlab.internal.traxpay.com:konstantin.zverev/dotfiles.git
```

Periodically update the dotfiles:
```shell
chezmoi update -v
```

Adding new files:
```shell
chezmoi add <file> # copy file (home -> source)
chezmoi git commit -m "add new file"  # add change to local repo (source -> local)
chezmoi git push # push to remote (local -> remote)
```

Changing existing files:
```shell
chezmoi edit <file>  # change the file at the source
chezmoi apply    # apply the change (source -> home)
chezmoi git commit -m "changed file"  # add change to local repo (source -> local)
chezmoi git push  # push to remote (local -> remote)
```

## Main tools

### Terminal: [WezTerm](https://wezfurlong.org/wezterm/)

Aside from being an awesome cross-platform terminal emulator it also supports multiplexing, thus replacing `tmux`. 

Important bits:
- multiplexing: local/remote sessions, session management
- appearance (dynamic window and tab naming, styling)
- keybindings
- NeoVim integration (so splits movement is handled transparently)

Further reading:
Generally useful info: https://mwop.net/blog/2024-07-04-how-i-use-wezterm.html
Pre-defined config snippets: https://github.com/wez/wezterm/discussions/5435
Multiplexing: https://wezfurlong.org/wezterm/multiplexing.html
Another customization blog post: https://alexplescan.com/posts/2024/08/10/wezterm/
And another one: https://www.florianbellmann.com/blog/switch-from-tmux-to-wezterm
Session management: https://github.com/danielcopper/wezterm-session-manager


### Shell: bash

I use Bash because it's available everywhere, and can be easily installed when not provided out-of-the-box. Also, `readline` is configured as part of Bash config, and it is used in many other CLI utils.

Alternatives are `zsh` and `fish`, but I never made time to buckle down and learn them properly. The only things that Bash doesn't have out of the box are syntax highlighting and suggestions.

To be configured and documented:
- Bash itself
- Readline
- Aliases
- Bash completion

#### Windows-only: PowerShell

TBD

### Prompt: Starship

TBD

### Editor: NeoVim

It's also available for every platform and can be easily installed if missing.

Alternatives: classic Vim or newer Vim-like alternatives (Helix, Amp, Kakoune, Vis, LunarVim, Lapce)

#### Alternative / Fallback: ViM

If NeoVim cannot be installed (no permissions etc), usually ViM is already available.

To be configured and documented:
- Vim itself
- Plugins, including plugin manager installation

### Pager: less

I'm using `less` mostly due to muscle memory and it's wide availability.

TBD

### Terminal multiplexor: Tmux

This can be partially achieved with terminal emulator features (windows/panes and remote sessions), but the persistence bit is seriously awesome: this lets me don't lose work if I get disconnected from the remote system.

To be configured and documented:
- Tmux itself
- Tmux plugin manager
- Tmux session manager
- Bash completion: https://github.com/imomaliev/tmux-bash-completion (copy the file into `/etc/bash_completion.d/tmux`)

TBD

### Version control system: git

No competition really.

To be configured and documented:
- Git minimal config (username/email)
- Git aliases (lsr, d, s, p)
- Git bash completion

TBD

## Additional tools

NOTE: The only requirement is that these should be cross-platform, i.e. work under Linux, OS X and Windows.

Alternative CLI utilities, mostly replacement for GNU tools:
- bat (cat/less)
- zoxide (cd)
- [httpie](https://httpie.io/) or [xh](https://github.com/ducaale/xh) (curl/wget)
- bottom (top)
- delta (diff)
- eza (ls)
- fzf (find and more)
- fd (find)

Other TUI tools:
- [Yazi](https://yazi-rs.github.io/docs/configuration/overview/) (file manager)
- [Just](https://just.systems/man/en/) (command runner, alternative to `make`)
- [Atuin](https://docs.atuin.sh/) (shared/synced shell history)


