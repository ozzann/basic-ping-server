

#!/bin/bash

CONTAINERS=$(docker ps -q)
if [ $CONTAINERS ]
then
	docker rm $CONTAINERS &> /dev/null
fi

docker build -t app /home/annas/dockerizing/basic-ping-server &> /dev/null
docker run -d -p 9000:9000 app &> /dev/null
