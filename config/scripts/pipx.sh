#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Your code goes here.
while IFS= read -r pkg; do echo "Installing $pkg" && PIPX_HOME=/usr/lib/opt/pipx PIPX_BIN_DIR=/var/usrlocal/bin pipx install $pkg; done < $CONFIG_DIRECTORY/scripts/packages/pipx.pkg
