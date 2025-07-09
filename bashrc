# utility function
_dir_exist() { 
    if [[ -d "$1" ]]; then 
        return 0 # return true (exit status 0) 
    else
        return 1
    fi
} 
_file_exist() { 
    if [[ -f "$1" ]]; then 
        return 0 # return true (exit status 0) 
    else
        return 1
    fi
} 
_have() { type "$1" &>/dev/null; }
_source_if() { [[ -r "$1" ]] && source "$1"; }


# usually for mac usage
_dot_if() { [[ -r "$1" ]] && . "$1"; }

# -------------------- prompt styling --------------------

PROMPT_AT=@

__ps1() {
  # list of colors
  local r='\[\e[32m\]' h='\[\e[34m\]' \
  u='\[\e[33m\]' w='\[\e[35m\]' \
  b='\[\e[36m\]' x='\[\e[0m\]' y='\[\e[37m\]'

  local P='$' dir="" T B
  
  # timestamp format
  T="[\D{%H.%M%z}]"

  # directory path format
  [[ $EUID == 0 ]] && P='#' && u=$r && p=$u # root
  [[ $PWD = / ]] && dir=/
  [[ $PWD = "$HOME" ]] && dir='~'

  # git branch format
  B=$(git branch --show-current 2>/dev/null)
  [[ $B == master || $B == main ]] && b="$r"
  [[ -n "$B" ]] && B="$y+$b$B"

  PS1="$T $u\u$y$PROMPT_AT$h\h$y:$w$dir $B\n$h$P$x "
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

# --------------------------------------------------------

# alias & export
_have vim && export EDITOR="vim"
_have vim && _have nvim && alias vim="nvim"
_have nvim && export EDITOR="nvim"

## tools
# TODO: add checking if mac
_dir_exist "/opt/homebrew/bin" && export PATH="$PATH:/opt/homebrew/bin"

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

_have fvm && export PATH="$PATH:$HOME/fvm/default/bin"
_have maestro && export PATH=$PATH:$HOME/.maestro/bin

_dot_if "/opt/homebrew/etc/profile.d/z.sh"
_dot_if "/usr/share/z/z.sh"

_have fzf && eval "$(fzf --bash)"
_dot_if "/opt/homebrew/opt/fzf/shell/key-bindings.bash"

# local config 
# naming derived from brlntrc, shorten to brc 
_source_if "$HOME/.brc"

# ----------------------- completion ---------------------

_dot_if "/usr/local/etc/profile.d/bash_completion.sh"

# TODO: SOMEHOW BROKEN
# _dot_if "/opt/homebrew/etc/profile.d/bash_completion.sh"

_have z && . <(z completion bash)

# --------------------------------------------------------

# git alias
# copied from oh-my-zsh plugin.
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh
__git_prompt_git() {
    GIT_OPTIONAL_LOCKS=0 command git "$@"
}

git_current_branch() {
    local ref
    ref=$(__git_prompt_git symbolic-ref --quiet HEAD 2> /dev/null)
    local ret=$?
    if [[ $ret != 0 ]]; then
        [[ $ret == 128 ]] && return  # no git repo.
        ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null) || return
    fi
    echo ${ref#refs/heads/}
}

alias gs='git status'

alias gco='git checkout'
alias gcb='git checkout -b'

alias gc!='git commit --verbose --amend'
alias gc='git commit --verbose'

alias gfa='git fetch --all --tags --prune --jobs=10'

alias ggpull='git pull origin "$(git_current_branch)"'

alias gpsupf='git push --set-upstream origin $(git_current_branch) --force-with-lease --force-if-includes'
alias gpsup='git push --set-upstream origin $(git_current_branch)'

function gr() {
    if [ -d ".git" ]; then
        open "$(git remote get-url origin | sed 's/:/\//; s/^git@/https:\/\//')"
    else 
        echo "error: current directory is not git root folder."
    fi
}

if _have gh; then
    alias grr='gh pr view --web'
fi

# kubectl alias
# copied from oh-my-zsh plugin
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/kubectl/kubectl.plugin.zsh
if _have kubectl; then
    alias k=kubectl
    complete -o default -F __start_kubectl k
fi

if _file_exist "/opt/homebrew/bin/terragrunt"; then
    complete -C /opt/homebrew/bin/terragrunt terragrunt
fi

_dot_if "$HOME/.local/bin/env"
