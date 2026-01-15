![rice](pic/rice.png)

# i like to fry my rice
*Now on NixOS using [wallust](https://codeberg.org/explosion-mental/wallust) instead of Arch and pywal/wpg for templating and colorscheme generation*

## why should you use this
- (consistent) vim keybinds and modes (hyprland calls them submaps) literally everywhere
- shell auto suggestions
- pretty colors that are consistent across apps (browser, discord, gtk, qt, terminal)
- nix-native but adaptable to any Linux/Darwin system
  - ubuntu, fedora, arch support via system-manager

## How to Install
```sh
# If you want to try out my configs in a new nix generation
git clone https://github.com/durcor/friedrice
rsync --remove-source-files friedrice $HOME

# On NixOS
export NH_FLAKE=$HOME
nix run nixpkgs#nh -- os switch

# On non-NixOS (Ubuntu, Fedora, Arch)
nix run github:numtide/system-manager os switch

# OR (don't try this at home)
sudo nixos-install --root / --flake github:durcor/friedrice#noveria
```

## My Workflow
```sh
. /etc/os-release && [ $ID = nixos ]
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
* `$FILEMAN`: yazi, fallback: lf
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
- Flash windows/window borders on mode/submap change w/ overlay of transparent text in center of screen instead of notifications
- investigate:
  - hyprland plugins (hy3, niri)
  - standalone niri
  - cosmic?
  - home-manager/hjem
