api_token() {
  export AUTH_TOKEN=$(curl --user admin:smartvm http://localhost:3000/api/auth | jq -r '.["auth_token"]')
  export AUTH_HEADER="X-Auth-Token: ${AUTH_TOKEN}"
}

# providers -x "[ \$(git branch-name) = 'master' ] && echo \$i"
# providers -t "[ \$(git branch-name) = 'master' ]
# providers git status

providers() {
  local v1
  local i
  case $1 in
    -t) shift ; v1=true ;;
    -f) shift ; v1=false ;;
    -x|-q) shift ; v1=quiet ;;
  esac
  pushd ~/src/ > /dev/null
  for i in $(cat providers) ; do
    [[ -z "${v1}" ]] && echo " === $i ==="
    pushd $i > /dev/null
    eval $*
    [[ "${v1}" == "true" && ${?} = 0 || "${v1}" == "false" && ${?} != 0 ]] && echo " === $i ==="
    popd > /dev/null
  done
  popd > /dev/null
}
