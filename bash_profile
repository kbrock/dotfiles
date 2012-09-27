#  .bash_profile - File executed for interactive login shell

export PATH="$HOME/bin:$PATH"
export WHOAMI=$(whoami)
export HOSTNAME=$(hostname -s)

# source .bashrc if it's there for aliases and functions
[ -f ~/.bashrc ] && . ~/.bashrc

#rbenv
#if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
