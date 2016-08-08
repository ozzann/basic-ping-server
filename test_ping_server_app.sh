#!/bin/bash
hostName="0.0.0.0:9000"
outputFileName="curlResult.txt"

echo "Preparing tests..........."
./prepare_tests.sh


data="Hello, world!"
echo "Testing a server app......."

curl -v localhost:9000


curl  "$hostName" > $outputFileName

response="$(cat "$outputFileName")"

if [ "$response" = "$data" ]; then
    echo "Success!"
else
    echo "Fail!"
fi

