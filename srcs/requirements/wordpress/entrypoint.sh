#!/usr/bin/env bash

# set -eu;

wcli="wp --allow-root --path=/var/www/html"

if [ ! -e "/var/www/html/wp-config.php" ]; then
	echo "trying to connect..."
	cd /var/www/html && mv wp-config-sample.php wp-config.php && sed -i "/put your unique phrase here/d; \
	s/database_name_here/$MYSQL_DB/; \
	s/username_here/$MYSQL_USER/; \
	s/password_here/$MYSQL_PASSWORD/; \
	s/localhost/$MYSQL_HOST:3306/" wp-config.php
	# wp config create --allow-root --path=/var/www/html --dbname=$MYSQL_DB --dbuser=$MYSQL_USER --dbhost=$MYSQL_HOST:3306 --dbpass=$MYSQL_PASSWORD
fi

# ./wait-for-it.sh --timeout=0 mariadb:3306 -- echo "Done"
# while true; do
#   nc -z mariadb 3306 && break
#   echo "Waiting for mariadb:3306..."
#   sleep 1
# done
# echo "created or passed check for config.php file"
# sleep 1;

# echo "wp config create --allow-root --dbname=$MYSQL_DB --dbuser=$MYSQL_USER --dbhost=$MYSQL_HOST --dbpass=$MYSQL_PASSWORD"

# cd /var/www && wp config create --allow-root --dbname=$MYSQL_DB --dbuser=$MYSQL_USER --dbhost=$MYSQL_HOST --dbpass=$MYSQL_PASSWORD
# echo "done 1"
echo "trying to install wordpress..."
$wcli core install --url=abiru.42.fr --title=inception --admin_user=$WPADMIN_USER \
						--admin_password=$WPADMIN_PASS --admin_email=$WPADMIN_EMAIL

std_user_ct=$($wcli --role__not_in=administrator user list --field=user_login | wc -l)
if [[ $std_user_ct -lt 1 ]]; then
	echo "trying to create a standard user..."
	$wcli user create $WPSTD_USER test123@gmail.com --role=author --user_pass=$WPSTD_PASS
fi

# if [ ! -d "/run/php" ]; then
# 	mkdir -p /run/php
# fi

exec php-fpm7.4 -F