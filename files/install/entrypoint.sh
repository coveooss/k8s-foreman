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

exec "$@"
