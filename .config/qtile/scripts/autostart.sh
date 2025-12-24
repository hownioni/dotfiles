#!/bin/bash

dev_type=$(hostnamectl chassis)

lf-dbus &
picom --daemon &
copyq &
QT_ENABLE_HIGHDPI_SCALING=0 flameshot &
blueman-applet &
udiskie -t &
fcitx5 &
kdeconnect-indicator &
caffeine start &

if [[ "$dev_type" != "laptop" ]]; then
	# qbittorrent
	pgrep '^qbittorrent$' || qbittorrent &>/dev/null &
	sleep 1
	xdotool search --class qbittorrent windowunmap
	mangohud steam -silent &
fi

[[ -z $(jobs) ]] || disown
exit 0
