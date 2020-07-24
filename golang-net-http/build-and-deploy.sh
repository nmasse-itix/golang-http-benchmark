#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Usage: $0 user@target.hostname"
  exit 1
fi

set -xe

#go generate
GOOS=linux GOARCH=arm GOARM=5 go build -o golang-net-http
ssh $1 start-stop-daemon -x /usr/local/bin/golang-net-http -b -K || true
ssh $1 mkdir -p /usr/local/bin/
scp golang-net-http $1:/usr/local/bin/golang-net-http
ssh $1 start-stop-daemon -x /usr/local/bin/golang-net-http -b -S
ssh $1 pgrep golang-net-http
curl http://$1:8001/
