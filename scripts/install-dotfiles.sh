#!/usr/bin/env bash
#
# Install and execute a dotfiles repository

set -e

DOTFILES_REPO=${1:-""}
DOTFILES_DEST=${2:-"~/dotfiles"}
INSTALL_FILES=("install.sh" "install" "bootstrap.sh" "bootstrap" "setup.sh" "setup")

if [ -z "${DOTFILES_REPO}" ]; then
  echo -e 'Skipping installation of dotfiles repo.'
  exit 0
fi

# Clone a repo
git clone -- "${DOTFILES_REPO}" "${DOTFILES_DEST}"

# Run an install script if one exists
for file in ${INSTALL_FILES[@]}; do
  if [ -f "${DOTFILES_DEST}/${file}" && -x "${DOTFILES_DEST}/${file}" ]; then
    ${DOTFILES_DEST}/$file
    break
  fi
done
