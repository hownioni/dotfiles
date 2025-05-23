#!/usr/bin/env bash

output_file="$HOME/.config/qtile/scripts/display/xrandr_command.sh"

get_avail_res() {
    MONITOR="$1"
    xrandr | awk -v monitor="^$MONITOR connected" \
        '/connected/ {p = 0} $0 ~ monitor {p=1} p' |
        awk '/^ /{print $1}'
}

join_arr() {
    local IFS="$1"
    shift
    echo "$*"
}

readarray -td $'\n' connected_monitors < <(xrandr | grep " connected " | awk '{print $1}')

monitor=$(
    zenity --forms --title="Monitor to change" \
        --add-combo "Monitor" \
        --combo-values "$(join_arr '|' "${connected_monitors[@]}")"
)

readarray -td $'\n' resolutions < <(get_avail_res "$monitor")

readarray -td $'\n' settings < <(
    zenity --forms --title="Set resolution" \
        --add-combo "Resolutions" \
        --combo-values "$(join_arr '|' "${resolutions[@]}")" \
        --add-combo "Primary?" \
        --combo-values "yes|no" \
        --separator=$'\n'
)

if [[ "${settings[1]}" == "yes" ]]; then
    primary="--primary"
else
    primary=""
fi

printf 'xrandr --output %s --mode %s %s' "$monitor" "${settings[0]}" "$primary" >"$output_file"
"$HOME/.config/qtile/scripts/display/setup.sh" "${settings[0]}"
