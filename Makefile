DOCKER_DIR=./srcs/requirements/
COMPOSE_=cd $(DOCKER_DIR) && docker compose

all:
	$(COMPOSE_) up -d --build
build:
	$(COMPOSE_) build
up:
	$(COMPOSE_) up -d
down:
	$(COMPOSE_) down
status:
	$(COMPOSE_) ps
clean:
	$(COMPOSE_) down -v
logs:
	$(COMPOSE_) logs -f
nx_logs:
	$(COMPOSE_) logs nginx
wp_logs:
	$(COMPOSE_) logs wordpress
md_logs:
	$(COMPOSE_) logs mariadb
vpurge:
	$(COMPOSE_) down --volumes --remove-orphans
re: down all

.PHONY: all build up down status logs clean re nx_logs md_logs wp_logs purge
