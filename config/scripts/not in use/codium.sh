#!/usr/bin/env bash

set -oue pipefail
# This script downloads the latest codium release rpm and installs it

# Create working directory in /tmp and cd to it
mkdir -p /tmp/codium
cd /tmp/codium

# Download codium package
curl -GLO \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
$(curl -GL \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/VSCodium/vscodium/releases/latest | jq  --raw-output '.assets[] | select(.name | test("x86_64.rpm$")).browser_download_url')

# Download checksum
curl -GLO \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
$(curl -GL \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/VSCodium/vscodium/releases/latest | jq  --raw-output '.assets[] | select(.name | test("x86_64.rpm.sha256$")).browser_download_url')

# Check if checksum matches
sha256sum -c ./*.sha256

#Install the package
rpm-ostree install ./*.rpm

#Change the icon to the transparent style
curl -GL https://github.com/VSCodium/icons/raw/main/icons/linux/nobg/blue1/paulo22s.png -o /usr/share/pixmaps/vscodium.png
