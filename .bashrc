# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# History Options
# ###############

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=10000
export HISTFILESIZE=20000

# Ignore some controlling instructions
export HISTIGNORE="[   ]*:&:bg:fg:exit:ls"

# Whenever displaying the prompt, write the previous line to disk
#export PROMPT_COMMAND="history -a; history -c; history -r"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# Completion options
# ##################

# These completion tuning parameters change the default behavior of bash_completion:

# Define to access remotely checked-out files over passwordless ssh for CVS
# COMP_CVS_REMOTE=1

# Define to avoid stripping description in --option=description of './configure --help'
# COMP_CONFIGURE_HINTS=1

# Define to avoid flattening internal contents of tar files
# COMP_TAR_INTERNAL_PATHS=1

# If this shell is interactive, turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    . /usr/local/etc/bash_completion.d/git-completion.bash
fi

## case $- in
##   *i*) [[ -f /etc/bash_completion ]] && . /etc/bash_completion ;;
## esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\w$ '
fi
#unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Aliases
# #######

# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.

# Interactive operation...
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

# Default to human readable figures
# alias df='df -h'
# alias du='du -h'

# Misc :)
alias less='less -r'                          # raw control characters
# alias whence='type -a'                      # where, of a sort
alias grep='grep --color=always'              # show differences in colour
alias sgrep='grep --exclude-dir="*target*" --exclude-dir="*logs*" --exclude-dir="*.svn*"'

# Some shortcuts for different directory listings
# alias dir='ls --color=auto --format=vertical'
# alias vdir='ls --color=auto --format=long'
# alias ll='ls -l'                              # long list
# alias la='ls -A'                              # all but . and ..
# alias l='ls -CF'                              #
alias ls='ls -AG'                 # classify files in colour

alias emax='emacsclient -n'

# Functions
# #########

# Some example functions
# function settitle() { echo -ne "\e]2;$@\a\e]1;$@\a"; }

# extract mp3 from a video file
function tomp3() { ffmpeg -i "$1" -f mp3 -vn -b:a "${2}000" "${1}.mp3"; }

fortune -a

## Execute .ssh-agent-file which has ssh-agent run details.
## See .profile for details
eval `cat ~/.ssh-agent-file`

## For maintaining machine specific configurations that just aren't
## worth storing in this file.
##
## For example: in one of my NT machines, emacsclient doesn't work.  I
## explicitly export EMACS_SERVER_FILE to the correct file for it to
## work.  This variable is not worth maintaining in this file because
## my other environments Just Work.
if [[ -f .envspecific ]] && [[ -x .envspecific ]]; then
    . .envspecific
fi

function transfer_schemas() {
    find olap_stitch -type f -name jdbc-olap-schema.xml | xargs -n1 cp -v olap_stitch/etc/schema/jdbc-olap-schema.xml
    find olap_stitch -type f -name olap-column-defs.xml | xargs -n1 cp -v olap_stitch/etc/schema/olap-column-defs.xml
}

function set_java8() {
    export M2_HOME=/usr/local/apache-maven
    export JAVA_HOME=$JAVA8_HOME
}

function set_java6() {
    export M2_HOME=/usr/local/apache-maven-3.2.2
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home
}

PATH="/Users/vlakshminarayanan/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/vlakshminarayanan/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/vlakshminarayanan/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/vlakshminarayanan/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/vlakshminarayanan/perl5"; export PERL_MM_OPT;
