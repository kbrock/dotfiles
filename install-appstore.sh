#!/usr/bin/env bash
# Install Xcode from the Mac App Store using mas CLI (everything else is in the Brewfile)
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

echo "Installing Xcode (slow)..."
mas install 497799835  # Xcode - Apple's integrated development environment

echo ""
echo "✓ App Store installations complete!"
