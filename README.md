*This project has been created as part of the 42 curriculum by armarake.*

# Inception

## Description

Inception is a system administration project focused on containerization using Docker.

The goal is to build a small infrastructure composed of multiple services running in isolated containers and orchestrated with Docker Compose.

The mandatory part consists of:

- NGINX configured with TLSv1.2/TLSv1.3
- WordPress with PHP-FPM
- MariaDB
- Docker named volumes for persistent data
- A custom Docker network connecting all services

### Why Docker?

Docker packages applications and their dependencies into isolated containers, making deployments reproducible and lightweight.

### Design Choices

- Each service runs in its own container.
- Custom Dockerfiles are used for all services.
- NGINX is the only public entry point.
- WordPress and MariaDB communicate through a dedicated Docker network.
- Persistent data is stored in Docker named volumes.

### Comparisons

#### Virtual Machines vs Docker

| Virtual Machines | Docker |
|------------------|---------|
| Full guest OS | Shared host kernel |
| Higher resource usage | Lightweight |
| Slower startup | Faster startup |
| Larger disk footprint | Smaller images |

#### Secrets vs Environment Variables

**Environment Variables**
- Easy configuration management.
- Suitable for non-sensitive settings.

**Secrets**
- Intended for passwords and confidential data.
- More secure than plain environment variables.

#### Docker Network vs Host Network

**Docker Network**
- Service isolation.
- Internal DNS resolution.
- Better security.

**Host Network**
- Shares host networking stack.
- Reduced isolation.

#### Docker Volumes vs Bind Mounts

**Docker Volumes**
- Managed by Docker.
- Portable and recommended for persistent data.

**Bind Mounts**
- Direct host filesystem access.
- More dependent on host configuration.

---

## Instructions

### Prerequisites

- Docker
- Docker Compose
- GNU Make

### Setup

Add your domain to `/etc/hosts`:

```text
127.0.0.1 armarake.42.fr
```

Create the `.env` file inside `srcs/` and configure the required variables.

### Run

```bash
make
```

### Stop

```bash
make down
```

### Access

Open:

```text
https://armarake.42.fr
```

---

## Resources

### Documentation

- [Docker Documentation](https://www.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [NGINX Documentation](https://nginx.org/)
- [WordPress Documentation](https://wordpress.com/)
- [MariaDB Documentation](https://mariadb.com/)

### AI Usage

AI was used as a learning tool for:
- Understanding Docker concepts
- Reviewing configuration choices
- Documentation assistance

All generated information was reviewed and validated before being used in the project.