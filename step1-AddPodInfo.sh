#!/usr/bin/env bash

PROJECT_DIR=$(git rev-parse --show-toplevel)
source ${PROJECT_DIR}/vars

flux create source git podinfo \
  --url=https://github.com/stefanprodan/podinfo \
  --branch=master \
  --interval=30s \
  --export > $FLUXWATCHDIR/podinfo-source.yaml

git add -A && git commit -m "Add podinfo GitRepository"
git pull && git push

flux create kustomization podinfo \
  --target-namespace=default \
  --source=podinfo \
  --path="./kustomize" \
  --prune=true \
  --interval=5m \
  --export > $FLUXWATCHDIR/podinfo-kustomization.yaml

git add -A && git commit -m "Add podinfo Kustomization"
git pull && git push

flux get kustomizations --watch
