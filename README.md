# base-user

A Docker environment which sets up a non-root user from `debian:unstable-slim`.

## Images

This image gets published at a regular frequency to the
GitHub Container Registry via a [GitHub action](.github/workflows/main.yml).

## Usage

The default user it creates is `developer`. If you want a different user,
clone this repository, customize the Dockerfile arguments, and then publish it
to GitHub to obtain your own custom image.
