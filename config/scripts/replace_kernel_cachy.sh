#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
set -oue pipefail

FEDORA_VERSION="$(cat /usr/lib/os-release | grep -Po '(?<=VERSION_ID=)\d+')"
INSTALLED_KERNEL_PACKAGES="$(rpm -qa --qf "%{NAME}\n" | grep -P '^kernel(?!-tools).*')"

printf "### Fedora version ###\n$FEDORA_VERSION\n\n"
printf "### Packages to be replaced ###\n$INSTALLED_KERNEL_PACKAGES\n\n"
sleep 2

# Use rpm-ostree's cliwrap to allow dracut to run on the container and generate
# an initramfs.
### COMMENT OUT BELOW LINE IF USING LOCALLY ###
rpm-ostree cliwrap install-to-root / && \
rpm-ostree override remove $INSTALLED_KERNEL_PACKAGES --install=kernel-cachyos-bore-eevdf
# rpm-ostree override remove $INSTALLED_KERNEL_PACKAGES --install=kernel-specified
# rpm-ostree override replace "URL/kernel-name.rpm"

# Credit https://github.com/JosSamLoh/replace-kernel/blob/live/scripts/replace-kernel-easy.sh
