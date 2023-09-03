# `files` Module for startingpoint

The `files` module simplifies the process of copying files to the image during the build time. These files are sourced from the `config/files` directory, which is located at `/tmp/config/files` inside the image.

> **Note**
> If you need to place any files in the `/etc` directory of the final image, it's crucial to place them within the `/usr/etc` directory in your image. In immutable Fedora distributions, `/usr/etc` is the appropriate directory for storing system configuration templates. The conventional `/etc` directory is reserved solely for manual overrides and edits by the machine's administrator after installation. For further information, please refer to [issue #28](https://github.com/ublue-os/startingpoint/issues/28).

## Example Configuration:

```yaml
type: files
files:
  usr: /usr
```

In the example above, `usr` represents the directory located inside the `config/files` in the repository, while `/usr` designates the corresponding destination within the image.

