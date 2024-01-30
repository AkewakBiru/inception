FROM debian:bullseye

RUN set -e; apt update \ 
	&& apt install -y mariadb-server

RUN sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

RUN service mariadb restart && \
	mariadb -e "\
	CREATE USER 'test'@'%' IDENTIFIED BY 'hardpass';\
	CREATE DATABASE IF NOT EXISTS login; \
	GRANT ALL PRIVILEGES ON login.* TO 'test'@'%';\
	FLUSH PRIVILEGES;"

USER mysql

CMD ["mariadbd"]
