#!/bin/sh
# ~/.profile
#
# shellcheck disable=1090
#
# Put stuff here that you only want sourced when
# initializing login shells

. "$HOME/.mancolors"
. "$HOME/.config/lf/ico"

# Default Programs
export EDITOR="nvr --remote -p"
export VISUAL="$EDITOR"
export TERMINAL="alacritty"
export BROWSER="copytoclip"
# export GUIBROWSER="qutebrowser"
export GUIBROWSER="firefox-nightly"
export PAGER="less"
export FILEMAN="lf"
export TASKMAN="ytop -p"
export MUSICPLAYER="ncmpcpp"
export NEWSREADER="newsboat"
export READER="zathura"
export MAILREADER="neomutt"
export STATUSBAR="i3blocks"

# Program Configuration
# export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_QPA_PLATFORMTHEME="gtk2"
export LYNX_CFG="$HOME/.lynxrc"

# XDG AppDirs
## Move to ~/.local/etc or ~/etc
export XDG_CONFIG_HOME="$HOME/.config"
## Move to ~/.local/cache or ~/cache or ~/var/cache
export XDG_CACHE_HOME="$HOME/.cache"
## Keep at current place or move to ~/share
export XDG_DATA_HOME="$HOME/.local/share"
## Keep at current place or move to ~/var/log
export XDG_STATE_HOME="$HOME/.local/state"

# Gaming Environment
## Wine
export WINEESYNC=0
export WINEFSYNC=1
## DXVK
export DXVK_HUD="compiler"
export DXVK_ASYNC=0
## Graphics
export AMDVLK_ENABLE_DEVELOPING_EXT="all"
export ENABLE_VKBASALT=0
export mesa_glthread=true

# Dev Environment
export GOPATH="$XDG_DATA_HOME/go"
export CLASSPATH="$CLASSPATH:/usr/share/java/*"
## LaTeX plugins
export TEXINPUTS="$HOME/doc/tex/*/:$TEXINPUTS"

[ "$TERM" = "linux" ] &&
    . "$HOME/.cache/wal/colors-tty.sh" &&
    sudo -n loadkeys ~/.config/ttymaps.kmap &&
    sudo -n kbdrate -r 35 -d 150

if systemctl -q is-active graphical.target; then
    if [ ! "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
        # if ! bluetoothctl info >/dev/null; then
        #     if bluetoothctl devices | grep XB9 >/dev/null; then
        #         bluetoothctl connect 38:18:4C:17:2E:97
        #     fi
        # fi
        DISPLAY_SERVER=x
        if [ "$DISPLAY_SERVER" = "x" ]; then
            export MOZ_ENABLE_WAYLAND=0
            startx
        else
            export MOZ_ENABLE_WAYLAND=1
            sway
        fi
    fi
fi
if [ -e /home/ty/.nix-profile/etc/profile.d/nix.sh ]; then . /home/ty/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
