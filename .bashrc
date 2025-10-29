# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
#export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" -a -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
function parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

RED="\[\033[01;31m\]"
YELLOW="\[\033[01;33m\]"
GREEN="\[\033[01;32m\]"
BLUE="\[\033[01;34m\]"
MAGENTA="\[\033[01;35m\]"
NO_COLOR="\[\033[0m\]"

PS1="$YELLOW\u$RED@$GREEN\h$NO_COLOR:$BLUE\w$MAGENTA\$(parse_git_branch)$NO_COLOR "

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
    ;;
*)
    ;;
esac

# Set terminal colors. For emacs themes to work etc
export TERM=xterm-256color

export PATH="$HOME/.local/bin:$PATH"

# set default editor
export ALTERNATE_EDITOR=""
export EDITOR=emacsclient

export PUBLICIP=$(curl -s http://whatismyip.akamai.com/)

# Define your own aliases here ...
#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#fi

# [ -z "$SSH_CLIENT" ] && . $HOME/.ssh-agent

#~/adm/bash_completion.sh

alias e="emacsclient -t"

alias keyon="ssh-add -t 10800"
alias keyoff='ssh-add -D'
alias keylist='ssh-add -l'

alias roy='ssh -A roy.ggez.no'
alias grom='ssh -A gromguten.ggez.no'
alias vold='ssh -A sersjantvold.ggez.no'
alias admin='ssh -A admin.gamer.c.bitbit.net'

alias fiffus='ssh -A fiffus.gamer.no'

alias css='cd ~/goodgameas/gamer/resources/sass'
alias js='cd ~/goodgameas/gamer/resources/js'
alias gamer='cd ~/goodgameas/gamer'
alias ggwp='cd ~/goodgameas/ggwp'
alias paradise='cd ~/goodgameas/paradise'

alias aether='vendor/bin/aether'
alias artisan='php artisan'
alias pest='./vendor/bin/pest'
alias cupdate='composer update && composer update'
alias situla='aws --endpoint=https://situla.bitbit.net'
alias oc='~/oc/oc'

alias dev='npm run dev -- --host ${PUBLICIP}'

alias buildplugin='sh /home/erlend/goodgameas/ggplugin/build.sh'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export NODE_OPTIONS=--max_old_space_size=8192
