#!/usr/bin/env bash

dpi_select() {
	local resolution dpi ans

	if [ "$#" != 0 ]; then
		resolution="$1"
	elif command -v xdpyinfo >/dev/null 2>&1; then
		resolution="$(xdpyinfo | awk '/dimensions/{print $2}')"
	else
		resolution="Unknown"
	fi

	while true; do
		dpi="$(
			zenity --entry \
				--title="DPI Selection" \
				--width=350 \
				--text="Current resolution: ${resolution}\nLook up https://dpi.lv for recommended value (preferrably a factor of 96)." \
				2>/dev/null
		)"
		ans=$?

		if [[ $ans != 0 ]]; then
			printf 'WARNING: zenity dialog canceled or failed, using default DPI: 96\n' >&2
			dpi="96"
			break
		fi

		if [[ -z "$dpi" ]]; then
			printf 'INFO: Empty input, using default DPI: 96\n' >&2
			dpi="96"
			break
		elif [[ "$dpi" =~ ^[0-9]+$ ]]; then
			break
		else
			zenity --error --text="'$dpi' is not a valid number. Please enter digits only." 2>/dev/null
		fi
	done

	printf '%s\n' "$dpi"
}

if [ "$0" = "${BASH_SOURCE[0]}" ]; then
	dpi_select "$@"
fi
