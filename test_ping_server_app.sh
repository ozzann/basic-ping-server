#!/bin/bash
hostName="localhost:9000"
outputFileName="curlResult.txt"

docker build app .
docker run -d -p 9000:9000 app

data="Hello, world!"
echo `curl -s "$hostName" > $outputFileName`

response="$(cat "$outputFileName")"

if [ "$response" = "$data" ]; then
    echo "Success!"
else
    echo "Fail!"
fi

