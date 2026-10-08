# Dotfiles

Personal macOS configuration files and setup scripts.

Open Mac App store and sign in with apple ID (for `install-appstore.sh`)

```bash
xcode-select --install
sudo xcodebuild -license accept # sudo needed?
softwareupdate --install-rosetta --agree-to-license

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv bash)"

git clone https://github.com/kbrock/bin.git ~/bin
git clone https://github.com/kbrock/pgbin.git ~/pgbin
git clone https://github.com/kbrock/dotfiles.git ~/dotfiles
cd ~/dotfiles

brew bundle install   # install cli tools and some mac apps
# HOMEBREW_FULL=1 brew bundle install # personal machines: dbs, langs, docker, media, etc
./install-appstore.sh # install mac apps
./setup.sh            # link dotfiles (HOMEBREW_FULL=1 also links ~/iCloud)
./macos_apply.sh      # apply finder/apple preferences
cp gitconfig.local.sample ~/.gitconfig.local
# vi ~/.gitconfig.local
# ensure ~/iCloud/core is downloaded
# point alfred to ~/iCloud/core, ensuring files have do
sudo sh -c "echo $(which bash) >> /etc/shells"
chsh -s $(which bash)

```

## Yealink USB Connect (optional)
- https://www.yealink.com/en/software # Yealink USB Connect 
- Mount (if DMG): `hdiutil mount YealinkUSBConnect.dmg`
- Install: `sudo installer -pkg /Volumes/YealinkUSBConnect/YealinkUSBConnect.pkg -target /`

## Logitech LogiTune (optional)


## Leader Key

Need to download from github. apple store is old
https://github.com/mikker/LeaderKey/releases/tag/v1.17.3
Config lives in `~/dotfiles/leader-key/config.json`. After install:

- Open Leader Key → Settings → set the config file path to `~/dotfiles/leader-key/config.json`
- Reload to apply
- Set the activation hotkey (e.g. ⌃⌥⌘F) in the Leader Key GUI (LCAG-Space)
- TODO: F is not working for me for windows. 
## Hyper
- remap physical key to hyper key: caps lock
- include shift in hyper key = false
- apply hyper key modifiers to keypress events and: click (default, not sure right value)

## Manual:

- System Settings > Keyboard > Keyboard Shortcuts
  - > Missing Control
    - move space left/right/switch desktop
  - > Windows (overlaps with Rectangle - may want to revisit)
  - > Input Sources
    - turned off (control-space, control-command-space)
  - > Spotlight
    - turned off both
  - > App Shortcuts
    - global shortcuts for file... used alfred instead for this - may want to revisit
- System Settings > Spotlight > Search Privacy... (button at the bottom)
  - Keeps `mds_stores` from re-indexing folders that change all the time (it was using 1.6GB)
  - `+`, then cmd-shift-G to type a path. Add:
    - `~/src` (git, tmp/, log/, node_modules, builds)
    - `~/.lima` (VM disk images, always changing)
    - `~/.asdf`, `~/.cache`, `~/Library/Caches`
  - Don't turn Spotlight off (`mdutil -a -i off`): Alfred uses its index to find apps. ripgrep doesn't use it
  - Manual only: the exclusion list is a root-owned file Apple doesn't let you script (old tricks like `.metadata_never_index` stopped working). A folder whose name ends in `.noindex` is skipped, but renaming `~/src` isn't practical
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
- **TypeWhisper**: `~/Library/Preferences/com.typewhisper.mac.plist` + `dictionary.store`, `snippets.store`, `workflows.store`, `prompt-actions.store`, `profiles.store` in `~/Library/Application Support/TypeWhisper/`

---

## Transferring to a New Machine

See [backup_manual.md](backup_manual.md) for the full checklist.

## TODO

limactl start --name=docker-m5 --vm-type=vz --rosetta template://docker
docker_context docker-m5 # defined in bashrc.d/lima.sh
docker context use docker-m5
docker context ls

docker run --rm -it --platform linux/amd64 ubuntu uname -m

brew install docker-compose
>> update docker config file to add extension support
{
  ...
  "cliPluginsExtraDirs": [
    "/opt/homebrew/lib/docker/cli-plugins"
  ]
}

## git
ssh-keygen -t ed25519 -C "git-signing: keenan@thebrocks.net" -f ~/.ssh/id_ed25519_signing
ssh-add --apple-use-keychain ~/.ssh/id_ed25519_signing
ssh-keygen -t ed25519 -C "keenan@thebrocks.net" -f ~/.ssh/id_ed25519
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
echo "keenan@thebrocks.net $(cat ~/.ssh/id_ed25519_signing.pub)" >> ~/.ssh/allowed_signers
