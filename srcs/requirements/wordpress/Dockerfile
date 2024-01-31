FROM debian:bullseye

ARG wcli="wp --allow-root --path=/var/www/" \
	MYSQL_USER \
	MYSQL_PASSWORD \
	MYSQL_DB \
	MYSQL_HOST \
    WPADMIN_USER \
    WPADMIN_PASS \
	WPADMIN_EMAIL \
	WPSTD_USER \
	WPSTD_PASS

RUN set -e; apt-get update \ 
	&& apt-get install -y wget php php-fpm php-bcmath php-soap php-mysqli php-xml php-intl php-curl php-mbstring php-gd php-zip

COPY entrypoint.sh .

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \ 
	&& chmod +x wp-cli.phar \ 
	&& mv wp-cli.phar /usr/local/bin/wp \ 
	&& $wcli core download\
	&& chmod +x /entrypoint.sh

# RUN set -eu; cd /var/www && wp config create --allow-root --dbname=$MYSQL_DB --dbuser=$MYSQL_USER --dbhost=$MYSQL_HOST --dbpass=$MYSQL_PASSWORD \
# 	&& $wcli core install --url=abiru.42.fr --title=inception --admin_user=$WPADMIN_USER \
# 						--admin_password=$WPADMIN_PASS --admin_email=$WPADMIN_EMAIL \
# 	&& $wcli user create $WPSTD_USER test@gmail.com --role=author --user_pass=$WPSTD_PASS
# RUN cd /var/www && mv wp-config-sample.php wp-config.php && sed -i "/put your unique phrase here/d; \
# 	s/database_name_here/$MYSQL_DB/; \
# 	s/username_here/$MYSQL_USER/; \
# 	s/password_here/$MYSQL_PASSWORD/; \
# 	s/localhost/mariadb/" wp-config.php
	# && $wcli core install --url=abiru.42.fr --title=inception --admin_user=$WPADMIN_USER \
	# 					--admin_password=$WPADMIN_PASS --admin_email=$WPADMIN_EMAIL \
	# && $wcli user create $WPSTD_USER test@gmail.com --role=author --user_pass=$WPSTD_PASS

ENV wcli=$wcli MYSQL_HOST=$MYSQL_HOST \
	MYSQL_USER=$MYSQL_USER \
	MYSQL_PASSWORD=$MYSQL_PASSWORD \
	MYSQL_DB=$MYSQL_DB \
	MYSQL_HOST=$MYSQL_HOST \
    WPADMIN_USER=$WPADMIN_USER \
    WPADMIN_PASS=$WPADMIN_PASS \
	WPADMIN_EMAIL=$WPADMIN_EMAIL \
	WPSTD_USER=$WPSTD_USER \
	WPSTD_PASS=WPSTD_PASS

CMD ["./entrypoint.sh"]