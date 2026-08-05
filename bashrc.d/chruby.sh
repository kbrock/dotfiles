# standard chruby (pre1.0 branch of kbrock/chruby - not homebrew's chruby)

if [[ ! -f "$HOME/src/chruby/share/chruby/chruby.sh" ]] ; then
  echo "warning: chruby not found at $HOME/src/chruby" >&2
  return
fi

. "$HOME/src/chruby/share/chruby/chruby.sh"
. "$HOME/src/chruby/share/chruby/auto.sh"

chruby 4.0

_chrubycomplete() {
  local cur=${COMP_WORDS[COMP_CWORD]}
  local rubies
  rubies=$(chruby_list | xargs -n1 basename)
  if [[ $COMP_CWORD -eq 1 ]]; then
    COMPREPLY=($( compgen -W "$rubies" -- $cur ))
  fi
}
complete -o nospace -F _chrubycomplete chruby
