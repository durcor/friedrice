#!/bin/bash

case $BLOCK_BUTTON in
	1) $TERMINAL -e pulsemixer & disown ;;
	3) pamixer -t ;;
	4) pamixer -i 5 ;;
	5) pamixer -d 5 ;;
esac

printpastatus() { [[ $(pamixer --get-mute) = "true" ]] && echo -n  && exit
echo  $(pamixer --get-volume)% ;}
printpastatus
