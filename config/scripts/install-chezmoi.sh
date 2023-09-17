#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

VER=$(curl -s https://api.github.com/repos/twpayne/chezmoi/releases/latest|grep tag_name|cut -d '"' -f 4)
VER2=$(echo "$VER" | sed -r 's/v//g')
rpm-ostree install https://github.com/twpayne/chezmoi/releases/download/${VER}/chezmoi-${VER2}-x86_64.rpm
