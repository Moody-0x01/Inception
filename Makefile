DOCKER_DIR=./srcs/requirements/
NGINX=./srcs/requirements/nginx/Dockerfile
MARIADB=./srcs/requirements/mariadb/Dockerfile
WP=./srcs/requirements/wordpress/Dockerfile
COMPOSE_FILE=./srcs/requirements/docker-compose.yml
FILES=$(NGINX) $(MARIADB) $(WP) $(COMPOSE_FILE)
COMPOSE_=cd $(DOCKER_DIR) && docker-compose

all: $(FILES)
	$(COMPOSE_) up -d --build

build: $(FILES)
	$(COMPOSE_) build

up:
	$(COMPOSE_) up -d

down:
	$(COMPOSE_) down

re: down all
status:
	$(COMPOSE_) ps

logs:
	$(COMPOSE_) logs -f

clean:
	$(COMPOSE_) down -v

fclean: clean
	cd $(DOCKER_DIR) && docker system prune -af --volumes

.PHONY: all build up down status logs clean fclean re
