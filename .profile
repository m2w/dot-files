#-*- mode: shell-script -*-
##
## Env
##
shopt -s extglob # ext glob by default
complete -cf sudo # tab completion for sudo'ed commands

export HISTFILESIZE=1000
export HISTCONTROL=erasedups
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR='emacsclient -c -a=""'
export TERM=screen-256color

# prefer homebrew over system executables
PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/texbin:$PATH
# append any gem scripts
[[ -d $HOME/.gems ]] && PATH=$PATH:$HOME/.gems/bin && export GEM_HOME=~/.gems
# set the GOPATH
[[ -d $HOME/go ]] && export GOPATH=$HOME/go
# prepend npm installed executables
[[ -d /usr/local/share/npm ]] && PATH=/usr/local/share/npm/bin:$PATH
[[ -d $HOME/.cabal ]] && PATH=$PATH:$HOME/.cabal/bin
PATH=$HOME/.scripts:$PATH # prepend custom scripts
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:$GOPATH/bin # Append the GOPATH
export PATH=$PATH

# python virtualenv
[[ -f /usr/local/bin/virtualenvwrapper.sh ]] && source /usr/local/bin/virtualenvwrapper.sh

##
## Autocompletion
##
if [[ -d /usr/local/etc/bash_completion.d ]]; then
    COMPLETION_PATH=/usr/local/etc/bash_completion.d/
    for f in $( \ls $COMPLETION_PATH ); do
        source $COMPLETION_PATH$f
    done
fi

##
## Alias definitions
##
alias semacs='sudo -e'
# daemonize emacs
alias emacs='emacsclient -c -a=""'
alias ..='cd ..'
# recursive find of all erl/hrl files to feed etags
alias erlt='find . -name "*.[he]rl" -print | etags -'
alias passwordgen='openssl rand -base64 20'
alias stn='setTabName'
alias unquote='python -c "import urllib; import sys; print urllib.unquote(sys.argv[1])"'

[[ -f $HOME/.aliases ]] && source $HOME/.aliases # private aliases

if [[ $(uname -s) = "Darwin" ]]; then alias find="gfind"; fi
if [[ $(uname -s) = "Darwin" ]]; then
    alias ls='ls -aFG'
    alias ll='ls -alFG'
else
    alias ls='ls -aF --color=auto'
    alias ll='ls -alG --color=auto'
fi

##
## Look & Feel
##
function setTabName() { echo -n -e "\033]0;$@\007"; }
function gitBranch() {
    if git rev-parse --git-dir >/dev/null 2>&1
    then
        branch=$(git symbolic-ref --short HEAD)
        echo " ($branch)"
    else
        return 0
    fi
}

# set the prompt to ``username@hostname:/pwd (current git branch) $ ''
PS1="\u@\h:\W\$(gitBranch) \$ "

##
## Misc
##
# lazy is good
function psgrep() {
    ps ax | grep $1
}

##
## OSX specifics
##
# shortcut to clear the wierd DL tracking from OSX gatekeeper
function clearDLhist() {
    sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'
}

# OPAM configuration
. /Users/blah/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
