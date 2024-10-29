#!/bin/sh

echo "Installing packages to do db initialisation..."
apt update
apt install ansible -y
apt install postgresql-client -y

psql postgresql://postgres:root@host.docker.internal:5432/postgres <<-EOSQL
    CREATE DATABASE emergency_alerts;
EOSQL

psql postgresql://postgres:root@host.docker.internal:5432/postgres -v ON_ERROR_STOP=1 <<-EOSQL
DO \$\$
BEGIN
    IF NOT EXISTS ( SELECT FROM pg_roles WHERE  rolname = 'eas-user') THEN
        CREATE USER "eas-user";
    END IF;
    GRANT ALL PRIVILEGES ON DATABASE emergency_alerts TO "eas-user";
    ALTER USER "eas-user" WITH PASSWORD 'password';
END;
\$\$;
EOSQL

cd /build/repos/emergency-alerts-api
cat /build/environment.sh
. /build/environment.sh && flask db upgrade

cd /build/repos/emergency-alerts-tooling/ansible/environments/local/
cat local-postgres-setup.yml | sed "s/127.0.0.1/host.docker.internal/" | sed "s/localhost/host.docker.internal/" >/build/local-postgres-setup.yml
cd /build
ansible-playbook local-postgres-setup.yml

if [ $? -eq 0 ]
then
	echo "===================================="
	echo "= DATABASE INITIALISATION COMPLETE ="
	echo "===================================="
	exit 0
else
	exit 1
fi

exit 0
