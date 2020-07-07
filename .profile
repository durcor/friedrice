#!/bin/sh
# ~/.profile
#
# Put stuff here that you only want sourced once
# at login

. "$HOME/.mancolors"
. "$HOME/.config/lf/ico"

export EDITOR="nvim"
export VISUAL="$EDITOR"
export TERMINAL="kitty"
export BROWSER="copytoclip"
export GUIBROWSER="qutebrowser"
export PAGER="less"
export FILEMAN="lf"
export TASKMAN="gotop"
export MUSICPLAYER="ncmpcpp"
export NEWSREADER="newsboat"
export READER="zathura"
export MAILREADER="neomutt"
export QT_QPA_PLATFORMTHEME="qt5ct"
export LYNX_CFG="$HOME/.lynxrc"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export DXVK_HUD="compiler"
export ENABLE_VKBASALT=0
export WINEESYNC=0
export WINEFSYNC=1
export DXVK_ASYNC=0
export AMDVLK_ENABLE_DEVELOPING_EXT="all"

export GOPATH="$HOME/.local/share/go"
export CLASSPATH="$CLASSPATH:/usr/share/java/*"
# LaTeX plugins
export TEXINPUTS="$HOME/doc/tex/*/:$TEXINPUTS"

[ "$TERM" = "linux" ] &&
	. "$HOME/cache/wal/colors-tty.sh" &&
	sudo -n loadkeys ~/.config/ttymaps.kmap &&
	sudo -n kbdrate -r 35 -d 150

bluetoothctl devices | grep XB9 && 
    ! bluetoothctl info &&
    bluetoothctl connect 38:18:4C:17:2E:97

systemctl -q is-active graphical.target && 
    [ ! "$DISPLAY" ] && 
    [ "$XDG_VTNR" -eq 1 ] &&
    DISPLAY_SERVER=x &&
    # DISPLAY_SERVER=w &&
    if [ "$DISPLAY_SERVER" = "x" ]; then
        export MOZ_ENABLE_WAYLAND=0
        startx
    else
        export MOZ_ENABLE_WAYLAND=1
        sway
    fi
