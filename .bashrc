[ -f /etc/bashrc/ ] && . /etc/bashrc

for i in $HOME/dotfiles/bashrc.d/* ; do
  source $i
done

# work machine setup (written by prevail bin/setup; no-op elsewhere)
[ -f "$HOME/.prevailrc" ] && . "$HOME/.prevailrc"
