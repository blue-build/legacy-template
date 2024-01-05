#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Your code goes here.
cd /
mkdir /tmp/mullvad/
wget -O /tmp/mullvad/mullvad.rpm https://mullvad.net/en/download/app/rpm/latest
ls /tmp/mullvad/
rpm-ostree install ./tmp/mullvad/mullvad.rpm

