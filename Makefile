pre:
	@mkdir -p $(HOME)/data/mariadb
	@mkdir -p $(HOME)/data/wordpress

start: pre
	@docker compose -f ./srcs/docker-compose.yml build
	@docker compose -f ./srcs/docker-compose.yml up

stop:
	@docker compose -f ./srcs/docker-compose.yml down

reboot:
	@docker compose -f ./srcs/docker-compose.yml restart

restart: reboot start

remove:
	@docker compose -f ./srcs/docker-compose.yml down --rmi all

delete: remove
	@rm -rf $(HOME)/data/mariadb/*
	@rm -rf $(HOME)/data/wordpress/*

.PHONY: pre start reboot restart stop remove delete