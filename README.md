# _This project has been created as part of the 42 curriculum by lazmoud_

## Description

This project is about setting up 3 services and linking them through a shared network and data volumes using Docker Compose. Each service runs separately in its own Docker container, and Docker Compose makes them accessible to connect with each other as needed.

The services we have are: WordPress, MariaDB, and NGINX.

NGINX is clearly on the top of the stack and is the one accessible by users to send requests to through port 443/HTTPS. It communicates internally with WordPress by forwarding requests to it. WordPress has a persistent connection with MariaDB in order to authenticate, manage data, and so on.

The goal of this project is to become familiar with containerization, Docker, and Docker Compose.

## Instructions

### Before-hand Setup

Install Docker and make it active through systemctl, because nothing will work without it. You can start it using these commands:

```sh
$> sudo systemctl start docker.service
$> sudo systemctl start docker.socket
```

Before typing any command, start by creating a `.env` file at `./srcs/requirements/.env` in this format:

```
MYSQL_DATABASE=database
WORDPRESS_DB_NAME=${MYSQL_DATABASE} # same as MYSQL_DATABASE
MYSQL_USER=db_user
WORDPRESS_DB_USER=${MYSQL_USER} # same as MYSQL_USER
WORDPRESS_DB_HOST=dbhost:dbport
WP_USER=wp_user
SITE_TITLE="EPIC WEBSITE!"
URL="Host"
EMAIL="example@example.co"
```

Then create these files:

- `./secrets/wp_admin_password.txt`: WordPress administrator password
- `./secrets/db_password.txt`: MariaDB regular user password
- `./secrets/db_root_password.txt`: MariaDB root user password (should be very secure)

### If all secrets/.env files were created

- To spawn up the containers: `sudo make` in the root directory
- To build the containers: `sudo make build` in the root directory
- To start the containers: `sudo make up` in the root directory
- To stop the containers: `sudo make down` in the root directory
- To check the status of the containers: `sudo make status` in the root directory

## Resources

- [The official NGINX docs](https://nginx.org/en/docs/)
- [The official Docker manuals](https://docs.docker.com/manuals/)
- [WordPress advanced administration](https://developer.wordpress.org/advanced-administration/)
- [The official MariaDB docs](https://mariadb.com/docs)
- [Intro into Docker](https://youtu.be/Ud7Npgi6x8E?si=booTArqRSeDZ5Cne)
- I also mainly used ChatGPT to understand how to link up NGINX and WordPress correctly by configuring NGINX properly

## Project Description

### The use of Docker and important source files

I mainly used Docker to build and run my containers, but I specifically used Docker Compose, which relies heavily on this file: `./srcs/requirements/docker-compose.yml`. This file helps Docker Compose understand which services to build/run and to connect them through a shared network. It also manages secrets like database passwords, admin passwords, and root user passwords. Additionally, it enables me to mount/shared mount data volumes for more persistent data storage inside this infrastructure.

List of all important sources:

- `./Makefile`: A makefile that I used to make it easier for me to manage containers using Docker Compose. Has all the important commands I might need.
- `./srcs/requirements/docker-compose.yml`: The configuration that Docker Compose uses to build up an understanding about the containers.
- `./srcs/requirements/{service}/Dockerfile`: Dockerfile that is responsible for building an image for its assigned service.
- `./srcs/requirements/{service}/tools`: A directory that has scripts that are run at container boot.
- `./srcs/requirements/nginx/conf/nginx.conf`: NGINX configuration
- `./srcs/requirements/nginx/conf/404.html`: A custom 404 page for NGINX

### Design

For better scalability, maintainability, and efficiency, I used a multi-service infrastructure using Docker Compose, separating my project into 3 different services that connect with each other internally using a shared Docker network.

I also configured Compose to expose only one service to the user, which is NGINX through port 443, for better security and isolation.

In addition, I have made sure that NGINX is using TLS 1.2/1.3 for even more security.

### Virtual Machines vs Docker

**Virtual Machines** run a complete operating system with its own kernel on top of a hypervisor. Each VM is fully isolated and includes the entire OS stack, making them resource-intensive but providing strong isolation.

**Docker** containers share the host OS kernel and package only the application and its dependencies. Containers are lightweight, start quickly, and use fewer resources than VMs, though they provide less isolation since they share the kernel.

### Secrets vs Environment Variables

**Secrets** are encrypted sensitive data (passwords, API keys, certificates) managed securely by orchestration tools like Docker Swarm or Kubernetes. They're stored encrypted at rest, transmitted securely, and mounted as temporary files in containers with restricted permissions.

**Environment Variables** are plain-text key-value pairs passed to containers at runtime. They're suitable for non-sensitive configuration but expose sensitive data in process lists, logs, and container inspection output. Use secrets for credentials and environment variables for general configuration.

### Docker Network vs Host Network

**Docker Network** (bridge mode) creates an isolated virtual network for containers with their own IP addresses. Containers communicate through this network and require explicit port mapping to be accessible from the host. This provides network isolation and allows multiple containers to use the same internal ports.

**Host Network** removes network isolation, making the container share the host's network stack directly. The container uses the host's IP and ports without mapping, offering better performance but sacrificing isolation and potentially causing port conflicts.

### Docker Volumes vs Bind Mounts

**Docker Volumes** are managed by Docker and stored in Docker's storage directory. Docker handles volume lifecycle, they work across platforms, support drivers for remote storage, and can be easily backed up or migrated. They're the recommended approach for persistent data.

**Bind Mounts** directly map a host filesystem path into the container. They provide access to specific host files/directories and are useful for development when you need to share code between host and container. However, they're less portable and tie containers to specific host paths.
