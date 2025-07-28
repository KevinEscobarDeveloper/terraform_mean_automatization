#!/bin/bash
set -e
apt-get update
apt-get install -y gnupg
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | apt-key add -
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/6.0 multiverse" \
  > /etc/apt/sources.list.d/mongodb-org-6.0.list
apt-get update
apt-get install -y mongodb-org
sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/' /etc/mongod.conf
systemctl enable --now mongod
