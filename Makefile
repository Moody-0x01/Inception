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
logs:
	$(COMPOSE_) logs -f
clean:
	$(COMPOSE_) down -v
re: down all
.PHONY: all build up down status logs clean re
