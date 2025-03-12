#!/bin/bash
# vi:ft=bash
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\e[34m\e[36m\]\u\[\e[35m\]@\[\e[32m\]\h \[\e[33m\]\w\[\e[34m\e[37m\] $ '

set -o vi

source_if_exists() { [ -f "$1" ] && . "$1" ;}

source_if_exists "$HOME/.mancolors"
source_if_exists "$HOME/.profile"
PATH=$HOME/.gem/ruby/2.6.0/bin:$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl

source_if_exists "$HOME/.config/broot/launcher/bash/br"
source_if_exists "$HOME/.cargo/env"
