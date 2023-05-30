#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
set -oue pipefail

# Set UNWANTED_PACKAGES=$(Query all installed packages listed as package names
# only | grab lines containing 'kernel-tools', 'virtualbox', 'kmod', and
# 'nvidia')
UNWANTED_PACKAGES="$(rpm -qa --qf "%{NAME}\n" | grep -P '(?=kernel-tools|virtualbox|kmod|nvidia)')"
if [[ "$?" != 0 ]]; then
    printf "### No problematic packages installed! ###\n"
else
    printf "### Packages are installed which may cause dependency issues ###\n$UNWANTED_PACKAGES\n"
    printf "### Some of these packages can be 'rpm-ostree override remove'-d ###\n"
fi

# Set INSTALLED_KERNEL_PACKAGES=$(Query all installed packages listed as
# package names only | grab entire lines beginning with 'kernel*' except
# 'kernel-tools')
INSTALLED_KERNEL_PACKAGES="$(rpm -qa --qf "%{NAME}\n" | grep -P '^kernel(?!-tools).*')"
printf "### Packages to be replaced ###\n$INSTALLED_KERNEL_PACKAGES\n"

# Automatically determine which Fedora version we"re building.
# Taken from build.sh - shortened
FEDORA_VERSION="$(cat /usr/lib/os-release | grep -Po '(?<=VERSION_ID=)\d+')"
printf "### Fedora version ###\n$FEDORA_VERSION\n"

# Download all files recursively from repo and output to
# /tmp/fsync-kernel-images - So far I've not found a way to specify specific
# files
wget -rc -np -nH -nd --random-wait -P "/tmp/fsync-kernel-images/" \
    https://download.copr.fedorainfracloud.org/results/sentry/kernel-fsync/fedora-$FEDORA_VERSION-x86_64/
printf "### kernel-fsync packages installed into ###\n/tmp/fsync-kernel-images/\n"

# Move into the directory containing the sentry/kernel-fsync files
cd /tmp/fsync-kernel-images/

# Use rpm-ostree's cliwrap to allow dracut to run on the container and generate
# an initramfs.
rpm-ostree cliwrap install-to-root / && \
# Replace all installed kernel packages with the respective fsync packages
rpm-ostree override replace \
    $(echo $INSTALLED_KERNEL_PACKAGES | \
    sed -e 's/^/.\//' | \
    sed -e 's/ /-[0-9]*[^src].rpm .\//g' | \
    sed -e 's/$/-[0-9]*[^src].rpm/')

# Exit the directory
cd ..

# Cleanup
rm -r /tmp/fsync-kernel-images/
printf "### Kernel replaced, temp files cleaned up ###\n"
