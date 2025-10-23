#!/bin/sh

apt update
apt install npm -y
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
. /root/.bashrc
. /root/.nvm/nvm.sh
cd /build/repos/emergency-alerts-admin
nvm install --lts
npm ci --no-audit

exit 0
