#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Your code goes here.
echo 'Install KWin Script for system76-scheduler Integration'

git clone https://github.com/maxiberta/kwin-system76-scheduler-integration.git --depth 1 /tmp/kwin-system76-scheduler-integration
kpackagetool5 --type=KWin/Script --global --install /tmp/kwin-system76-scheduler-integration
rm -rf /tmp/kwin-system76-scheduler-integration