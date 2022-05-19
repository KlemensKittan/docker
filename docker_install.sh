#!/bin/bash

# Description: Install Docker Engine and Docker Compose on Debian.
# Written by : Klemens Kittan, klemens.kittan@uni-potsdam.de, 14.02.22

clear

echo "Install Docker Engine on Debian:"

# Uninstall old versions
echo "Uninstall old versions..."
aptitude -y purge docker docker-engine docker.io containerd runc > /dev/null 2>&1

# Add required packages
echo "Add required packages..."
aptitude -y update > /dev/null
aptitude -y install apt-transport-https ca-certificates curl gnupg lsb-release > /dev/null 2>&1

# Set up the repository
echo "Set up the repository..."
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
$(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
echo "Install Docker Engine..."
aptitude -y update > /dev/null
aptitude -y install docker-ce docker-ce-cli docker-scan-plugin docker-ce-rootless-extras docker-compose-plugin > /dev/null

# Enable userns-remap on the daemon
#systemctl stop docker.service > /dev/null 2>&1
#rm -rf /var/lib/docker/*
#echo "Enable userns-remap on the daemon..."
#echo \
#"{
#  \"userns-remap\": \"default\"
#}" > /etc/docker/daemon.json
#systemctl start docker.service > /dev/null 2>&1

# Verify that Docker Engine is installed correctly by running the hello-world image.
echo
echo "Running the hello-world image..."
docker run hello-world
docker rm $(docker ps -aq)
docker image rm hello-world:latest
