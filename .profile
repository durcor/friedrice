#!/bin/sh
# ~/.profile
#
# shellcheck disable=1091
#
# Put stuff here that you only want sourced when
# initializing login shells

. "$HOME/.mancolors"
. "$HOME/.config/lf/ico"
. "$HOME/.secret"

# Default Programs
export EDITOR="edit"
export VISUAL="$EDITOR"
# export TERMINAL="kitty -1"
export TERMINAL="wezterm"
export BROWSER="copytoclip"
# export GUIBROWSER="qutebrowser"
# export GUIBROWSER="firefox-nightly"
export GUIBROWSER="firedragon"
export PAGER="nvimpager -p"
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
## TODO: Move to ~/.local/etc or ~/etc
export XDG_CONFIG_HOME="$HOME/.config"
## TODO: Move to ~/.local/cache or ~/cache or ~/var/cache
export XDG_CACHE_HOME="$HOME/.cache"
## TODO: Keep at current place or move to ~/share
export XDG_DATA_HOME="$HOME/.local/share"
## TODO: Keep at current place or move to ~/var/log
export XDG_STATE_HOME="$HOME/.local/state"

## Wine
export WINEESYNC=1
export WINEFSYNC=1
export STAGING_SHARED_MEMORY=1
export STAGING_WRITECOPY=1
## DXVK
export DXVK_HUD="compiler"
export DXVK_ASYNC=0
## Graphics
export AMDVLK_ENABLE_DEVELOPING_EXT="all"
export ENABLE_VKBASALT=0
# export mesa_glthread=true
# export RADV_FORCE_VRS="2x2"
# pswave32,gewave32,cswave32
export RADV_PERFTEST="rt,sam,nv_ms"
export VAAPI_MPEG4_ENABLED=true

# Dev Environment
export GOPATH="$XDG_DATA_HOME/go"
export CLASSPATH="$CLASSPATH:/usr/share/java/*"
## LaTeX plugins
export TEXINPUTS="$HOME/doc/tex/*/:$TEXINPUTS"

[ "$TERM" = linux ] && {
	. "$XDG_CACHE_HOME/wal/colors-tty.sh"
	sudo -n kbdrate -r 35 -d 150 >/dev/null
}

if [ "$SSH_TTY" ]; then
	disp=t
elif [ ! "$TMUX" ] && [ ! "$DISPLAY" ]; then
	echo "How do you wish to log in?"
	echo "Run $(tput bold)sway ($(tput setaf 2)w$(tput sgr0))"
	echo "Run $(tput bold)i3 ($(tput setaf 5)x$(tput sgr0))"
	echo "Stay in $(tput bold)tty ($(tput setaf 6)t$(tput sgr0))"
	tput sgr0

	read -r disp
	while [ "$disp" != t ] && [ "$disp" != x ] && [ "$disp" != w ]; do
		tput setaf 1
		echo "Invalid input. Please input w, x, or t"
		tput sgr0
		read -r disp
	done
fi

case $disp in
x)
	# Set up multi-monitor FreeSync correctly
	# sway &
	# sleep 5
	# SWAYSOCK="/run/user/$(id -u)/sway-ipc.$(id -u).$(pgrep -x sway).sock" sway exit
	startx
	;;
w)
	# export WLR_RENDERER=vulkan
	export QT_QPA_PLATFORM=wayland
	export SDL_VIDEODRIVER=wayland
	export XDG_CURRENT_DESKTOP=sway
	export MOZ_ENABLE_WAYLAND=1
	sway
	;;
t)
	neofetch
	;;
esac
