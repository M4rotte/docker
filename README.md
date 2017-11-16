# Itchy Oxyure’s Docker Images Repository

The wonderful docker images collection.

Each tag can be considered a different image, having its own purpose. Most images, starting with the `base` tag, are built on top of the official Alpine docker image (version 3.6).

Some are simple processes, some use docker-init (aka Tini) or a more complet system daemon (like OpenRC), and some use a custom shell script for entrypoint.

I’m a Docker newbie and I’d be glad having some feedback, whatever it’s positive or negative.

## Tags 

### base

Based on alpine:3.6

 - OpenRC
 - sudo
 - Timezone Europe/Paris
 
Root password may be configured at build-time. In case it is not defined during the image construction, a random password is set.
 
### base-sh

Based on oxyure/oxyure:base

Entrypoint is an un-privileged shell. User is `operator` and may do any command via sudo using its password.

### mariadb

Based on oxyure/oxyure:base

If /var/lib/mysql is empty the database is initiallized. You probably want to use a docker volume or a mount for this.

MariaDB root password must be provided at run-time if /var/lib/mysql is not already populated. The container will exit if no password is provided.
