#!/bin/sh
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\e[34m\e[36m\]\u\[\e[35m\]@\[\e[32m\]\h \[\e[33m\]\w\[\e[34m\e[37m\] $ '

source ~/.mancolors
source ~/.profile
PATH=/home/ty/.gem/ruby/2.6.0/bin:/home/ty/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl

source /home/ty/.config/broot/launcher/bash/br
