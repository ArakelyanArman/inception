# USER_DOC.md

## Overview

This project provides a complete WordPress website stack composed of three services:

| Service   | Purpose                              |
| --------- | ------------------------------------ |
| NGINX     | HTTPS web server and reverse proxy   |
| WordPress | Website and administration interface |
| MariaDB   | Database storage                     |

All services run inside Docker containers and communicate through a private Docker network.

---

## Starting the Project

From the project root:

```bash
make
```

or

```bash
make up
```

The containers will be created and started automatically.

---

## Stopping the Project

Stop all services:

```bash
make down
```

---

## Accessing the Website

Open the website in your browser:

```text
https://armarake.42.fr
```

---

## Accessing the WordPress Administration Panel

Open:

```text
https://armarake.42.fr/wp-admin
```

Log in using the WordPress administrator credentials configured in the `.env` file.

---

## Credentials

Credentials are configured through environment variables.

The configuration file is located at:

```text
srcs/.env
```

This file contains:

* Database configuration
* WordPress administrator account
* WordPress user account
* Domain configuration

Modify the values before launching the project if necessary.

---

## Checking Service Status

View running containers:

```bash
docker ps
```

Expected services:

* nginx
* wordpress
* mariadb

---

## Viewing Logs

Show logs from all services:

```bash
docker compose logs
```

Show logs from a specific service:

```bash
docker compose logs nginx
docker compose logs wordpress
docker compose logs mariadb
```

---

## Verifying Correct Operation

The stack is working correctly if:

1. All containers appear in `docker ps`.
2. The website is reachable through HTTPS.
3. The WordPress login page is accessible.
4. WordPress can authenticate users.
5. No critical errors appear in the container logs.

---

## Persistent Data

Website files and database data are stored in Docker volumes.

This allows data to remain available even after containers are stopped or recreated.

Removing containers does not delete the website content or database unless the volumes are explicitly removed.

