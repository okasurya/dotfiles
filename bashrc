# utility function
_have() { type "$1" &>/dev/null; }
_source_if() { [[ -r "$1" ]] && source "$1"; }

# usually for mac usage
_dot_if() { [[ -r "$1" ]] && . "$1"; }

# -------------------- prompt styling --------------------

PROMPT_AT=@

__ps1() {
  local P='$' dir="${PWD##*/}" B short \
    r='\[\e[31m\]' h='\[\e[34m\]' \
    u='\[\e[33m\]' p='\[\e[34m\]' w='\[\e[35m\]' \
    b='\[\e[36m\]' x='\[\e[0m\]' y='\[\e[97m\]'

  [[ $EUID == 0 ]] && P='#' && u=$r && p=$u # root
  [[ $PWD = / ]] && dir=/
  [[ $PWD = "$HOME" ]] && dir='~'
  
  B=$(git branch --show-current 2>/dev/null)
  [[ $B == master || $B == main ]] && b="$r"
  [[ -n "$B" ]] && B="$y($b$B$y)"
  
  short="$u\u$y$PROMPT_AT$h\h$y:$w$dir$B\n$p$P$x "
  
  PS1="$short"
}

# append rather than overwrite
shopt -s histappend
# attempts to save all lines of a multiple-line command in the same history entry
shopt -s cmdhist
# with cmdhist, saved with embedded newlines rather than semicolon separators 
shopt -s lithist

HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000
HISTTIMEFORMAT="%y/%m/%d %T "
HISTIGNORE="history:ls:l:pwd:exit:"
if [[ ${BASH_VERSION:0:1} -gt 5 || ${BASH_VERSION:0:1} -ge 5 && ${BASH_VERSION:2:1} -ge 1 ]]; then
  PROMPT_COMMAND=("history -a" "history -c" "history -r" "__ps1")
else
  PROMPT_COMMAND="history -a; history -c; history -r; __ps1"
fi

# PROMPT_COMMAND="__ps1"

# --------------------------------------------------------

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

_have kubectl && alias k=kubectl
_have kubectl && complete -F __start_kubectl k

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

[[ -f "$HOME/vpn/do.sh" ]] && alias v="$HOME/vpn/do.sh"

_dot_if "/opt/homebrew/etc/profile.d/z.sh"
_dot_if "/usr/share/z/z.sh"
_dot_if "/opt/homebrew/opt/asdf/libexec/asdf.sh"

_have fzf && eval "$(fzf --bash)"
_dot_if "/opt/homebrew/opt/fzf/shell/key-bindings.bash"

# local config 
# naming derived from brlntrc, shorten to brc 
_source_if "$HOME/.brc"

# ----------------------- completion ---------------------

_dot_if "/usr/local/etc/profile.d/bash_completion.sh"
_dot_if "/opt/homebrew/etc/profile.d/bash_completion.sh"

_have z && . <(z completion bash)

# --------------------------------------------------------

