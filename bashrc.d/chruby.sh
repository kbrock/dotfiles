# standard chruby (pre1.0 branch of kbrock/chruby - not homebrew's chruby)
# optional: machines without ~/src/gems/chruby (e.g. asdf/mise) skip this file

if [[ ! -f "$HOME/src/gems/chruby/share/chruby/chruby.sh" ]] ; then
  # echo "warning: chruby not found at $HOME/src/gems/chruby" >&2
  return
fi

. "$HOME/src/gems/chruby/share/chruby/chruby.sh"
. "$HOME/src/gems/chruby/share/chruby/auto.sh"

not_defined chruby || chruby 4.0

_chrubycomplete() {
  local cur=${COMP_WORDS[COMP_CWORD]}
  local rubies
  rubies=$(chruby_list | xargs -n1 basename)
  if [[ $COMP_CWORD -eq 1 ]]; then
    COMPREPLY=($( compgen -W "$rubies" -- $cur ))
  fi
}
complete -o nospace -F _chrubycomplete chruby

# set .ruby-version to the current (or given) ruby
function ruby_version {
  if [ $# -eq 1 ] ; then
    chruby $1
  fi
  local rv=`chruby | awk '/\*/ { print $2; }'`
  if [ -n "$rv" ] ; then
    echo $rv > .ruby-version

    which ruby
  else
    echo "please pick a ruby"
    chruby
  fi
}
complete -o nospace -F _chrubycomplete ruby_version
