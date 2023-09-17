#!/bin/sh

set -ouex pipefail

wget -P /tmp/rpms \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-${RELEASE}.noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${RELEASE}.noarch.rpm

rpm-ostree install \
    /tmp/rpms/*.rpm \
    fedora-repos-archive

rpm-ostree override remove \
    libavcodec-free libavfilter-free libavformat-free libavutil-free \
    libpostproc-free libswresample-free libswscale-free mesa-va-drivers google-noto-sans-cjk-vf-fonts \
    --install=ffmpeg ffmpeg-libs ffmpegthumbnailer intel-media-driver libva-intel-driver \
    mesa-va-drivers-freeworld pipewire-codec-aptx
