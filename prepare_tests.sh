

#!/bin/bash

docker stop $(docker ps -q)

docker build -t app .
docker run -d -p 9000:9000 app
