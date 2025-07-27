#!/bin/bash
set -e

sudo apt-get update
sudo apt-get install -y git curl nginx

curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

git clone https://github.com/meanjs/mean.git /opt/mean
cd /opt/mean
npm install

nohup npm start > /opt/mean/app.log 2>&1 &

sudo bash -c 'cat > /etc/nginx/sites-available/default <<EOF
server {
    listen 80 default_server;
    server_name _;
    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF'
sudo systemctl restart nginx
