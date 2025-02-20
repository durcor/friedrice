![rice](pic/rice.png)

# My Dotfiles
*wpgtk templates are stored in .config/wpg/templates/*

## My Workflow
```sh
. /etc/os-release && [ "$PRETTY_NAME" = "Arch Linux" ]
```

* WM
  * Wayland
    - sway w/ i3blocks (+ personal [blocks](https://github.com/durcor/blocks))
    - hyprland w/ waybar
  * Xorg
    - i3-gaps w/ i3blocks and picom
* `$TERMINAL`: kitty + nvim
* `$SHELL`: zsh (zinit)
  - [zsh expandable aliases](.zshal)
  - [powerline10k prompt](.p10k.zsh)
* `$BROWSER`:
  - firefox/librewolf
    - tridactyl
    - ublock origin + umatrix
    - dark reader wal fork
  - qutebrowser
  - brave
* `$FILEMAN`: lf or yazi
* `$EDITOR`: nvim (lazy-vim)
* `$MAILREADER`: neomutt or thunderbird
* `$MUSICPLAYER`: mpd (ncmpcpp[tui] + mpc[cli]) + spotfiyd (spotify-tui)
* `$NOTIFYDAEMON`: dunst (xorg), mako (wayland)
* `$MEDIAPLAYER`: mpv

## Bringing Vim-Like Modes to Your Own Setup
* Text Editor/IDE: Neovim
* Terminal Multiplexer: Neovim :terminal + tabs/windows functionality
* Window Manager: 
  - Wayland - sway/hyprland
  - Xorg - i3
* Browser
  - firefox-based (tridactyl)
  - chromium-based (vimium)
  - qutebrowser
* shell:
  - sh (`set -o vi`)
  - zsh (vi-mode)

## Some Usage Information
- wpg templates need to be symlinked upon cloning/pulling if the symlink isn't there already

# TODO
- Flash windows/window borders on mode/submap change w/ overlay of transparent text in center of screen instead of notifications
- migrate wpg templates to wallust
- get off of xorg fully
- move from i3blocks to top+bottom waybar/polybar
- nixos?
