# Ōrora

[![build-ublue](https://github.com/n16hth4wkk/orora/actions/workflows/build.yml/badge.svg)](https://github.com/n16hth4wkk/orora/actions/workflows/build.yml)

This is a constantly updating template repository for creating [a native container image](https://fedoraproject.org/wiki/Changes/OstreeNativeContainerStable) designed to be customized however you want. GitHub will build your image for you, and then host it for you on [ghcr.io](https://github.com/features/packages). You then just tell your computer to boot off of that image. GitHub keeps 90 days worth image backups for you, thanks Microsoft!

For more info, check out the [uBlue homepage](https://universal-blue.org/) and the [main uBlue repo](https://github.com/ublue-os/main/)

## Getting started

See the [Make Your Own-page in the documentation](https://universal-blue.org/tinker/make-your-own/) for quick setup instructions for setting up your own repository based on this template.

Don't worry, it only requires some basic knowledge about using the terminal and git.

After setup, it is recommended you update this README to describe your custom image.

> **Note**
> Everywhere in this repository, make sure to replace `n16hth4wkk/orora` with the details of your own repository. Unless you used one of the automatic repository setup tools in which case the previous repo identifier should already be your repo's details.
> **Warning**
> To start, you *must* create a branch called `live` which is exclusively for your customizations. That is the **only** branch the GitHub workflow will deploy to your container registry. Don't make any changes to the original "template" branch. It should remain untouched. By using this branch structure, you ensure a clear separation between your own "published image" branch, your development branches, and the original upstream "template" branch. Periodically sync and fast-forward the upstream "template" branch to the most recent revision. Then, simply rebase your `live` branch onto the updated template to effortlessly incorporate the latest improvements into your own repository, without the need for any messy, manual "merge commits".

## Customization

The easiest way to start customizing is by looking at and modifying `config/recipe.yml`. It's documented using comments and should be pretty easy to understand.

If you want to add custom configuration files, you can just add them in the `/usr/etc/` directory, which is the official OSTree "configuration template" directory and will be applied to `/etc/` on boot. `config/files/usr` is copied into your image's `/usr` by default. If you need to add other directories in the root of your image, that can be done using the `files` module. Writing to `/var/` in the image builds of OSTree-based distros isn't supported and will not work, as that is a local user-managed directory!

For more information about customization, see [the README in the config directory](config/README.md)

Documentation around making custom images exists / should be written in two separate places:

* [The Tinkerer&#39;s Guide on the website](https://universal-blue.org/tinker/make-your-own/) for general documentation around making custom images, best practices, tutorials, and so on.
* Inside this repository for documentation specific to the ins and outs of the template (like module documentation), and just some essential guidance on how to make custom images.

## Installation

> **Warning**
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable) and should not be used in production, try it in a VM for a while!

To rebase an existing Silverblue/Kinoite installation to the latest build:

* First rebase to the unsigned image, to get the proper signing keys and policies installed:

  ```sh
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/n16hth4wkk/orora:latest
  ```

* Reboot to complete the rebase:

  ```sh
  systemctl reboot
  ```

* Then rebase to the signed image, like so:

  ```sh
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/n16hth4wkk/orora:latest
  ```

* Reboot again to complete the installation

  ```sh
  systemctl reboot
  ```

This repository builds date tags as well, so if you want to rebase to a particular day's build:

```sh
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/n16hth4wkk/orora:20230403
```

This repository by default also supports signing.

The `latest` tag will automatically point to the latest build. That build will still always use the Fedora version specified in `recipe.yml`, so you won't get accidentally updated to the next major version.
