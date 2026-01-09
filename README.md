# _This project has been created as part of the 42 curriculum by lazmoud_

## Description

This project is clearly about setting up 3 services and linking them through a shared network and data volumes using docker compose.
each service is ran separately in its own docker instance and then docker compose makes it accessible to be connected to by the service that needs it.
the services we got are: wordpress, mariadb, nginx.
nginx is ckearly on the top of the stack and is the one which accessible by the users to send requests to through port 443/https. then it communicates internally
with wordpress by forwarding the request to it, then wordpress has a persistent connection with mariadb in order to authenticate, manage data and so on.
the goal of this project is to become familiar with containerization, docker, and docker compose.

## Instructions

### before-hand Setup
I mean, Install docker then make it active through systemctl, becuase nothing will work without those.
you can start it using these commands:
    `sh
        $> sudo systemctl start docker.service
        $> sudo systemctl start docker.socket
    `
before typing any command you start by creating a .env file at: `./srcs/requirements/.env` in this format:
    `
        MYSQL_DATABASE=database
        WORDPRESS_DB_NAME=${MYSQL_DATABASE} # same as MYSQL_DATABASE
        MYSQL_USER=db_user
        WORDPRESS_DB_USER=${MYSQL_USER} # same as MYSQL_USER
        WORDPRESS_DB_HOST=dbhost:dbport
        WP_USER=wp_user
        SITE_TITLE="EPIC WEBSITE!"
        URL="Host"
        EMAIL="example@example.co"
    `
then create these files:
`./secrets/wp_admin_password.txt`:  wordpress administrator password.
`./secrets/db_password.txt`:        mariadb regular user password.
`./secrets/db_root_password.txt`:   mariadb root user password. should be very secure

### if all secrets/.env files were created
to spawn up the containers you can just type `sudo make` in the root directory
to build the containers you can just type `sudo make build` in the root directory
to start the containers you can just type `sudo make up` in the root directory
to stop the containers you can just type `sudo make down` in the root directory
to check the status of the containers you can just type `sudo make status` in the root directory

## Resources
- [The official NGINX docs](https://nginx.org/en/docs/)
- [The official Docker manuals](https://docs.docker.com/manuals/)
- [Wordpress advanced administration](https://developer.wordpress.org/advanced-administration/)
- [The official Mariadb docs](https://mariadb.com/docs)
- [Intro into docker](https://youtu.be/Ud7Npgi6x8E?si=booTArqRSeDZ5Cne)
- I also meanly used chatgpt to understand how can I link up nginx and wordpress correctly by configuring nginx properly.
