#  .bash_profile - File executed for interactive login shell

#export PATH="$HOME/bin:$PATH:$HOME/.local/bin"
export WHOAMI=$(whoami)
export HOSTNAME=$(hostname -s)

# source .bashrc if it's there for aliases and functions
[ -f ~/.bashrc ] && . ~/.bashrc

# bin/setup appends these unless the exact text is already here; .prevailrc (via .bashrc) does the real work
# p bin/setup: eval "$(/opt/homebrew/bin/brew shellenv)"
# p bin/setup: export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
# p bin/setup: export PATH="/opt/homebrew/opt/ffmpeg@5/bin:$PATH"
# p bin/setup: export PATH="$(brew --prefix libpq)/bin:$PATH"
# p bin/setup: alias prevail='aws-vault exec prevail --duration=12h -- bundle exec rails s'
