# Starting point

[![build-ublue](https://github.com/noahdotpy/myublue/actions/workflows/build.yml/badge.svg)](https://github.com/noahdotpy/myublue/actions/workflows/build.yml)

This is a constantly updating custom [native container image](https://fedoraproject.org/wiki/Changes/OstreeNativeContainerStable). GitHub builds this image. and then hosts it on [ghcr.io](https://github.com/features/packages). You then just tell your computer to boot off of that image. GitHub keeps 90 days worth image backups for you, thanks Microsoft!

For more info, check out the [uBlue homepage](https://ublue.it/) and the [main uBlue repo](https://github.com/ublue-os/main/)
## Installation

> **Warning**
> This is an experimental feature and should not be used in production, try it in a VM for a while!

To rebase an existing Silverblue/Kinoite installation to the latest build:

```
sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/noahdotpy/myublue-gnome:latest
```

This repository builds date tags as well, so if you want to rebase to a particular day's build:

```
sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/noahdotpy/myublue-gnome:20230403
```

The `latest` tag will automatically point to the latest build. That build will still always use the Fedora version specified in `recipe.yml`, so you won't get accidentally updated to the next major version.

## Just

The `just` task runner is included in `ublue-os/main`-derived images, and we have provided several template commands which help you perform further customization after first boot.

You can merge our template justfiles into your own local configuration. When `just` supports [include directives](https://just.systems/man/en/chapter_52.html), you will instead be able to simply include these paths into your own justfile, without having to copy anything manually.

Run the following commands when you're logged into the operating system, to merge uBlue's provided configurations into your own user config. (The "touch" command is only necessary on certain shells which won't let you merge into non-existent files.)

```sh
touch ~/.justfile
cat /usr/share/ublue-os/just/main.just >> ~/.justfile
cat /usr/share/ublue-os/just/custom.just >> ~/.justfile
```

After doing that, you'll be able to run the following commands:

- `just` - Show all tasks

Check the [just website](https://just.systems) for tips on modifying and adding your own recipes.

## Verification

These images are signed with sisgstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the following command:

    cosign verify --key cosign.pub ghcr.io/noahdotpy/myublue

If you're forking this repo, the uBlue website has [instructions](https://ublue.it/making-your-own/) for setting up signing properly.
