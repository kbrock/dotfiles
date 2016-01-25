function chruby_discover() {
  local dir
  RUBIES=()

  for dir in "$PREFIX/opt/rubies" "$HOME/.rubies"; do
    [[ -d "$dir" && -n "$(ls -A "$dir")" ]] && RUBIES+=("$dir"/*)
  done
}

_chrubycomplete() {
  local cur=${COMP_WORDS[COMP_CWORD]}
  local rubies="system ${RUBIES[@]##*/}"

  if [[ $COMP_CWORD -eq 1 ]]; then
    COMPREPLY=($( compgen -W "$rubies" -- $cur ))
  fi
}
complete -o nospace -F _chrubycomplete chruby
