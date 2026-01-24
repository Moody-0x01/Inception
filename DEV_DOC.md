# Set Up
    - To correctly setup the environment these are required to exist:
    - configurations:
        - nginx config that insures that the server can connect to `php-fpm` at ./srcs/requirements/nginx/conf/nginx.conf
        - `.env` file that has these variables setup:
            - `MARIA_DATABASE_NAME`:  Name of the db that will be created by mariadb.
            - `MARIA_DB_USER`: The user that will be created by mariadb when it starts.
            - `MARIA_DB_HOST`: the host of the db inside the container network, it has this format: container_name:PORT, example: mariadb:3306 or just mariadb since mariadb defaults to 3306.
            - `WP_USER`: wordpress user that will be created by wordpress.
            - `SITE_TITLE`: The title of the site that will be created through wordpress.
            - `URL`: the url of ur website... typically the host that will be assigned either via dns or just internally through `/etc/hosts`
            - `EMAIL`: Your email.
    - secrets:
        - `./secrets/wp_admin_password.txt`: your wp_user password. should be secure..
        - `./secrets/db_root_password.txt`: the root password of mariadb, make it very long and very secure.. better be generated..
        - `./secrets/db_password.txt`: the password of the regular mariadb user.. I mean `MYSQL_USER`
        NORE: If any of these are not created then some service will not be run correctly.
# Launch
    - Build & Launch:
        - using make: `sudo make`
        - using docker compose: `cd ./srcs &&  sudo docker compose up -d --build`
    - Build:
        - using make: `sudo make build`
        - using docker compose: `cd ./srcs &&  sudo docker compose build`
    - Launch:
        - using make: `sudo make up`
        - using docker compose: `cd ./srcs &&  sudo docker compose up -d`

# Management
    - Restart:
        - using make: `sudo make re`
        - using docker compose: `cd ./srcs &&  sudo docker compose down && sudo docker compose up -d --build`
    - Logs:
        - using make: `sudo make logs`
        - using docker compose: `cd ./srcs &&  sudo docker compose logs -f`
        - Additional make commands for each service: nx_logs[nginx], wp_logs[wordpress], md_logs[mariadb]
    - Status:
        - using make: `sudo make status`
        - using docker compose: `cd ./srcs &&  sudo docker compose ps`
    - Shutdown:
        - using make: `sudo make down`
        - using docker compose: `cd ./srcs &&  sudo docker compose down`
    - Shutdown and Clean:
        - using make: `sudo make clean`
        - using docker compose: `cd ./srcs &&  sudo docker compose down -v`
    - Clean up volumes:
        - using make: `sudo make vpurge`
        - using docker compose: `cd ./srcs &&  sudo docker compose down --volumes --remove-orphans`
    - Rebuild:
        - using make: `sudo make rebuild`
        - using docker compose: `cd ./srcs docker compose up --build --force-recreate`
# Data
    - mariadb's data live in a volume that exists inside the host`s file system at `/home/lazmoud/data/db` and is mounted to `/var/lib/mysql`.
    - wordpress's data and configuration live in a volume that exists inside the host`s file system at `/home/lazmoud/data/html` and is mounted to `/var/www/html`
    - nginx reads wordpress's files, do it needs access to the same volume as wordpress.. so it is mounted the same way.
