FROM debian:unstable-slim

LABEL maintainer="Nicholas Nooney <nicholasnooney@gmail.com>"

COPY scripts/*.sh /tmp/scripts/

ARG USERNAME="nicholasnooney"
ARG USER_UID="auto"
ARG USER_GID="auto"

RUN apt update && bash /tmp/scripts/create-user.sh \
  "${USERNAME}" "${USER_UID}" "${USER_GID}"
