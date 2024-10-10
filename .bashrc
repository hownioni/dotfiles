#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ -e "$HOME"/.config/bash/aliases ]]; then
    source "$HOME"/.config/bash/aliases
fi

if [[ -e "/usr/share/bash-complete-alias/complete_alias" ]]; then
    source "/usr/share/bash-complete-alias/complete_alias"
fi

complete -F _complete_alias "${!BASH_ALIASES[@]}"

if [[ -e "$HOME"/.config/bash/functions ]]; then
    source "$HOME"/.config/bash/functions
fi

# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# Not suppoerted in the "fish" shell.
(cat ~/.cache/wal/sequences &)

# To add support for TTYs this line can be optionally added.
source ~/.cache/wal/colors-tty.sh

LF="$HOME/.config/lf/lf.sh"
if [ -f "$LF" ]; then
    source "$LF"
fi

# Shopt
shopt -s checkwinsize

PS1='[\u@\h \W]\$ '

eval "$(zoxide init --cmd cd bash)"
