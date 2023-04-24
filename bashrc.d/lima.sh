if [ -d $HOME/.lima ] ; then
  export KUBECONFIG="$HOME/.lima/default/copied-from-guest/kubeconfig.yaml"
fi
