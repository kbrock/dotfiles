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
if ! mas list &> /dev/null; then
   echo "Error: You must be signed into the Mac App Store"
   echo "Please open the App Store app and sign in, then run this script again"
   exit 1
fi

echo "Installing Mac App Store applications..."
echo ""

# Development setup - Editors and IDEs
echo "Installing Development Tools..."
mas install 414568915  # Key Codes - Display key codes and unicode characters

# Productivity apps
echo "Installing Productivity Apps..."
mas install 937984704  # Amphetamine - Keep-awake utility
mas install 973134470  # Be Focused - Pomodoro timer and task manager
# mas install 409203825  # Numbers - Apple's spreadsheet application
# mas install 409201541  # Pages - Apple's word processing application

# Communication apps
# mas install 803453959  # Slack - Team communication platform

# this is slow, install at end
mas install 497799835  # Xcode - Apple's integrated development environment
mas install 899247664  # TestFlight - iOS app testing platform

echo ""
echo "✓ App Store installations complete!"
echo ""
echo "Note: Slack is also in your Brewfile."
echo "      You may want to choose either App Store or Homebrew for it."
