#!/bin/bash
echo "Setting up 1password repo"
set -ex
wget https://downloads.1password.com/linux/keys/1password.asc -O /etc/pki/rpm-gpg/1password.asc
cat >/etc/yum.repos.d/1password.repo <<EOF
[1password]
name=1Password Stable Channel
baseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/1password.asc
EOF
