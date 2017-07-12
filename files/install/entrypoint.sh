#!/bin/bash

set -e

#mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 $EFS_ENDPOINT:/ /var/lib/puppet/ssl
# SSL installtion was disable to allow foreman-installer to complete its run
# If not it ask for ssl certificate which are not present on docker build
a2ensite 05-foreman-ssl
a2enmod ssl

# Make api cache
foreman-rake apipie:cache
foreman-rake db:migrate

exec "$@"
