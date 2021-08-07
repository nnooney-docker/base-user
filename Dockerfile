FROM debian:unstable-slim

LABEL maintainer="Nicholas Nooney <nicholasnooney@gmail.com>"

COPY scripts/*.sh /tmp/scripts/

ARG USERNAME="user"
ARG USER_UID="auto"
ARG USER_GID="auto"
ARG DOTFILES_REPO=""
ARG DOTFILES_DEST="~/dotfiles"

RUN test -z "${DOTFILES_REPO}" || apt install -y -q --no-install-recommends \
  ca-certificates \
  curl \
  git \
  libssl-dev \
  ssh \
  wget

RUN apt update && bash /tmp/scripts/create-user.sh \
  "${USERNAME}" "${USER_UID}" "${USER_GID}"

USER ${USERNAME}

# Installs `ca-certificates curl git wget` if DOTFILES_REPO is provided
RUN bash /tmp/scripts/install-dotfiles.sh \
  "${DOTFILES_REPO}" "${DOTFILES_DEST}"
