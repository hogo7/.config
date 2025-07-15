#!/usr/bin/env bash
img=(`find ~/Pictures/wallpapers/ -name '*' -exec file {} \; | grep -o -P '^.+: \w+ image' | cut -d':' -f1`)
swaybg -m fill -i "${img[$RANDOM % ${#img[@]} ]}"
