#!/usr/bin/env bash

# set -eu;

wcli="wp-cli.phar --allow-root --path=/var/www/html"

if [ ! -e "/var/www/html/wp-config.php" ]; then
	wp-cli.phar config create --allow-root --path=/var/www/html --dbname=$MYSQL_DB --dbuser=$MYSQL_USER \
								--dbhost=$MYSQL_HOST:3306 --dbpass=$MYSQL_PASSWORD
fi

$wcli core install --url=abiru.42.fr --title=inception --admin_user=$WPADMIN_USER \
						--admin_password=$WPADMIN_PASS --admin_email=$WPADMIN_EMAIL

std_user_ct=$($wcli --role__not_in=administrator user list --field=user_login | wc -l)
if [[ $std_user_ct -lt 1 ]]; then
	$wcli user create $WPSTD_USER test123@gmail.com --role=author --user_pass=$WPSTD_PASS
fi

exec php-fpm7.4 -F