# standard chruby

if [[ -d ${HOMEBREW_PREFIX}/share/chruby ]] ; then
  . ${HOMEBREW_PREFIX}/share/chruby/chruby.sh
  # chruby.xtra
  . ${HOMEBREW_PREFIX}/share/chruby/auto.sh
fi
