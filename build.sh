#!/bin/bash
# don't remove the default firefox (from fedora) in favor of the flatpak (U2F broken on Flatpak)
# rpm-ostree override remove firefox firefox-langpacks

echo "-- Installing RPMs defined in recipe.yml --"
rpm_packages=$(yq '.rpms[]' < /tmp/ublue-recipe.yml)
for pkg in $(echo -e "$rpm_packages"); do \
    echo "Installing: ${pkg}" && \
    rpm-ostree install $pkg; \
done
echo "---"

echo "-- Installing RPMFusion and related codecs --"
# remove a bunch of codecs and other stuff that you'll replace with the RPMFusion ones
rpm-ostree override remove toolbox && \
rpm-ostree install \
https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && \
rpm-ostree install rpmfusion-free-release rpmfusion-nonfree-release \
--uninstall rpmfusion-free-release \
--uninstall rpmfusion-nonfree-release && \
rpm-ostree install intel-media-driver libva-intel-driver && \
rpm-ostree override remove mesa-va-drivers --install=mesa-va-drivers-freeworld --install=mesa-vdpau-drivers-freeworld && \
rpm-ostree override remove libavfilter-free libavformat-free libavcodec-free libavutil-free libpostproc-free libswresample-free libswscale-free --install=ffmpeg && \
rpm-ostree install gstreamer1-plugin-libav gstreamer1-plugins-bad-free-extras gstreamer1-plugins-bad-freeworld gstreamer1-plugins-ugly gstreamer1-vaapi && \
mkdir -p /etc/distrobox && \
echo "container_image_default=\"registry.fedoraproject.org/fedora-toolbox:$(rpm -E %fedora)\"" >> /etc/distrobox/distrobox.conf
echo "---"

# install yafti to install flatpaks on first boot, https://github.com/ublue-os/yafti
pip install --prefix=/usr yafti

# add a package group for yafti using the packages defined in recipe.yml
yq -i '.screens.applications.values.groups.Custom.description = "Flatpaks defined by the image maintainer"' /etc/yafti.yml
yq -i '.screens.applications.values.groups.Custom.default = true' /etc/yafti.yml
flatpaks=$(yq '.flatpaks[]' < /tmp/ublue-recipe.yml)
for pkg in $(echo -e "$flatpaks"); do \
    yq -i ".screens.applications.values.groups.Custom.packages += [{\"$pkg\": \"$pkg\"}]" /etc/yafti.yml
done
