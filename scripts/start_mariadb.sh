#!/bin/sh

set -e
set -xo pipefail

PID_FILE=/run/mysqld/mysqld.pid
exec mysqld_safe --pid-file=$PID_FILE

