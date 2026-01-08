#!/bin/bash

nixosConfiguration=$1
target=$2

echo "Installing NixOS"
echo "Config: $nixosConfiguration"
echo "Target: $target"

nix --extra-experimental-features "nix-command flakes" run \
  github:nix-community/nixos-anywhere -- \
  --flake ".#$nixosConfiguration" \
  --generate-hardware-config nixos-generate-config ./hardware-configuration.nix \
  "$target"