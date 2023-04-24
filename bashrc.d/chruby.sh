# standard chruby


if [[ -d $(brew --prefix)/share/chruby ]] ; then
  . $(brew --prefix)/share/chruby/chruby.sh
  # chruby.xtra
  . $(brew --prefix)/share/chruby/auto.sh
fi
