#!/bin/bash

echo "Preparing tests..........."
./prepare_tests.sh

echo "Testing a server app......."

outputFileName="curlResult.txt"
curl -s localhost:9000 > $outputFileName 

EXPECTED="expectedResponse.txt"
DIFF=$(diff -q "$outputFileName" "$EXPECTED")

if [ "$DIFF" ] 
then
	echo "Fail!"
	exit 1
fi

exit 0
