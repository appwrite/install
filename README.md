# Appwrite Installer

CLI Tool for easy installation of a self-hosted Appwrite server. The installation tool takes your input and creates a custom docker-compose file for your Appwrite installation.

## Install

```bash
docker run -it --rm \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --volume "$(pwd)"/appwrite:/install/appwrite:rw \
    appwrite/install:latest
```

## Build

```bash
docker build --no-cache --tag appwrite/install:latest .
```
