if [ -d $HOME/.lima ] ; then
  export KUBECONFIG="$HOME/.lima/default/copied-from-guest/kubeconfig.yaml"
fi

function docker_context() {
  docker context create $1 --docker "host=$(limactl list $1 --format 'unix://{{.Dir}}/sock/docker.sock')"
}
