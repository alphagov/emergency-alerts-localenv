# Emergency Alerts Localenv

This is a opinionated and unperfect Docker Compose-based instance of the Emergency Alerts system in a turnkey fashion.
It will use the exact same Dockerfiles as used to build the main system as well as approximations of AWS components running locally.
You may of course run components manually, or only use a subset of these components.

Notably it does *not* include the Cell Broadcast Controller Proxy functionality (a Lambda). 'Sending' a broadcast will have those tasks ultimately fail.

## Getting started

This repository expects a specific folder layout. More specifically, repositories should be checked out to `repos/<repo>` within this repository.

```bash
git clone https://github.com/alphagov/emergency-alerts-localenv
cd emergency-alerts-localenv/repos
git clone https://github.com/alphagov/emergency-alerts-api.git
git clone https://github.com/alphagov/emergency-alerts-govuk.git
git clone https://github.com/alphagov/emergency-alerts-utils.git
git clone https://github.com/alphagov/emergency-alerts-tooling.git
git clone https://github.com/alphagov/emergency-alerts-admin.git
```

Admin requires a large SQLite Database of location libraries. You can fetch this from the `infra-mgt` AWS account in an S3 bucket.
It will need copying to `emergency-alerts-localenv/repos/emergency-alerts-admin/app/broadcast_areas/broadcast-areas.sqlite3`.

Modify the `emergency-alerts-localenv/environment.sh` file by adding the credentials for the environment variables:
 - MASTER_USERNAME
 - MASTER_PASSWORD
 - SECRET_KEY
 - DANGEROUS_SALT
 - ENCRYPTION_DANGEROUS_SALT
 - ENCRYPTION_SECRET_KEY
 - ADMIN_CLIENT_SECRET
 - POSTGRES_PASSWORD
 - POSTGRES_USER
 - POSTGRES_DB

Values for these are outlined in this guidance note:
    https://gds-ea.atlassian.net/wiki/spaces/EA/pages/192217089/Setting+up+Local+Development+Environment#Getting-API-setup

Now you should be able to ask Docker Compose to come up. We use a shared based image which there isn't great native support for.
You may have to run this a couple of times (as the builds for repos will fail while base/utils is building) - or build base first.

You may also need to ensure Postgres and Localstack are up and running before the others - Celery nopes out immediately if SQS isn't populated.
```
docker compose up -d utils localstack postgres
docker compose up
```

This should automatically provision Postgres with a test database and auto-populate LocalStack with 'AWS' resources.
The admin UI should be reachable at http://localhost:6012 and the GovUK at http://local-govuk-alerts.s3-website.localhost.localstack.cloud:4566/alerts.
