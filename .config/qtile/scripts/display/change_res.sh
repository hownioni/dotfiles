#!/usr/bin/env bash

resolution="$(xdpyinfo | awk '/dimensions/{print $2}')"
arandr
"$HOME/.config/qtile/scripts/display/setup.sh" "$resolution"
