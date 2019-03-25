#!/bin/bash

set -e

# SSL installtion was disable to allow foreman-installer to complete its run
# If not it ask for ssl certificate which are not present on docker build
a2ensite 05-foreman-ssl
a2enmod ssl

# Make api cache
foreman-rake apipie:cache&
# Migrate DB or populate it if it's empty
foreman-rake db:migrate

if [ ! -f /var/lib/puppet/ssl/.init_foreman ]; then
    echo "####### Init Db ######"
    foreman-rake db:seed
    echo "####### Reset Forman admin password ######"
    foreman-rake permissions:reset
    echo "####### Create account for prometheus exporter ######"
    foreman-rake prometheus:create_user
    echo "##########################################"
    touch /var/lib/puppet/ssl/.init_foreman
fi

echo "* 6 * * * root /usr/sbin/foreman-rake reports:expire days=7" >> /etc/cron.d/foreman-task
echo "* 4 * * * root /usr/sbin/foreman-rake reports:expire days=1 status=0" >> /etc/cron.d/foreman-task

service cron restart

exec "$@"
