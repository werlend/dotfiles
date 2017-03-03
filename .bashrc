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

[ -z "$SSH_CLIENT" ] && . $HOME/.ssh-agent

#~/adm/bash_completion.sh

alias keyon="ssh-add -t 10800"
alias keyoff='ssh-add -D'
alias keylist='ssh-add -l'

alias generateConfig='php ~/aether/bin/generateConfig'
alias updateLocales='php ~/aether/bin/updateLocales'

alias bustCache='sh ~/adm/bin/varnish_purge.sh'

alias creeper='ssh -A golan'
alias wank='ssh -A ssh.raw.no'
alias golan='ssh -A golan.tu.c.bitbit.net'
alias hal='ssh -A ssh.raw.no'
alias pluto='ssh -A pluto.tu.no'
alias guffen='ssh -A guffen.tu.no'

alias tek='cd ~/tek'
alias static='cd ~/static.tek.no'
alias css='cd ~/static.tek.no/public/css'
alias js='cd ~/static.tek.no/public/js'
alias lib='cd ~/commonlibs/lib'
alias neo='cd ~/neo'
alias gamer='cd ~/gamer'
alias tekno='cd ~/tekno'
alias tu='cd ~/tu'
alias digi='cd ~/digi'
alias aperitif='cd ~/aperitif'
