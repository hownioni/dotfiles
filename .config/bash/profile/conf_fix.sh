#!/usr/bin/env bash

[[ ! -d "$HOME/.cache/wal" ]] && wal -i "$HOME/Pictures/Wallpapers/Disco_Elysium"
[[ ! -d "$HOME/.config/dunst" ]] && mkdir "$HOME/.config/dunst"
[[ ! -d "$HOME/.config/dunst/dunstrc.d" ]] && mkdir "$HOME/.config/dunst/dunstrc.d"
[[ ! -L "$HOME/.config/dunst/dunstrc.d/00-colors-dunst.conf" ]] && ln -s "$HOME/.cache/wal/00-colors-dunst.conf" "$HOME/.config/dunst/dunstrc.d/00-colors-dunst.conf"
