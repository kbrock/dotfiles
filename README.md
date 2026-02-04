# Dotfiles

Personal macOS configuration files and setup scripts.

Open Mac App store and sign in with apple ID (for `install-appstore.sh`)

```bash
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# eval "$(/opt/homebrew/bin/brew shellenv zsh)"

git clone https://github.com/kbrock/dotfiles.git ~/dotfiles
cd ~/dotfiles

brew bundle install   # install cli tools and some mac apps
./install-appstore.sh # install mac apps
./setup.sh            # link dotfiles
./macos_apply.sh      # apply finder/apple preferences
cp gitconfig.local.sample ~/.gitconfig.local
# vi ~/.gitconfig.local
open ~/dotfiles/Library/Divvy.url # imports divy bookmarks
# ensure ~/iCloud/core is downloaded
# point alfred to ~/iCloud/core, ensuring files have do
sudo sh -c "echo $(which bash) >> /etc/shells"
chsh -s $(which bash)

```

## Yealink USB Connect (optional)
- https://www.yealink.com/en/software # Yealink USB Connect 
- Mount (if DMG): `hdiutil mount YealinkUSBConnect.dmg`
- Install: `sudo installer -pkg /Volumes/YealinkUSBConnect/YealinkUSBConnect.pkg -target /`

## LG webcam configurator (Optional)

## Manual:

- System Settings > Keyboard > Keyboard Shortcuts
  - > Missing Control
    - move space left/right/switch desktop
  - > Windows (overlaps with Divyy - may want to revisit)
  - > Input Sources
    - turned off (control-space, control-command-space)
  - > Spotlight
    - turned off both
  - > App Shortcuts
    - global shortcuts for file... used alfred instead for this - may want to revisit
---

## What Gets Linked

### Dotfiles (symlinked to ~/)
### App Configurations
- **Sublime Text**: `~/Library/Application Support/Sublime Text 3/Packages/User/`
- **Zed**: `~/.config/zed/settings.json`
- **Claude Code**: `~/.claude/settings.json`
- **iTerm2**: Uses `defaults write` to point to `~/dotfiles/Library/iTerm/`
  - `defaults read com.googlecode.iterm2 PrefsCustomFolder`
- **KeyBindings**: `~/Library/KeyBindings/DefaultKeyBinding.dict`

---

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
