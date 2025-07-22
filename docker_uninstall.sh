#!/bin/bash

# Description: Uninstall Docker Engine and Docker Compose.
# Written by : Klemens Kittan, klemens.kittan@uni-potsdam.de, 14.02.22

clear

echo "Uninstall Docker Engine and Docker Compose:"

systemctl stop docker.service > /dev/null 2>&1
systemctl stop docker.socket > /dev/null 2>&1

# Uninstall packages
echo "Uninstall packages..."
aptitude -y purge docker-ce docker-ce-cli docker-scan-plugin docker-ce-rootless-extras docker-compose-plugin > /dev/null 2>&1

# Remove directories
echo "Remove directories..."
rm -f /etc/apt/sources.list.d/docker.list
rm -f /usr/share/keyrings/docker-archive-keyring.gpg
rm -f /usr/local/bin/docker-compose
rm -f /usr/bin/docker-compose
rm -rf /etc/docker/*
rm -rf /var/lib/docker/*
chown -R root:root /var/lib/docker/

# Remove user dockremap
#echo "Remove user dockremap..."
#userdel dockremap > /dev/null 2>&1
