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

# Pin an app to the end of the Dock unless it is already there. Restart the Dock afterwards.
function add_to_dock() {
	app="$1"
	[ -d "$app" ] || return 0
	url="file://${app// /%20}/"
	if defaults read com.apple.dock persistent-apps 2>/dev/null | grep -qF "$url"; then
		return
	fi
	echo "Adding $app to the Dock"
	defaults write com.apple.dock persistent-apps -array-add \
		"<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$url</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>"
	DOCK_CHANGED=true
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

	# Link Sublime Merge User preferences directory (opens files in Zed instead of the system default)
	if [ -d "$DIR/Sublime Merge/Packages/User" ]; then
		target_dir="$HOME/Library/Application Support"
		link_file "$DIR/Sublime Merge/Packages/User" "$target_dir/Sublime Merge/Packages/User"
	fi

	# Link Zed editor configuration
	if [ -f "$DIR/.config/zed/settings.json" ]; then
		link_file "$DIR/.config/zed/settings.json" "$HOME/.config/zed/settings.json"
	fi
	if [ -f "$DIR/.config/zed/keymap.json" ]; then
		link_file "$DIR/.config/zed/keymap.json" "$HOME/.config/zed/keymap.json"
	fi

	# Link Ghostty configuration (config and themes)
	if [ -f "$DIR/.config/ghostty/config" ]; then
		link_file "$DIR/.config/ghostty/config" "$HOME/.config/ghostty/config"
		link_file "$DIR/.config/ghostty/themes" "$HOME/.config/ghostty/themes"
	fi

	# Link skhd configuration
	if [ -f "$DIR/.config/skhd/skhdrc" ]; then
		link_file "$DIR/.config/skhd/skhdrc" "$HOME/.config/skhd/skhdrc"
		# Register the launchd agent; needs Accessibility access for skhd before it stays up
		command -v skhd >/dev/null && skhd --start-service
		# Clickable escape hatch for when skhd stalls the keyboard
		osacompile -o "$HOME/Applications/Restart skhd.app" "$DIR/.config/skhd/Restart skhd.applescript"
	fi

	# Dock apps. Activity Monitor and Restart skhd are mouse-only recovery when the keyboard is stuck
	add_to_dock "/Applications/Ghostty.app"
	add_to_dock "/Applications/Alfred 5.app"
	add_to_dock "/System/Applications/Utilities/Activity Monitor.app"
	add_to_dock "$HOME/Applications/Restart skhd.app"
	if [ "$DOCK_CHANGED" == "true" ]; then killall Dock; fi

	# Link Claude Code configuration
	if [ -f "$DIR/.claude/settings.json" ]; then
		link_file "$DIR/.claude/settings.json" "$HOME/.claude/settings.json"
	fi

	# Seed TypeWhisper preferences (stores, audio, history, and model caches stay local)
	# cfprefsd won't read a symlinked plist, so import once; save back with:
	#   defaults export com.typewhisper.mac ~/dotfiles/Library/Preferences/com.typewhisper.mac.plist
	if [ -f "$DIR/Library/Preferences/com.typewhisper.mac.plist" ] && ! defaults read com.typewhisper.mac >/dev/null 2>&1 ; then
		echo "Importing TypeWhisper preferences"
		defaults import com.typewhisper.mac "$DIR/Library/Preferences/com.typewhisper.mac.plist"
	fi

  # make shortcut to iCloud (only with HOMEBREW_FULL)
  if [[ -n "${HOMEBREW_FULL:-}" && ! -e ~/iCloud ]] ; then
    ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs ~/iCloud
  fi
fi
