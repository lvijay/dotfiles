
## executed in .bashrc
#if [ -f /etc/bash_completion ] && [ -x /etc/bash_completion ]; then
#  . /etc/bash_completion
#fi

export EMACS_HOME=/cygdrive/c/programs/emacs-24.0.50
export PATH=${EMACS_HOME}/bin:$HOME/bin:${PATH}
export APACHE=/cygdrive/c/apache-tomcat-5.5.28
export EDITOR=emacsclient

. ~/.bashrc
