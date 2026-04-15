# standard chruby

if [[ -d ${HOMEBREW_PREFIX}/share/chruby ]] ; then
  . ${HOMEBREW_PREFIX}/share/chruby/chruby.sh
  . ${HOMEBREW_PREFIX}/share/chruby/auto.sh
  chruby 4.0

  chruby_discover() {
    local dir
    RUBIES=()
    for dir in "$PREFIX/opt/rubies" "$HOME/.rubies"; do
      [[ -d "$dir" && -n "$(ls -A "$dir")" ]] && RUBIES+=("$dir"/*)
    done
  }

  _chrubycomplete() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local rubies="${RUBIES[@]##*/}"
    if [[ $COMP_CWORD -eq 1 ]]; then
      COMPREPLY=($( compgen -W "$rubies" -- $cur ))
    fi
  }
  complete -o nospace -F _chrubycomplete chruby
else
  echo "warning: chruby not found (HOMEBREW_PREFIX=${HOMEBREW_PREFIX:-unset})" >&2
fi
