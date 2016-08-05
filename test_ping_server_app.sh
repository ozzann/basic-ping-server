#!/bin/bash
hostName="localhost:8080"
outputFileName="curlResult.txt"


data="Hello, world!"
echo `curl -s "$hostName" > $outputFileName`

response="$(cat "$outputFileName")"

if [ "$response" = "$data" ]; then
    echo "Success!"
else
    echo "Fail!"
fi

