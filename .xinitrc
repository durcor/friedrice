#!/bin/sh
# ~/.xinitrc

~/.config/wpg/wp_init.sh &
~/.fehbg &
setxkbmap -layout us,es -option caps:escape && setxkbmap -option grp:alt_shift_toggle &
redshift &
xset r rate 150 35 &
dunst &
clipmenud &
musnify-mpd &
# nm-applet &
# mpdscribble &
barriers -c ~/.barrier.conf &
i3
