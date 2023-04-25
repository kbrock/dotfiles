
mkdir -p ~/.nvm
export NVM_DIR=~/.nvm

# $(brew --prefix nvm)/nvm.sh
source ${HOMEBREW_PREFIX}/opt/nvm/nvm.sh

[ -d ${HOMEBREW_PREFIX}/lib/node_modules ] && NODE_PATH=$NODE_PATH:${HOMEBREW_PREFIX}/lib/node_modules
add_to_path ${HOMEBREW_PREFIX}/share/npm/bin
