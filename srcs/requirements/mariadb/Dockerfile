FROM debian:bullseye

ARG MYSQL_USER \
	MYSQL_PASSWORD \
	MYSQL_ROOT_PASSWORD \
	MYSQL_DB

RUN set -eu; \
	apt-get update \ 
	&& apt-get install -y mariadb-server \
	&& sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf \
	&& service mariadb restart && \
		mariadb -e "\
		ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}'; \
		CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';\
		CREATE DATABASE IF NOT EXISTS $MYSQL_DB; \
		GRANT ALL PRIVILEGES ON ${MYSQL_DB}.* TO '${MYSQL_USER}'@'%';\
		FLUSH PRIVILEGES;" \
	&& rm -rf /var/lib/apt/lists/*

USER mysql

CMD ["mariadbd"]
