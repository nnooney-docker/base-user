#!/usr/bin/env bash
#
# Create a non-root user for this container.

set -e

USERNAME=${1:-"user"}
USER_UID=${2:-"auto"}
USER_GID=${3:-"auto"}

if [ "$(id -u)" -ne 0 ]; then
  echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
  exit 1
fi

if id -u "${USERNAME}" >/dev/null 2>&1; then
  # user exists
  if [ "${USER_GID}" != "auto" ] && [ "$USER_GID" != "$(id -G $USERNAME)" ]; then
    groupmod --gid $USER_GID $USERNAME
    usermod --gid $USER_GID $USERNAME
  fi
  if [ "${USER_UID}" != "auto" ] && [ "$USER_UID" != "$(id -u $USERNAME)" ]; then
    usermod --uid $USER_UID $USERNAME
  fi
else
  # create user
  if [ "${USER_GID}" = "auto" ]; then
    groupadd $USERNAME
  else
    groupadd --gid $USER_GID $USERNAME
  fi
  if [ "${USER_UID}" = "auto" ]; then
    useradd -s /bin/bash --gid $USERNAME -m $USERNAME
  else
    useradd -s /bin/bash --uid $USER_UID --gid $USERNAME -m $USERNAME
  fi
fi

# ** Shell customization section **
if [ "${USERNAME}" = "root" ]; then
  USER_RC_PATH="/root"
else
  USER_RC_PATH="/home/${USERNAME}"
fi

# Restore user .bashrc defaults from skeleton file if it doesn't exist or is empty
if [ ! -f "${USER_RC_PATH}/.bashrc" ] || [ ! -s "${USER_RC_PATH}/.bashrc" ]; then
  cp /etc/skel/.bashrc "${USER_RC_PATH}/.bashrc"
fi

# Restore user .profile defaults from skeleton file if it doesn't exist or is empty
if [ ! -f "${USER_RC_PATH}/.profile" ] || [ ! -s "${USER_RC_PATH}/.profile" ]; then
  cp /etc/skel/.profile "${USER_RC_PATH}/.profile"
fi
