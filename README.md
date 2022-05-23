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

## Containerizing an App

Docker can build images automatically by reading the instructions from a
Dockerfile. A Dockerfile is a text document that contains all the commands a
user could call on the command line to assemble an image. Using docker build
users can create an automated build that executes several command-line
instructions in succession.

### Dockerfile

This Dockerfile is from the repository of Nigel Poulton.

    # Test web app
    FROM node:current-alpine

    # Create directory in container image for app code
    RUN mkdir -p /usr/src/app

    # Copy app code (.) to /usr/src/app in container image
    COPY . /usr/src/app

    # Set working directory context
    WORKDIR /usr/src/app

    # Install dependencies from packages.json
    RUN npm install

    # Command for container to execute
    ENTRYPOINT [ "node", "app.js" ]

**FROM**<br>
The FROM instruction initializes a new build stage and sets the Base Image for
subsequent instructions. As such, a valid Dockerfile must start with a FROM
instruction.

**RUN**<br>
The RUN instruction will execute any commands in a new layer on top of the
current image and commit the results. The resulting committed image will be used
for the next step in the Dockerfile.

It can be written in both shell and exec forms.

    RUN apt-get -y update
    RUN [“apt-get”, “install”, “vim”]

**COPY**<br>
The COPY instruction copies new files or directories and adds them to the
filesystem of the container.

**ADD**<br>
The ADD instruction copies new files, directories or remote files (URLs) from
and adds them to the filesystem of the image.

In most cases if you're using a URL, you're downloading a zip file and are then
using the RUN command to extract it. However, you might as well just use RUN
with curl instead of ADD here so you chain everything into one RUN command to
make a smaller Docker image.

A valid use case for ADD is when you want to extract a local tar file into a
specific directory in your Docker image.

    ADD rootfs.tar.gz /

**ENV**<br>
The ENV instruction sets the environment variable to the value. This value will
be in the environment for all subsequent instructions in the build stage and
can be replaced inline in many as well.

    ENV MY_NAME="John Doe"

**CMD**<br>
There can only be one CMD instruction in a Dockerfile. If you list more than one
CMD then only the last CMD will take effect.

This Dockerfile uses Alpine Linux as a base and executes the echo command when
a corresponding container is started.

    FROM alpine:3.9
    CMD ["echo", "Hallo vom CMD!"]

The special thing about CMD is that this specification can be overridden when a
container is started. The syntax for starting a container is docker container
`run [OPTIONS] IMAGE [COMMAND] [ARG...]`, so an optional command with arguments
can be appended to the image name, which then overwrites the CMD statement of
the image.

    docker container run my-alpine echo "Hallo von der Konsole!"

**ENTRYPOINT**<br>
An ENTRYPOINT allows you to configure a container that will run as an
executable.

ENTRYPOINT also specifies a command to be executed when a container starts.
Unlike CMD, however, it is not overwritten by docker container run. This makes
entrypoints well suited for containers that should always execute the same
program.

However, the power of entrypoints lies in the fact that a CMD statement is
always appended to the ENTRYPOINT statement.

    FROM alpine:3.9
    ENTRYPOINT ["echo"]
    CMD ["Hallo vom CMD"]

However, CMD is still overwriteable. This means that I can overwrite the
arguments for echo here.

    docker container run my-alpine "Hallo von der Konsole"

The entry point for a container, namely ENTRYPOINT, therefore always remains
the same. So it is possible to set a fixed command as entrypoint for a
container and additionally specify default arguments for it with CMD, which
can be overridden with docker container run.

### Create an image from a Dockerfile in the current directory

    docker build -t [Docker Hub ID]/[Repo name]:[Image name] .

### Start a container and keep it running

    docker run -d --name [CONTAINER_NAME] -p 8080:80 [IMAGE]

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

    docker run -d --name [CONTAINER_NAME] -p 8080:80 [IMAGE]

    Options:
    -d, --detach
    Run container in background and print container ID
    --name
    Assign a name to the container
    -p, --publish
    Publish a container's port(s) to the host
    -t, --tty
    Allocate a pseudo-TTY

Execute command inside already running container:

    docker exec -it [CONTAINER] /bin/bash

Delete a container (if it is not running):

    docker rm [CONTAINER]

Update the configuration of the container:

    docker update [CONTAINER]

Remove all unused data:

    docker system prune --all --volumes

### Starting and stopping containers

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

### Docker image commands

Search the Docker Hub for images:

    docker search [TERM]

Pull an image from a registry:

    docker pull [IMAGE]

Push an image to a registry:

    docker push [IMAGE]

Create an image from a container:

    docker commit [CONTAINER] [NEW_IMAGE_NAME]

Create an image from a Dockerfile in the current directory and tags the image:

    docker build -t [Docker Hub ID]/[Repo name]:[Image name] .

Load an image from a tar archive:

    docker load [TAR_FILE]

Save an image to a tar archive with all parent layers, tags and versions:

    docker save [IMAGE] > [TAR_FILE]

Remove an image:

    docker image rm [IMAGE]

### Docker information

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
- <https://docs.docker.com/engine/reference/builder/>
