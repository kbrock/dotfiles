
# ruby-build 2.4.0 /opt/rubies/ruby-2.4.0
# helps choose 2.4.0 version and auto types full path
_ruby_build_complete() {
  local cur prev target
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"

  # previous is empty
  if [[ "${cur}" = -* || "${prev}" = /* ]] ; then
    # the x is bogus, but it prevents a default - from being added
    COMPREPLY=($(compgen -W 'x -k --keep -v --verbose -p --patch -4 \
                                --ipv4 -6 --ipv6 --definitions' -- $cur ))
    return 0
  elif [[ "${prev}" = "ruby-build" ]] ; then
    # suggest a version of ruby to use
    # if they haven't specified anything yet, assume 3.x
    COMPREPLY=($(compgen -W "`ruby-build --definitions`" -- ${cur:-3}))
    return 0
  else # if [[ "" = "" ]] ; then
    case ${prev} in
      [a-z]*-dev) target="${prev%-dev}-$(date +"%Y%m%d")" ;;
      [a-z]*) target="${prev}" ;;
      *) target="ruby-${prev}" ;;
    esac

    COMPREPLY=( $(compgen -W "~/.rubies/${target}" -- ${cur}) )
    return 0
  fi
}
complete -F _ruby_build_complete ruby-build
