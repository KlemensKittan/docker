# Install Docker Engine on Debian

## Introduction

To get started with Docker Engine and Docker Compose on Debian.

## Configuring

After Docker is installed, enable userns-remap to isolate containers with a user
namespace. Linux namespaces provide isolation for running processes, limiting
their access to system resources without the running process being aware of the
limitations.

Verify that Docker Engine is installed correctly:

    docker run hello-world

Clean up:

    docker rm $(docker ps -aq)
    docker image rm hello-world:latest

## Commands

### Container management commands

Create a container (without starting it):

    docker create [IMAGE]

Rename an existing container:

    docker rename [CONTAINER_NAME] [NEW_CONTAINER_NAME]

Run a command in a new container:

    docker run [IMAGE] [COMMAND]

Remove container after it exits:

    docker run --rm [IMAGE]

Start a container and keep it running:

    docker run -d [IMAGE]

Start a container and creates an interactive bash shell in the container:

    docker run -it [IMAGE]

Start a container:

    docker run --name nginx -p 8080:80 -d nginx:latest

Options:
- `--name`<br>
  Assign a name to the container
    
- `-p`<br>
  Publish a container's port(s) to the host

- `-d`<br>
  Run container in background and print container ID

Execute command inside already running container:

    docker exec -it [CONTAINER] /bin/bash

Delete a container (if it is not running):

    docker rm [CONTAINER]

Update the configuration of the container:

    docker update [CONTAINER]

### Starting and Stopping Containers

Start Container:

    docker start [CONTAINER]

Stop running Container:

    docker stop [CONTAINER]

Stop running Container and start it again:

    docker restart [CONTAINER]

Pause processes in a running container:

    docker pause [CONTAINER]

Unpause processes in a running container:

    docker unpause [CONTAINER]

Kill a container by sending a SIGKILL to a running container:

    docker kill [CONTAINER]

### Docker Image Commands

Create an image from a container:

    docker commit [CONTAINER] [NEW_IMAGE_NAME]

Remove an image:

    docker image rm [IMAGE]

### Docker Container And Image Information

List running containers:

    docker ps

Lists both running containers and ones that have stopped:

    docker ps -a

List the logs from a running container:

    docker logs [CONTAINER]

List low-level information on Docker objects:

    docker inspect [OBJECT_NAME/ID]

List real-time events from a container:

    docker events [CONTAINER]

Show port mapping for a container:

    docker port [CONTAINER]

Show running processes in a container:

    docker top [CONTAINER]

Show live resource usage statistics of container:

    docker stats [CONTAINER]

Show changes to files (or directories) on a filesystem:

    docker diff [CONTAINER]

List all images that are locally stored with the docker engine:

    docker image ls

Show the history of an image:

    docker history [IMAGE]

### Network Commands

List networks:

    docker network ls

Remove one or more networks:

    docker network rm [NETWORK]

Show information on one or more networks:

    docker network inspect [NETWORK]

Connects a container to a network:

    docker network connect [NETWORK] [CONTAINER]

Disconnect a container from a network:

    docker network disconnect [NETWORK] [CONTAINER]

## Resources

- <https://docs.docker.com/engine/install/debian/>
- <https://docs.docker.com/engine/security/userns-remap/>
