export EDITOR=emacsclient
#export JAVA_HOME=$HOME/programs/JAVA_HOME
#export M2_HOME=$HOME/programs/M2_HOME
#export ANT_HOME=$HOME/programs/ANT_HOME
#export PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH
export PATH=$HOME/bin:$PATH

if ! ps -u`whoami` | grep -v grep | grep ssh-agent; then
  ssh-agent > .ssh-agent-file
fi
