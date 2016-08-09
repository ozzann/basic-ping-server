

#!/bin/bash

CONTAINERS=$(docker ps -q)
if [ $CONTAINERS ] 
then
	docker stop $CONTAINERS &> /dev/null
fi

docker build -t app . &> /dev/null
docker run -d -p 9000:9000 app &> /dev/null

