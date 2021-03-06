#!/bin/bash

iwconfig wlp2s0b1 2>&1 | grep -q no\ wireless\ extensions\. && {
  echo wired
  exit 0
}

# Get name of connection
essid=$(iwconfig wlp2s0b1 | awk -F '"' '/ESSID/ {print $2}')

# Get strength of connection
stngth=$(iwconfig wlp2s0b1 | awk -F '=' '/Quality/ {print $2}' | cut -d '/' -f 1)

# Normalize strength number for bars
bars=$(("$stngth" / 10))

case $bars in
  0)  bar='[----------]' ;;
  1)  bar='[/---------]' ;;
  2)  bar='[//--------]' ;;
  3)  bar='[///-------]' ;;
  4)  bar='[////------]' ;;
  5)  bar='[/////-----]' ;;
  6)  bar='[//////----]' ;;
  7)  bar='[///////---]' ;;
  8)  bar='[////////--]' ;;
  9)  bar='[/////////-]' ;;
  10) bar='[//////////]' ;;
  *)  bar='[----!!----]' ;;
esac

echo "$essid" "$bar"

exit 0
