#!/bin/sh

. /build/environment.sh 

cd /build/repos/emergency-alerts-api

make bootstrap
make test

if [ $? -eq 0 ]
then
	. /build/environment.sh && flask run -h 0.0.0.0 -p 6011
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

exit 0
