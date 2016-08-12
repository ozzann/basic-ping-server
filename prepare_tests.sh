#!/bin/bash

CONTAINERS=$(docker ps -q -a)
if [ "$CONTAINERS" ]
then
	docker stop $CONTAINERS &> /dev/null
	docker rm $CONTAINERS &> /dev/null
fi

docker rmi app &> /dev/null

docker build -t app . &> /dev/null
docker run -p 9000:9000  app &
