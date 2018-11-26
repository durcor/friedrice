#!/bin/sh
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\e[34m\e[36m\]\u\[\e[35m\]@\[\e[32m\]\h \[\e[33m\]\w\[\e[34m\e[37m\] $ '

source ~/.mancolors
source ~/.profile
