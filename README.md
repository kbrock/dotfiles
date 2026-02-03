# Dotfiles

Personal macOS configuration files and setup scripts.

Open Mac App store and sign in with apple ID (for `install-appstore.sh`)

```bash
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

git clone https://github.com/kbrock/dotfiles.git ~/dotfiles
cd ~/dotfiles
brew bundle install   # install cli tools and some mac apps
./install-appstore.sh # install mac apps
./setup.sh            # link dotfiles
cp gitconfig.local.sample ~/.gitconfig.local
# vi ~/.gitconfig.local
open ~/dotfiles/Library/Divvy.url # imports divy bookmarks
```

## Install Yealink USB Headset configuration

Not strictly necessary.

- https://www.yealink.com/en/software
- Yealink USB Connect
- Mount (if DMG): `hdiutil mount YealinkUSBConnect.dmg`
- Install: `sudo installer -pkg /Volumes/YealinkUSBConnect/YealinkUSBConnect.pkg -target /`

## Monitor control
There is "LG Screen Manager"
But use MonitorControl instead

---

## What Gets Linked

### Dotfiles (symlinked to ~/)
- `.agignore`, `.bash_profile`, `.bashrc`
- `.gemrc`, `.gitattributes`, `.gitconfig`, `.gitignore_global`
- `.inputrc`, `.irbrc`
- `.bundler.d/Gemfile.global.rb`
- `.gnupg/gpg.conf`
- `.gnupg/gpg-agent.conf` (platform-specific: `-mac` or `-linux`)
- `.gitconfig_platform` (platform-specific)

### Editor Configurations
- **Sublime Text**: `~/Library/Application Support/Sublime Text 3/Packages/User/` → `dotfiles/Sublime Text 3/Packages/User/`
- **Zed**: `~/.config/zed/settings.json` → `dotfiles/.config/zed/settings.json`
- **Claude Code**: `~/.claude/settings.json` → `dotfiles/.claude/settings.json`

### System Preferences
- **iTerm2**: Uses `defaults write` to point to `~/dotfiles/Library/iTerm/`
- **KeyBindings**: `~/Library/KeyBindings/DefaultKeyBinding.dict` → `dotfiles/Library/KeyBindings/DefaultKeyBinding.dict`

### Not Linked (Must Be Manually Imported)
- **Divvy**: Import via URL (preferences can't be symlinked)
- **gitconfig.local**: Contains sensitive information (name, email, tokens)

---

### iTerm2 not loading preferences
Check that the preferences are pointing to the right location:
```bash
defaults read com.googlecode.iterm2 PrefsCustomFolder
# Should output: ~/dotfiles/Library/iTerm
```

## Transferring to a New Machine

When setting up a new machine, you'll need to manually transfer these items:

1. Open Divvy → Preferences → Shortcuts → Export
2. Copy the URL
3. Save (commit) to `~/dotfiles/Library/Divvy.url`

- ~/.ssh/id_ed25519
- ~/.ssh/id_ed25519.pub
- ~/.ssh/config
- ~/.gitconfig.local
- ~/.gnupg/pubring.kbx

### **macOS Keychain** (Avoid if possible)
You mentioned you avoid the keychain because it's a black box - good practice!

**What might be in there:**
- GitHub tokens (if using `credential.helper = osxkeychain`)
- SSH key passphrases (if using `UseKeychain yes` in SSH config)
- WiFi passwords (system-managed)

**Alternative:** Store credentials in 1Password or environment variables instead of keychain.
