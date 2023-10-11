#!sh

DOCKER_IMAGE_TO_RUN=$1

# if not an image specified, use the default
if [ -z "$DOCKER_IMAGE_TO_RUN" ]; then
    DOCKER_IMAGE_TO_RUN=standalone
    echo "Using default image <$DOCKER_IMAGE_TO_RUN>"
fi

if [ ! -d $DOCKER_IMAGE_TO_RUN ]; then
    echo "Cannot find docker image directory <$DOCKER_IMAGE_TO_RUN>"
    exit 1
fi


cd $DOCKER_IMAGE_TO_RUN
DOCKER_CONTAINER_NAME=${DOCKER_IMAGE_TO_RUN}_learn_postgresql_master_1
DOCKER_CONTAINER_NAME_REPLICA=${DOCKER_IMAGE_TO_RUN}_learn_postgresql_replica_1

# check for docker-compose
DOCKER_COMPOSE=$(which docker-compose 2>/dev/null)
if [ ! -x "$DOCKER_COMPOSE" ]; then

    # try to run docker compose
    `docker compose > /dev/null 2>&1`
    if [ $? -eq 0 ]; then
	DOCKER_COMPOSE="docker compose"
	echo "Using \`docker compose\`"
    else
	echo "\`docker-compose\` not installed, cannot proceed"
	exit 2
    fi
fi

# if running as root, no need to use sudo
if [ $UID = 0 ]; then
    SUDO=""
else
    SUDO=$(which sudo 2>/dev/null)
    if [ ! -x "$SUDO" ]; then
	echo "\`sudo\` is required to run the script!"
	exit 1
    fi
fi

$SUDO $DOCKER_COMPOSE build --force-rm --no-cache
$SUDO $DOCKER_COMPOSE up -d --remove-orphans

SECS=25
echo "Waiting $SECS secs for the container to complete starting..."
sleep $SECS

$SUDO docker exec --user postgres --workdir /var/lib/postgresql -it  $DOCKER_CONTAINER_NAME /bin/bash

$SUDO "Stopping the container $DOCKER_CONTAINER_NAME"
$SUDO docker stop $DOCKER_CONTAINER_NAME
$SUDO docker stop $DOCKER_CONTAINER_NAME_REPLICA
