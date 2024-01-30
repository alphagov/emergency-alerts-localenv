#!/bin/sh
apt update -y
apt install npm -y
if [ "`pwd`" != "/build/repos/emergency-alerts-admin" ]
then
	pip install flake8==5.0.4
	pip install black==22.8.0
fi
pip uninstall flake8-print -y
pip install psycopg2==2.9.3

# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
. /root/.bashrc

exit 0
