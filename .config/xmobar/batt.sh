#!/bin/sh

CHARGESTAT=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep 'state' | awk -F" " '{ print $2 }' | sed -e 's/discharging//' -e 's/charging/+/')

LEVEL=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep 'percentage' | awk -F" " '{ print $2 }' | sed -e 's/%//')

if [ "$CHARGESTAT" == "+" ]
then
    echo ""$LEVEL"$CHARGESTAT%"
elif [ "$LEVEL" -lt "20" ]
then
    echo ""$LEVEL"%!"
elif [ "$LEVEL" -ge "88" ]
then
    echo ""$LEVEL"%"
else
    echo ""$LEVEL"%"
fi
