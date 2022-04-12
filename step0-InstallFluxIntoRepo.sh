#!/usr/bin/env bash

PROJECT_DIR=$(git rev-parse --show-toplevel)
source ${PROJECT_DIR}/vars

echo ${REPONAME}

flux check --pre

flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=$REPONAME \
  --branch=main \
  --path=$FLUXWATCHDIR \
  --personal
