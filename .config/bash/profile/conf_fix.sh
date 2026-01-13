#!/usr/bin/env bash

if [[ ! -d "$HOME/.cache/wal" ]] && ! hash matugen 2>/dev/null; then
	wal -i "$HOME/Pictures/Wallpapers/Disco_Elysium"
fi

[[ ! -d "$HOME/.config/dunst" ]] && mkdir "$HOME/.config/dunst"
[[ ! -d "$HOME/.config/dunst/dunstrc.d" ]] && mkdir "$HOME/.config/dunst/dunstrc.d"

if [[ ! -L "$HOME/.config/dunst/dunstrc.d/00-colors-dunst.conf" ]] && [[ -d "$HOME/.cache/wal" ]]; then
	ln -s "$HOME/.cache/wal/00-colors-dunst.conf" "$HOME/.config/dunst/dunstrc.d/00-colors-dunst.conf"
fi
