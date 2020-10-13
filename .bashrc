#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias sl='ls -alh'
alias pbcopy='clip.exe'
alias pbpaste='powershell.exe -command [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))'
alias grep='grep --color'
alias bundle='~/.gem/ruby/2.7.0/bin/bundle'
alias jkl='~/.gem/ruby/2.7.0/bin/bundle exec jekyll'

PS1='\[\033[0;34m\]\w\[\033[0m\] \$ '

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
    shift $[$OPTIND-1]
    for img in "$@"; do
        if [ -r $img ]; then
            echo -en "\e]1337;File=name=$(base64 -w 0 $img);inline=1;$width$height$pAR:$(base64 -w 0 $img)\a"
        else
            echo "File $img not found!" >&2
        fi
    done
}
