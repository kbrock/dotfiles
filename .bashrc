[ -f /etc/bashrc/ ] && . /etc/bashrc

for i in $HOME/dotfiles/bashrc.d/* ; do
  source $i
done

# work machine setup (written by prevail bin/setup; no-op elsewhere)
[ -f "$HOME/.prevailrc" ] && . "$HOME/.prevailrc"

# bin/setup appends these unless the exact text is already here; .prevailrc does the real work
# p bin/setup: eval "$(/opt/homebrew/bin/brew shellenv)"
# p bin/setup: export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
# p bin/setup: export PATH="/opt/homebrew/opt/ffmpeg@5/bin:$PATH"
# p bin/setup: export PATH="$(brew --prefix libpq)/bin:$PATH"
# p bin/setup: alias prevail='aws-vault exec prevail --duration=12h -- bundle exec rails s'
