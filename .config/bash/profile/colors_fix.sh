#!/usr/bin/env bash

check_symlink() {
	local target_file="$1"
	local link_path="$2"

	if [[ -e "$target_file" ]] && [[ ! -L "$link_path" ]]; then
		ln -s "$target_file" "$link_path"
	fi
}

display_server="$XDG_SESSION_TYPE"

case "$display_server" in
	"x11")
		### Pywal colors on X11
		if [[ ! -d "$HOME/.cache/wal" ]]; then
			wal -i "$HOME/Pictures/Wallpapers/Disco_Elysium"
		fi

		[[ ! -d "$HOME/.config/dunst/dunstrc.d" ]] && mkdir "$HOME/.config/dunst/dunstrc.d"
		check_symlink "$HOME/.cache/wal/00-colors-dunst.conf" "$HOME/.config/dunst/dunstrc.d/00-colors-dunst.conf"
		;;
	"wayland")
		### DMS colors on Wayland
		check_symlink "$HOME/.config/nvim/lua/plugins/dankcolors.lua" "$HOME/.config/nvim/lua/migu/plugins/ui/dankcolors.lua"
		;;
esac

unset -f check_symlink
unset -v display_server
