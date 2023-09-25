#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
set -oue pipefail

# Add the repo
# wget https://copr.fedorainfracloud.org/coprs/kylegospo/gnome-vrr/repo/fedora-$(rpm -E %fedora)/kylegospo-gnome-vrr-fedora-$(rpm -E %fedora).repo -O /etc/yum.repos.d/_copr_kylegospo-gnome-vrr.repo
# wget https://copr.fedorainfracloud.org/coprs/kylegospo/gnome-vrr/repo/fedora-38/kylegospo-gnome-vrr-fedora-38.repo -O /etc/yum.repos.d/_copr_kylegospo-gnome-vrr.repo

# Replace with vrr components
# rpm-ostree override replace --experimental --from repo=copr:copr.fedorainfracloud.org:kylegospo:gnome-vrr mutter mutter-common gnome-control-center gnome-control-center-filesystem xorg-x11-server-Xwayland

# Remove extra repos
ls -l /etc/yum.repos.d/
rm -rf /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:phracek:PyCharm.repo
rm -rf /etc/yum.repos.d/google-chrome.repo
rm -rf /etc/yum.repos.d/fedora-updates-archive.repo
rm -rf /etc/yum.repos.d/fedora-updates-testing.repo
rm -rf /etc/yum.repos.d/rpmfusion-nonfree-steam.repo
rm -rf /etc/yum.repos.d/rpmfusion-nonfree-nvidia-driver.repo

ls -l /etc/yum.repos.d/