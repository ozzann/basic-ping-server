
#!/bin/bash

# Internal functions
is_listening() {
    LOGS=$(docker logs $1)
    LISTEN_REGEX="LISTEN"

    if [[ $LOGS =~ $LISTEN_REGEX ]]
    then
       return 1
    fi

    return 0
}


echo "Running tests .................................."

# wait until the server is ready
echo "Test #1: ping a server ........................."
MAXTRIES=5
ATTEMPT=1

is_listening $CONTAINERID
LISTEN_FLAG=$?
until [ $LISTEN_FLAG == 1 ] || [ $ATTEMPT == $MAXTRIES ]
do
    sleep 0.1
    ATTEMPT=$(($ATTEMPT+1))
    is_listening $CONTAINERID
    LISTEN_FLAG=$?
done

if [ ! $LISTEN_FLAG ]
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
