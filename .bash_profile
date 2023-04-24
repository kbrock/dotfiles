#  .bash_profile - File executed for interactive login shell

#export PATH="$HOME/bin:$PATH:$HOME/.local/bin"
export WHOAMI=$(whoami)
export HOSTNAME=$(hostname -s)

# source .bashrc if it's there for aliases and functions
[ -f ~/.bashrc ] && . ~/.bashrc
