#!/usr/bin/env bash

dotdata_dir="$HOME/.local/share/dotfiles"
source "$dotdata_dir"/helpers.sh
source "$dotdata_dir"/dpi.sh

setup_display() {
	local display_server resolution new_resolution dpi dpi_factor

	display_server="$(get_display_server)"
	if [[ "$display_server" == "x11" ]]; then
		resolution="$(xdpyinfo | awk '/dimensions/{print $2}')"
		new_resolution="$1"

		if ([[ ! -f "$vars_file" ]] || ! check_var "dpi") \
			|| [[ -n "$new_resolution" &&
				"$new_resolution" != "$resolution" ]]; then
			resolution="${new_resolution:-$resolution}"
			dpi="$(dpi_select "$resolution")"
			create_var "dpi" "$dpi"
		fi
	else
		dpi=96
		if [[ ! -f "$vars_file" ]] || ! check_var "dpi"; then
			create_var "dpi" "$dpi"
		fi
	fi

	dpi="$(get_var "dpi")"
	dpi="${dpi:-96}"
	dpi_factor="$(printf 'scale=2;%s/96\n' "$dpi" | bc 2>/dev/null || echo "1.00")"

	for template in "$templates"/*; do
		replace_template '<dpi>' "$dpi" "$template"
		replace_template '<dpi_factor>' "$dpi_factor" "$template"
	done

	if [[ "$display_server" == "x11" ]]; then
		[[ ! -d "$dotdata_dir/screenlayout" ]] && mkdir -p "$dotdata_dir/screenlayout"

		if [[ -f "$dotdata_dir/screenlayout/${hostneim}.sh" ]]; then
			"$dotdata_dir/screenlayout/${hostneim}.sh"
		fi

		Xresources="$HOME/.config/X11/Xresources"
		if [ -f "$Xresources" ]; then
			xrdb -merge "$Xresources"
		fi

		dunstctl reload 2>/dev/null &
		[[ -f "$HOME"/.fehbg ]] && "$HOME"/.fehbg &
	fi
}

main() {
	local display_server
	display_server="$(get_display_server)"

	if [[ $display_server != "tty" ]]; then
		setup_display "$@"
	fi
}

if get_display_server >/dev/null 2>&1; then
	main "$@"
fi
