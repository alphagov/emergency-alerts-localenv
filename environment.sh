#!/usr/bin/env bash

export HOST='local'
export ENVIRONMENT='local'
export SERVICE='api'

export FLASK_APP=application.py
export FLASK_DEBUG=False
export WERKZEUG_DEBUG_PIN=off

export RDS_HOST='host.docker.internal'
export RDS_PORT=5432
export RDS_USER='eas-user'
export RDS_REGION='eu-west-2'

export MASTER_USERNAME=
export MASTER_PASSWORD=
export API_HOST_NAME=http://host.docker.internal:6011
export ADMIN_EXTERNAL_URL=http://host.docker.internal:6012

export SECRET_KEY=
export DANGEROUS_SALT=
export ENCRYPTION_DANGEROUS_SALT=
export ENCRYPTION_SECRET_KEY=
export ADMIN_CLIENT_SECRET=

export POSTGRES_PASSWORD=
export POSTGRES_USER=
export POSTGRES_DB=
