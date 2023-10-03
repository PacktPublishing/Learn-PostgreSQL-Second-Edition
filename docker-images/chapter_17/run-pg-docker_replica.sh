#!sh

DOCKER_IMAGE_TO_RUN=$1

DOCKER_CONTAINER_NAME_REPLICA=${DOCKER_IMAGE_TO_RUN}_learn_postgresql_replica_1

sudo docker exec --user postgres --workdir /var/lib/postgresql -it  $DOCKER_CONTAINER_NAME_REPLICA /bin/bash

