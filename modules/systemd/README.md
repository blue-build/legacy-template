# `systemd` module for startingpoint

The systemd module allows for enabling and disabling systemd units at build time. Systemd units are declared under `system` and `user`

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

