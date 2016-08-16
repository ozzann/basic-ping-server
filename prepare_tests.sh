#!/bin/bash

CONTAINERS=$(docker ps -q -a)
if [ "$CONTAINERS" ]
then
	docker stop $CONTAINERS &> /dev/null
	docker rm $CONTAINERS &> /dev/null
fi

docker build -t app . &> /dev/null
if [ $? -ne 0 ]; then
    echo 'Docker build failed'
    exit 1
fi

docker run -d -p 9000:9000 --cidfile $CIDFILE  app &> /dev/null
