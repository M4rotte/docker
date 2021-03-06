#!/usr/bin/env bash

# Build images.

# Arguments are prepended to the `docker-compose build` command argument array
# (before the service name)
#
# Possible values are:
#    --force-rm              Always remove intermediate containers.
#    --no-cache              Do not use cache when building the image.
#    --pull                  Always attempt to pull a newer version of the image.
#    --build-arg key=val     Set build-time variables for one service.
    
HUB_ID="oxyure"
SERVICES="base base-sh mariadb mini busybox"

function prune_docker {
    echo -e "\n  ### Do some cleaning…\n"
    docker container prune --force
    docker image prune --force 
}

function flatten {
    # Service is given as argument. ***The image `$HUB_ID/$1:latest-full` is supposed to exist.***
    # Then `$HUB_ID/$1:latest` will be created and the original image deleted.
    echo -e "\n  ### Flattening $HUB_ID/$1:latest-full\n"
    RANDNAME="$(echo $RANDOM |sha512sum |cut -d' ' -f1)"
    docker run -d --name "$RANDNAME" "$HUB_ID/$1:latest-full"
    docker stop "$RANDNAME"
    docker export -o "/tmp/$RANDNAME.tar" "$RANDNAME"
    docker import \
       --change 'WORKDIR /' \
       --change 'USER root' \
       --change 'ENTRYPOINT ["/sbin/tini","/bin/su","-l","-c","/bin/sh","operator"]' \
       --message "/tmp/$RANDNAME.tar" \
       "/tmp/$RANDNAME.tar" "$HUB_ID/$1:latest"
    rm "/tmp/$RANDNAME.tar"
    docker rm "$RANDNAME"
    docker rmi "$HUB_ID/$1:latest-full"
}

for service in ${SERVICES}; do

    echo -e "\n  ### Building image \"${service}\"\n"
    echo -e "docker-compose build $@ ${service}\n"
    docker-compose build $@ ${service}

done

echo -e "\n  ### All builds finished\n"

flatten 'mini'

prune_docker

docker image ls

exit 0
