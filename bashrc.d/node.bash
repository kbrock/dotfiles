
export NVM_DIR=~/.nvm

# TO configure nvm:
# mkdir ${NVM_DIR}
# source $(brew --prefix nvm)/nvm.sh
# nvm install 18.0.0
# nvm default 18.0.0

# alt:
# From https://www.ioannispoulakas.com/2020/02/22/how-to-speed-up-shell-load-while-using-nvm/
# # Add default node to path
# add_to_path ${NVM_DIR}/versions/node/v$(< ${NVM_DIR}/alias/default)/bin
# [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh" --no-use

# From https://www.growingwiththeweb.com/2018/01/slow-nvm-init.html
# Defer initialization of nvm until nvm, node or a node-dependent command is
# run. Ensure this block is only run once if .profile gets sourced multiple times
# by checking whether __init_nvm is a defined
if [[ -s "$NVM_DIR/nvm.sh" ]] && ! type -t __init_nvm > /dev/null ; then
  declare -a __node_commands=('nvm' 'node' 'npm' 'yarn' 'gulp' 'grunt' 'webpack')
  function __init_nvm() {
    for i in "${__node_commands[@]}"; do unalias $i; done
    . "$NVM_DIR/nvm.sh"
    unset __node_commands
    unset -f __init_nvm
  }
  for i in "${__node_commands[@]}"; do alias $i='__init_nvm && '$i; done
fi

[ -d ${HOMEBREW_PREFIX}/lib/node_modules ] && NODE_PATH=$NODE_PATH:${HOMEBREW_PREFIX}/lib/node_modules
add_to_path ${HOMEBREW_PREFIX}/share/npm/bin
