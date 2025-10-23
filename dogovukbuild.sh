#!/bin/sh

. /build/environment.sh 

cd /build/repos/emergency-alerts-govuk

make bootstrap
# make test

if [ $? -eq 0 ]
then
	. /build/environment.sh && flask --debug run -h 0.0.0.0 -p 6017
else
	echo ""
	echo ""
	echo ""
	echo "********************************"
	echo "* BUILD TESTS FAILED - EXITING *"
	echo "********************************"
	echo ""
	echo ""
fi

while [ 1 ]
do
sleep 30
done

exit 0
