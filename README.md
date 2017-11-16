# Miscellaneous Docker images

## base

Based on alpine:3.6

 - OpenRC
 - sudo
 - Timezone Europe/Paris
 
Root password may be configured at build-time or at run-time.
 
## base-sh

Based on oxyure/oxyure:base

Entrypoint is a un-privileged shell.

## mariadb

Based on oxyure/oxyure:base

MariaDB. To be used with a docker volume mounted on /var/lib/mysql.

If /var/lib/mysql is empty the database is initiallized.

MariaDB root password must be provided at run-time.
