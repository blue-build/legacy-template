# My custom uBlue images

> **Warning**
> These images are made only for my hardware and may not work on yours, but they could, feel free to try.
> Anyone that uses AMD/Intel should have no problems booting, but I can't tell you any more than that.
> Some changes I have made will only affect a certain type of laptop (e.g, I made custom scripts to handle my lenovo laptop's battery conservation mode)

[![build-ublue](https://github.com/noahdotpy/.mykinoite/actions/workflows/build.yml/badge.svg)](https://github.com/noahdotpy/.mykinoite/actions/workflows/build.yml)

This is a constantly updating repository which hosts my custom [ostree images](https://fedoraproject.org/wiki/Changes/OstreeNativeContainerStable) designed to be customized however you want.
GitHub will build this image, and then host it on [ghcr.io](https://github.com/features/packages).
The users can then tell the computer to boot off of that image.
GitHub keeps 90 days worth of image backups for us, thanks Microsoft!

For info on how to create your own, check out [ublue/startingpoint](https://github.com/ublue-os/startingpoint)
and the [uBlue tinkering documentation](https://universal-blue.org/tinker/make-your-own/).

## Customization

The easiest way to start customizing is by looking at and modifying `config/recipe.yml`.
It's documented using comments and should be pretty easy to understand.

If you want to add custom configuration files, you can just add them in the `/usr/etc/` directory, 
which is the official OSTree "configuration template" directory and will be applied to `/etc/` on boot.
`config/files/usr` is copied into your image's `/usr` by default.
If you need to add other directories in the root of your image, that can be done using the `files` module.
Writing to `/var/` in the image builds of OSTree-based distros isn't supported and will not work, as that is a local user-managed directory!

For more information about customization, see [the README in the config directory](config/README.md)

Documentation around making custom images exists in two separate places:
* [The Tinkerer's Guide on the website](https://universal-blue.org/tinker/make-your-own/) for general documentation around making custom images, best practices, tutorials, and so on.
* Inside this repository for documentation specific to the ins and outs of the template (like module documentation),
and just some essential guidance on how to make custom images.

## Installation

> **Warning**
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable) and should not be used in production, try it in a VM for a while!

To rebase an existing Silverblue/Kinoite installation to the latest build:

> **Tip**
> If you are already on a signed uBlue image you may skip directly to step 3

- 1. First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/noahdotpy/mykinoite:latest
  ```
- 2. Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- 3. Then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/noahdotpy/mykinoite:latest
  ```
- 4. Reboot again to complete the installation
  ```
  systemctl reboot
  ```

This repository builds date tags as well, so if you want to rebase to a particular day's build:

```
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/noahdotpy/mykinoite:20230403
```

This repository by default also supports signing.

The `latest` tag will automatically point to the latest build.
That build will still always use the Fedora version specified in `recipe.yml`, so you won't get accidentally updated to the next major version.

## ISO

This template includes a simple Github Action to build and release an ISO of your image. 

The Action uses [isogenerator](https://github.com/ublue-os/isogenerator) and works in a similar manner to the official Universal Blue ISO. If you have any issues, you should first check [the documentation page on installation](https://universal-blue.org/installation/). The ISO is a netinstaller and should always pull the latest version of your image.

Note that this release-iso action is not a replacement for a full-blown release automation like [release-please](https://github.com/googleapis/release-please).

## `just`

The [`just`](https://just.systems/) command runner is included in all `ublue-os/main`-derived images.

> **Tip**: Type `just` to list the just recipes available.

The file `/usr/share/ublue-os/just/custom.just` is intended for the custom just commands (recipes) you wish to include in your image.
if you wish to disable that, you need to just remove the line that includes bling.just.

See [the just-page in the Universal Blue documentation](https://universal-blue.org/guide/just/) for more information.
