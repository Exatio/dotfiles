#!/bin/bash

screenOff="sleep 5; hyprctl dispatch dpms off"
screenOn="hyprctl dispatch dpms on"
lockcmd="$HOME/.config/scripts/lock.sh"

sway-audio-idle-inhibit &
swayidle -w timeout 900 "$lockcmd & $screenOff" resume "$screenOn"
