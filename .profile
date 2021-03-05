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
export TERMINAL="kitty -1"
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
export GTK_THEME="oomox-colors-oomox"
export QT_QPA_PLATFORMTHEME="gtk2"
export LYNX_CFG="$HOME/.lynxrc"
# Because some programs can't find the pulse cookie on their own I guess
export PULSE_COOKIE="$HOME/.pulse-cookie"

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
export WINEESYNC=1
export WINEFSYNC=1
## DXVK
export DXVK_HUD="compiler"
export DXVK_ASYNC=0
## Graphics
export AMDVLK_ENABLE_DEVELOPING_EXT="all"
export ENABLE_VKBASALT=0
export mesa_glthread=true
export RADV_PERFTEST="pswave32,gewave32,cswave32,tccompatcmask,sam"
export VAAPI_MPEG4_ENABLED=true

# Dev Environment
export GOPATH="$XDG_DATA_HOME/go"
export CLASSPATH="$CLASSPATH:/usr/share/java/*"
## LaTeX plugins
export TEXINPUTS="$HOME/doc/tex/*/:$TEXINPUTS"

[ "$TERM" = "linux" ] && {
    . "$XDG_CACHE_HOME/wal/colors-tty.sh"
    sudo -n kbdrate -r 35 -d 150 >/dev/null
}

[ ! "$SSH_TTY" ] && [ ! "$DISPLAY" ] && {
	echo "How do you wish to log in?"
	echo "Run $(tput bold)sway ($(tput setaf 2)w$(tput sgr0))"
	echo "Run $(tput bold)i3 ($(tput setaf 5)x$(tput sgr0))"
	echo "Stay in $(tput bold)tty ($(tput setaf 6)t$(tput sgr0))"
	tput sgr0

	read -r disp
	while [ "$disp" != "t" ] && [ "$disp" != "x" ] && [ "$disp" != "w" ]; do
		tput setaf 1
		echo "Invalid input. Please input w, x, or t"
		tput sgr0
		read -r disp
	done
}

[ "$SSH_TTY" ] && disp=t

if [ "$disp" = "x" ]; then
	# Set up multi-monitor FreeSync correctly
	sway &
	sleep 5
	SWAYSOCK="/run/user/$(id -u)/sway-ipc.$(id -u).$(pgrep -x sway).sock" sway exit
	startx
elif [ "$disp" = "w" ]; then
	export QT_QPA_PLATFORM=wayland
	export SDL_VIDEODRIVER=wayland
	export XDG_CURRENT_DESKTOP=sway
	export MOZ_ENABLE_WAYLAND=1
	sway
elif [ "$disp" = "t" ]; then
	# clear
	neofetch
fi

# Added by Nix installer
# if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi
