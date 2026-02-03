#!/bin/bash -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ "$OSTYPE" == "darwin"* ]]; then
	IS_MAC=true
#else
#	USERPROFILE="/mnt/c/Users/Fryguy"
fi

function link_file() {
	file="$1"
	target="$2"
	copy="$3"

  if [ ! -e "$file" ] ; then
    echo "No source"
  	return
  fi

	link_dir=$(dirname "$target")
	[ ! -d "$link_dir" ] && echo "Creating $link_dir" && mkdir -p "$link_dir"

	if [ "$copy" == "true" ]; then
		echo "Copying $file -> $target"
		echo "TODO"
		rm -f "$target"
		cp "$file" "$target"
	else
		echo "Linking $target -> $file"
		echo "TODO: ensure linked target isn't wonky"
		ln -snf "$file" "$target"
	fi
}

for target in \
	.agignore \
	.bash_profile \
	.bashrc \
	.bundler.d/Gemfile.global.rb \
	.gemrc \
	.gitattributes \
	.gitconfig \
	.gitignore_global \
	.gnupg/gpg.conf \
	.inputrc \
	.irbrc \
do
	link_file "$DIR/$target" "$HOME/$target"
done

for target in \
	.gnupg/gpg-agent.conf \
	.gitconfig_platform
do
	if [ "$IS_MAC" == "true" ]; then
		link_file "$DIR/$target-mac" "$HOME/$target"
#	else
#		link_file "$DIR/$target-linux" "$HOME/$target"
	fi
done

# Set gnupg permissions
if [ -d "$HOME/.gnupg" ]; then
	chown -R $(whoami) $HOME/.gnupg/ 2>/dev/null || true
	chmod 600 $HOME/.gnupg/* 2>/dev/null || true
	chmod 700 $HOME/.gnupg 2>/dev/null || true
fi

if [ "$IS_MAC" == "true" ]; then
	target="Library/KeyBindings/DefaultKeyBinding.dict"
	link_file "$DIR/$target" "$HOME/$target"

	# Link Sublime Text User preferences directory
	if [ -d "$DIR/Sublime Text 3/Packages/User" ]; then
		target_dir="$HOME/Library/Application Support"
		link_file "$DIR/Sublime Text 3/Packages/User" "$target_dir/Sublime Text 3/Packages/User"
	fi

	# Link Zed editor configuration
	if [ -f "$DIR/.config/zed/settings.json" ]; then
		link_file "$DIR/.config/zed/settings.json" "$HOME/.config/zed/settings.json"
	fi
	if [ -f "$DIR/.config/zed/keymap.json" ]; then
		link_file "$DIR/.config/zed/keymap.json" "$HOME/.config/zed/keymap.json"
	fi

	# Link Claude Code configuration
	if [ -f "$DIR/.claude/settings.json" ]; then
		link_file "$DIR/.claude/settings.json" "$HOME/.claude/settings.json"
	fi

	# Point iTerm to our custom config files
	defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/dotfiles/Library/iTerm"
	defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

	# Divvy preferences must be imported via URL (can't be symlinked)
	# To update the export URL: Open Divvy → Preferences → Shortcuts → Export → Copy URL
	# Then save to $DIR/Library/Divvy.url
	echo "To import Divvy shortcuts, open: $DIR/Library/Divvy.url"
	# Uncomment to auto-open:
	# open "$DIR/Library/Divvy.url"
fi

# default to sublime
# defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add '{LSHandlerContentType=public.plain-text;LSHandlerRoleAll=com.sublimetext.4;}'
# default to vscode
defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add '{LSHandlerContentType=public.plain-text;LSHandlerRoleAll=com.microsoft.VSCode;}'
