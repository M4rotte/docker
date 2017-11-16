#!/usr/bin/env bash

# Build images.

SERVICES="base base-sh mariadb"

echo -e "\n  ### Do some cleaning…\n"
docker container prune --force
docker image prune --force

for service in ${SERVICES}; do

    echo -e "\n  ### Building image \"${service}\": \n"
    docker-compose build $1 $2 ${service}

done

echo -e "\n  ### Do some cleaning…\n"
docker container prune --force
docker image prune --force

echo -e "\n  ### All builds finished.\n"

docker image ls

exit 0
