#!/bin/bash

lf-dbus &
picom --daemon &
copyq &
flameshot &
steam -silent &
heroic &
blueman-applet &
udiskie -t &
syncthingtray qt-widgets-gui --single-instance --wait &
snapclient &

# qbittorrent
pgrep '^qbittorrent$' || qbittorrent &>/dev/null &
sleep 1
xdotool search --class qbittorrent windowunmap

[[ -z $(jobs) ]] || disown
exit 0
