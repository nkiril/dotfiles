#!/bin/bash
#
# ref: https://qiita.com/b4b4r07/items/24872cdcbec964ce2178

read -p 'This may overwrite existing files in your home directory. Are you sure? (y/n): ';

if [[ ${REPLY} =~ ^[Yy]$ ]]; then
  read -p "install directory [${HOME}/denvernine/dotfiles]: ";

  if type curl &> /dev/null || type wget &> /dev/null; then
    dotfiles_directory="${REPLY:=${HOME}/denvernine/dotfiles}"
    tarball_url='https://github.com/denvernine/dotfiles/archive/master.tar.gz'

    if type curl &> /dev/null; then
      curl -L "${tarball_url}"
    elif type wget &> /dev/null; then
      wget -O - "${tarball_url}"
    fi | tar zxv

    unset tarball_url
    mv -f dotfiles-master "${dotfiles_directory}"

    . "${dotfiles_directory}/deploy.sh"
  else
    echo 'curl or wget required.'
    exit 1
  fi
else
  echo 'abort.'
fi
