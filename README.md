# A Jenkins Container to Build Containers


## Background

The compose file was generated from these two separate `run` commands:

```bash
# docker dind service

docker container run \
  --name jenkins-docker \
  --rm \
  --detach \
  --privileged \
  --network jenkins \
  --network-alias docker \
  --env DOCKER_TLS_CERTDIR=/certs \
  --volume jenkins-docker-certs:/certs/client \
  --volume jenkins-data:/var/jenkins_home \
  --publish 2376:2376 \
  docker:dind
```

```bash
#jenkins (blueocean) service

docker container run \
  --name jenkins-blueocean \
  --rm \
  --detach \
  --network jenkins \
  --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client \
  --env DOCKER_TLS_VERIFY=1 \
  --publish 8080:8080 \
  --publish 50000:50000 \
  --volume jenkins-data:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
  jenkinsci/blueocean
```

## Running the Compose Services

You must have [Docker and Docker Compose installed](https://docs.docker.com/get-docker/) locally to run this.

- Clone the repo: `git clone`
- Run the services: `docker compose up -d`
- List running services: `docker ps`
- Inspect the logs: `docker logs [jenkins-blueocean ID]`
- Find and copy the admin password
- Navigate to: http://localhost:8080
- Complete the initial configuration and install all suggested plugins

Now you can run `docker` commands in your Jenkins builds!

Run `docker compose down` the services.