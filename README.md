# Install Docker Engine on Debian

## Introduction

To get started with Docker Engine and Docker Compose on Debian.

## Configuring

After Docker is installed, enable userns-remap Isolate containers with a user
namespace. Linux namespaces provide isolation for running processes, limiting
their access to system resources without the running process being aware of
the limitations.

## Commands

### Verify that Docker Engine is installed correctly

    docker run hello-world

### Clean up

    docker rm $(docker ps -aq)
    docker image rm hello-world:latest

## Resources

- <https://docs.docker.com/engine/install/debian/>
- <https://docs.docker.com/engine/security/userns-remap/>
