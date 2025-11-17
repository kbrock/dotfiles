api_token() {
  export AUTH_TOKEN=$(curl --user admin:smartvm http://localhost:3000/api/auth | jq -r '.["auth_token"]')
  export AUTH_HEADER="X-Auth-Token: ${AUTH_TOKEN}"
}

# These are all the ems providers
# To create:
#   sed 's/"//g' ~/src/manageiq/Gemfile | awk '/plugin.*-providers-/ {printf "%s\n", $2}' | sort > ~/src/providers2
#
# providers -x "[ \$(git branch-name) = 'master' ] && echo \$i"
# providers -t "[ \$(git branch-name) = 'master' ]
# providers git status
#
providers() {
  local v1 i
  case $1 in
    -t|-y) shift ; v1=true ;;
    -f|-n) shift ; v1=false ;;
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

# think using plugins may be better?
repos() {
  local v1 i f
  case $1 in
    -t|-y) shift ; v1=true ;;
    -f|-n) shift ; v1=false ;;
    -x|-q) shift ; v1=quiet ;;
  esac
  for f in ~/src/{manageiq,manageiq-*,inventory_refresh} ; do
    i=${f##*/}
    [[ -z "${v1}" ]] && echo " === $i ==="
    pushd ~/src/$i > /dev/null
    eval "$*"
    [[ "${v1}" == "true" && ${?} = 0 || "${v1}" == "false" && ${?} != 0 ]] && echo " === $i ==="
    popd > /dev/null
  done
}

plugins() {
  local v1 i
  case $1 in
    -t|-y) shift ; v1=true ;;
    -f|-n) shift ; v1=false ;;
    -x|-q) shift ; v1=quiet ;;
  esac
  for i in $(grep -v '#' ~/src/plugins) ; do
    [[ -z "${v1}" ]] && echo " === $i ==="
    pushd ~/src/$i > /dev/null
    eval $*
    [[ "${v1}" == "true" && ${?} = 0 || "${v1}" == "false" && ${?} != 0 ]] && echo " === $i ==="
    popd > /dev/null
  done
}
