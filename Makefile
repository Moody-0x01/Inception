DOCKER_DIR=./srcs/requirements/
VOLUMES=/home/lazmoud/data/db/ /home/lazmoud/data/html/
RM=@rm -rf
COMPOSE_=@cd $(DOCKER_DIR) && DOCKER_BUILDKIT=1  docker compose

all:
	$(COMPOSE_) up -d --build
build:
	$(COMPOSE_) build
reup:
	$(COMPOSE_) up --build --force-recreate
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
	$(RM) $(VOLUMES)
	@mkdir -p $(VOLUMES)
	$(COMPOSE_) down --volumes --remove-orphans --rmi all
	@cd $(DOCKER_DIR) && docker system prune -af --volumes
fclean: clean
	$(RM) $(VOLUMES)
	@mkdir $(VOLUMES)
re: vpurge reup

.PHONY: all build up down status logs clean re nx_logs md_logs wp_logs vpurge fclean reup
