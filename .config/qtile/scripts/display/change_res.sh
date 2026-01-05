#!/usr/bin/env bash

setup_home="$HOME/.local/share/dotfiles"
hostname="$(hostnamectl hostname)"

resolution="$(xdpyinfo | awk '/dimensions/{print $2}')"
[[ ! -d "$setup_home/screenlayout" ]] && mkdir "$setup_home/screenlayout"
while [[ ! -f "$setup_home/screenlayout/${hostname}.sh" ]]; do
	arandr
done
"$HOME/.local/share/dotfiles/setup.sh" "$resolution"
