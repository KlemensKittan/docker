#!/bin/bash

# Description: Uninstall Docker Engine and Docker Compose.

clear

echo "Uninstall Docker Engine and Docker Compose:"

systemctl stop docker.service
systemctl stop docker.socket
aptitude purge docker-ce docker-ce-cli docker-scan-plugin docker-ce-rootless-extras containerd.io
rm -f /etc/apt/sources.list.d/docker.list
rm -f /usr/share/keyrings/docker-archive-keyring.gpg
rm -f /usr/local/bin/docker-compose
rm -f /usr/bin/docker-compose
rm -rf /etc/docker/*
rm -rf /var/lib/docker/*
userdel dockremap
chown -R root:root /var/lib/docker/
