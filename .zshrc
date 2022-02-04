# ~/.zshrc
# vi:ft=zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
[[ -r "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh" ]] &&
    source "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh"

# [[ $- != *i* ]] && return

# Source the global shell-agnostic script
. $HOME/.shrc

# autoload -U colors && colors
# Set up the prompt
autoload -Uz promptinit
promptinit

unsetopt nomatch

# PROMPT='%F{10}%n%f@%F{12}%m%f in %F{11}%~%f
# %F{13}-%F{14}-%F{9}%# '
# RPROMPT=''

# TODO: Figure out what to do with KEYTIMEOUT
# KEYTIMEOUT=

setopt histignorealldups sharehistory autocd

# Keep 100000 lines of history within the shell and save it to ~/.shhis
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=$HOME/.shhis
HISTCONTROL=ignoreboth

# Use zinit as the zsh plugin manager
source $XDG_DATA_HOME/zinit/zinit.git/zinit.zsh

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

# Plugin loading
zinit light-mode for \
    zdharma-continuum/fast-syntax-highlighting \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-completions \
    jeffreytse/zsh-vi-mode \
    romkatv/powerlevel10k \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust
    # Load a few important annexes, without Turbo
    # (this is currently required for annexes)

    # light-mode zdharma/history-search-multi-word \
    # light-mode mbenford/zsh-tmux-auto-title \
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

# export ZSH_TMUX_AUTO_TITLE_IDLE_TEXT="%last"
export ZSH_TMUX_AUTO_TITLE_IDLE_TEXT="%pwd"

# export ZVM_INSERT_MODE_CURSOR="white blinking bar"
# export MODE_CURSOR_REPLACE="$MODE_CURSOR_VIINS white"
# export MODE_CURSOR_VICMD="white block"
# export ZVM_SEARCH_MODE_CURSOR="#ff00ff steady underline"
# export ZVM_VISUAL_MODE_CURSOR="$MODE_CURSOR_VICMD steady bar"
# export MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL white"

export ZLE_RPROMPT_INDENT=0

# Keybinds
exit_shell() { exit; }
lf_from_shell() { lfcd; }

zvm_define_widget exit_shell
zvm_define_widget lf_from_shell

zvm_bindkey vicmd 'q' exit_shell
zvm_bindkey vicmd 'Q' exit_shell
zvm_bindkey vicmd 'z' lf_from_shell
zvm_bindkey viins '^o' lf_from_shell

# bindkey -M isearch " "  magic-space     # normal space during searches
# bindkey -M vicmd '/' history-incremental-search-backward
# bindkey -M vicmd '?' history-incremental-search-forward

# Disable all escape sequences in normal mode
# bindkey -rpM viins '\e'
# bindkey -rpM viins '\e\e'

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect '^[[Z' reverse-menu-complete

zvm_after_init()
{
    zinit light momo-lab/zsh-abbrev-alias && source ~/.zshal
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source ~/.p10k.zsh

# source /home/ty/.nix-profile/etc/profile.d/nix.sh
# source /home/ty/.config/broot/launcher/bash/br
