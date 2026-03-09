[ -f /etc/bashrc/ ] && . /etc/bashrc

for i in $HOME/dotfiles/bashrc.d/* ; do
  source $i
done
