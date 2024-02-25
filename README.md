# Legacy template [![build-ublue](https://github.com/blue-build/legacy-template/actions/workflows/build.yml/badge.svg)](https://github.com/blue-build/legacy-template/actions/workflows/build.yml)

> **Warning**  
> This repository was previously `ublue-os/startingpoint`, but has now been [moved to the BlueBuild organization](https://blue-build.org/blog/introducing-bluebuild/). New custom images should be created from the new [blue-build/template](https://github.com/blue-build/template), but this repository will be supported for the foreseeable future.  
> Check out the [migration guide](https://blue-build.org/blog/introducing-bluebuild/#how-to-migrate) for migration instructions.

## Installation

> **Warning**  
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable), try at your own discretion.

To rebase an existing Silverblue/Kinoite installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/blue-build/legacy-template:latest
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/blue-build/legacy-template:latest
  ```
- Reboot again to complete the installation
  ```
  systemctl reboot
  ```

The `latest` tag will automatically point to the latest build. That build will still always use the Fedora version specified in `recipe.yml`, so you won't get accidentally updated to the next major version.

## ISO

This template includes a simple Github Action to build and release an ISO of your image.

To run the action, simply edit the `boot_menu.yml` by changing all the references to startingpoint to your repository. This should trigger the action automatically.

The Action currently uses [ublue-os/isogenerator-old](https://github.com/ublue-os/isogenerator-old) and works in a similar manner to the official Universal Blue ISO. If you have any issues, you should first check [the documentation page on installation](https://universal-blue.org/installation/). The ISO is a netinstaller and should always pull the latest version of your image.

Note that this release-iso action is not a replacement for a full-blown release automation like [release-please](https://github.com/googleapis/release-please).

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/blue-build/legacy-template
```
