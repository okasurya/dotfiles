# Path to your oh-my-zsh installation.
export TERM=xterm-256color
export ZSH="/Users/brilliant.oka/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git brew history kubectl npm go z
)

source $ZSH/oh-my-zsh.sh

# POWERLINE CONFIGURATION 
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
source ~/.oh-my-zsh/custom/themes/powerlevel10k/.purepower
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
# POWERLINE CONFIGURATION END

export GOPATH=$HOME/go
export JAVA_HOME=/Applications/Android\ Studio.app/Contents/jre/jdk/Contents/Home
export MONO_GAC_PREFIX="/usr/local"

export PATH=$PATH:/Users/Shared/Android/Sdk/platform-tools:/Users/Shared/Android/Sdk/tools:/Users/Shared/Android/Sdk/emulator
export PATH=$PATH:/Applications/Android\ Studio.app/Contents/jre/jdk/Contents/Home/bin
export PATH=$PATH:/Users/Shared/flutter/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/.dwm

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
export PATH="/usr/local/opt/ruby@2.5/bin:$PATH"
export PATH="/usr/local/opt/ncurses/bin:$PATH"
# tmux
export LDFLAGS="-L/usr/local/opt/ncurses/lib"
export CPPFLAGS="-I/usr/local/opt/ncurses/include"
export PATH="/usr/local/lib/ruby/gems/2.5.0/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export EDITOR="vim"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/brilliant.oka/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/brilliant.oka/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/brilliant.oka/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/brilliant.oka/google-cloud-sdk/completion.zsh.inc'; fi

source ~/.secretrc
source ~/.aliasrc
