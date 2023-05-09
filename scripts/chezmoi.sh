#!/bin/bash
curl https://api.github.com/repos/twpayne/chezmoi/releases/latest | jq -r '.assets[] | select(.name|test("x86_64.rpm")) | .browser_download_url' | wget -qi -
rpm-ostree install chezmoi*x86_64.rpm
rm -rf chezmoi*x86_64.rpm
