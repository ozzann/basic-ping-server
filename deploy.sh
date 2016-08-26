#!/bin/bash

echo "Deploying ............ "

CONTAINERS=$(docker ps -q -a)
if [ "$CONTAINERS" ]
then
	docker stop $CONTAINERS &> /dev/null
	docker rm $CONTAINERS &> /dev/null
fi

docker build -t app . 

docker run -d -p 9000:9000 app

exit 0
