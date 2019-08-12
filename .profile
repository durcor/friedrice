#!/bin/sh
# ~/.profile

# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

if which ruby >/dev/null && which gem >/dev/null
then
    PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

if [ $TERM = linux ]
then
	source ~/.config/wpg/formats/colors-tty.sh &
	sudo -n loadkeys ~/.config/ttymaps.kmap 2>/dev/null &
	sudo -n kbdrate -r 35 -d 150
fi

source ~/.config/wpg/formats/colors.sh
source ~/.mancolors
source ~/.config/environment
source ~/.spooky

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  startx
  export DISPLAY=":0.0"
fi
