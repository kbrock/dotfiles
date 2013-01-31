
# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in

for i in ~/dotfiles/bashrc.d/* ; do
  source $i
done
