function speak {
  if [ ${#} -gt 1 ] ; then
    tail -$(wc -l $2 | awk '{printf "%d\n", $1 * (100 - '$1') / 100}') $2 | say -r 320 --progress
  elif [ ${#} -eq 0 ] ; then
    say -r 320 --progress
  elif [ ${#} -eq 2 ] ; then
    say -r 320 --progress "$@"
  else
    say -r 320 --progress -f "$@"
  fi
}
alias get="./exe/audio_book_creator -v --mute'"
