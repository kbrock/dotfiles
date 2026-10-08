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
		if [ -d "$target" ] && [ ! -L "$target" ]; then
			echo "Removing existing directory $target"
			rm -rf "$target"
		fi
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
	.inputrc
do
	link_file "$DIR/$target" "$HOME/$target"
done

for target in \
	.gitconfig_platform
do
	if [ "$IS_MAC" == "true" ]; then
		link_file "$DIR/$target-mac" "$HOME/$target"
#	else
#		link_file "$DIR/$target-linux" "$HOME/$target"
	fi
done

if [ "$IS_MAC" == "true" ]; then
	target="Library/KeyBindings/DefaultKeyBinding.dict"
	link_file "$DIR/$target" "$HOME/$target"

	# Link custom dictionary
	target="Library/Spelling/LocalDictionary"
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

	# Link TypeWhisper configuration (excludes audio, dictation history, and plugin/model caches)
	if [ -f "$DIR/Library/Preferences/com.typewhisper.mac.plist" ]; then
		link_file "$DIR/Library/Preferences/com.typewhisper.mac.plist" "$HOME/Library/Preferences/com.typewhisper.mac.plist"
	fi
	for target in \
		"Library/Application Support/TypeWhisper/dictionary.store" \
		"Library/Application Support/TypeWhisper/snippets.store" \
		"Library/Application Support/TypeWhisper/workflows.store" \
		"Library/Application Support/TypeWhisper/prompt-actions.store" \
		"Library/Application Support/TypeWhisper/profiles.store"
	do
		link_file "$DIR/$target" "$HOME/$target"
	done

	# Point iTerm to our custom config files
	defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/dotfiles/Library/iTerm"
	defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

  # make shortcut to iCloud (only with HOMEBREW_FULL)
  if [[ -n "${HOMEBREW_FULL:-}" && ! -e ~/iCloud ]] ; then
    ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs ~/iCloud
  fi
fi
