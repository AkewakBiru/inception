build:
	@docker compose -f ./srcs/docker-compose.yml build -q
start:
	#@docker compose up
	@docker compose -f ./srcs/docker-compose.yml up

reboot:
	@docker compose -f ./srcs/docker-compose.yml restart

restart: reboot start

stop:
	@docker compose -f ./srcs/docker-compose.yml down

remove:
	@docker compose -f ./srcs/docker-compose.yml down --rmi all

