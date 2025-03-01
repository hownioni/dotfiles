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
export TERMINAL='kitty'
export MANPAGER='nvim +Man!'
export LEDGER_FILE=$HOME/Documents/cuentas/${year}.journal
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus
export XMODIFIERS=@im=fcitx

unset year
