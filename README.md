# Ōrora (オーロラ)

<div align="center">

[![Build Ōrora](https://github.com/n16hth4wkk/orora/actions/workflows/build.yml/badge.svg)](https://github.com/n16hth4wkk/orora/actions/workflows/build.yml)
[![Ōrora Iso Release](https://github.com/n16hth4wkk/orora/actions/workflows/release-iso.yml/badge.svg?branch=live)](https://github.com/n16hth4wkk/orora/actions/workflows/release-iso.yml)

</div>

<div align="center" width="50%">
  <img width="35%" alt="orora" src="assets/second_design/aurora_ublue_transparent_2.png">

  [Ōrora (オーロラ)](https://www.nihongomaster.com/japanese/dictionary/word/3106/o%E3%83%BCrora-%E3%82%AA%E3%83%BC%E3%83%AD%E3%83%A9) is an opinionated custom-built operating system developed on the solid foundation of Universal Blue (Ublue). Embark on a Cosmic Computing Odyssey with Ōrora: Your Imagination in the Universe of Operating Systems
  
</div>

## Installation

Images that can be rebased:

- [Silverblue](https://fedoraproject.org/silverblue/)
- [Kinoite](https://fedoraproject.org/kinoite/)
- [Sericea](https://fedoraproject.org/sericea/)
- [Onyx](https://fedoraproject.org/onyx/)
- [Any UBlue OS Image](https://universal-blue.org/images/)
- [Any rpm-ostree Based Image](https://coreos.github.io/rpm-ostree/)

---

> [!CAUTION]
> It is reccomended to pin your current deployment before rebasing onto another.
> sudo ostree admin pin 0

- First rebase to the unsigned image, to get the proper signing keys and policies installed:

  ```sh
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/n16hth4wkk/orora:latest --reboot
  ```

- Then rebase to the signed image, like so:

  ```sh
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/n16hth4wkk/orora:latest --reboot
  ```

- This repository builds date tags as well, so if you want to rebase to a particular day's build:

  ```sh
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/n16hth4wkk/orora:20230403
  ```

## Signing

This repository by default also supports signing.
The `latest` tag will automatically point to the latest build. That build will still always use the Fedora version
specified in `recipe.yml`, so you won't get accidentally updated to the next major version.
