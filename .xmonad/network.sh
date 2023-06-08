#!/usr/bin/env bash

network=$(nmcli general | awk '/^[c,d]/ {print $1}')
echo "$network"
