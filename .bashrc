#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# alias
alias ls='ls --color=auto'
alias sl='ls -alh'
alias grep='grep --color'
alias pbcopy='clip.exe'
alias pbpaste='powershell.exe -command get-clipboard -raw | tr -d "\r"'
alias jupyterlab='jupyter lab --no-browser'

# prompt
function nonzero_return {
    RETVAL=$?
    [ $RETVAL -ne 0 ] && echo " [$RETVAL]"
}

PS1='\[\033[34m\]\W\[\033[31m\]$(nonzero_return)\[\033[0m\] \$ '

# cat image
function icat {
    width=""
    height=""
    pAR=""
    OPTIND=1
    while getopts "w:h:f" opt; do
        case "$opt" in
            w)
                width="width=$OPTARG;"
                ;;
            h)
                height="height=$OPTARG;"
                ;;
            f)
                pAR="preserveAspectRatio=0;"
                ;;
            *)
                echo "Usage: icat [-w width] [-h height] [-f] filename"
                ;;
        esac
    done
    shift $(($OPTIND-1))
    for img in "$@"; do
        if [ -r $img ]; then
            echo -en "\e]1337;File=name=$(base64 -w 0 $img);inline=1;$width$height$pAR:$(base64 -w 0 $img)\a"
        else
            echo "File $img not found!" >&2
        fi
    done
}

# proxy
function proxy_on {
    export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"

    hostip=$(cat /etc/resolv.conf | awk '/nameserver/{print $2}')
    echo Your Windows host IP is $hostip
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
