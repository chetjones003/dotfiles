#!/usr/bin/env bash

update=$(apt list --upgradeable | wc -l)
echo "$update updates "
