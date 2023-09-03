# `systemd` module for startingpoint

The systemd module allows for enabling and disabling systemd units at build time.

Units are split into two categories, being defined under either `system` or `user`, units declared under `user` will be handled with `systemctl --user`, and units declared under `system` will be handled with `systemctl` directly.

Units declared under `enable` with be enabled with `systemctl enable`, and units declared under `disable` will be disabled with `systemctl disable`

Example configuration:
```yaml
type: systemd
  system:
    enable:
      - example.service
    disable:
      - example.target
  user:
    enable:
      - example.timer
    disable:
      - example.service
```

In this example, `example.service` (system) and `example.timer` (user) systemd units are enabled meaning both units will run upon booting the image. `example.service` (user) and `example.target` are both disabled, and thus will not run on boot.

This is effectively the same as:
```sh
systemctl enable example.service
systemctl disable example.target
systemctl --user enable example.timer
systemctl --user disable example.service
```
