FROM debian:bullseye

ARG MYSQL_USER MYSQL_PASSWORD MYSQL_DB

RUN set -eu; apt update \ 
	&& apt install -y mariadb-server \
	&& sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf \
	&& set -eu; service mariadb restart && \
		mariadb -e "\
		CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';\
		CREATE DATABASE IF NOT EXISTS $MYSQL_DB; \
		GRANT ALL PRIVILEGES ON $MYSQL_DB.* TO '$MYSQL_USER'@'%';\
		FLUSH PRIVILEGES;"

USER mysql

ENV MYSQL_DB=$MYSQL_DB

CMD ["mariadbd"]
