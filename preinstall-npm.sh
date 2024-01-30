#!/bin/sh

apt update
apt install npm -y
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
. /root/.bashrc
. /root/.nvm/nvm.sh
cd /build/repos/emergency-alerts-admin
nvm install
npm ci --no-audit

exit 0
