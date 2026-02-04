#!/bin/bash
# Show current macOS system settings
# Use this to see what settings you have before running macos_apply.sh

set -e

# Helper function to read defaults safely
read_default() {
    domain=$1
    key=$2
    value=$(defaults read "$domain" "$key" 2>/dev/null || echo "NOT SET")
    printf "  %-40s %s\n" "$key:" "$value"
}

echo "=== Current macOS Settings ==="
echo ""

echo "## Finder"
read_default com.apple.finder AppleShowAllFiles
read_default NSGlobalDomain AppleShowAllExtensions
read_default com.apple.finder ShowPathbar
read_default com.apple.finder ShowStatusBar
read_default com.apple.finder _FXShowPosixPathInTitle
read_default com.apple.finder FXDefaultSearchScope
read_default com.apple.finder FXPreferredViewStyle
read_default com.apple.finder NewWindowTarget
read_default com.apple.desktopservices DSDontWriteNetworkStores
read_default com.apple.desktopservices DSDontWriteUSBStores
echo ""

echo "## Dock"
read_default com.apple.dock autohide
read_default com.apple.dock show-recents
read_default com.apple.dock mru-spaces
echo ""

echo "## Screenshots"
read_default com.apple.screencapture location
read_default com.apple.screencapture type
read_default com.apple.screencapture disable-shadow
echo ""

echo "## Keyboard & Input"
read_default NSGlobalDomain KeyRepeat
read_default NSGlobalDomain InitialKeyRepeat
read_default NSGlobalDomain ApplePressAndHoldEnabled
echo ""

echo "## Text Input & Auto-corrections"
read_default NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled
read_default NSGlobalDomain NSAutomaticDashSubstitutionEnabled
read_default NSGlobalDomain NSAutomaticSpellingCorrectionEnabled
read_default NSGlobalDomain NSAutomaticCapitalizationEnabled
read_default NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled
echo ""

echo "## Trackpad"
read_default com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking
read_default com.apple.AppleMultitouchTrackpad Clicking
echo ""

echo "=== Export Complete ==="
