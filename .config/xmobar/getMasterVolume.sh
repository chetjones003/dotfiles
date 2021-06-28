#!/bin/sh

LEVEL=$(amixer get Master | tail -n1 | awk -F"[][]" '{ print $2}' | sed -e 's/%//')

MUTED=$(amixer get Master | tail -n1 | awk -F"[][]" '{ print $4}' | sed -e 's/off/M/' -e 's/on//')

if [ "$MUTED" == "M" ]; then
    echo ""$LEVEL"%"$MUTED
else
    echo ""$LEVEL"%"
fi
