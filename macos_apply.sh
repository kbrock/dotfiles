#!/bin/bash -e
# Apply macOS system settings using defaults write
# Run this after macos_setup.sh to configure Finder, Dock, and other system preferences

echo "=== Applying macOS System Settings ==="
echo ""

# Close System Preferences to prevent conflicts
osascript -e 'tell application "System Preferences" to quit' 2>/dev/null || true

echo "Configuring Finder..."
# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true
# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Show path bar
defaults write com.apple.finder ShowPathbar -bool true
# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true
# Show full POSIX path in title bar
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# Search current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Use list view by default (Nlsv=list, icnv=icon, clmv=column, glyv=gallery)
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# New Finder windows show home directory
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
# Avoid creating .DS_Store files on network and USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

echo "Configuring Dock..."
# Auto-hide the Dock
defaults write com.apple.dock autohide -bool true
# Don't show recent applications
defaults write com.apple.dock show-recents -bool false
# Don't rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

echo "Configuring Screenshots..."
# Save screenshots to ~/Desktop (or change to ~/Pictures/Screenshots)
defaults write com.apple.screencapture location -string "${HOME}/Desktop"
# Save screenshots as PNG (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"
# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

echo "Configuring Keyboard..."
# Set fast key repeat rate (1 = fastest)
defaults write NSGlobalDomain KeyRepeat -int 2
# Set short delay before key repeat (15 = shortest)
defaults write NSGlobalDomain InitialKeyRepeat -int 15
# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

echo "Configuring Text Input..."
# Disable smart quotes (use straight quotes)
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
# Disable smart dashes (use regular hyphens)
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
# Disable auto-capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
# Disable period substitution (double-space to period)
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

echo "Configuring Trackpad..."
# Enable tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

echo "Configuring Performance..."
# Reduce transparency (improves performance, reduces memory usage)
# defaults write com.apple.universalaccess reduceTransparency -bool true
# Reduce motion (disables animations)
# defaults write com.apple.universalaccess reduceMotion -bool true

echo "Configuring default file handlers..."
#EDITOR_BUNDLE="com.sublimetext.4"
EDITOR_BUNDLE="dev.zed.Zed"
for content_type in \
    public.plain-text \
    public.source-code \
    public.shell-script \
    com.netscape.javascript-source \
    public.python-script \
    public.ruby-script \
    public.yaml \
    net.daringfireball.markdown
do
    defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add "{LSHandlerContentType=${content_type};LSHandlerRoleAll=${EDITOR_BUNDLE};}"
done

# Keep Xcode for Apple development files
EDITOR_BUNDLE="com.apple.dt.Xcode"
for content_type in \
    public.swift-source \
    com.apple.dt.playground \
    com.apple.dt.playgroundpage \
    com.apple.xcode.project \
    com.apple.xcode.workspace
do
    defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add "{LSHandlerContentType=${content_type};LSHandlerRoleAll=${EDITOR_BUNDLE};}"
done

echo ""
echo "=== Settings Applied ==="
echo ""
echo "Note: Some changes require logging out or restarting Finder/Dock:"
echo "  killall Finder"
echo "  killall Dock"
echo ""
echo "Or restart your Mac for all changes to take effect."
