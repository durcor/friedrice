#!/bin/sh
# ~/.profile

# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
# umask 022

. ~/.cache/wal/colors.sh
. ~/.mancolors
. ~/.secret

export GOPATH=$HOME/.local/share/go

export EDITOR=nvim
export VISUAL=$EDITOR
export TERMINAL=alacritty
export BROWSER=copytoclip
export GUIBROWSER=qutebrowser
export PAGER=less
export FILEMAN="lf"
export TASKMAN=gotop
export MUSICPLAYER=ncmpcpp
export NEWSREADER=newsboat
export READER=zathura
export MAILREADER=neomutt
export QT_QPA_PLATFORMTHEME=qt5ct
export LYNX_CFG=$HOME/.lynxrc
export XDG_CONFIG_HOME="$HOME/.config"

[ "$TERM" = linux ] && \
	. ~/.cache/wal/colors-tty.sh && \
	sudo -n loadkeys ~/.config/ttymaps.kmap && \
	sudo -n kbdrate -r 35 -d 150

[ ! "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ] &&
  export DISPLAY=":0.0" && \
  startx
  # sway

if [ "$WAYLAND_DISPLAY" ]; then
    export MOZ_ENABLE_WAYLAND=1
else
    export MOZ_ENABLE_WAYLAND=0
fi

export DXVK_HUD="compiler"
export ENABLE_VKBASALT=0
export WINEESYNC=0
export WINEFSYNC=1
export DXVK_ASYNC=0
export AMDVLK_ENABLE_DEVELOPING_EXT="all"

export CLASSPATH="$CLASSPATH:/usr/share/java/*"

# LaTeX plugins
export TEXINPUTS="$HOME/doc/tex/*/:$TEXINPUTS"
