#!/bin/sh
# ~/.profile

# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

export PATH="$PATH:$HOME/bin"

if which ruby >/dev/null && which gem >/dev/null
then
    PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

export EDITOR=nvim
export VISUAL=nvim
export TERMINAL=st
export BROWSER=copytoclip
export GUIBROWSER=qutebrowser
#export BROWSER=qutebrowser
#export BROWSER=~/bin/linkhandler
export PAGER=less
export FILEMAN=ranger
export TASKMAN=gotop
export READER=zathura
#[ "$XDG_CURRENT_DESKTOP" = "KDE" ] || [ "$XDG_CURRENT_DESKTOP" = "GNOME" ] || export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_QPA_PLATFORMTHEME=qt5ct
#export QT_AUTO_SCREEN_SCALE_FACTOR=0
export LYNX_CFG=~/.lynxrc

if [ $TERM = linux ]
then
	source ~/.config/wpg/formats/colors-tty.sh
	sudo -n loadkeys ~/.config/ttymaps.kmap 2>/dev/null
	sudo -n kbdrate -r 35 -d 150
fi

source ~/.zshal
#source ~/.shal

source ~/.config/wpg/formats/colors.sh
source ~/.mancolors
source ~/.spooky
