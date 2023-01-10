#!/bin/bash

STATUS=$(mullvad status | awk '{ print $1 }')
if [ $STATUS = "Connected" ]; then
    echo "Mullvad: On"
else
    echo "Mullvad: Off"
fi
