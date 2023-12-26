#!/usr/bin/bash

# ----------------------------------------------------- 
# Startup
# ----------------------------------------------------- 

scripts=$HOME/.config/scripts

## Notification daemon
dunst -config ~/.config/dunst/dunstrc &

## battery notification
$scripts/battery_notification.sh &

## screen locking when idle
$scripts/idle_handler.sh &

## clipboard
wl-clip-persist --clipboard regular &
wl-paste --watch cliphist store &

## KDE Polkit
/usr/lib/polkit-kde-authentication-agent-1 &

## KDE Connect
/usr/lib/kdeconnectd & # Should I ? -platform offscreen &

## If Portal problems :
# $hyprDir/scripts/hyprland_portal.sh

## Is this necessary ?
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

## Use until EWW configured
blueman-applet & 
nm-applet --indicator &

## Setup Wallpapers & Colors with pywal
swww init &
$scripts/random_wallpaper.sh &

## Start Waybar
$scripts/status_bar.sh &

# Wlsunset apply temperature TODO check values
wlsunset -t 4000 -T 6500 -d 900 -S 07:00 -s 19:00 &

# Starts the Emacs server
emacs --daemon
