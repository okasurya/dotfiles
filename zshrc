# utility function
_have() { type "$1" &>/dev/null; }

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
plugins=(
  git brew history kubectl npm golang z aws
)
source $ZSH/oh-my-zsh.sh

# alias & export
_have vim && export EDITOR="vim"
_have vim && _have nvim && alias vim="nvim"
_have nvim && export EDITOR="nvim"

## tools
if _have nordvpn; then
    alias nvp="nordvpn connect"
    alias nvpus="nordvpn connect united_states"
    alias nvpd="nordvpn disconnect"
fi

if _have pyenv; then
    alias python="$(pyenv which python)"
    alias pip="$(pyenv which pip)"
fi

[[ -f "$HOME/vpn/do.sh" ]] &&  alias v="~/vpn/do.sh sgp"

# local config 
# naming derived from brlntrc, shorten to brc 
source ~/.brc

# pure theme
ZSH_THEME=""
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure
