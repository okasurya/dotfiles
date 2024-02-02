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
    eval "$(pyenv init -)"
    alias python="$(pyenv which python)"
    alias pip="$(pyenv which pip)"
fi

if _have volta; then
    export VOLTA_HOME="$HOME/.volta"
    export PATH="$PATH:$VOLTA_HOME/bin"
fi

if _have go; then
    export GOPATH=$HOME/go
    export PATH="$PATH:$GOPATH/bin"
fi

_have brew && export PATH="$PATH:/opt/homebrew/bin"

_have fvm && export PATH="$PATH:$HOME/fvm/default/bin"

[[ -f "$HOME/vpn/do.sh" ]] &&  alias v="$HOME/vpn/do.sh sgp"

# local config 
# naming derived from brlntrc, shorten to brc 
source ~/.brc

# pure theme
ZSH_THEME=""
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure
