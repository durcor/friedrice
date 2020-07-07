# ~/.zshrc
# vi:ft=zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  . "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# [[ $- != *i* ]] && return

# Source the global shell-agnostic script
. ~/.shrc

autoload -Uz add-zsh-hook

function xterm_title_precmd () {
	print -Pn -- '\e]2;%n@%m %~\a'
	[[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

function xterm_title_preexec () {
	print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
	[[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}

if [[ "$TERM" == (alacritty*|gnome*|konsole*|putty*|rxvt*|screen*|tmux*|xterm*) ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi

# autoload -U colors && colors
#
# Set up the prompt
autoload -Uz promptinit
promptinit

unsetopt nomatch

# PROMPT='%F{10}%n%f@%F{12}%m%f in %F{11}%~%f
# %F{13}-%F{14}-%F{9}%# '
# RPROMPT=''

export KEYTIMEOUT=1
# Make zsh more like vim - no key timeouts
# XXX: Breaks escaping into NORMAL mode by default
# export KEYTIMEOUT=0

setopt \
    histignorealldups \
    sharehistory \
    autocd

# Keep 100000 lines of history within the shell and save it to ~/.shhis
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.shhis
HISTCONTROL=ignoreboth

# Use zinit as the zsh plugin manager
. ~/.zinit/bin/zinit.zsh

setopt COMPLETE_ALIASES
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zmodload zsh/complist
# Use zsh's modern completion system
autoload -Uz compinit
compinit
_comp_options+=(globdots)

kitty + complete setup zsh | . /dev/stdin

# Plugin loading
zinit for \
    light-mode zdharma/fast-syntax-highlighting \
    light-mode softmoth/zsh-vim-mode \
    light-mode zsh-users/zsh-autosuggestions \
    light-mode zsh-users/zsh-completions \
    light-mode momo-lab/zsh-abbrev-alias \
    light-mode romkatv/powerlevel10k \
    light-mode zdharma/history-search-multi-word

    # light-mode zsh-users/zsh-history-substring-search \

# zinit wait lucid for \
#     atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
#         zdharma/fast-syntax-highlighting \
#     blockf \
#         zsh-users/zsh-completions \
#         zdharma/history-search-multi-word \
#     atload"!_zsh_autosuggest_start" \
#         zsh-users/zsh-autosuggestions

zstyle :plugin:history-search-multi-word reset-prompt-protect 1
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=5

export MODE_CURSOR_VIINS="white blinking bar"
# export MODE_CURSOR_REPLACE="$MODE_CURSOR_VIINS white"
# export MODE_CURSOR_VICMD="white block"
export MODE_CURSOR_SEARCH="#ff00ff steady underline"
export MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD steady bar"
# export MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL white"

# Mode prompts on the right
# export MODE_INDICATOR_VIINS='%B%F{10}%K{10}%F{0} INSERT %f%K{0}'
# export MODE_INDICATOR_VICMD='%B%F{12}%K{12}%F{0} NORMAL %f%K{0}'
# export MODE_INDICATOR_REPLACE='%B%F{13}%K{13}%F{1} REPLACE %f%K{0}'
# export MODE_INDICATOR_SEARCH='%B%F{5}%K{5}%F{0} SEARCH %f%K{0}'
# export MODE_INDICATOR_VISUAL='%B%F{9}%K{9}%F{0} VISUAL %f%K{0}'
# export MODE_INDICATOR_VLINE='%B%F{9}%K{9}%F{0} V-LINE %f%K{0}'

# bindkey -M isearch " "  magic-space     # normal space during searches
# bindkey -M vicmd '/' history-incremental-search-backward
# bindkey -M vicmd '?' history-incremental-search-forward

bindkey -M vicmd 'Q' exit-cmd
bindkey -M vicmd 'q' exit-cmd
zle -N lf
bindkey -M vicmd 'z' lf

# Disable all escape sequences in normal mode
# bindkey -rpM viins '\e'
# bindkey -rpM viins '\e\e'

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect '^[[Z' reverse-menu-complete

. ~/.zshal

# source /home/ty/.config/broot/launcher/bash/br

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
