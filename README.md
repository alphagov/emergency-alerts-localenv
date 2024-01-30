#Ensure docker is installed/running
    brew install qemu
    https://www.docker.com/products/docker-desktop/

#Clone this repository
    mkdir ~/localenv
    cd repos

#Clone all Emergency Alerts repos (not all are listed here)
    git clone git@github.com:alphagov/emergency-alerts-api.git
    git clone git@github.com:alphagov/emergency-alerts-govuk.git
    git clone git@github.com:alphagov/emergency-alerts-utils.git
    git clone git@github.com:alphagov/emergency-alerts-tooling.git
    git clone git@github.com:alphagov/emergency-alerts-admin.git
    
#Bring up the containers
    cd emergency-alerts-api
    docker-compose up api -d
    docker-compose up db-init
Once this completes and returns to a prompt
    docker-compose down db-init
    docker-compose up admin -d

#Check that the admin site works
Once this completes and shows waiting for connections, open a local browser and visit http://localhost:6012

#Bring up the govuk container
    docker-compose up govuk

#Check that the govuk site works
Once this completes and shows waiting for connections, open a local browser and visit http://localhost:6017/alerts
