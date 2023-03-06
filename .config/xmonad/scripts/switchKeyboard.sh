#! /bin/bash

LAYOUT=$(echo $(setxkbmap -query | grep "layout: " | awk '{print $2}'))

if [ $LAYOUT = "se" ]; then
    setxkbmap -layout us
else 
    setxkbmap -layout se
fi
