# Declutter home
export CARGO_HOME=$HOME/.local/share/cargo
export INPUTRC=$HOME/.config/readline/inputrc

[ ! -d "$HOME"/.local/state/bash/ ] && mkdir "$HOME"/.local/state/bash/
export HISTFILE=$HOME/.local/state/bash/history
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc":"$HOME/.config/gtk-2.0/gtkrc.mine"
export XCURSOR_PATH=/usr/share/icons:$HOME/.local/share/icons
export PYTHONSTARTUP="$HOME"/.config/python/pythonrc
export PYTHON_HISTORY="$HOME"/.local/state/python/history
export WINEPREFIX=$HOME/.local/share/wine

[ ! -d "$HOME"/.local/share/npm/ ] && mkdir "$HOME"/.local/share/npm/
[ ! -d "$HOME"/.cache/npm/ ] && mkdir "$HOME"/.cache/npm/
export NPM_CONFIG_USERCONFIG=$HOME/.config/npm/npmrc
