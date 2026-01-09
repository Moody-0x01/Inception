# Understanding what services are provided by the stack
The stack in this infrastructure is very simple and can be located at `./srcs/requirements/`, every directory is named after its respective service..
example: `./srcs/requirements/nginx/` contains the nginx service.. and so on.
but you also can check out the `./srcs/requirements/docker-compose.yml` file for more information about services under the `services` key.

# Start and stop the project.
To start the project you can just type `sudo make up` in the command line at the root of the project.
if you want to stop it then you can just type `sudo make down` in the command line.

# Access the website and the administration panel.
To access the website just type `https://yourhost` or `https://localhost` if you have not setup a host, in my case it is `https://lazmoud.42.ma` but it may vary depending on your use case, but generally localhost always works.
for the administration panel you need the `WP_USER` you set up in the file located at `./srcs/requirements/.env` and the password which is expected to be at `./secrets/wp_admin_password.txt`.
if you have aquired those with no problem you can just visit `https://[yourhost|localhost]/wp-admin` and login normally.

# Locate and manage credentials.
DOTENV file that is responsible for usenames, hosts, other information is located at: `./srcs/requirements/.env` in this format:
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
any passwords are stored in file at: `./secrets/` in this fashion:
`./secrets/wp_admin_password.txt`: wordpress administrator password.
`./secrets/db_password.txt`: mariadb regular user password.
`./secrets/db_root_password.txt`: mariadb root user password. should be very secure

# Check that the services are running correctly
for checking the status of the services, you can use `sudo make status` this will list all the services that are currently running.
also you can check the logs of any service by using this list of command:
`sudo make logs`: show all the logs.
`sudo make nx_logs`: show nginx logs.
`sudo make md_logs`: show mariadb logs.
`sudo make wp_logs`: show wordpress logs.
