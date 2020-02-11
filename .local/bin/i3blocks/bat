#!/usr/bin/env sh
# Give a battery name (e.g. BAT0) as an argument.

case $BLOCK_BUTTON in
    1);;
    2);;
    3);;
esac

#   full battery
#   almost full battery
#   half full battery
#   low battery
#   no battery/dead

# capacity=$(echo scale=4\;$(cat /sys/class/power_supply/BAT0/charge_now)/$(cat /sys/class/power_supply/BAT0/charge_full)\*100 | bc | sed 's/0\{1,\}$//') || exit
capacity=$(cat /sys/class/power_supply/BAT0/capacity)
kernelcapacity=$(cat /sys/class/power_supply/BAT0/charge_now)
kernelalarm=$(cat /sys/class/power_supply/BAT0/alarm)
status=$(cat /sys/class/power_supply/BAT0/status)

source ~/.cache/wal/colors.sh

color=$color7

if [ "$capacity" -ge 90 ]
then
	color=$color7
    icon=" "
elif [ "$capacity" -ge 60 ]
then
	color="#ffffff"
    icon=" "
elif [ "$capacity" -ge 40 ]
then
	color="#ffff00"
    icon=" "
elif [ "$capacity" -ge 10 ]
then
	color="#ff0000"
    icon=" "
else
    color="#ff0000"
    icon=" "
fi

if [ "$kernelcapacity" -ge "$kernelalarm" ]
then
    alarm=""
else
	alarm="❗"
fi


case $status in
    Full)
        statusicon=\=
        ;;
    Charging)
        statusicon=\+
        statuscolor="#00ff00"
        ;;
    Discharging)
        statusicon=\-
        statuscolor="#ff0000"
        ;;
    Unknown)
        statusicon=\*
        ;;
    'Not Charging')
        statusicon=\!
        ;;
esac
 
# printf "<span color='%s'>%s</span><span color='%s'>%s</span>\n" "$color" "$alarm$capacity%" "$statuscolor" "$statusicon $icon"
printf "<span color='%s'>%s</span>\n" "$color" "$alarm$capacity%$statusicon $icon"
