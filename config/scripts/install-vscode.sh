#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
rpm-ostree refresh-md
rpm-ostree install code

# Install extensions
declare -a extensions=(
  "ms-python.python"
  "charliermarsh.ruff"
  "ms-python.isort"
  "ms-python.black-formatter"
  "ms-vscode-remote.remote-containers"
  "redhat.vscode-yaml"
)
for ext in "${extensions[@]}"; do
  code --install-extension $ext
done