#!/bin/bash

DOTFILES_ROOT="`pwd`"

set -e

link_file() {
  ln -s $1 $2
  echo "linked $2 to $1"
}

remove_file() {
  rm -rf $1
  echo "removed $1"
}

delete_all() {
  for source in `find $DOTFILES_ROOT -name \*.symlink`
  do
    dest="$HOME/.`basename \"${source%.*}\"`"
    if [ -f $dest ] || [ -d $dest ]
    then
      remove_file $dest
    fi
  done
}

install_dotfiles() {
  echo "Installing dotfiles from $DOTFILES_ROOT"
  for source in `find $DOTFILES_ROOT -name \*.symlink`
  do
    dest="$HOME/.`basename \"${source%.*}\"`"

    link_file $source $dest
  done
}

echo ''
delete_all
install_dotfiles
echo ''
echo ' Installed!'
