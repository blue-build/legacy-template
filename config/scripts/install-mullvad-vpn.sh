#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

wget --content-disposition https://mullvad.net/download/app/rpm/latest
rpm-ostree install MullvadVPN-*.rpm
rm -f MullvadVPN-*.rpm
