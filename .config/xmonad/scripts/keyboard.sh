#! /bin/bash

# show current keyboard layout
echo $(setxkbmap -query | grep "layout: " | awk '{print $2}')
