#!/usr/bin/env bash

setup_home="$HOME/.local/share/dotfiles"
vars_file="$setup_home/vars"
templates="$setup_home/templates"
hostneim="$(hostnamectl hostname)"

check_var() {
	var="$1"
	grep -q "<${var}>" "$vars_file"
}

create_var() {
	var="$1"
	value="$2"
	if [[ ! -f "$vars_file" ]] || ! grep -q "$var" "$vars_file"; then
		printf "<%s> %s\n" "$var" "$value" >>"$vars_file"
	else
		awk -i inplace "/${var}/{\$2=${value};print}" "$vars_file"
	fi
}

replace_template() {
	placeholder="$1"
	value="$2"
	template="$3"
	location="${HOME}/$(awk '/<location>/{print $2}' "$template")"
	mkdir -p "${location%/*}"
	if grep -q "$placeholder" "$template"; then
		sed '/<location>/,+1 d' "$template" \
			| sed "s/${placeholder}/${value}/g" >"$location"
	fi
}

resolution="$(xdpyinfo | awk '/dimensions/{print $2}')"
new_resolution="$1"
if ([[ ! -f "$vars_file" ]] || ! check_var "dpi") || [[ $# != 0 && "$new_resolution" != "$resolution" ]]; then
	resolution="$new_resolution"
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
	create_var "dpi" "$dpi"
fi

dpi="$(awk '/<dpi>/{print $2}' "$vars_file")"
dpi_factor="$(printf 'scale=2;%s/96\n' "$dpi" | bc)"

for template in "$templates"/*; do
	replace_template '<dpi>' "$dpi" "$template"
	replace_template '<dpi_factor>' "$dpi_factor" "$template"
done

Xresources="$HOME/.config/X11/Xresources"

[[ ! -d "$setup_home/screenlayout" ]] && mkdir "$setup_home/screenlayout"

if [[ -f "$setup_home/screenlayout/${hostneim}.sh" ]]; then
	"$setup_home/screenlayout/${hostneim}.sh"
fi

if [ -f "$Xresources" ]; then
	xrdb -merge "$Xresources"
fi

dunstctl reload &
"$HOME"/.fehbg &
