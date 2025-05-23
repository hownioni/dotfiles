#!/usr/bin/env bash

vars_file="$HOME/.config/qtile/scripts/display/vars"
templates="$HOME/.config/qtile/scripts/display/templates"

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
        sed '/<location>/,+1 d' "$template" |
            sed "s/${placeholder}/${value}/g" >"$location"
    fi
}

resolution="$(xdpyinfo | awk '/dimensions/{print $2}')"
if ([[ ! -f "$vars_file" ]] || ! check_var "dpi") || [[ $# != 0 && "$1" != "$resolution" ]]; then
    [[ $# != 0 ]] && resolution="$1"
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

dpi="$(awk '/dpi/{print $2}' "$vars_file")"
dpi_factor="$(printf 'scale=2;%s/96\n' "$dpi" | bc)"

for template in "$templates"/*; do
    replace_template '<dpi>' "$dpi" "$template"
    replace_template '<dpi_factor>' "$dpi_factor" "$template"
done

Xresources="$HOME/.config/X11/Xresources"

if [[ -f "$HOME/.config/qtile/scripts/display/xrandr_command.sh" ]]; then
    bash "$HOME/.config/qtile/scripts/display/xrandr_command.sh"
fi

if [ -f "$Xresources" ]; then
    xrdb -merge "$Xresources"
fi
