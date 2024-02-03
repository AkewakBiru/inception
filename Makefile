all: build start

pre:
	@mkdir -p $(HOME)/data/mariadb
	@mkdir -p $(HOME)/data/wordpress

build: pre
	@docker compose -f ./srcs/docker-compose.yml build --no-cache

start: pre
	@docker compose -f ./srcs/docker-compose.yml up --build

stop:
	@docker compose -f ./srcs/docker-compose.yml down

remove:
	@docker compose -f ./srcs/docker-compose.yml down -v --rmi all
	@rm -rf $(HOME)/data/mariadb/*
	@rm -rf $(HOME)/data/wordpress/*

.PHONY: all pre build start stop remove