
# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in

for i in ~/dotfiles/bashrc.d/* ~/dotfiles/bash_completion.d/* ; do
  source $i
done
