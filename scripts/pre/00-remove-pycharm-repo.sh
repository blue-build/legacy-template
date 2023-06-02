#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail


# Remove this unneeded repo added in a layered image
if [ -f '/etc/yum.repos.d/_copr:copr.fedorainfracloud.org:phracek:PyCharm.repo' ]; then
  rm /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:phracek:PyCharm.repo
fi
