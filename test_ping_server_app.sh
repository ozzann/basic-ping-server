
#!/bin/bash

echo "Running tests .................................."

# wait until tmp file 'listens' is created.
# It indicates if a servery is ready or not.
echo "Test #1: ping a server ........................."
MAXTRIES=5
ATTEMPT=1
TMPFILE=listens
until [ -f TMPFILE ] || [ $ATTEMPT == $MAXTRIES ]
do
    sleep 0.5
    ATTEMPT=$(($ATTEMPT+1))
done

if ! -f TMPFILE
then
    echo "Fail!"
    exit 1
fi


# ping the server
echo "Test #2: check server's response ..............."

RESULT="serverResponse.txt"
curl -s http://localhost:9000 > $RESULT

# check result
EXPECTED="expectedResponse.txt"
DIFF=$(diff -q  "$RESULT" "$EXPECTED")

if [ "$DIFF" ] 
then
	echo "Fail!"
	exit 1
fi

exit 0
