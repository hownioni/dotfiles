#!/usr/bin/env sh

### XDG Variables
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

### Declutter home
export CARGO_HOME="$XDG_DATA_HOME"/cargo

export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc

[ ! -d "$XDG_STATE_HOME"/bash/ ] && mkdir "$XDG_STATE_HOME"/bash
export HISTFILE="$XDG_STATE_HOME"/bash/history
[ ! -f "$HISTFILE" ] && touch "$HISTFILE"

export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc:"$XDG_CONFIG_HOME"/gtk-2.0/gtkrc.mine

export XCURSOR_PATH=/usr/share/icons:"$XDG_DATA_HOME"/icons

[ ! -d "$XDG_STATE_HOME"/python ] && mkdir "$XDG_STATE_HOME"/python
export PYTHON_HISTORY="$XDG_STATE_HOME"/python/history
[ ! -f "$PYTHON_HISTORY" ] && touch "$PYTHON_HISTORY"

export WINEPREFIX="$XDG_DATA_HOME"/wine

[ ! -d "$XDG_DATA_HOME"/npm/ ] && mkdir "$XDG_DATA_HOME"/npm
[ ! -d "$XDG_CACHE_HOME"/npm/ ] && mkdir "$XDG_CACHE_HOME"/npm
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc

[ ! -d "$XDG_DATA_HOME"/renpy ] && mkdir "$XDG_DATA_HOME"/renpy
export RENPY_PATH_TO_SAVES="$XDG_DATA_HOME"/renpy

export TERMINFO="$XDG_DATA_HOME"/terminfo
export TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo:/usr/share/terminfo

export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=${XDG_CONFIG_HOME}/java -Djavafx.cachedir=${XDG_CACHE_HOME}/openjfx"

export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle

export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel

export SQLITE_HISTORY="$XDG_CACHE_HOME"/sqlite_history
