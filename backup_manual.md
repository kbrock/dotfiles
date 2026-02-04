# Manual Backup & Restore Checklist

Items that must be manually transferred to a new machine.

## Before leaving old machine

### SSH Keys
```bash
cp -r ~/.ssh ~/dotfiles-backup/
```
Files: `id_ed25519`, `id_ed25519.pub`, `config`

### GPG Keys
```bash
cp ~/.gnupg/pubring.kbx ~/dotfiles-backup/
```

### Git Local Config
```bash
cp ~/.gitconfig.local ~/dotfiles-backup/
```
Contains: name, email, tokens

### Custom Dictionary (if not already committed)
```bash
cp ~/Library/Spelling/LocalDictionary ~/dotfiles/Library/Spelling/
```

### Divvy Shortcuts (if changed)
1. Open Divvy → Preferences → Shortcuts → Export
2. Copy URL and save to `~/dotfiles/Library/Divvy.url`
3. Commit changes

## On new machine

### Restore SSH Keys
```bash
cp ~/dotfiles-backup/.ssh/* ~/.ssh/
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
```

### Restore GPG Keys
```bash
cp ~/dotfiles-backup/pubring.kbx ~/.gnupg/
```

### Setup Git Local Config
```bash
cp ~/dotfiles/gitconfig.local.sample ~/.gitconfig.local
# Edit with your info
vi ~/.gitconfig.local
```

### Text Replacements
Text replacements (e.g., "omw" → "On my way!") sync via iCloud:
- System Settings → Apple ID → iCloud → Keyboard (or iCloud Drive)

No manual backup needed if iCloud sync is enabled.

### Keyboard Shortcuts
**Alfred/Spotlight conflict:**
- System Settings → Keyboard → Keyboard Shortcuts → Spotlight
- Disable "Show Spotlight search" (Cmd+Space)
- Open Alfred and set to Cmd+Space

**Other custom shortcuts:**
- No automated way to backup/restore `com.apple.symbolichotkeys.plist`
- Reconfigure manually via System Settings → Keyboard → Keyboard Shortcuts

### Login Items (Auto-start apps)
System Settings → General → Login Items

Add these apps:
- Hyperkey
- Divvy
- Alfred 5
- Shottr

### Verify iTerm2 Settings
```bash
defaults read com.googlecode.iterm2 PrefsCustomFolder
# Should output: ~/dotfiles/Library/iTerm
```
