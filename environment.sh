#!/usr/bin/env bash
#localenv

export HOST='hosted'
export ENVIRONMENT='local'

export FLASK_APP=application.py
export FLASK_DEBUG=False
export WERKZEUG_DEBUG_PIN=off

export DATABASE='emergency_alerts'
export RDS_HOST='pg'
export RDS_PORT=5432

export USE_RDS_IAM_AUTH="false"
# Confusingly master here refers to the application's DB user (i.e. not the DB superuser)

export API_HOST_NAME=http://api:6011
export ADMIN_EXTERNAL_URL=http://localhost:6012
export ADMIN_ACTION_ALLOW_SELF_APPROVAL=true
export GOVUK_ALERTS_S3_BUCKET_NAME='local-govuk-alerts'
export GOVUK_ALERTS_HOST_URL=http://localhost:6017
export NOTIFY_API_CLIENT_SECRET=
export FASTLY_ENABLED=false
# If running the functional tests on a host - this is the IP of the host from the container's PoV
# (at least from the perspective of Docker Desktop on macOS)
export FUNCTIONAL_TEST_IPS='172.18.0.1'
export FUNCTIONAL_TEST_USER_ID='44153bb8-db31-4cb0-8cee-b909a5482d1a'

export SECRET_KEY=
export DANGEROUS_SALT=
export ENCRYPTION_DANGEROUS_SALT=
export ENCRYPTION_SECRET_KEY=
export ADMIN_CLIENT_SECRET=

# The superuser within Postgres
export POSTGRES_USER=
export POSTGRES_PASSWORD=
