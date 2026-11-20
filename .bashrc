# shellcheck shell=bash
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ -e "$HOME"/.config/bash/aliases ]]; then
	source "$HOME"/.config/bash/aliases
fi

if [[ -e "/usr/share/bash-complete-alias/complete_alias" ]]; then
	# shellcheck disable=SC1094
	source "/usr/share/bash-complete-alias/complete_alias"
fi

complete -F _complete_alias "${!BASH_ALIASES[@]}"

if [[ -e "$HOME"/.config/bash/functions ]]; then
	source "$HOME"/.config/bash/functions
fi

if [[ -d "$HOME/.cache/wal" ]] && ! hash matugen 2>/dev/null; then
	# Import colorscheme from 'wal' asynchronously
	# shellcheck disable=SC1091
	(cat "$HOME"/.cache/wal/sequences &)

	# To add support for TTYs this line can be optionally added.
	# shellcheck disable=SC1091
	source "$HOME"/.cache/wal/colors-tty.sh
fi

LFCD="$HOME/.config/lf/lfcd.sh"
if [ -f "$LFCD" ]; then
	# shellcheck disable=SC1090
	source "$LFCD"
fi

# Shopt
shopt -s checkwinsize

PS1='[\u@\h \W]\$ '

eval "$(zoxide init --cmd cd bash)"

# fzf
# List files with fd: skips hidden dirs (~/.cache, ~/.local/share, ...) and
# anything .gitignore'd / in ~/.ignore, so caches don't flood the results.
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
export FZF_DEFAULT_OPTS="--scheme=path --layout=reverse --height=50% --border --info=inline-right"
# Ctrl-T / Alt-C don't use FZF_DEFAULT_COMMAND; without these they include hidden dirs
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --strip-cwd-prefix'
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:200 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --level=2 --color=always {}'"
eval "$(fzf --bash)"

# ripgrep reads a config file only through this variable
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/config"
