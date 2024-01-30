# syntax=docker/dockerfile:1.3-labs
FROM debian:bullseye

RUN set -e; apt-get update \ 
	&& apt-get install -y wget tar php php-curl php-fpm php-mysqlnd
	#&& wget -O wordpress.tar.gz https://wordpress.org/latest.tar.gz \ 
	#&& mkdir -p /var/www/html \ 
	#&& cd /var/www/html && tar -xvzf /wordpress.tar.gz

RUN mkdir -p /var/www \ 
	&& cd /var/www \
	&& wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \ 
	&& chmod +x wp-cli.phar \ 
	&& mv wp-cli.phar /usr/local/bin/wp \ 
	&& wp core download --allow-root

RUN cd /var/www && mv wp-config-sample.php wp-config.php && sed -i '/put your unique phrase here/d; \
	s/database_name_here/dbname/; \
	s/username_here/username/; \
	s/password_here/password/; \
	s/localhost/mariadb/' wp-config.php

#RUN cat <<EOF > wp-config.php
#<?php
#define( 'DB_NAME', 'test' );
#define( 'DB_USER', 'dbuser' );
#define( 'DB_PASSWORD', 'dbpass' );
#define( 'DB_HOST', 'mariadb' );
#define( 'DB_CHARSET', 'utf8' ); 
#define( 'DB_COLLATE', '' ); 
#"$table_prefix" = 'wp_'; 
#define( 'WP_DEBUG', false );
#if ( ! defined( 'ABSPATH' ) ) { 
#	define( 'ABSPATH', __DIR__ . '/' ); 
#} 
#require_once ABSPATH . 'wp-settings.php';
#EOF
