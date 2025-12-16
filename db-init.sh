#!/bin/bash

apt update
apt install ansible postgresql-client python3-psycopg2 -y

set -e

. /eas/emergency-alerts-api/environment.sh

psql postgresql://postgres:root@pg:5432/postgres <<-EOSQL
    CREATE DATABASE $DATABASE;
EOSQL

cd /eas/emergency-alerts-api

. /venv/emergency-alerts-api/bin/activate

# PostGIS requires superuser to create the extension during its migration
export MASTER_USERNAME='postgres'
export MASTER_PASSWORD='root'

flask db upgrade
echo "Flask done"

cd /eas/emergency-alerts-tooling/ansible/environments/development
ansible-playbook -e "database_host=pg database_username=postgres database_password=root email_address=eas.admin@digital.cabinet-office.gov.uk phone_number=07700900111" 02-database-setup-after-migrations.yml

# Because the tables were created by the postgres user, they're owned by postgres, not eas-user
# So we patch that up by adding grants after the migrations.
psql postgresql://postgres:root@pg:5432/postgres -v ON_ERROR_STOP=1 <<-EOSQL
DO \$\$
BEGIN
    IF NOT EXISTS ( SELECT FROM pg_roles WHERE rolname = 'eas-user') THEN
        CREATE USER "eas-user";
    END IF;

    GRANT ALL PRIVILEGES ON DATABASE $DATABASE TO "eas-user";
    GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO "eas-user";

    ALTER USER "eas-user" WITH PASSWORD 'password';
END;
\$\$;
EOSQL

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
