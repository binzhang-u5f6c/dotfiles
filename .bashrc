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

# proxy
function proxy_on {
    export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"

    echo -n "server: "
    read server
    echo -n "port: "
    read port

    local proxy=$server:$port
    export http_proxy=$proxy
    export https_proxy=$proxy
    export ftp_proxy=$proxy
    export rsync_proxy=$proxy
    export HTTP_PROXY=$proxy
    export HTTPS_PROXY=$proxy
    export FTP_PROXY=$proxy
    export RSYNC_PROXY=$proxy
}

function proxy_off {
    unset http_proxy
    unset https_proxy
    unset ftp_proxy
    unset rsync_proxy
    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset FTP_PROXY
    unset RSYNC_PROXY
    echo -e "Proxy environment variables removed."
}
