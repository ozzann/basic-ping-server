
#!/bin/bash

echo "Running tests .................................."

# get docker ip address
DOCKERIP=$(docker inspect --format='{{.NetworkSettings.IPAddress}}' $CONTAINERID)
PORT=9000

# wait until server is ready
echo "Test #1: ping a server ........................."
MAXTRIES=5
ATTEMPT=1
until  nc -z $DOCKERIP $PORT || [ $ATTEMPT == $MAXTRIES ]
do
    sleep 0.5
    ATTEMPT=$(($ATTEMPT+1))
done

if ! nc -z $DOCKERIP $PORT
then
    echo "Fail!"
    exit 1
fi


# ping the server
echo "Test #2: check server's response ..............."

RESULT="serverResponse.txt"
curl -s $DOCKERIP:$PORT > $RESULT

# check result
EXPECTED="expectedResponse.txt"
DIFF=$(diff -q  "$RESULT" "$EXPECTED")

if [ "$DIFF" ] 
then
	echo "Fail!"
	exit 1
fi

exit 0
