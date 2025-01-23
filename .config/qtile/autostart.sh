#!/bin/bash

lf-dbus &
picom --daemon &
copyq &
flameshot &
mangohud steam -silent &
blueman-applet &
udiskie -t &
syncthingtray qt-widgets-gui --single-instance --wait &
fcitx5 &
snapclient &
kdeconnect-indicator &

# qbittorrent
pgrep '^qbittorrent$' || qbittorrent &>/dev/null &
sleep 1
xdotool search --class qbittorrent windowunmap

[[ -z $(jobs) ]] || disown
exit 0
