#!/usr/bin/env bash

# Your code goes here.
wget -O /tmp/mullvad.rpm https://mullvad.net/en/download/app/rpm/latest
sudo rpm-ostree install ./tmp/mullvad.rpm
sudo systemctl enable --now mullvad-daemon
