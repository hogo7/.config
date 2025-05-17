#!/usr/bin/bash
img=(`find ~/Pictures/wallpapers/ -name '*' -exec file {} \; | grep -o -P '^.+: \w+ image' | cut -d':' -f1`)
feh --bg-scale  "${img[$RANDOM % ${#img[@]} ]}"
