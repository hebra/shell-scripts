# Run Gitlab as Docker container

How to run Gitlab as a Docker container with external Postgres and Reposistory persistence.

## Preconditions

- Ubuntu 18.04 LTS (Bionic) or newer, or a similar distribution
- Docker CE installed from the main Docker repositories
- a docker-compose installation

## The docker-compose file

There are 2 main requirements when using Gitlab in Docker: modularization and persistence.

**Persistence** is important as we want do keep e.g. the database data and created GIT repositories even when updating the containers for PostgreSQL or Gitlab.

**Easy Update** of the Gitlab container without losing persisted data (like database, configuration and the actual GIT repositories).

The file ```docker-compose.yml``` will take care of all of these steps for you.

## Prepare the folders used for data persistence

Create a parent persistence folder, e.g. inside `/var` which will be used to persist data across container updates and also as an easy way to backup data.

```
mkdir -p /var/data/docker/gitlab/
```
Next ccreate a copy of the `env.sample` called `.env` in the same folder as the `docker-compose.yml` file.

```
cp env.sample .env
```

Adjust the parameters in the `.env` file according to your requirement and environment.

Finally, bring the whole Gitlab Docker environemnt up via

```
docker-compose up -d
```

The `-d` will put the process into the background as a daemon process. Also the startup might take a few minutes the first time it is executed. You can follow the logs via

```
docker-compose logs -f
```

## Proxy it via nginx

As the Gitlab Docker container is often not the only webservice running on the host machine, we disabled the shipped NGinx via the docker-compose configuration - therefore no httpd webserver is running.

We can however use Linux sockets to still forward external request to the Docker Gitlab instance using an NGinx virtual host and proxy configruation, see the file `nginx-vhost.conf.sample` for an example configuration.

For this to work we need to add the NGinx user (usually called `nginx` or `www-data`) to the group `docker`.
