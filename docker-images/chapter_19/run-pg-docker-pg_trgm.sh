#!sh

DOCKER_IMAGE_TO_RUN=$1

# if not an image specified, use the default
if [ -z "$DOCKER_IMAGE_TO_RUN" ]; then
    DOCKER_IMAGE_TO_RUN=chapter19-pg_trgm
    echo "Using default image <$DOCKER_IMAGE_TO_RUN>"
fi

if [ ! -d $DOCKER_IMAGE_TO_RUN ]; then
    echo "Cannot find docker image directory <$DOCKER_IMAGE_TO_RUN>"
    exit 1
fi


cd $DOCKER_IMAGE_TO_RUN
DOCKER_CONTAINER_NAME=${DOCKER_IMAGE_TO_RUN}_learn_postgresql_1
sudo docker-compose  build
sudo docker-compose up -d --remove-orphans

SECS=5
echo "Waiting $SECS secs for the container to complete starting..."
sleep $SECS

sudo docker exec --user postgres --workdir /var/lib/postgresql -it  $DOCKER_CONTAINER_NAME /bin/bash

echo "Stopping the container $DOCKER_CONTAINER_NAME"
sudo docker stop $DOCKER_CONTAINER_NAME
