#!/bin/bash

apt update
apt install ansible postgresql-client python3-psycopg2 -y

set -e

. /build/environment.sh

psql postgresql://postgres:root@host.docker.internal:5432/postgres <<-EOSQL
    CREATE DATABASE $DATABASE;
EOSQL

psql postgresql://postgres:root@host.docker.internal:5432/postgres -v ON_ERROR_STOP=1 <<-EOSQL
DO \$\$
BEGIN
    IF NOT EXISTS ( SELECT FROM pg_roles WHERE rolname = 'eas-user') THEN
        CREATE USER "eas-user";
    END IF;

    GRANT ALL PRIVILEGES ON DATABASE $DATABASE TO "eas-user";

    ALTER USER "eas-user" WITH PASSWORD 'password';
END;
\$\$;
EOSQL

cd /build/repos/emergency-alerts-api

# PostGIS requires superuser to create the extension
export MASTER_USERNAME='postgres'
export MASTER_PASSWORD='root'

flask db upgrade
echo "Flask done"

cd /build/repos/emergency-alerts-tooling/ansible/environments/development
ansible-playbook -e "database_host=postgres database_username=postgres database_password=root email_address=eas.admin@digital.cabinet-office.gov.uk phone_number=07700900111" 02-database-setup-after-migrations.yml

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
