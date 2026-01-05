#!/usr/bin/env bash

if [ "$#" != 0 ]; then
	resolution="$1"
else
	resolution="$(xdpyinfo | awk '/dimensions/{print $2}')"
fi

while true; do
	dpi="$(
		zenity --entry \
			--title="DPI Selection" \
			--width=350 \
			--text="Current resolution: ${resolution}\nLook up https://dpi.lv for recommended value (preferrably a factor of 96)."
	)"
	dpi=${dpi:="96"}
	ans=$?
	[[ $ans == 0 ]] && break
done
