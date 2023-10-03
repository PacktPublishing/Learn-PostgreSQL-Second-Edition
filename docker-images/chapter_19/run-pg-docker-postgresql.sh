#!sh

DOCKER_IMAGE_TO_RUN=chapter19-mysql2postgresql

cd $DOCKER_IMAGE_TO_RUN
DOCKER_CONTAINER_NAME=${DOCKER_IMAGE_TO_RUN}_postgresql_1

sudo docker exec --user postgres --workdir /var/lib/postgresql -it  $DOCKER_CONTAINER_NAME /bin/bash

echo "Stopping the container $DOCKER_CONTAINER_NAME"
sudo docker stop $DOCKER_CONTAINER_NAME
