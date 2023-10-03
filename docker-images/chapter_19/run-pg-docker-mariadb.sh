#!sh

DOCKER_IMAGE_TO_RUN=chapter19-mysql2postgresql

cd $DOCKER_IMAGE_TO_RUN
DOCKER_CONTAINER_NAME=${DOCKER_IMAGE_TO_RUN}_mariadb_1
sudo docker-compose  build
sudo docker-compose up -d --remove-orphans

SECS=5
echo "Waiting $SECS secs for the container to complete starting..."
sleep $SECS

sudo docker exec --user root --workdir /root  -it  $DOCKER_CONTAINER_NAME /bin/bash

echo "Stopping the container $DOCKER_CONTAINER_NAME"
sudo docker stop $DOCKER_CONTAINER_NAME
