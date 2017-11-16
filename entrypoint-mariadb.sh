#!/bin/sh

# oxyure:mariadb entrypoint.sh
#
# Only one mandatory argument: the mariadb root password
#
# The password will be set only if /var/lib/mysql/mysql doesn’t exist
# (so the initial setup takes place).
# If the mysql database doesn’t exist and root password is not provided
# the MariaDB server won’t start and the container will exit.

set -e

PID_FILE=/run/mysqld/mysqld.pid
DATADIR=/var/lib/mysql/

if [ ! -d "$DATADIR/mysql" ]
then
    echo "MariaDB Initial setup…"
    [ -z "$1" ] && { echo "MariaDB Initial setup FAILED." ; echo "No password provided for the MariaDB root account. Exiting."; exit 1; }
    mysql_install_db --force --skip-auth-anonymous-user --user=mysql
    (mysqld_safe --pid-file=$PID_FILE &) &&\
    sleep 3 &&\
    echo "Setting root password…" &&\
    mysqladmin -u root password "$1" &&\
    kill -15 $(cat $PID_FILE) && sleep 3 &&\
    
    echo "MariaDB Initial setup OK."
else
    echo "Database '$DATADIR/mysql' exists."
fi
      
echo "Starting MariaDB…"
exec mysqld_safe --pid-file=$PID_FILE



