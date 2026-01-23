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
if [[ "$(hostnamectl chassis)" == "laptop" ]]; then
	eval "$(_AUTO_CPUFREQ_COMPLETE=bash_source auto-cpufreq)"
fi
