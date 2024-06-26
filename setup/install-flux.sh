#!/bin/bash +x
set -e

# https://fluxcd.io/flux/installation/
#
# Homebrew
#brew install fluxcd/tap/flux
# Chocolatey
#choco install flux
# bash
#curl -s https://fluxcd.io/install.sh | sudo bash
# docker
# flux_version=v2.3.0
# docker run --rm -it ghcr.io/fluxcd/flux-cli:${flux_version} install \
#   --components-extra="image-reflector-controller,image-automation-controller" \
#   --network-policy=false \
#   --export > release-fluxcd-${flux_version}.yaml

flux install \
  --components-extra="image-reflector-controller,image-automation-controller" \
  --network-policy=false \
  --export > release-fluxcd-$(flux version --client | awk '{print $2}').yaml

echo "\nsuccessfully exported flux manifests to release-fluxcd-$(flux version --client | awk '{print $2}').yaml\n"

kubectl apply -f release-fluxcd-$(flux version --client | awk '{print $2}').yaml
