![rice](pic/rice.png)

# i like to fry my rice
*Now using [wallust](https://codeberg.org/explosion-mental/wallust) instead of pywal/wpg for templating and colorscheme generation*

## why should you use this
- vim keybinds and modes literally everywhere
- shell auto suggestions
- pretty colors that are consistent across apps (browser, discord, gtk, qt, terminal)
- aims to be distro-agnostic (first-class support for arch, debian, fedora, etc.)

## How to Install
```sh
git clone https://github.com/durcor/friedrice
rsync --remove-source-files friedrice $HOME
```

## My Workflow
```sh
. /etc/os-release && [ $ID = arch ]
```

* `WM`: hyprland or sway
* `$STATUSBAR`: waybar (+ personal [blocks](https://github.com/durcor/blocks))
* `$TERMINAL`: kitty
* `$SHELL`: zsh (zinit)
  - [zsh expandable aliases](.zshal)
  - [powerline10k prompt](.p10k.zsh)
* `$BROWSER`:
  - firefox/librewolf/firedragon
    - tridactyl
    - ublock origin + umatrix
    - dark reader wal fork
  - brave
* `$FILEMAN`: lf or yazi
* `$EDITOR`: nvim (lazy-vim)
* `$MAILREADER`: neomutt or thunderbird
* `$MUSICPLAYER`: mpd (ncmpcpp(tui) + mpc(cli)) + spotfiyd (spotify-tui)
* `$NOTIFYDAEMON`: mako (wayland)
* `$MEDIAPLAYER`: mpv

### Some older stuff I don't use much anymore
* qutebrowser
* `$NOTIFYDAEMON`: dunst (xorg)
* WM
  * Xorg
    - i3-gaps w/ i3blocks and picom

## Bringing Vim-Like Modes to Your Own Setup
* Text Editor/IDE: Neovim
* Terminal Multiplexer: Neovim :terminal + tabs/windows functionality
* Window Manager: 
  - Wayland - sway (modes)/hyprland (submaps) + hy3
  - Xorg - i3 (modes)
* Browser
  - firefox-based (tridactyl)
  - chromium-based (vimium)
  - qutebrowser
* shell:
  - sh (`set -o vi`)
  - zsh (vi-mode)

# TODO
- hy3 on hyprland
- Flash windows/window borders on mode/submap change w/ overlay of transparent text in center of screen instead of notifications
- move from hyprland/sway + waybar to cosmic?
- investigate home-manager/hjem
