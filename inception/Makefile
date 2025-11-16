COMPOSE_FILE = srcs/docker-compose.yml
DATA_DIR = ${HOME}/data
WP_DIR = ${DATA_DIR}/wordpress
DB_DIR = ${DATA_DIR}/mariadb

.PHONY: all setup build up down clean fclean re status logs

all: setup build up

setup:
	@mkdir -p $(WP_DIR)
	@mkdir -p $(DB_DIR)
	@if ! grep -q "jlevy.42.fr" /etc/hosts; then \
		sudo sh -c 'echo "127.0.0.1 jlevy.42.fr" >> /etc/hosts'; \
	fi

build:
	docker compose -f $(COMPOSE_FILE) build --no-cache

up:
	docker compose -f $(COMPOSE_FILE) up -d

down:
	docker compose -f $(COMPOSE_FILE) down

clean: down
	docker compose -f $(COMPOSE_FILE) down --rmi all
	docker system prune -af

fclean: clean
	docker volume prune -f
# 	docker volume rm mariadb_data wordpress_data
# 	rm -rf ${WP_DIR}
# 	rm -rf ${DB_DIR}

re: fclean all

logs:
	docker compose -f $(COMPOSE_FILE) logs

status:
	docker compose -f $(COMPOSE_FILE) ps
	docker ps