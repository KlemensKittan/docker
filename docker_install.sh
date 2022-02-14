#!/bin/bash

# Description: Install Docker Engine and Docker Compose on Debian.

clear

echo "Install Docker Engine on Debian:"

# Uninstall old versions
echo "Uninstall old versions..."
aptitude -y purge docker docker-engine docker.io containerd runc > /dev/null

# Add required packages
echo "Add required packages..."
aptitude -y update > /dev/null
aptitude -y install apt-transport-https ca-certificates curl gnupg lsb-release > /dev/null

# Set up the repository
echo "Set up the repository..."
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
$(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
echo "Install Docker Engine..."
aptitude -y update > /dev/null
aptitude -y install docker-ce docker-ce-cli docker-scan-plugin docker-ce-rootless-extras > /dev/null

# Enable userns-remap on the daemon
systemctl stop docker.service
rm -rf /var/lib/docker/*
echo "Enable userns-remap on the daemon..."
echo \
"{
  \"userns-remap\": \"default\"
}" > /etc/docker/daemon.json
systemctl start docker.service

# Install Docker Compose
echo "Install Docker Compose..."
curl -fsSL "https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Verify that Docker Engine is installed correctly by running the hello-world image.
docker run hello-world
docker rm $(docker ps -aq)
docker image rm hello-world:latest
