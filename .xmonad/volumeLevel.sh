#!/usr/bin/env bash

volumeLevel=$(amixer | awk 'NR==6 {print $5}' | awk '{gsub(/\[|\]/,"")}1')
volumeToggle=$(amixer | awk 'NR==6 {print $6}')
echo "Volume: $volumeLevel $volumeToggle"
