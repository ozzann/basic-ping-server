
#!/bin/bash

# tmp file containing container ID
export CIDFILE="app.cid"

<<<<<<< HEAD
echo "Test #1: check server's response................"
./test_ping_server_app.sh
=======
echo "Preparing tests................................."
./prepare_tests.sh  

FULLCID=$(cat $CIDFILE)
export CONTAINERID=${FULLCID:0:12}
rm $CIDFILE
 ./test_ping_server_app.sh
>>>>>>> origin/master

if [ $? = 1 ]
then 
	exit 1
fi

exit 0
