#!sh

DOCKER_IMAGE_TO_RUN=$1

DOCKER_CONTAINER_NAME_REPLICA=${DOCKER_IMAGE_TO_RUN}_learn_postgresql_replica_1

# if running as root, no need to use sudo
if [ "$UID" = "0" ]; then
    SUDO=""
else
    SUDO=$(which sudo 2>/dev/null)
    if [ ! -x "$SUDO" ]; then
	echo "\`sudo\` is required to run the script!"
	exit 1
    fi
fi

$SUDO docker exec --user postgres --workdir /var/lib/postgresql -it  $DOCKER_CONTAINER_NAME_REPLICA /bin/bash

