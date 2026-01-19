# shellcheck shell=bash
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

if [[ -f "$HOME/.local/share/dotfiles/setup.sh" ]]; then
	"$HOME/.local/share/dotfiles/setup.sh"
fi

year=$(date +%Y)

export PATH="$PATH:$HOME/.local/bin"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export EDITOR='nvim'
export VISUAL='nvim'
export TERMINAL='kitty'
export MANPAGER='nvim +Man!'
export HOSTNAME
export LEDGER_FILE=$HOME/Documents/cuentas/${year}.journal
[[ "$XDG_SESSION_TYPE" == "x11" ]] && export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
[[ "$XDG_SESSION_TYPE" == "wayland" ]] && export QT_IM_MODULES="wayland;fcitx"
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus
export XMODIFIERS=@im=fcitx
export MOZ_USE_XINPUT2=1

unset year
