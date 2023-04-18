# /usr/local/lib/node_modules
# /usr/local/share/npm/bin
[ -d $(brew --prefix)/lib/node_modules ] && NODE_PATH=$NODE_PATH:$(brew --prefix)/lib/node_modules
add_to_path $(brew --prefix)/share/npm/bin
