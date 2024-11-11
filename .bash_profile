#
# ~/.bash_profile
#
#
# shellcheck source=./.bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Load profiles from $HOME/.config/bash/profile
if test -d "$HOME"/.config/bash/profile/; then
    for profile in "$HOME"/.config/bash/profile/*.sh; do
        test -r "$profile" && . "$profile"
    done
    unset profile
fi

year=$(date +%Y)

export PATH="$PATH:$HOME/.local/bin"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export EDITOR='nano'
export VISUAL='nvim'
export MANPAGER='nvim +Man!'
export QT_QPA_PLATFORMTHEME=qt5ct:qt6ct
export SAL_USE_VCLPLUGIN=qt5
export LEDGER_FILE=$HOME/Documents/cuentas/${year}.journal

unset year
