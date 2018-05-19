# Docker image for SoftEther VPN

This will deploy a fully functional [SoftEther VPN](https://www.softether.org) server as a docker image.

Available on [Docker Hub](https://hub.docker.com/r/bravado/softether/).

## Download

    docker pull bravado/softether

## Run


Simplest version:

    docker run -d --net host --cap-add NET_ADMIN --name softether bravado/softether

To keep configuration and logs in a data container:

    docker volume create --name softether
    docker run -d --net host --cap-add NET_ADMIN --name softether -v softether:/vpnserver bravado/softether

Using docker-compose:

    docker-compose up

