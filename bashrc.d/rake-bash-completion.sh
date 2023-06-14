# https://github.com/sgruhier/rake_cap_bash_autocomplete/blob/master/rake_cap_bash_autocomplete.sh
# cleanup of COMP_WORDBREAKS from:
# https://stackoverflow.com/questions/10528695/how-to-reset-comp-wordbreaks-without-affecting-other-completion-script

_rakecomplete() {
  local cur
  _get_comp_words_by_ref -n : cur

  COMPREPLY=( $(compgen -W "`rake -s -T 2>/dev/null | awk '{{print $2}}'`" -- $cur) )
  return 0
}

_capcomplete() {
  local cur
  _get_comp_words_by_ref -n : cur
  COMPREPLY=($(compgen -W "`cap  -T  2>/dev/null| awk '{{ if ( $3 ~ /\#/ ) print $2}}'`" -- $cur))
  return 0
}

_thorcomplete() {
  local cur
  _get_comp_words_by_ref -n : cur
  COMPREPLY=($(compgen -W "`THOR_COLUMNS=1000 thor -T 2>/dev/null| awk '{{ if ( $2 ~ /./ ) print $2}}'`" -- $cur))
  return 0
}

complete -o default -o nospace -F _rakecomplete rake
complete -o default -o nospace -F _capcomplete cap
complete -o default -o nospace -F _thorcomplete thor
