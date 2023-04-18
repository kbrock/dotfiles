# standard chruby

if [[ -d /usr/local/share/chruby ]] ; then
  . /usr/local/share/chruby/chruby.sh
  # chruby.xtra
  . /usr/local/share/chruby/auto.sh
elif [[ -d /opt/homebrew/share/chruby ]]; then
  . /opt/homebrew/share/chruby/chruby.sh
  # chruby.xtra
  . /opt/homebrew/share/chruby/auto.sh
fi