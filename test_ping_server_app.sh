
#!/bin/bash

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
