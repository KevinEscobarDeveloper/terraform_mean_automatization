#!/bin/bash
set -euxo pipefail

##############################################################################
# 0) SWAP 1 GB – evita OOM al compilar Angular
##############################################################################
fallocate -l 1G /swapfile
chmod 600 /swapfile
mkswap   /swapfile
swapon   /swapfile

##############################################################################
# 1) Básicos, Node 18 LTS y Nginx
##############################################################################
apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get install -y \
  git curl gnupg build-essential nginx

curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs

##############################################################################
# 2) MongoDB 6 Community (Ubuntu 22.04)
##############################################################################
wget -qO- https://www.mongodb.org/static/pgp/server-6.0.asc \
  | tee /etc/apt/trusted.gpg.d/mongodb.asc
echo "deb [arch=amd64] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" \
  > /etc/apt/sources.list.d/mongodb-org-6.0.list

apt-get update -y
apt-get install -y mongodb-org
systemctl enable --now mongod

##############################################################################
# 3) Clona proyecto MEAN
##############################################################################
git clone https://github.com/mongodb-developer/mean-stack-example.git \
  /opt/mean_app
cd /opt/mean_app

##############################################################################
# 4) Backend
##############################################################################
cd server
npm ci --omit=dev

cat > .env <<'EOF'
ATLAS_URI=mongodb://127.0.0.1:27017/mean-example
PORT=4000
EOF

# Exportamos la variable para Node (por si el server usa crypto antiguo)
export NODE_OPTIONS=--openssl-legacy-provider
nohup node server.js > /opt/mean_app/server.log 2>&1 &

##############################################################################
# 5) Frontend (Angular 13)
##############################################################################
cd ../client
npm ci --legacy-peer-deps
npm install -g @angular/cli@13

# Necesario para WebPack‑4 + Node 18
export NODE_OPTIONS=--openssl-legacy-provider
ng build --configuration production

##############################################################################
# 6) Copiar bundle al backend
##############################################################################
mkdir -p ../server/public
# Use the command substitution directly in the cp command to avoid Terraform template variable interpretation
cp -R "$$(ls -d dist/* | head -n1)/"* ../server/public/

##############################################################################
# 7) Nginx reverse‑proxy :80 → :4000
##############################################################################
cat >/etc/nginx/sites-available/default <<'NGINX'
server {
    listen 80 default_server;
    server_name _;
    location / {
        proxy_pass http://127.0.0.1:4000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
    }
}
NGINX

systemctl restart nginx
systemctl enable  nginx

echo "✅ MEAN desplegada. Visita: http://$$(curl -s ifconfig.me)/"
