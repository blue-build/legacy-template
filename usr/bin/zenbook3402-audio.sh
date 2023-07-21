#!/usr/bin/env bash
# This script downloads and applies the required modifications to the ACPI tables in order for the sound to work on the ASUS Zenbook 3402za
# and similar laptops using the same chip. 

# set -oue pipefail
#
if [[ -f "/var/lib/zenbook3402-audio" ]]
then 
  exit 0
fi

mkdir /tmp/audio-build 
cd /tmp/audio-build
curl https://raw.githubusercontent.com/thor2002ro/asus_zenbook_ux3402za/main/Sound/ssdt-csc3551.dsl -o ssdt-csc3551.dsl
curl https://raw.githubusercontent.com/thor2002ro/asus_zenbook_ux3402za/main/Sound/01_acpi -o 01_acpi

iasl -tc ssdt-csc3551.dsl

cp -f ssdt-csc3551.aml /boot
cp -f 01_acpi /etc/grub.d

chmod +x /etc/grub.d/01_acpi
grub2-mkconfig -o /etc/grub2-efi.cfg

/usr/bin/touch /var/lib/zenbook3402-audio
