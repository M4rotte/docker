#!/usr/bin/env bash

# Build and tag images.

DOCKER_HUB_ID="oxyure"
LOCAL_REPO="oxyure"
SERVICES="base base-sh mariadb"

echo -e "\n  ### Do some cleaning…\n"
docker container prune --force
docker image prune --force

for service in ${SERVICES}; do

    echo -e "\n  ### Building image \"${service}\": \n"
    docker-compose build --force-rm --no-cache ${service}
    docker tag ${LOCAL_REPO}:${service} ${LOCAL_REPO}/${service}:latest
done

echo -e "\n  ### Do some cleaning…\n"
docker container prune --force
docker image prune --force

echo -e "\n  ### All builds finished.\n"

docker image ls

exit 0
