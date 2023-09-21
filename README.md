# Gidrov OS

My lightly customized image, based on Fedora Silverblue, main edition, derived from UniversalBlue project.

Removed packages (RPMs), which I consider a bloat:
- Firefox
- htop
- nvtop
- Gnome Software (not in the best state right now)
- Gnome classic session
- Gnome Tour
- Gnome System Monitor
- Gnome system extensions
- Gnome Tweaks

Replaced packages (RPMs)/usecases:
- Ungoogled Chromium from Flathub instead of Firefox rpm
- Flathub web shortcut from Ungoogled Chromium instead of Gnome Software for browsing & installing flatpaks
- Mission Center from Flathub instead of Gnome System Monitor

Installed packages (RPMs):
- Extensions (currently tied to pre-installed extensions listed below, I will try to find the way to remove it)
- System76 Scheduler (for performance improvement by adequately adjusting process priorities in realtime)

Added extensions:
- Blur My Shell
- OpenWeather
- Caffeine
- System76 Scheduler (needed for integration with Gnome)

Note: Flatpaks below are not separated in the system + user remote. This will maybe get implemented in the future.

System(ish) flatpaks (what I consider a must out-of-the-box):
- Flatseal
- Easy Effects
- Gnome Image Viewer (Loupe)
- Gnome Snapshot
- Gnome Document Viewer
- Extension Manager
- Gnome Text Editor
- Sticky Notes
- Secrets
- Gradience
- Gnome Calculator
- Gnome Calendar
- Gnome Maps
- Gnome Boxes
- Gnome Clocks
- LibreOffice
- G4Music
- Clapper
- Bottles

User flatpaks:
- Dialect
- Telegram Desktop
- Discord
- Rnote
- Fragments
- FreeTube
- ASCII Draw
- Mousai
- NewsFlash
- Tagger
- Parabolic
- Nicotine+
- Tenacity
- Thunderbird
- GitHub Desktop
- PCSX2
- Space Cadet Pinball
- Grapejuice
- ProtonPlus

Settings applied by default:
- Close button from windows removed (because I mapped the close button to special mouse key)
- Set font hinting to "None"
- Enable "Remove Old Trash files automatically" in Nautilus
- Set mouse acceleration to flat
- Set Nokia Pure Text font as default 
- Set BlurMyShell sigma value to 12, as default value is too strong & looks cheap imo
- Set OpenWeather to top right, set condition to show on top bar, set arrows for wind direction & use mbar for pressure

Additional configuration:
- OBS distrobox, hide/unhide grub justfile
- bling justfile (which I would remove, but just command won't work without it)

## Post-Setup
- Install OBS distrobox container
  ```
  just install-obs-studio-portable
  ```
- Install Bazzite-arch distrobox container, which includes Steam & Lutris for gaming + AdwSteamGTK skin (enter commands one by one)
  ```
  just distrobox-bazzite
  distrobox-enter -n bazzite-arch -- '  distrobox-export --app steam'
  distrobox-enter -n bazzite-arch -- '  distrobox-export --app lutris'
  distrobox-enter -n bazzite-arch -- '  paru -S adwsteamgtk --noconfirm'
  distrobox-enter -n bazzite-arch -- '  distrobox-export --app AdwSteamGtk'
  ```
- Hide GRUB
  ```
  just hide-grub
  ```

## Post-Setup which will get integrated into the image
Install & enable selected extensions in Extension Manager:
- Quick Close in Overview
- Rounded Window Corners
- GTK3 Theme Switcher

Than apply "Enable Nautilus "Sort folders before files"" manually in Nautilus settings. (manually because command doesn't work right now)

Config changes (one-liner command):
- Add Nautilus "New Document" to context menu
- Set light & dark theme to AdwGtk3
- Set keyboard delay to be much faster, as Gnome defaults are too slow
- "Window not responding" dialog extended to 20s

Run this command after install until I implement this into the image:
  ```
touch ~/Templates/Untitled\ Document && gsettings --schemadir ~/.local/share/gnome-shell/extensions/gtk3-theme-switcher@charlieqle/schemas/ set org.gnome.shell.extensions.gtk3-theme-switcher light adw-gtk3 && gsettings --schemadir ~/.local/share/gnome-shell/extensions/gtk3-theme-switcher@charlieqle/schemas/ set org.gnome.shell.extensions.gtk3-theme-switcher dark adw-gtk3-dark && gsettings set org.gnome.desktop.peripherals.keyboard delay 226 && gsettings set org.gnome.mutter check-alive-timeout 20000
  ```

## Installation (ISO) [Recommended]

ISOs are online-based & are constantly upgraded. There is no need to worry about the version & the date of the ISO.
Just download, install & enjoy!

Available for download in Releases page.

## Installation (Rebase)

> **Warning**
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable) and should not be used in production, try it in a VM for a while!

To rebase an existing Silverblue/Kinoite installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/fiftydinar/gidrov-os:latest
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/fiftydinar/gidrov-os:latest
  ```
- Reboot again to complete the installation
  ```
  systemctl reboot
  ```

This repository builds date tags as well, so if you want to rebase to a particular day's build:

```
sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/fiftydinar/gidrov-os:20230403
```
