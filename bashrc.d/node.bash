
export NVM_DIR=~/.nvm

# TO configure nvm:
# mkdir ${NVM_DIR}
# source $(brew --prefix nvm)/nvm.sh
# nvm install 18.0.0
# nvm default 18.0.0
# ln -s ${HOMEBREW_PREFIX}/etc/bash_completion.d/nvm ${NVM_DIR}/bash_completion

# $(brew --prefix nvm)/nvm.sh
source ${HOMEBREW_PREFIX}/opt/nvm/nvm.sh

[ -d ${HOMEBREW_PREFIX}/lib/node_modules ] && NODE_PATH=$NODE_PATH:${HOMEBREW_PREFIX}/lib/node_modules
add_to_path ${HOMEBREW_PREFIX}/share/npm/bin
