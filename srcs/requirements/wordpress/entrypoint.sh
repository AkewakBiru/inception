#!/usr/bin/env bash

# set -eu;

wcli="wp --allow-root --path=/var/www/"

if [ ! -e "/var/www/wp-config.php" ]; then
	cd /var/www && wp config create --allow-root --dbname=$MYSQL_DB --dbuser=$MYSQL_USER --dbhost=$MYSQL_HOST --dbpass=$MYSQL_PASSWORD
fi

# ./wait-for-it.sh --timeout=0 mariadb:3306 -- echo "Done"
# while true; do
#   nc -z mariadb 3306 && break
#   echo "Waiting for mariadb:3306..."
#   sleep 1
# done

# echo "wp config create --allow-root --dbname=$MYSQL_DB --dbuser=$MYSQL_USER --dbhost=$MYSQL_HOST --dbpass=$MYSQL_PASSWORD"

# cd /var/www && wp config create --allow-root --dbname=$MYSQL_DB --dbuser=$MYSQL_USER --dbhost=$MYSQL_HOST --dbpass=$MYSQL_PASSWORD
# echo "done 1"
$wcli core install --url=abiru.42.fr --title=inception --admin_user=$WPADMIN_USER \
						--admin_password=$WPADMIN_PASS --admin_email=$WPADMIN_EMAIL 
$wcli user create $WPSTD_USER test123@gmail.com --role=author --user_pass=$WPSTD_PASS

exec tail -f;