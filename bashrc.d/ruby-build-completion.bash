
# ruby-build 2.4.0 /opt/rubies/ruby-2.4.0
# helps choose 2.4.0 version and auto types full path
_ruby_build_complete() {
  local cur prev target
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"

  # previous is empty
  if [[ "${prev}" = "ruby-build" ]] ; then
    case ${cur} in
      -*) COMPREPLY=($(compgen -W '-k --keep -v --verbose -p --patch -4 \
                                   --ipv4 -6 --ipv6 --definitions' -- $cur )) ; return 0 ;;
    esac


    # if they haven't specified anything yet, assume 2.x
    COMPREPLY=($(compgen -W "`ruby-build --definitions`" -- ${cur:-2}))
    return 0
  else
    # echo "cur=${cur}"
    # echo "prev=${prev}"
    # return 0

    case ${prev} in
      [a-z]*-dev) target="${prev%-dev}-$(date +"%Y%m%d")" ;;
      [a-z]*) target="${prev}" ;;
      *) target="ruby-${prev}" ;;
    esac

    COMPREPLY=( $(compgen -W "/opt/rubies/${target}" -- ${cur}) )
    return 0
  fi
}
complete -F _ruby_build_complete ruby-build
