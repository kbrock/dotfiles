# /usr/local/lib/node_modules
# /usr/local/share/npm/bin
[ -d ${HOMEBREW_PREFIX}/lib/node_modules ] && NODE_PATH=$NODE_PATH:${HOMEBREW_PREFIX}/lib/node_modules
add_to_path ${HOMEBREW_PREFIX}/share/npm/bin
