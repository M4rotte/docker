# Itchy Oxyure’s Docker Images Repository

The wonderful docker images collection.

Most images, starting with the `base` image, are built on top of the official Alpine docker image (version 3.6).

I’m a Docker newbie and I’d be glad having some feedback, whatever it’s positive or negative.

## Images 

### base

Based on alpine:3.6

 - OpenRC
 - sudo
 - Timezone Europe/Paris
 
Root password may be configured at build-time. In case it is not defined during the image construction a random password is set.
 
### base-sh

Based on oxyure/base:latest

Entrypoint is an un-privileged shell. User is `operator` and may do any command via sudo using its password.

### mariadb

Based on oxyure/base:latest

If /var/lib/mysql is empty the database is initiallized. You probably want to use a docker volume or a mount for this.

MariaDB root password must be provided at run-time if /var/lib/mysql is not already populated. The container will exit if no password is provided.

### mini

This is a stripped down Alpine with a proper PID 1 process. Basically: Busybox + musl + Tini. The size (after flattenization) is 1.42MB.

### busybox

Image create from scratch with Busybox 1.28.0 (from source) and Musl 1.1.18 (Debian sid binary)

 - https://wiki.musl-libc.org/building-busybox.html
 - https://github.com/sabotage-linux/kernel-headers
 - `$ make CC="musl-gcc" CFLAGS="-I/opt/package/usr/include -Os"`

Many of the Busybox components which are useless inside a container have been removed. There is no init daemon.

## Docker version

I currently use:

 - Docker version 17.09.0-ce, build afdb6d4
 - docker-compose version 1.17.1, build 6d101fb
