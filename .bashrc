
# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in

[ -f /etc/bashrc/ ] && . /etc/bashrc

for i in $HOME/dotfiles/bashrc.d/* ; do
  source $i
done
