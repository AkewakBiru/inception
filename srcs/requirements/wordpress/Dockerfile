FROM debian:bullseye

ARG wcli="wp --allow-root --path=/var/www/html" \
	MYSQL_USER \
	MYSQL_PASSWORD \
	MYSQL_DB \
	MYSQL_HOST \
    WPADMIN_USER \
    WPADMIN_PASS \
	WPADMIN_EMAIL \
	WPSTD_USER \
	WPSTD_PASS

RUN set -e; \
	apt-get update \ 
	&& apt-get install -y wget php php-fpm php-bcmath php-soap \
		php-mysqli php-xml php-intl php-curl php-mbstring php-gd php-zip

COPY entrypoint.sh .

RUN set -eu; \
	chmod +x /entrypoint.sh \
	&& wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \ 
	&& chmod +x wp-cli.phar \ 
	&& mv wp-cli.phar /usr/local/bin/wp \ 
	&& mkdir -p /var/www/html \
	&& wp --allow-root --path=/var/www/html core download \
	&& sed -i "s|listen = /run/php/php7.4-fpm.sock|listen = 9000|" /etc/php/7.4/fpm/pool.d/www.conf \
	&& mkdir -p /run/php \
	&& chown -R www-data:www-data /var/log /run/php \
	&& rm -rf /var/lib/apt/lists/*

ENV MYSQL_USER=${MYSQL_USER} \
	MYSQL_PASSWORD=${MYSQL_PASSWORD} \
	MYSQL_DB=${MYSQL_DB} \
	MYSQL_HOST=${MYSQL_HOST} \
    WPADMIN_USER=${WPADMIN_USER} \
    WPADMIN_PASS=${WPADMIN_PASS} \
	WPADMIN_EMAIL=${WPADMIN_EMAIL} \
	WPSTD_USER=${WPSTD_USER} \
	WPSTD_PASS=${WPSTD_PASS}

EXPOSE 9000

USER www-data

ENTRYPOINT ["./entrypoint.sh"]