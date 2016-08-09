
#!/bin/bash

echo "Preparing tests.............................."
./prepare_tests.sh

sleep .5
echo "Test #1: check server's response................"

RESULT="result.txt"
curl -s localhost:9000 > $RESULT

EXPECTED="expectedResponse.txt"
DIFF=$(diff -q  "$RESULT" "$EXPECTED")

if [ "$DIFF" ] 
then
	echo "Fail!"
	exit 1
fi

exit 0
