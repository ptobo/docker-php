#!/bin/sh

/usr/sbin/php-fpm -D -y /etc/php-fpm.conf
/usr/sbin/nginx -g "daemon off;"
