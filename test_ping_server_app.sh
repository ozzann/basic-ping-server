#!/bin/bash
hostName="localhost:9000"
outputFileName="curlResult.txt"

echo "Preparing tests..........."
./prepare_tests.sh

echo "Testing a server app......."

curl  "$hostName" > $outputFileName

response="$(cat "$outputFileName")"

if [ "$response" = "$data" ]; then
    echo "Success!"
else
    echo "Fail!"
fi

