#!/bin/bash
# cleanup exited docker containers
EXITED_CONTAINERS=$(docker ps -a | grep Exited | awk '{ print $1 }')
if [ -z "$EXITED_CONTAINERS" ]
then
  echo "No exited containers to clean"
else
  docker rm $EXITED_CONTAINERS
fi
 
# renew certbot certificate
docker compose -f /home/tigaron/docker/server.fls.red/docker-compose.yml run --rm certbot-server.fls.red
docker compose -f /home/tigaron/docker/server.fls.red/docker-compose.yml exec nginx-server.fls.red nginx -s reload
