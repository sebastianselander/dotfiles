#!/bin/bash

STATUS=$(mullvad status | awk '{ print $1 }')
if [ $STATUS = "Connected" ]; then
    echo -e "Mullvad: On"
else
    echo -e "Mullvad: Off"
fi

