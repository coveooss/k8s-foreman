# 1. Presentation

This docker can only be used on K8S because it will use config maps and secret to define the whole configuration.

Foreman installer is used to install a standalone foreman setup. 
The database is an external MySQL instance. 
The foreman proxy will be install with puppet in a different [docker](https://github.com/coveo/k8s-puppet).
Foreman will use certificate signed by puppetCA
An NFS share is used to store all certificates from puppetCA 

# 2. Configuration
## Secret to set

* /etc/foreman/database.yml
* /etc/foreman/encryption_key.rb
* /etc/foreman/settings.yaml
* /usr/share/foreman/config/initializers/local_secret_token.rb

## ConfigMap to set

* /etc/apache2/sites-available/05-foreman-ssl.conf
* /etc/apache2/sites-available/05-foreman.conf
* /etc/foreman/plugins/default_hostgroup.yaml

## EFS Configuration

Create Persistent Volumes and Persistent Volumes claims with the yaml available in puppet repos.