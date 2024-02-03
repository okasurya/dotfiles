# utility function
_have() { type "$1" &>/dev/null; }
_source_if() { [[ -r "$1" ]] && source "$1"; }
# usually for mac usage
_dot_if() { [[ -r "$1" ]] && . "$1"; }

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
plugins=(
  git brew history kubectl npm golang z aws
)
source $ZSH/oh-my-zsh.sh

# pure theme
ZSH_THEME=""
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

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

# TODO: add checking if mac
export PATH="$PATH:/opt/homebrew/bin"
_have fvm && export PATH="$PATH:$HOME/fvm/default/bin"
_have maestro && export PATH=$PATH:$HOME/.maestro/bin

[[ -f "$HOME/vpn/do.sh" ]] &&  alias v="$HOME/vpn/do.sh sgp"

_dot_if "/opt/homebrew/etc/profile.d/z.sh"
_dot_if "/usr/share/z/z.sh"
_dot_if "/opt/homebrew/opt/asdf/libexec/asdf.sh"

# local config 
# naming derived from brlntrc, shorten to brc 
_source_if "$HOME/.brc"
