#!/bin/bash

# TODO : make config thanks to the following
# lockcmd="swaylock --screenshots --clock --indicator-idle-visible --indicator-radius 100 --indicator-thickness 7 --ignore-empty-password --ring-color 53E2AE --ring-ver-color 53E2AE --ring-wrong-color EE4F84 --key-hl-color EE4F84 --text-color ffffff --text-ver-color ffffff --text-wrong-color EE4F84 --line-color 00000000 --inside-color 00000088 --inside-ver-color 00000088 --inside-wrong-color 00000088 --separator-color 00000000 --fade-in 0.15 --effect-blur 10x2 -c 0B0A10ff"
# lockcmd="swaylockd --screenshots --indicator --clock --inside-wrong-color f38ba8 --ring-wrong-color 11111b --inside-clear-color a6e3a1 --ring-clear-color 11111b --inside-ver-color 89b4fa --ring-ver-color 11111b --text-color  f5c2e7 --indicator-radius 80 --indicator-thickness 5 --effect-blur 10x7 --effect-vignette 0.2:0.2 --ring-color 11111b --key-hl-color f5c2e7 --line-color 313244 --inside-color 0011111b --separator-color 00000000 --fade-in 0.1"

sleep 0.5s; swaylock -f & disown
