#!/usr/bin/env bash
set -euo pipefail
sudo apt-get update -y
if [[ -f /mnt/c/Users/*/bootstrap-repo/manifests/apt-packages.txt ]]; then
  xargs -a /mnt/c/Users/*/bootstrap-repo/manifests/apt-packages.txt -r sudo apt-get install -y
fi
