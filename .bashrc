
# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in

[ -f /etc/bashrc/ ] && . /etc/bashrc

for i in $HOME/dotfiles/bashrc.d/* ; do
  source $i
done

# added by rust
[ -f $HOME/.cargo/env ] && . "$HOME/.cargo/env"
# added by lima
if [ -d $HOME/.lima ] ; then
  export KUBECONFIG="$HOME/.lima/default/copied-from-guest/kubeconfig.yaml"
fi
