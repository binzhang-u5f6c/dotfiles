#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias sl='ls -alh'
alias grep='grep --color'
alias jkl='~/.gem/ruby/2.7.0/bin/jekyll'
alias bundle='~/.gem/ruby/2.7.0/bin/bundle'

PS1='\[\033[0;34m\]\w\[\033[0m\] \$ '
