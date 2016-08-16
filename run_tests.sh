
#!/bin/bash


echo "Preparing tests................................."
./prepare_tests.sh  

 ./test_ping_server_app.sh

if [ $? = 1 ]
then 
	exit 1
fi

exit 0
