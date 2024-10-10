#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export EDITOR='nano'
export VISUAL='nvim'
export MANPAGER='nvim +Man!'
export PATH="$PATH:$HOME/.local/bin"
export QT_QPA_PLATFORMTHEME="qt6ct"
export SAL_USE_VCLPLUGIN=qt5
export LEDGER_FILE=$HOME/Documents/cuentas/"$(date +%Y)".journal

# Declutter home
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
