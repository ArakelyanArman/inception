# DEV_DOC.md

## Development Environment Setup

### Prerequisites

Install:

* Docker
* Docker Compose
* GNU Make

Verify installation:

```bash
docker --version
docker compose version
make --version
```

---

## Configuration

### Domain Name

Add your domain to `/etc/hosts`:

```text
127.0.0.1 armarake.42.fr
```

### Environment Variables

Create `srcs/.env` and configure the required variables:

```env
DOMAIN_NAME=aarakelya.42.fr

MYSQL_DATABASE=wordpress
MYSQL_USER=user
MYSQL_PASSWORD=password
MYSQL_ROOT_PASSWORD=root_password

WP_ADMIN_USER=owner
WP_ADMIN_PASSWORD=admin_password
WP_ADMIN_EMAIL=admin@example.com

WP_USER=user42
WP_USER_PASSWORD=user_password
WP_USER_EMAIL=user@example.com
```

Never commit sensitive credentials.

---

## Project Structure

```text
.
├── Makefile
└── srcs
    ├── docker-compose.yml
    ├── .env
    └── requirements
        ├── nginx
        ├── wordpress
        └── mariadb
```

---

## Building and Launching

Build images and start the infrastructure:

```bash
make
```

or

```bash
make up
```

---

## Managing Containers

List running containers:

```bash
docker ps
```

View logs:

```bash
docker compose logs
```

View logs for a specific service:

```bash
docker compose logs nginx
docker compose logs wordpress
docker compose logs mariadb
```

Open a shell inside a container:

```bash
docker exec -it nginx sh
docker exec -it wordpress sh
docker exec -it mariadb sh
```

Stop containers:

```bash
make down
```

---

## Managing Volumes

List volumes:

```bash
docker volume ls
```

Inspect a volume:

```bash
docker volume inspect <volume_name>
```

Remove unused volumes:

```bash
docker volume prune
```

---

## Persistent Data

The project uses two Docker named volumes:

### MariaDB Volume

Stores:

* Database files
* Users
* WordPress data

### WordPress Volume

Stores:

* Themes
* Plugins
* Uploads
* Website files

Both volumes are mounted under:

```text
/home/aarakelya/data/
```

Data persists even if containers are recreated.

---

## Useful Commands

Rebuild containers:

```bash
docker compose up --build
```

Restart services:

```bash
docker compose restart
```

Stop and remove containers:

```bash
docker compose down
```

Remove containers, networks, images and volumes:

```bash
docker compose down -v
```

