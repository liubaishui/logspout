#!/bin/sh
set -e
export http_proxy=http://192.168.21.21:8080
export https_proxy=http://192.168.21.21:8080
apk add --update go git mercurial
mkdir -p /go/src/github.com/gliderlabs
cp -r /src /go/src/github.com/gliderlabs/logspout
cd /go/src/github.com/gliderlabs/logspout
export GOPATH=/go
go get
go build -ldflags "-X main.Version $1" -o /bin/logspout
apk del go git mercurial
rm -rf /go
rm -rf /var/cache/apk/*

unset http_proxy
unset https_proxy

# backwards compatibility
ln -fs /tmp/docker.sock /var/run/docker.sock
