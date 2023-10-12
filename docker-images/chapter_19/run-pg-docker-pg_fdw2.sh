#!sh

DOCKER_IMAGE_TO_RUN=$1

DOCKER_CONTAINER_NAME=${DOCKER_IMAGE_TO_RUN}_pg_fdw2_1

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

$SUDO docker exec --user postgres --workdir /var/lib/postgresql -it  $DOCKER_CONTAINER_NAME /bin/bash

echo "Stopping the container $DOCKER_CONTAINER_NAME"
$SUDO docker stop $DOCKER_CONTAINER_NAME

