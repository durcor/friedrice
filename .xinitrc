#!/bin/sh
# ~/.xinitrc

~/.config/wpg/wp_init.sh &
~/.fehbg &
setxkbmap -layout us,es -option caps:escape && setxkbmap -option grp:alt_shift_toggle &
xset r rate 150 35 &
source ~/.zshrc
i3
# export XDG_SESSION_TYPE=x11
# export GDK_BACKEND=x11
# exec gnome-session
