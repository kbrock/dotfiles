#!/usr/bin/env bash
# Install Mac App Store applications using mas CLI
# Make sure you're signed into the App Store before running this script

set -e

# Check if mas is installed
if ! command -v mas &> /dev/null; then
    echo "Error: 'mas' is not installed. Install it with: brew install mas"
    exit 1
fi

# Check if signed into App Store
if ! mas account &> /dev/null; then
    echo "Error: You must be signed into the Mac App Store"
    echo "Please open the App Store app and sign in, then run this script again"
    exit 1
fi

echo "Installing Mac App Store applications..."
echo ""

# Development setup - Editors and IDEs
echo "Installing Development Tools..."
mas install 497799835  # Xcode - Apple's integrated development environment
mas install 414568915  # Key Codes - Display key codes and unicode characters
mas install 899247664  # TestFlight - iOS app testing platform
mas install 6738750845 # Semantic SF - SF Symbols browser and viewer

# Productivity apps
echo "Installing Productivity Apps..."
mas install 937984704  # Amphetamine - Keep-awake utility
mas install 973134470  # Be Focused - Pomodoro timer and task manager
# mas install 635758264  # Calca - Symbolic calculator and math notebook
mas install 409203825  # Numbers - Apple's spreadsheet application
mas install 409201541  # Pages - Apple's word processing application
mas install 6720708363 # Obsidian Web Clipper - Web clipper for Obsidian

# Media and image tools
echo "Installing Media and Image Tools..."
mas install 1219074514 # Linearity Curve - Vector design and illustration tool
mas install 1582493835 # Lunacy - Design tool with built-in graphics

# Apps also available via Homebrew (you may want to choose one method):
# - Divvy (413857545) - included in Brewfile as cask "divvy"
# - Simplenote (692867256) - not included in Brewfile
# - Slack (803453959) - included in Brewfile as cask "slack"

# Uncomment these if you prefer App Store versions over Homebrew:
# mas install 413857545  # Divvy - Window management tool
# mas install 692867256  # Simplenote - Simple note-taking app
# mas install 803453959  # Slack - Team communication platform

echo ""
echo "✓ App Store installations complete!"
echo ""
echo "Note: Some apps (Divvy, Slack) are also in your Brewfile."
echo "      You may want to choose either App Store or Homebrew for these."
