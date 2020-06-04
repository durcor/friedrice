#!/bin/zsh
# ~/.xinitrc

~/.config/wpg/wp_init.sh &
~/.fehbg &
setxkbmap -layout us,es -option caps:escape 
xset r rate 150 35 &
source ~/.zshrc
i3
