# Ensure docker is installed/running
    brew install qemu
    https://www.docker.com/products/docker-desktop/

# Clone this repository
    git clone git@github.com:alphagov/emergency-alerts-localenv.git
    cd emergency-alerts-localenv

# Clone all Emergency Alerts repos (not all are listed here)
    cd repos
    git clone git@github.com:alphagov/emergency-alerts-api.git
    git clone git@github.com:alphagov/emergency-alerts-govuk.git
    git clone git@github.com:alphagov/emergency-alerts-utils.git
    git clone git@github.com:alphagov/emergency-alerts-tooling.git
    git clone git@github.com:alphagov/emergency-alerts-admin.git

# Download broadcast-areas.sqlite3 from S3
You can use the emergency-alerts-development account.  You can find it in the bucket prefixed with `eas-app-postcode-bucket-`.
After you have downloaded the file, place it in the `emergency-alerts-localenv/repos/emergency-alerts-admin/app/broadcast_areas/` directory.
    
# Bring up the containers
    cd emergency-alerts-api
    docker compose up api -d
    docker compose up db-init

# Once this completes and returns to a prompt
    docker compose down db-init
    docker compose up admin -d

# Check that the admin site works
    docker compose up admin
Once this completes and shows waiting for connections, open a local browser and visit http://localhost:6012

# Bring up the govuk container
    docker compose up govuk

# Check that the govuk site works
Once this completes and shows waiting for connections, open a local browser and visit http://localhost:6017/alerts
