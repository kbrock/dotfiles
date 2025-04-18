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
  .autotest \
  .agignore \
  .autotest \
  .bash_profile \
  .bashrc \
	.bundler.d/Gemfile.global.rb \
	.editrc \
	.gemrc \
	.gitattributes \
	.gitconfig \
	.gitignore_global \
	.gnupg/gpg.conf \
	.gnuplot \
	.inputrc \
	.irbrc \
	.rdebugrc \
do
	link_file "$DIR/$target" "$HOME/$target"
done

# for target in \
# 	.gnupg/gpg-agent.conf \
# 	.gitconfig_platform
# do
# 	if [ "$IS_MAC" == "true" ]; then
# 		link_file "$DIR/$target-mac" "$HOME/$target"
# #	else
# #		link_file "$DIR/$target-linux" "$HOME/$target"
# 	fi
# done

if [ "$IS_MAC" == "true" ]; then
	target="Library/KeyBindings/DefaultKeyBinding.dict"
	link_file "$DIR/$target" "$HOME/$target"

	#link_file "$DIR/Sublime Text 3/Packages/User/Twilight (Fryguy).tmTheme" "$HOME/Library/Preferences/bat/themes/Twilight (Fryguy).tmTheme"
#else
#	link_file "/mnt/c/Program Files/Sublime Text 3/subl.exe" "$HOME/bin/subl"
fi

IFS=$'\n' files=($(ls "Sublime Text 3/Packages/User"))
for target in ${files[@]}; do
	if [ "$IS_MAC" == "true" ]; then
		target_dir="$HOME/Library/Application Support"
#	else
#		copy=true
#		target_dir="$USERPROFILE/AppData/Roaming"
#	fi
	link_file "$DIR/Sublime Text 3/Packages/User" "$target_dir/Sublime Text 3/Packages/User"
done

# point iTerm to our custom config files
defaults write com.googlecome.iterm2 PrefsCustomFolder -string "~/dotfiles/Library/iTerm"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
# Divyy has been acting up
open $DIR/Library/Divvy.url
