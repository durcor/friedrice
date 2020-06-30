# ~/.zshrc
# vi:ft=zsh
#

# [[ $- != *i* ]] && return

. /etc/profile
#
# Set up the prompt
autoload -Uz promptinit
promptinit

PROMPT='%F{10}%n%f@%F{12}%m%f in %F{11}%~%f
%F{13}-%F{14}-%F{9}%# '
RPROMPT=''

# Make zsh more like vim - no key timeouts
export KEYTIMEOUT=0

setopt \
    histignorealldups \
    sharehistory \
    autocd

zmodload zsh/complist
bindkey -M menuselect '^[[Z' reverse-menu-complete

# Keep 100000 lines of history within the shell and save it to ~/.shhis
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.shhis
HISTCONTROL=ignoreboth

. ~/.zinit/bin/zinit.zsh

# Use modern completion system
autoload -Uz compinit
compinit

. ~/.zsh/compopt

kitty + complete setup zsh | . /dev/stdin

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

n ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "export" as in:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    # NOTE: NNN_TMPFILE is fixed, should not be modified
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

. ~/.config/lf/ico

# plugins
zinit for \
    light-mode zdharma/fast-syntax-highlighting \
    light-mode zdharma/history-search-multi-word \
    light-mode zsh-users/zsh-autosuggestions \
    light-mode zsh-users/zsh-completions \
    light-mode momo-lab/zsh-abbrev-alias \
    light-mode softmoth/zsh-vim-mode

    # light-mode zsh-users/zsh-history-substring-search \

zstyle :plugin:history-search-multi-word reset-prompt-protect 1
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=5

export MODE_CURSOR_VIINS="white blinking bar"
export MODE_CURSOR_REPLACE="$MODE_CURSOR_VIINS red"
export MODE_CURSOR_VICMD="green block"
export MODE_CURSOR_SEARCH="#ff00ff steady underline"
export MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD steady bar"
export MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL blue"

# Mode prompts on the right
export MODE_INDICATOR_VIINS='%B%F{10}%K{10}%F{0} INSERT %f%K{0}'
export MODE_INDICATOR_VICMD='%B%F{12}%K{12}%F{0} NORMAL %f%K{0}'
export MODE_INDICATOR_REPLACE='%B%F{13}%K{13}%F{1} REPLACE %f%K{0}'
export MODE_INDICATOR_SEARCH='%B%F{5}%K{5}%F{0} SEARCH %f%K{0}'
export MODE_INDICATOR_VISUAL='%B%F{9}%K{9}%F{0} VISUAL %f%K{0}'
export MODE_INDICATOR_VLINE='%B%F{9}%K{9}%F{0} V-LINE %f%K{0}'

# bindkey -M isearch " "  magic-space     # normal space during searches
# bindkey -M vicmd '/' history-incremental-search-backward
# bindkey -M vicmd '?' history-incremental-search-forward

# Disable all escape sequences in normal mode
# bindkey -rpM viins '\e'
# bindkey -rpM viins '\e\e'
. ~/.zshal
