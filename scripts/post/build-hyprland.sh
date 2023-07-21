#!/bin/bash

git clone --recursive https://github.com/hyprwm/Hyprland
cd Hyprland || exit 1
meson _build
ninja -C _build
sudo ninja -C _build install

cp /usr/local/share/wayland-sessions/hyprland.desktop /usr/share/wayland-sessions
