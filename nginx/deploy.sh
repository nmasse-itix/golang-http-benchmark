#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Usage: $0 user@target.hostname"
  exit 1
fi

set -xe

ssh $1 mkdir -p /srv/nginx/default/
echo "Hello, World!" | ssh $1 tee /srv/nginx/default/index.html
scp nginx.conf $1:/etc/nginx/nginx.conf
ssh $1 /etc/init.d/nginx restart || true
ssh $1 pgrep nginx
curl http://$1/
