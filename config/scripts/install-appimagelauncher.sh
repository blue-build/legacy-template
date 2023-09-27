#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Fetch the URL and assign it to a variable
rpm_url=$(curl -s https://api.github.com/repos/TheAssassin/AppImageLauncher/releases/latest \
  | jq -r '.assets[] | select(.name | endswith("x86_64.rpm")) | .browser_download_url')

# Use the variable in a dnf install command
rpm-ostree install $rpm_url
