FROM debian:bullseye

ARG MYSQL_USER \
	MYSQL_PASSWORD \
	MYSQL_DB \
	MYSQL_HOST \
    WPADMIN_USER \
    WPADMIN_PASS \
	WPADMIN_EMAIL \
	WPSTD_USER \
	WPSTD_PASS \
	DOMAIN_NAME

RUN set -e; \
	apt-get update \ 
	&& apt-get install -y wget php php-fpm php-bcmath php-soap \
		php-mysqli php-xml php-intl php-curl php-mbstring php-gd php-zip

COPY ./conf/* /usr/local/bin

RUN set -eu; \
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/ \
	&& chmod +x /usr/local/bin/wp-cli.phar /usr/local/bin/docker_entrypoint.sh \ 
	&& mkdir -p /var/www/html /usr/local/bin/wp /run/php \
	&& php /usr/local/bin/extract_phar.php \
	&& wp-cli.phar --allow-root --path=/var/www/html/ core download \
	&& sed -i "s|listen = /run/php/php7.4-fpm.sock|listen = 9000|" /etc/php/7.4/fpm/pool.d/www.conf \
	&& chown -R www-data:www-data /var/log /run/php \
	&& rm -rf /usr/local/bin/extract_phar.php /var/lib/apt/lists/* 

ENV MYSQL_USER=${MYSQL_USER} \
	MYSQL_PASSWORD=${MYSQL_PASSWORD} \
	MYSQL_DB=${MYSQL_DB} \
	MYSQL_HOST=${MYSQL_HOST} \
    WPADMIN_USER=${WPADMIN_USER} \
    WPADMIN_PASS=${WPADMIN_PASS} \
	WPADMIN_EMAIL=${WPADMIN_EMAIL} \
	WPSTD_USER=${WPSTD_USER} \
	WPSTD_PASS=${WPSTD_PASS} \
	DOMAIN_NAME=${DOMAIN_NAME}

EXPOSE 9000

USER www-data

ENTRYPOINT ["docker_entrypoint.sh"]