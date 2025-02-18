[[ ! -d "$HOME/.cache/wal" ]] && wal -i "$HOME/Pictures/Wallpapers/Disco_Elysium"
[[ ! -d "$HOME/.config/dunst" ]] && mkdir "$HOME/.config/dunst"
[[ ! -L "$HOME/.config/dunst/dunstrc" ]] && ln -s "$HOME/.cache/wal/dunstrc" "$HOME/.config/dunst/dunstrc"
