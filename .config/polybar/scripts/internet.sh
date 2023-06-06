#!/usr/bin/env bash

wifistatus="$(cat /sys/class/net/wlan0/operstate)"
ethstatus="$(cat /sys/class/net/lo/operstate)"
if [ $wifistatus = "up" ]; then 
    essid="$(nmcli c | sed -n '2{p;q}' | awk '{print $1}')"
    quality="$(cat /proc/net/wireless |  sed -n '3{p;q}' | awk '{printf "%.0f\n",$3}')"
    icon=" "
elif [ $ethstatus = "up" ]; then
    essid="$(nmcli c | sed -n '2{p;q}' | awk '{print $5}')"
    quality=""
    icon=""
elif [ -d /sys/class/net/enp5s* ]; then
    essid="$(nmcli c | sed -n '2{p;q}' | awk '{print $5}')"
    quality=""
    icon=""
else
    essid="Disconnected"
    quality=""
    icon=""
fi
echo "$icon $essid"
