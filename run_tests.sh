
#!/bin/bash

# tmp file containing container ID
export CIDFILE="app.cid"

echo "Preparing tests................................."
./prepare_tests.sh  


FULLCID=$(cat $CIDFILE)
export CONTAINERID=${FULLCID:0:12}
rm $CIDFILE
 ./test_ping_server_app.sh

if [ $? = 1 ]
then 
	exit 1
fi

# If tests are successfull then deploy code to 
# the remote production host
./deploy.sh

exit 0
