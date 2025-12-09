#!/usr/bin/env bash
#localenv

export HOST='hosted'
export ENVIRONMENT='local'

export FLASK_APP=application.py
export FLASK_DEBUG=False
export WERKZEUG_DEBUG_PIN=off

export DATABASE='emergency_alerts'
export RDS_HOST='host.docker.internal'
export RDS_PORT=5432
export RDS_USER='eas-user'
export RDS_REGION='eu-west-2'

export USE_RDS_IAM_AUTH="false"
export MASTER_USERNAME=
export MASTER_PASSWORD=

export API_HOST_NAME=http://host.docker.internal:6011
export ADMIN_EXTERNAL_URL=http://localhost:6012
export ADMIN_ACTION_ALLOW_SELF_APPROVAL=true
export GOVUK_ALERTS_S3_BUCKET_NAME='local-govuk-alerts'
export GOVUK_ALERTS_HOST_URL=http://localhost:6017
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

export POSTGRES_PASSWORD=
export POSTGRES_USER=
export POSTGRES_DB=
