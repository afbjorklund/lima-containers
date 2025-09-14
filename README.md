# lima-containers

Container images for Lima, as an exported rootfs.

An image has to satisfy the following requirements:
- systemd or OpenRC (given as the ENTRYPOINT)
- ~~cloud-init~~ (not needed for containers)
- The following binaries to be preinstalled:
    - `sudo`
- The following binaries to be preinstalled:
    - `sshfs`

On boot, the image is supposed to start `sshd`.
Per definition it will listen on tcp port 22.

The user, home and ssh keys will be provided,
the host keys will be generated on first boot.
