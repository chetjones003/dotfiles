#!/usr/bin/env bash

brightness=$(xrandr --verbose | grep Brightness | grep -o '[0-9].*' | awk '{print $0 * 100}')
echo " $brightness%"
