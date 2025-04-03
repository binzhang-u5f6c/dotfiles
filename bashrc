#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# alias
alias ls='ls --color=auto'
alias sl='ls -alh'
alias grep='grep --color'

# prompt
function nonzero_return {
    RETVAL=$?
    [ $RETVAL -ne 0 ] && echo " [$RETVAL]"
}

PS1='\[\033[34m\]\W\[\033[31m\]$(nonzero_return)\[\033[0m\] \$ '

# pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init - bash)"

# local PATH
if ! [[ "$PATH" =~ "$HOME/.local/bin:" ]]; then
    PATH="$HOME/.local/bin:$PATH"
fi
if [[ -d $PYENV_ROOT/bin ]]; then
    PATH="$PYENV_ROOT/bin:$PATH"
fi
export PATH
