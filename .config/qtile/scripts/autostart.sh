#!/bin/bash

dev_type=$(hostnamectl chassis)

lf-dbus &
picom --daemon &
copyq &
flameshot &
blueman-applet &
udiskie -t &
fcitx5 &
kdeconnect-indicator &

if [[ "$dev_type" != "laptop" ]]; then
    # qbittorrent
    pgrep '^qbittorrent$' || qbittorrent &>/dev/null &
    sleep 1
    xdotool search --class qbittorrent windowunmap
    mangohud steam -silent &
fi

[[ -z $(jobs) ]] || disown
exit 0
