# `files` module for startingpoint

The files module simplifies copying files to the image at build time. These files are located in the `config/files` directory (`/tmp/config/files` inside of the image)

Note: If you need to place anything in the `/etc` directory of the final image, it must be placed in `/usr/etc` within your repository. This ensures they are written to `/usr/etc` on the final system. `/usr/etc` is the appropriate directory for system configuration templates on immutable Fedora distros. The normal `/etc` directory is solely for manual overrides and editing by the machine's admin after installation. For more details, refer to issue [#28](https://github.com/ublue-os/startingpoint/issues/28).

Example configuration:

```yaml
type: files
files:
  usr: /usr
```
In this example, the `usr` represents the file or directory inside the config/files directory, and `/usr` represents the corresponding location on the image.


