# ~/.zshrc
# vi:ft=zsh
#
source /etc/profile
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

PROMPT='%F{10}%n%f@%F{12}%m%f in %F{11}%~%f
%F{13}-%F{14}-%F{9}%# '
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

source ~/.zinit/bin/zinit.zsh

# Use modern completion system
autoload -Uz compinit
compinit

source ~/.zsh/compopt

function lf()
{
    tmp="$(mktemp)"
    command lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

source ~/.config/lf/ico

bindkey -M viins '^ '   magic-space     # control-space to bypass completion
bindkey -M emacs '^ '   magic-space
bindkey -M isearch " "  magic-space     # normal space during searches

# plugins
zinit for \
    light-mode b4b4r07/zsh-vimode-visual \
    light-mode zdharma/fast-syntax-highlighting \
    light-mode zsh-users/zsh-autosuggestions \
    light-mode zsh-users/zsh-completions \
    light-mode momo-lab/zsh-abbrev-alias

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=5

source ~/.zshal
