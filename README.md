# Centos 7 systemd unprivileged patch

This project patches systemd to allow systemd to be executed in a docker container without the SYS_ADMIN capability.  Currently in user namespaced containers systemd starts correctly however dbus is not configured correctly so commands like systemctl do not work correctly.

## Build Image
    docker build -t centos7-systemd-patch .

## Build Patch
    docker run -it --rm -v /output/:/output/ centos7-systemd-patch
