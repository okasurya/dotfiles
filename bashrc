# utility function
_have() { type "$1" &>/dev/null; }
_source_if() { [[ -r "$1" ]] && source "$1"; }

# -------------------- prompt styling --------------------

PROMPT_LONG=20
PROMPT_MAX=95
PROMPT_AT=@

__ps1() {
	local P='$' dir="${PWD##*/}" B countme short long double \
		r='\[\e[31m\]' g='\[\e[30m\]' h='\[\e[34m\]' \
		u='\[\e[33m\]' p='\[\e[34m\]' w='\[\e[35m\]' \
		b='\[\e[36m\]' x='\[\e[0m\]' y='\[\e[97m\]'

	[[ $EUID == 0 ]] && P='#' && u=$r && p=$u # root
	[[ $PWD = / ]] && dir=/
	[[ $PWD = "$HOME" ]] && dir='~'

	B=$(git branch --show-current 2>/dev/null)
	[[ $dir = "$B" ]] && B=.
        # hostname is available from inetutils package
	countme="$USER$PROMPT_AT$(hostname):$dir($B)\$ "

	[[ $B == master || $B == main ]] && b="$r"
	[[ -n "$B" ]] && B="$y($b$B$y)"

	short="$u\u$y$PROMPT_AT$h\h$y:$w$dir$B$p$P$x "
	long="$y╔ $u\u$y$PROMPT_AT$h\h$y:$w$dir$B\n$y╚ $p$P$x "
	double="$y╔ $u\u$y$PROMPT_AT$h\h$y:$w$dir\n$y║ $B\n$y╚ $p$P$x "

	if ((${#countme} > PROMPT_MAX)); then
		PS1="$double"
	elif ((${#countme} > PROMPT_LONG)); then
		PS1="$long"
	else
		PS1="$short"
	fi
}

PROMPT_COMMAND="__ps1"

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

_have maestro && export PATH=$PATH:$HOME/.maestro/bin

[[ -f "$HOME/vpn/do.sh" ]] &&  alias v="$HOME/vpn/do.sh sgp"

# local config 
# naming derived from brlntrc, shorten to brc 
_source_if "$HOME/.brc"

# ----------------------- completion ---------------------

# for mac
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

_have z && . <(z completion bash)

# --------------------------------------------------------

