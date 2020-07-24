#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Usage: $0 user@target.hostname"
  exit 1
fi

set -xe

#go generate
GOOS=linux GOARCH=arm GOARM=5 go build -o golang-fasthttp
ssh $1 start-stop-daemon -x /usr/local/bin/golang-fasthttp -b -K || true
ssh $1 mkdir -p /usr/local/bin/
scp golang-fasthttp $1:/usr/local/bin/golang-fasthttp
ssh $1 start-stop-daemon -x /usr/local/bin/golang-fasthttp -b -S
ssh $1 pgrep golang-fasthttp
curl http://$1:8002/

