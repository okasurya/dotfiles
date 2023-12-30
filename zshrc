# export TERM=xterm-256color 
export ZSH="$HOME/.oh-my-zsh"


plugins=(
  git brew history kubectl npm golang z aws
)

export EDITOR="nvim"

source $ZSH/oh-my-zsh.sh

source ~/.aliasrc

# pure
ZSH_THEME=""
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure
