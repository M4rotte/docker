#!/bin/sh

mysqld_safe &
ps -ef
sleep 3
ps -ef
sleep 1
mysqladmin -u root password "$1"
mysqladmin -u root -p"$1" shutdown

exit 0
