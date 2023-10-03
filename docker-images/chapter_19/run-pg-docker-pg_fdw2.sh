#!sh

DOCKER_IMAGE_TO_RUN=$1

DOCKER_CONTAINER_NAME=${DOCKER_IMAGE_TO_RUN}_pg_fdw2_1

sudo docker exec --user postgres --workdir /var/lib/postgresql -it  $DOCKER_CONTAINER_NAME /bin/bash

echo "Stopping the container $DOCKER_CONTAINER_NAME"
sudo docker stop $DOCKER_CONTAINER_NAME

