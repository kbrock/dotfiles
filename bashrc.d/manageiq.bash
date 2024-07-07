api_token() {
  export AUTH_TOKEN=$(curl --user admin:smartvm http://localhost:3000/api/auth | jq -r '.["auth_token"]')
  export AUTH_HEADER="X-Auth-Token: ${AUTH_TOKEN}"
}

# providers -x "[ \$(git branch-name) = 'master' ] && echo \$i"
# providers -t "[ \$(git branch-name) = 'master' ]
# providers git status
providers() {
  local v1 i
  case $1 in
    -t) shift ; v1=true ;;
    -f) shift ; v1=false ;;
    -x|-q) shift ; v1=quiet ;;
  esac
  for i in $(cat ~/src/providers) ; do
    [[ -z "${v1}" ]] && echo " === $i ==="
    pushd ~/src/$i > /dev/null
    eval $*
    [[ "${v1}" == "true" && ${?} = 0 || "${v1}" == "false" && ${?} != 0 ]] && echo " === $i ==="
    popd > /dev/null
  done
}

# sed 's/"//g' ~/src/manageiq/Gemfile | awk '/plugin.*-providers-/ {printf "%s\n", $2}' > ~/src/providers2
