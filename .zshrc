# ~/.zshrc
# vi:ft=zsh
#
# Set up the prompt
autoload -Uz promptinit
promptinit

# if [ $USER = "root" ]
# then
#     USER_PROMPT_COLOR=12
# fi
# 
# if [ $USER = "ty" ]
# then
#     USER_PROMPT_COLOR=9
# fi

PROMPT='%F{10}%n%f@%F{4}%m%f %F{3}%~%f %# '
RPROMPT=''
export KEYTIMEOUT=1

setopt histignorealldups sharehistory
setopt autocd

bindkey -v

# Change cursor shape for different vi modes.
    function zle-line-init zle-keymap-select {
	VICMDPR="%K{6} %F{0}NORMAL%f %k"
	VIINSPR="%K{5} %F{0}INSERT%f %k"
	VISUALPR="%K{15} %F{0}VISUAL%f %k"
	RPS1="${${KEYMAP/vicmd/$VICMDPR}/(main|viins)/$VIINSPR} $EPS1"

      if [[ ${KEYMAP} == vicmd ]] ||
         [[ $1 = 'block' ]]; then
        echo -ne '\e[1 q'

      elif [[ ${KEYMAP} == main ]] ||
           [[ ${KEYMAP} == viins ]] ||
           [[ ${KEYMAP} = '' ]] ||
           [[ $1 = 'beam' ]]; then
        echo -ne '\e[5 q'
      fi

	zle reset-prompt
    }

zle -N zle-line-init
zle -N zle-keymap-select

# Use beam shape cursor on startup.
echo -ne '\e[5 q'

# Use beam shape cursor for each new prompt.
 preexec() {
	echo -ne '\e[5 q'
    }

bindkey -a 'u' undo
bindkey -a '^R' redo
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char

zmodload zsh/complist
bindkey -M menuselect '^[[Z' reverse-menu-complete

# bindkey -M vicmd "^V" edit-command-line
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

# bindkey -M vicmd "k" up-line-or-beginning-search
# bindkey -M vicmd "j" down-line-or-beginning-search

# Keep 100000 lines of history within the shell and save it to ~/.shhis
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.shhis
HISTCONTROL=ignoreboth

# Use modern completion system
autoload -Uz compinit
compinit

source ~/.zsh/compopt

# alias auto-expand
typeset -a ealiases
ealiases=()

function ealias()
{
	alias $1
	ealiases+=(${1%%\=*})
}

function expand-ealias()
{
	if [[ $LBUFFER =~ "\<(${(j:|:)ealiases})\$" ]]; then
		zle _expand_alias
		zle expand-word
	fi
	zle magic-space
}

zle -N expand-ealias

source ~/.zshal

bindkey -M viins ' '   	expand-ealias
bindkey -M emacs ' '   	expand-ealias
bindkey -M viins '^ '   magic-space     # control-space to bypass completion
bindkey -M emacs '^ '   magic-space
bindkey -M isearch " "  magic-space     # normal space during searches

# plugins
if ls ~/.zsh/antigen.zsh >/dev/null
then
    source ~/.zsh/antigen.zsh
    antigen bundle zdharma/fast-syntax-highlighting
    antigen bundle zsh-users/zsh-autosuggestions
    antigen bundle zsh-users/zsh-completions
    # antigen bundle b4b4r07/zsh-vimode-visual
    antigen apply
    export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=5
else
    mkdir -p ~/.zsh
    curl -L git.io/antigen-nightly > ~/.zsh/antigen.zsh
fi
