#!/usr/bin/env bash

export HOST='local'
export ENVIRONMENT='local'

export FLASK_APP=application.py
export FLASK_DEBUG=False
export WERKZEUG_DEBUG_PIN=off

export DATABASE='emergency_alerts'
export RDS_HOST='host.docker.internal'
export RDS_PORT=5432
export RDS_USER='eas-user'
export RDS_REGION='eu-west-2'
export MASTER_USERNAME='eas-user'
export MASTER_PASSWORD='password'
export API_HOST_NAME=http://host.docker.internal:6011
export ADMIN_EXTERNAL_URL=http://host.docker.internal:6012
export ADMIN_ACTION_ALLOW_SELF_APPROVAL=true

export SECRET_KEY='dev-notify-secret-key'
export DANGEROUS_SALT='dev-notify-salt'
export ENCRYPTION_DANGEROUS_SALT='dev-notify-salt'
export ENCRYPTION_SECRET_KEY='dev-notify-secret-key'
export ADMIN_CLIENT_SECRET='dev-notify-secret-key'
export FUNCTIONAL_TEST_IPS='172.18.0.1'
export FUNCTIONAL_TEST_USER_ID='44153bb8-db31-4cb0-8cee-b909a5482d1a'
